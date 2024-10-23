import { router } from '@kit.ArkUI'
import { auth } from '../utils/Auth'
import { logger } from '../utils/Logger'

@Component
export struct HcSearchBox {
  @Prop
  boxWith: number = 100
  @Prop
  boxHeight: number =32
  @Prop ph: ResourceStr = '搜索题目'
  @Prop phColor: ResourceColor = $r('app.color.common_gray_02')
  @Prop bgColor: ResourceColor = $r('app.color.common_gray_border')
  @Prop layoutWeightValue: number = 0

  build() {
    Row({space: 4}){
      Image($r('app.media.ic_common_search'))
        .width(14)
        .aspectRatio(1)
      Text(this.ph)
        .fontSize(14)
        .fontColor(this.phColor)
    }
    .onClick(() => {
      logger.info('SearchPage')
      auth.checkAuth(() => {
        router.pushUrl({
          url: 'pages/SearchPage'
        })
      })

    })
    .width(this.boxWith)
    .height(this.boxHeight)
    .backgroundColor(this.bgColor)
    .justifyContent(FlexAlign.Center)
    .layoutWeight(this.layoutWeightValue)
    .borderRadius(10)

  }
}