import { permission } from '../commons/utils'
import { promptAction, router } from '@kit.ArkUI'
import { Permissions } from '@kit.AbilityKit'
import { AudioView } from './views/Audio/AudioView'

@Entry
@Component
export  struct AudioPage {
  permissions: Permissions[] = ['ohos.permission.MICROPHONE']
  confirmConfig: promptAction.ShowDialogOptions = {
    title: "温馨提示",
    message: "未授权使用麦克风将无法使用该面试录音功能，是否前往设置进行授权？",
    buttons: [
      { text: '离开', color: $r('app.color.common_gray_01') },
      { text: '去授权', color: $r('app.color.black') }
    ]
  }

  async getPermission() {
    try {
      // 第一请求授权
      const isOk = await permission.requestPermissions(this.permissions)
      if (isOk) {
        return
      }
      // 未授权弹窗提示
      const confirm = await promptAction.showDialog(this.confirmConfig)
      if (confirm.index === 1) {
        // 第二次请求权限
        const isOk2 = await permission.openPermissionSetting(this.permissions)
        if (isOk2) {
          return
        }
      }
      router.back()
    } catch (e) {
      promptAction.showToast({ message: '未授权' })
      router.back()
    }
  }
  aboutToAppear(): void {
    this.getPermission()
  }
  build() {
    Column() {
      AudioView()
    }
  }
}