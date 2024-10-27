import { HcNavBar } from '../commons/components'
import { HmCalendar, HmCalendarSelectedDay } from '@ohmos/calendar'
import { ClockInfo, ClockInfoParams } from '../models'
import { http } from '../commons/utils'

interface DayBuilderParams {
  day: number
  text: string
}


@Entry
@Component
struct ClockInPage {

  @State clockInfo: ClockInfo = {
    flag: false,
    clockinNumbers: 0,
    totalClockinNumber: 0,
    clockins: []
  }

  @State selectedDays: HmCalendarSelectedDay[] = []
  @Builder
  dayBuilder(params: DayBuilderParams) {
    Column() {
      Row() {
        Text(params.day.toString())
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
        Text('天')
          .fontSize(10)
          .fontColor($r('app.color.common_gray_01'))
          .margin({ bottom: 8, left: 10 })
      }
      .alignItems(VerticalAlign.Bottom)

      Text(params.text)
        .fontSize(10)
        .fontColor($r('app.color.common_gray_01'))
    }.margin({ right: 36 })
  }
  aboutToAppear(): void {
    const current = new Date()
    this.getClockInfo({ year: current.getFullYear().toString(), month: (current.getMonth() + 1).toString() })
  }

  async getClockInfo (params: ClockInfoParams) {
    const res = await http.request<ClockInfo>({ url: 'clockinInfo', params })
    this.clockInfo = res
    this.selectedDays = res.clockins.map(item=>({ date: item.createdAt } as HmCalendarSelectedDay))
  }

  build() {
    Column({ space: 16 }) {
      HcNavBar({ title: '每日打卡', showRight: false })
      Row() {
        this.dayBuilder({ day:  this.clockInfo.totalClockinNumber, text: '累计打卡' })
        this.dayBuilder({ day: this.clockInfo.clockinNumbers, text: '连续打卡' })

      }
      .padding({ top: 10, bottom: 25, left: 16, right: 16 })
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Row() {
        Row(){
          HmCalendar({
            selectedDays: this.selectedDays,
            onChangeMonth: month => {
              const arr = month.split('-')
              this.getClockInfo({ year: arr[0], month: arr[1] })
            }
          })
            .borderRadius(8)
            .border({ width: 0.5, color: '#ededed' })
            .shadow({ color: '#ededed', radius: 16 })
            .backgroundColor($r('app.color.white'))
        }
          .width('100%')
          // .height(360)
          .borderRadius(8)
          .border({ width: 0.5, color: '#ededed' })
          .shadow({ color: '#ededed', radius: 16 })
          .backgroundColor($r('app.color.white'))
      }
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.clocked_bg'))
    .backgroundImageSize({ width: '100%' })
  }
}