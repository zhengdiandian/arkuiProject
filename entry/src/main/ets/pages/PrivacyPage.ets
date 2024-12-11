import { HcNavBar } from '../commons/components';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct PrivacyPage {
  webController :WebviewController = new webview.WebviewController();
  @StorageProp('isDark') isDark: boolean = false
  mode: WebDarkMode =  this.isDark? WebDarkMode.On : WebDarkMode.Auto
  @StorageProp('topHeight') topHeight: number = 0
  @StorageProp('bottomHeight') bottomHeight: number = 0
  build() {
    Column(){
      HcNavBar({ title: '隐私政策', showRight: false })

      Web({src: $rawfile('privacy.html'), controller: this.webController}).darkMode(this.mode)
    }
    .padding({
      bottom: this.bottomHeight

    })
    .height('100%')
    .width('100%')
  }
}