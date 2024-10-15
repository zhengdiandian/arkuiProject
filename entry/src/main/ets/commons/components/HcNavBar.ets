import { router } from '@kit.ArkUI'

@Component
export struct HcNavBar {
  @StorageProp('topHeight') topHeight: number =0
  @Prop title: string = ''
  @Prop showBorder: boolean = false
  @Prop
  leftIcon: ResourceStr =$r('app.media.ic_common_back')
  // 右边图标
  @Prop
  rightIcon: ResourceStr = $r('sys.media.ohos_ic_public_more')
  // 是否显示右边图标
  @Prop showRight: boolean = true

  build() {
    Row({space: 16 }){
      Image(this.leftIcon)
        .size({ width: 24, height: 24 })
        .fillColor($r('app.color.black'))
        .onClick(() => router.back())
      Row(){
        if(this.title){
          Text(this.title)
            .fontWeight(600)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .maxLines(1)
            .textOverflow({overflow:TextOverflow.Ellipsis}  )
        }
      }
      .height(56)
      .layoutWeight(1)
      if(this.showRight){
        Image(this.rightIcon)
          .size({ width: 24, height: 24 })
          .objectFit(ImageFit.Contain)
      }else {
        Blank()
          .width(24)
      }
    }
    .padding({ left: 16, right: 16, top: this.topHeight })
    .height(56 + this.topHeight)
    .width('100%')
    .border({
      width: { bottom: this.showBorder ? 0.5 : 0 },
      color: $r('app.color.common_gray_bg')
    })
  }
}