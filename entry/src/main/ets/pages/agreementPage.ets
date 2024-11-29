import { webview } from '@kit.ArkWeb';
import { HcNavBar } from '../commons/components';

@Entry
@Component
struct AgreementPage {
  @State message: string = 'Hello World';
  webController :WebviewController = new webview.WebviewController();
  @StorageProp('isDark') isDark: boolean = false
  mode: WebDarkMode =  this.isDark? WebDarkMode.On : WebDarkMode.Auto

  build() {
    Column(){
      HcNavBar({ title: '用户协议', showRight: false })

      Web({src: $rawfile('user.html'), controller: this.webController}).darkMode(this.mode)
    }
    .height('100%')
    .width('100%')
  }
}