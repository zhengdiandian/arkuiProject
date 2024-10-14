import { SortType } from '../../models'

@Component
export struct  FilterButton {
  text: string =''
  isNew: boolean = false
  isSort: boolean = false
  @Prop selected: boolean = false
  @Prop sort: number = SortType.Default
  build() {
    Row(){
      Text(this.text)
        .fontSize(12)
        .fontColor($r('app.color.black'))
        .fontColor(this.selected ? $r('app.color.common_main_color') : $r('app.color.black'))
      if (this.isNew) {
        Image($r('app.media.ic_home_new'))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .position({ right: -26, top: -7 })
      }
      if (this.isSort) {
        Column() {
          Image($r('sys.media.ohos_ic_public_arrow_up'))
            .size({ width: 12, height: 6 })
            .fillColor(this.selected && this.sort % 2 === 1 ? $r('app.color.common_main_color') : $r('app.color.black'))
          Image($r('sys.media.ohos_ic_public_arrow_down'))
            .size({ width: 12, height: 6 })
            .fillColor(this.selected && this.sort % 2 === 1 ? $r('app.color.common_main_color') : $r('app.color.black'))
        }
        .margin({ top: -0.5, left: 2 })
      }
    }
    .height(30)
    .padding({ left: 10, right: 10 })
    .backgroundColor($r('app.color.common_gray_bg'))
    .borderRadius(4)
    .margin({ top: 12, right: this.isNew ? 26 : 10 })
  }
}