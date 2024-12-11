import { HcTag } from '../commons/components'
import { HcNavBar } from '../commons/components/HcNavBar'
import { QuestionDetail, QuestionOptParams, QuestionPageParams } from '../models'
import { promptAction, router } from '@kit.ArkUI'
import {http} from '../commons/utils/index'
import { webview } from '@kit.ArkWeb'
import { HcLoadingDialog } from '../commons/components/HcLoadingDialog'
import { QuestionShareDialog } from './views/Question/QuestionShareDialog'

@Entry({routeName: 'QuestionPage'})
@Component
  struct  QuestionPage {
  webController :WebviewController = new webview.WebviewController();
  @StorageProp('isDark') isDark: boolean = false

  @State
  mode: WebDarkMode =  this.isDark? WebDarkMode.On : WebDarkMode.Auto
  dialog = new CustomDialogController({
    builder: HcLoadingDialog(),
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  @State item: QuestionDetail = {} as QuestionDetail
  @State list: QuestionDetail[] = []
  @State questionIndex: number = 0
  codeDialog = new CustomDialogController({
    builder: QuestionShareDialog({ item: this.item }),
    customStyle: true,
    alignment: DialogAlignment.Center

  })
  @Builder
  TitleBuilder(title: string) {
    Row(){
      Text()
        .width(2)
        .height(12)
        .backgroundColor($r('app.color.black'))
        .margin({ right: 13 })
      Text(title)
        .fontWeight(700)
    }
    .width('100%')
    .padding({top: 10})
    .height(32)
  }
  @Builder
  MenuBuilder() {
    Menu(){
      MenuItem({ content: this.item.likeFlag === 1 ? '取消点赞' : '点赞' })
        .onClick(() => this.questionOpt(1, this.item.likeFlag === 1 ? 0 : 1))
      MenuItem({ content: this.item.collectFlag === 1 ? '取消收藏' : '收藏' })
        .onClick(() => this.questionOpt(2, this.item.collectFlag === 1 ? 0 : 1))
      // MenuItem({ content: '点我反馈' })
      MenuItem({ content: '试题分享' }).onClick(() => {
        this.codeDialog.open()

      })
    }
    .width(108)
  }
  async aboutToAppear() {

    const params = router.getParams() as QuestionPageParams
    if (params) {
      this.item = params.item as QuestionDetail
      this.list = params.list as QuestionDetail[]
      this.item = await this.getQuestionDetail(this.item.id)

      this.questionIndex = this.list.findIndex((item => {
        return item.id === this.item.id
      }))
      this.list[this.questionIndex] = this.item
      this.webController.loadUrl($rawfile('question.html'))
    }
  }
  async toggleQuestion (step: number) {
    const index = this.questionIndex + step
    if (index < 0 || index >= this.list.length) {
      return promptAction.showToast({ message: '没有更多题了' })
    }
    this.questionIndex = index
    const item = this.list[index]
    // if(this.item.answer!==undefined){
    //   this.item = item
    //
    // } else {
      const res = await this.getQuestionDetail(item.id)
      this.list[index] = res
      this.item = res
    // }
    this.webController.runJavaScript(`writeHtml(\`${this.item.answer}\`)`)
  }

  async getQuestionDetail (id: string) {
    this.dialog.open()
    const res = await http.request<QuestionDetail>({ url: `question/${id}` })
    this.dialog.close()
    return res
  }
  async questionOpt(optType: 1 | 2, flag: 0 | 1) {
    try {
      const data: QuestionOptParams = {
        id: this.item.id,
        type: 0,
        optType
      }
      // flag 是你要执行的操作 执行 | 取消
      await http.request<null, QuestionOptParams>({
        url: flag === 1 ? 'question/opt' : 'question/unOpt',
        method: 'post',
        data
      })
      if (optType === 1) {
        this.item.likeFlag = flag
        promptAction.showToast({ message: flag ? '点赞成功' : '取消点赞' })
      }
      if (optType === 2) {
        this.item.collectFlag = flag
        promptAction.showToast({ message: flag ? '收藏成功' : '取消收藏' })
      }
    } catch (e) {
      promptAction.showToast({ message: '操作失败' })
    }
  }
  onPageHide(): void {
  this.dialog.close()
  }
  build() {
    Column(){
      HcNavBar({title: '试题详情', showRight: false})
      this.TitleBuilder('题目：')
      Text(`${this.item.stem}`)
        .width('100%')
        .padding(16)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Row({ space: 12 }) {
        if(this.item.stage && this.item.stage.length){
          ForEach(this.item.stage, (item:string) => {
            HcTag({ text: item })

          })
        }
        // HcTag({ text: 'HarmonyOS' })
        // HcTag({ text: 'ArkTS', color: '#ff6600' })
        Blank()
        Image($r("app.media.ic_home_more"))
          .width(20)
          .aspectRatio(1)
          .bindMenu(this.MenuBuilder())
      }
      .width('100%')
      .padding({ bottom: 16, left: 16, right: 16 })

      Divider()
        .strokeWidth(8)
        .color($r('app.color.common_gray_bg'))

      this.TitleBuilder('答案')
      Web({src: $rawfile('question.html') ,controller: this.webController}).darkMode(this.mode)
        .layoutWeight(1)
        // .padding(16)
        .onPageEnd(() => {
          if (this.item.answer) {
            this.webController.runJavaScript(`writeHtml(\`${this.item.answer}\`)`)
          }
        })
        .width('100%')

      Row({space: 80}){
        Row(){
          Image($r('sys.media.ohos_ic_public_arrow_left'))
            .width(20)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_01'))
          Text(' 上一题')
            .fontColor($r('app.color.common_gray_01'))
        }.onClick(() => {
          this.toggleQuestion(-1)
        })
        Row() {
          Text('下一题 ')
            .fontColor($r('app.color.common_gray_03'))
          Image($r('sys.media.ohos_ic_public_arrow_right'))
            .width(20)
            .aspectRatio(1)
            .fillColor($r('app.color.common_gray_03'))
        }
        .onClick(() => {
          this.toggleQuestion(1)
        })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height(44)



    }.width('100%')
    .height('100%')

  }
}