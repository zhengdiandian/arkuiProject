import { HcNavBar } from '../commons/components'
import { WordItem, Words } from '../models'
import { util } from '@kit.ArkTS'
import { logger } from '../commons/utils'
import { webview } from '@kit.ArkWeb'
import { promptAction } from '@kit.ArkUI'
import { WordDialog } from './views/Word/WordDialog'

@Preview
@Entry
@Component
struct WordPage {
  words: Words = {}
  @State wordKey:string = ''
  @State showTypeSheet: boolean = false
  scroller = new Scroller()
  @State currentCode: string = ''
  webController = new webview.WebviewController()
  @State showCodeSheet: boolean = false
  @State currentEn: string = ''
  @State currentZh: string = ''
  dialog = new CustomDialogController({
    builder: WordDialog({ en: this.currentEn, zh: this.currentZh }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })
  @Builder
  CodeSheetBuilder() {
    Column(){
      Web({src: $rawfile('word.html'), controller: this.webController})
      .width('100%')
      .height(400)
      .backgroundColor($r('app.color.common_gray_bg'))
      .onPageEnd(() => {
        this.webController.runJavaScript(`writeHtml(\`${this.currentCode}\`)`)
      })
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 34 })
  }
  @Builder
  TypeSheetBuilder() {
    Column() {
      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
        ForEach(Object.keys(this.words), (key: string) => {
          Button() {
            Text(key)
              .fontSize(14)
              .fontColor(key === this.wordKey ? $r('app.color.common_green') : $r('app.color.common_gray_01'))
          }
          .backgroundColor($r('app.color.common_gray_bg'))
          .padding({ top: 6, right: 12, bottom: 6, left: 12 })
          .margin({ right: 12, bottom: 12 })
          .onClick(() => {
            this.wordKey = key
            this.showTypeSheet = false
            this.scroller.scrollTo({ yOffset: 0, xOffset: 0 })
          })
        })
      }
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 34 })
  }
  init() {
    const ctx = getContext(this)
    // 获取二进制数据
    const uint8Array = ctx.resourceManager.getRawFileContentSync('word.json')
    // 实例化文本解析工具
    logger.info(uint8Array.toString())

    const textDecoder = new util.TextDecoder()
    // 解析文本
    const jsonStr = textDecoder.decodeWithStream(uint8Array)
    logger.info(jsonStr);
    // 转成对象
    this.words = JSON.parse(jsonStr) as Words
    this.wordKey = Object.keys(this.words)[0]
  }
  aboutToAppear(): void {
    this.init()

  }
  build() {
    Column(){
      HcNavBar({ title: '常用单词', showRight: false })
      Row(){
        Column({ space: 4 }) {
          Text('开发常用词汇')
          Text(`共 ${this.words[this.wordKey].length}个单词`)
            .fontSize(12)
            .fontColor($r('app.color.common_gray_03'))
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          Text(this.wordKey)
            .fontSize(12)
            .fontColor($r('app.color.common_gray_01'))
          Image($r('sys.media.ohos_ic_public_arrow_down'))
            .width(16)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_01'))

        }
        .onClick(() => {
          this.showTypeSheet = true
        })
        .bindSheet($$this.showTypeSheet, this.TypeSheetBuilder, {
          title: { title: '选择阶段' },
          backgroundColor: $r('app.color.white'),
          height: 400
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(16)
      .border({ width: { top: 0.5 }, color: $r('app.color.common_gray_bg') })
      Divider()
        .strokeWidth(8)
        .color($r('app.color.common_gray_bg'))

      List({scroller:this.scroller}){
        ForEach(this.words[this.wordKey], (item: WordItem) => {
          ListItem(){
            Row({space: 6}){
              Image($r('sys.media.ohos_ic_public_sound'))
                .width(20)
                .aspectRatio(1)
                .alignSelf(ItemAlign.Start)
                .fillColor($r('app.color.common_gray_03'))
                .onClick(() => {
                  this.currentEn = item.en
                  this.currentZh = item.zh
                  this.dialog.open()
                })
              Column({ space: 10 }) {
                Text(item.en)
                  .fontWeight(FontWeight.Bold)
                Text(item.zh)
                  .fontSize(14)
                  .fontColor($r('app.color.common_gray_03'))
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Row(){
                Text('详细代码')
                  .fontSize(12)
                  .fontColor(item.code ? $r('app.color.common_gray_01') : '#dddddd')
                Image($r('sys.media.ohos_ic_public_arrow_right'))
                  .width(16)
                  .aspectRatio(1)
                  .fillColor(item.code ? $r('app.color.common_gray_01'): '#dddddd')
                  .alignSelf(ItemAlign.Center)
              }
              .alignSelf(ItemAlign.End)
              .onClick(() => {
                this.currentCode = item.code
                if (this.currentCode) {
                  this.showCodeSheet = true
                } else {
                  promptAction.showToast({ message: '暂无代码' })
                }
              })
              .padding(16)

            }

          }

        })
      }
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_bg')
      })
      .layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .bindSheet($$this.showCodeSheet, this.CodeSheetBuilder, {
      detents: [SheetSize.FIT_CONTENT],
      backgroundColor: $r('app.color.white'),
      title: { title: '详细代码' }
    })

  }
}