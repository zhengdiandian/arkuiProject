import { User } from '../../models'
import { requestClockIn } from '../utils'
import { UserStoreKey } from '../utils/Auth'
import { router } from '@kit.ArkUI'

@Component
export  struct HcClockIn {
  @Prop clockInCount : number =0
  // @StorageProp(UserStoreKey) user: User = {} as User
  build() {
    Row(){
      if(this.clockInCount > 0) {
        Column(){
          Text('已经连续打卡')
            .font({size: 8})
            .fontColor($r('app.color.black'))
            .letterSpacing(1)
            .maxLines(1)
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
        .onClick(() =>{
          router.pushUrl({
            url: 'pages/ClockInPage'
          })
        })
      } else {
        Text('打卡')
          .fontColor($r('app.color.black'))
          .margin({left: 30, top: -4})
          .fontSize(18)
          .fontWeight(500)
          .onClick(() => {
            requestClockIn()
          })


      }
    }
    .width(74)
    .height(28)
    .backgroundImage($r('app.media.ic_common_clocked'))
    .backgroundImageSize(ImageSize.Contain)
  }
}