import { HcNavBar } from '../commons/components'
import { Words } from '../models'
import { util } from '@kit.ArkTS'
import { logger } from '../commons/utils'

@Preview
@Entry
@Component
struct WordPage {
  words: Words = {}
  init() {
    const ctx = getContext(this)
    // 获取二进制数据
    const uint8Array = ctx.resourceManager.getRawFileContentSync('word.json')
    // 实例化文本解析工具
    logger.info(uint8Array.toString())

    const textDecoder = new util.TextDecoder()
    // 解析文本
    const jsonStr = textDecoder.decodeWithStream(uint8Array)
    // 转成对象
    this.words = JSON.parse(jsonStr) as Words
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
          Text(`共 0 个单词`)
            .fontSize(12)
            .fontColor($r('app.color.common_gray_03'))
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          Text('HarmonyOS')
            .fontSize(12)
            .fontColor($r('app.color.common_gray_01'))
          Image($r('sys.media.ohos_ic_public_arrow_down'))
            .width(16)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_01'))
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(16)
      .border({ width: { top: 0.5 }, color: $r('app.color.common_gray_bg') })
      Divider()
        .strokeWidth(8)
        .color($r('app.color.common_gray_bg'))

      List(){
        ForEach([1, 2,3], () => {
          ListItem(){
            Row({space: 6}){
              Image($r('sys.media.ohos_ic_public_sound'))
                .width(20)
                .aspectRatio(1)
                .alignSelf(ItemAlign.Start)
                .fillColor($r('app.color.common_gray_03'))
              Column({ space: 10 }) {
                Text('title')
                  .fontWeight(FontWeight.Bold)
                Text('标题')
                  .fontSize(14)
                  .fontColor($r('app.color.common_gray_03'))
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Row(){
                Text('详细代码')
                  .fontSize(12)
                  .fontColor($r('app.color.common_gray_01'))
                Image($r('sys.media.ohos_ic_public_arrow_right'))
                  .width(16)
                  .aspectRatio(1)
                  .fillColor($r('app.color.common_gray_01'))
                  .alignSelf(ItemAlign.Center)
              }
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

  }
}