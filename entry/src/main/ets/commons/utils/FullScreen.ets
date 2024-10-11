import { window } from '@kit.ArkUI'
import {logger} from './index'
class FullScreen{
  async enable() {
    try {
      // 从 AppStorage 获取名为 'context' 的 Context 对象
      const context = AppStorage.get<Context>('context')

      // 如果 context 存在
      if (context) {
        // 使用 context 获取最后一个窗口对象
        const win = await window.getLastWindow(context)

        // 设置窗口为全屏布局
        await win.setWindowLayoutFullScreen(true)

        // 获取系统类型的窗口避让区域（例如状态栏区域）
        const topArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)

        // 将 topArea 的高度转换为虚拟像素，并存储在 AppStorage 中
        AppStorage.setOrCreate('topHeight', px2vp(topArea.topRect.height))

        // 获取导航指示器类型的窗口避让区域（例如底部导航栏区域）
        const bottomArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)

        // 将 bottomArea 的高度转换为虚拟像素，并存储在 AppStorage 中
        AppStorage.setOrCreate('bottomHeight', px2vp(bottomArea.bottomRect.height))
      }
    } catch (e) {
      logger.error('FullScreen enable', JSON.stringify(e))
    }
  }

  async disable () {
    try {
      const context = AppStorage.get<Context>('context')
      if(context){
        const win = await window.getLastWindow(context)
        await win.setWindowLayoutFullScreen(false)
        AppStorage.setOrCreate('topHeight', 0)
        AppStorage.setOrCreate('bottomHeight', 0)
      }

    } catch (e) {
      logger.error('FullScreen enable', JSON.stringify(e))
    }


  }
}
export const fullScreen = new FullScreen()