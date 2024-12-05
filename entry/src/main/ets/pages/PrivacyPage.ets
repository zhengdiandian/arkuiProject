import { HcNavBar } from '../commons/components';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct PrivacyPage {
  webController :WebviewController = new webview.WebviewController();
  @StorageProp('isDark') isDark: boolean = false
  mode: WebDarkMode =  this.isDark? WebDarkMode.On : WebDarkMode.Auto

  build() {
    Column(){
      HcNavBar({ title: '隐私政策', showRight: false })

      Web({src: $rawfile('privacy.html'), controller: this.webController}).darkMode(this.mode)
    }
    .height('100%')
    .width('100%')
  }
}