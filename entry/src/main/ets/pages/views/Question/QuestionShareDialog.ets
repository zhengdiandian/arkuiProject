import { UserStoreKey } from '../../../commons/utils/Auth'
import { QuestionDetail, User } from '../../../models'
import { componentSnapshot, promptAction } from '@kit.ArkUI';
import { image } from '@kit.ImageKit';
import { fileIo, fileUri } from '@kit.CoreFileKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

@CustomDialog
export  struct  QuestionShareDialog{
  controller: CustomDialogController
  @Prop item: QuestionDetail = {} as QuestionDetail
  @StorageProp(UserStoreKey) user: User = {} as User
  async  savaImg() {
    const pixelMap = await componentSnapshot.get('share')
    const imagePacker = image.createImagePacker()
    const  arrayBuffer = await imagePacker.packing(pixelMap,{format: 'image/jpeg', quality: 98})
    const ctx = getContext(this)
    const imagePath = ctx.cacheDir + '/' + Date.now() + '.jpeg'
    const  file = fileIo.openSync(imagePath,fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE)
    fileIo.writeSync(file.fd, arrayBuffer)
    fileIo.closeSync(file.fd)
    const uri = fileUri.getUriFromPath(imagePath)
    const assetChangeRequest = photoAccessHelper.MediaAssetChangeRequest.createImageAssetRequest(ctx, uri)
    const phAccessHelper = photoAccessHelper.getPhotoAccessHelper(ctx)
    await phAccessHelper.applyChanges(assetChangeRequest)
    this.controller.close()
    promptAction.showToast({message: '保存成功'})
  }
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: 20 }) {
        Image($r('app.media.ic_interview_logo'))
          .width(40)
          .height(40)
        Text('搞定面试题')
        Divider()
          .strokeWidth(0.5)
          .color($r('app.color.common_gray_border'))
        Text('大厂面试题：' + this.item.stem)
          .fontSize(12)
          .maxLines(2)
          .fontWeight(600)
          .width('100%')
          .lineHeight(24)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Column(){

          QRCode(this.item.id)
            .width(160)
            .height(160)

        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        Text('扫码查看答案')
          .fontSize(12)
          .alignSelf(ItemAlign.Center)
        Blank()
        Text('分享来自：' + this.user.nickName || this.user.username)
          .fontSize(12)
      }
      .id('share')
      .padding(20)
      .alignItems(HorizontalAlign.Start)
      .width(300)
      .height(500)
      .backgroundColor($r('app.color.white'))


      Row() {
        SaveButton({
          icon: SaveIconStyle.FULL_FILLED,
          text: SaveDescription.SAVE_IMAGE,
          buttonType: ButtonType.Normal
        })
          .fontColor($r('app.color.white'))
          .fontSize(14)
          .padding(12)
          .backgroundColor($r('app.color.common_main_color'))
          .onClick((_event, result) => {
            if (result === SaveButtonOnClickResult.SUCCESS) {
              this.savaImg()
            }
          })
      }
      .borderRadius({ topLeft: 8 })
      .clip(true)
      // .onClick(this.savaImg)
    }
    .borderRadius(8)
    .clip(true)
  }


}