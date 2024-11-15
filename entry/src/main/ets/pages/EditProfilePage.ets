import { HcNavBar } from '../commons/components'
import { HcLoadingDialog } from '../commons/components/HcLoadingDialog'
import { setAvatar, updateNickName } from '../commons/request/home'
import { auth, UserStoreKey } from '../commons/utils/Auth'
import { User } from '../models'
import { promptAction } from '@kit.ArkUI'
import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { fileIo } from '@kit.CoreFileKit'
import { FormData } from '@ohos/axios'

@Preview
@Entry
@Component
struct EditProfilePage {
  @StorageProp(UserStoreKey) user: User = {} as User
  dialog: CustomDialogController = new CustomDialogController(
    {
      customStyle: true,
      builder: HcLoadingDialog({ message: '更新中...' }),
      alignment: DialogAlignment.Center
    }
  )
  build() {
    Column(){
      HcNavBar({ title: '编辑资料', showRight: false })
      List(){
        ListItem() {
          Row() {
            Text('头像')
            Image(this.user.avatar || $r('app.media.ic_mine_avatar'))
              .alt($r('app.media.ic_mine_avatar'))
              .width(40)
              .aspectRatio(1)
              .borderRadius(20)
              .border({ width: 0.5, color: $r('app.color.common_gray_border') })
              .onClick(async () => {
                // TODO 更新头像

                // 1. 选择相册照片
                // 选择照片配置
                const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions()
                photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
                photoSelectOptions.maxSelectNumber = 1
                // 选择照片对象
                const photoPicker = new photoAccessHelper.PhotoViewPicker()
                const photoResult = await photoPicker.select(photoSelectOptions)
                const uri = photoResult.photoUris[0]

                this.dialog.open()
                // 2. 拷贝选择的图片到应用沙箱
                const file = fileIo.openSync(uri, fileIo.OpenMode.READ_ONLY)
                const filePath = getContext(this).cacheDir + '/' + file.name
                fileIo.copyFileSync(file.fd, filePath)
                fileIo.closeSync(file.fd)
                const formData :FormData = new FormData()
                formData.append('file', `internal://cache/${file.name}`)
                const user = await  setAvatar(formData, getContext(this))
                this.user.avatar = user.avatar
                auth.setUser(this.user)
                promptAction.showToast({ message: '更新头像成功' })
                this.dialog.close()
              })
          }
          .width('100%')
          .height(60)
          .justifyContent(FlexAlign.SpaceBetween)
        }

        ListItem() {
          Row() {
            Text('昵称')
            TextInput({ text: this.user.nickName })
              .fontColor($r('app.color.common_gray_03'))
              .textAlign(TextAlign.End)
              .layoutWeight(1)
              .padding(0)
              .height(60)
              .backgroundColor($r('app.color.white'))
              .borderRadius(0)
              .onChange((value) => this.user.nickName = value)
              .onSubmit(() => {
                updateNickName(
                  this.user
                )
                promptAction.showToast({ message: '更新昵称成功' })
                auth.setUser(this.user)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
      }
      .width('100%')
      .height('100%')
      .padding({
        left: 35,
        right: 35,
        top: 15,
        bottom: 15
      })
      .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_bg') })
    }
    .width('100%')
    .height('100%')
  }
}


