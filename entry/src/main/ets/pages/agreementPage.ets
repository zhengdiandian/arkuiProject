import { webview } from '@kit.ArkWeb';
import { HcNavBar } from '../commons/components';

@Entry
@Component
struct AgreementPage {
  webController :WebviewController = new webview.WebviewController();
  @StorageProp('isDark') isDark: boolean = false
  mode: WebDarkMode =  this.isDark? WebDarkMode.On : WebDarkMode.Auto
  @StorageProp('topHeight') topHeight: number = 0
  @StorageProp('bottomHeight') bottomHeight: number = 0
  build() {
    Column(){
      HcNavBar({ title: '用户协议', showRight: false })

      Web({src: $rawfile('user.html'), controller: this.webController}).darkMode(this.mode)
    }
    .padding({
      bottom: this.bottomHeight

    })
    .height('100%')
    .width('100%')
  }
}