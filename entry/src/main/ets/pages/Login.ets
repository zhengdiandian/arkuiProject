import { HcNavBar } from '../commons/components/HcNavBar'
import { promptAction, router } from '@kit.ArkUI'
import { login } from '../commons/request/login'
import { User } from '../models'
import { auth } from '../commons/utils/Auth'
import { emitter } from '@kit.BasicServicesKit'
import { LOGIN_EVENT } from '../constants'

@Extend(TextInput)
function customStyle(){
    .placeholderColor('#C3C3C5')
    .caretColor('#fa711d')
    .height(44)
    .borderRadius(0)
    .backgroundColor($r('app.color.white'))
    .border({ width: { bottom: 0.5 }, color: $r('app.color.common_gray_border') })
}


@Entry
@Component
struct LoginPage {
  @StorageProp('topHeight')
  topHeight:number = 0
  @State
  mobile: string = 'hmheima'
  @State
  code: string = 'Hmheima%123'
  @State
  isAgree: boolean = false
  @State
  loading: boolean = false

  async login() {
    if (this.loading) {
      return
    }
    if (!this.mobile) {
      return promptAction.showToast({ message: '请输入用户名' })
    }
    if (!this.code) {
      return promptAction.showToast({ message: '请输入密码' })
    }
    if (!this.isAgree) {
      return promptAction.showToast({ message: '请勾选已阅读并同意' })
    }
    try {
      this.loading = true
      const user = await login({
        username: this.mobile,
        password: this.code
      })
      this.loading = false
      auth.setUser(user)
      emitter.emit(LOGIN_EVENT)
      // 有 return_url 就回跳
      const params = router.getParams() as Record<string, string>
      if (params?.return_url) {
        router.replaceUrl({ url: params.return_url, params })
      } else {
        router.back()
      }
    } catch (e) {
      this.loading = false
      promptAction.showToast({ message: e.message })
    }
  }
  build() {
    Column({space: 15}) {
      HcNavBar({showRight: false})
      Column(){
        Image($r('app.media.icon'))
          .width(120)
          .aspectRatio(1)
        Text('学习arkUI中')
          .fontSize(28)
          .margin({ bottom: 15 })
        Text('联系邮箱：zzp19980703@gmail.com')
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
      }
      .padding(16)

      Column({space: 15}){
        TextInput({ placeholder: '请输入用户名', text: $$this.mobile })
          .customStyle()
        TextInput({ placeholder: '请输入密码', text: $$this.code })
          .customStyle()


        Row(){
          Checkbox()
            .shape(CheckBoxShape.ROUNDED_SQUARE)
            .selectedColor('#fa711d')
            .width(14)
            .aspectRatio(1)
            .select($$this.isAgree)
            .onChange((v) => {
              this.isAgree = v
            })
          Text('已阅读并同意')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
            .padding({ right: 4 })
          Text('用户协议')
            .fontSize(14)
            .padding({ right: 4 })
            .onClick(() => {
              promptAction.showToast({message: '仅供预览'})
            })
          Text('和')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
            .padding({ right: 4 })
          Text('隐私政策')
            .fontSize(14)
            .onClick(() => {
              promptAction.showToast({message: '仅供预览'})
            })

        }
        .width('100%')
        .justifyContent(FlexAlign.Center)


        Button({type: ButtonType.Normal}){
          Row(){
            if(this.loading){
              LoadingProgress()
                .color($r('app.color.white'))
                .width(24)
                .height(24)
                .margin({ right: 10 })
            }
            Text('登录')
          }

        }

        .width('100%')
        .backgroundColor('none')
        .borderRadius(4)
        .height(44)
        .linearGradient({
          direction: GradientDirection.Right,
          colors: [['#fc9c1c', 0], ['#fa711d', 1]]
        })
        .stateEffect(false)

        .onClick(() => {
          this.login()
        })
      }
      .padding({ left: 36, right: 36, top: 30 })




      Column() {
        Text('其他登录方式')
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
      }
      .padding({ top: 70, bottom: 100 })
      .onClick(() => {
        promptAction.showToast({message: '没有真机暂不开发'})
      })

    }
    .width('100%')
    .height('100%')


  }
}