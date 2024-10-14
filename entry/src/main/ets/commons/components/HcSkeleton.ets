@Component
export struct HcSkeleton{
  @State opacityValue: number = 1
  @Builder
  defaultBuilder() {
  }
  @BuilderParam
  default: () => void = this.defaultBuilder
  build() {
    Row({ space: 15 }) {
      this.default()
    }
    .opacity(this.opacityValue)
    .animation({
      duration: 600,
      playMode: PlayMode.Alternate,
      iterations: -1,
      curve: Curve.EaseInOut
    })
    .onAppear(() => {
      this.opacityValue = 0.5
    })
  }
}
@Component
export struct HcSkeletonItem {
  @Prop
  widthValue: Length = '100%'

  build() {
    Text()
      .height(16)
      .width(this.widthValue)
      .borderRadius(2)
      .backgroundColor($r('app.color.white'))
  }
}