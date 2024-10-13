@Component
export  struct HcClockIn {
  @Prop clockInCount : number =0
  build() {
    Row(){
      if(this.clockInCount > 0) {
        Column(){
          Text('已经连续打卡')
            .font({size: 8})
            .fontColor($r('app.color.black'))
          Text(){
            Span(this.clockInCount.toString())
              .fontSize(12)
              .fontWeight(600)
            Span('天')
              .fontSize(10)
          }
          .fontColor($r('app.color.black'))
        }
        .margin({left: 30})
      } else {
        Text('打卡')
          .fontColor($r('app.color.black'))
          .margin({left: 30, top: -4})
          .fontSize(18)
          .fontWeight(500)


      }
    }
    .width(74)
    .height(28)
    .backgroundImage($r('app.media.ic_common_clocked'))
    .backgroundImageSize(ImageSize.Contain)
  }
}