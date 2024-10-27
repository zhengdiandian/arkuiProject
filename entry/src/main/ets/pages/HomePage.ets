import { HcClockIn, HcSearchBox } from '../commons/components'
import { HomeCategory } from './views/Home/HomeCategory'
import { scanBarcode } from '@kit.ScanKit'
import { QuestionDetail, User } from '../models'
import { http, logger } from '../commons/utils/index'
import { router } from '@kit.ArkUI'
import { auth, UserStoreKey } from '../commons/utils/Auth'

@Component
export struct HomePage {
  @StorageProp('topHeight') topHeight: number =0
  @StorageProp(UserStoreKey) user: User = {} as User
  async scanQuestionCode() {
    if (canIUse('SystemCapability.Multimedia.Scan.ScanBarcode')) {
      logger.info('扫码'+canIUse('SystemCapability.Multimedia.Scan.ScanBarcode'))
      const result = await scanBarcode.startScanForResult(getContext(this))
      // TODO 根据ID拿数据跳转
      if(result.originalValue){
        const data = await http.request<QuestionDetail>({ url: `question/${result.originalValue}` })
        router.pushUrl({
          url: 'pages/QuestionPage',
          params: {
            data,
            list: [data]
          }
        })
      }
    }
  }
  @Builder

  SwiperItemBuilder(src: Resource){
    Row(){
      Image(src)
        .width('100%')
        .aspectRatio(2.65)

    }

  }

  build() {
    Column(){
      Row({space: 16}){
        Image($r('app.media.ic_home_scan'))
          .width(24)
          .aspectRatio(1)
          .onClick(() => {
            auth.checkAuth(() => {
              this.scanQuestionCode()
            })
          })
        Blank()
        HcSearchBox({layoutWeightValue: 1})

        HcClockIn({clockInCount: this.user.clockinNumbers})
      }
      .padding({left:16, right:16})
      .height(64)
      .width('100%')
      Swiper(){
        ForEach([$r('app.media.banner_ai'), $r('app.media.banner_pj'), $r('app.media.banner_qa')],
          (item: ResourceStr) => {
            this.SwiperItemBuilder(item as  Resource)
          })
      }
      .autoPlay(true)
      .indicator(DotIndicator.dot().bottom(4).itemHeight(4).selectedItemHeight(4).selectedColor($r('app.color.white')))
      .margin({bottom: 16})
      HomeCategory()
    }
    .padding({top: this.topHeight})
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.common_gray_bg'))
  }
}