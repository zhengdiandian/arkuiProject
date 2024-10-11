import {logger} from '../utils/index'
import { window } from '@kit.ArkUI'

class  StatusBar {
  async setDarkBar() {
     await  this.setBar({statusBarContentColor: '#000000'})
  }
  async setLightBar() {
    await this.setBar({ statusBarContentColor: '#FFFFFF' })
  }
  async  setBar(config: window.SystemBarProperties) {
    const context = AppStorage.get<Context>('context')
    if(context){
      const win = await window.getLastWindow(context)
      await win.setWindowSystemBarProperties(config)
    }
  }
}


export const statusBar = new StatusBar()