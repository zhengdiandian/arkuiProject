import { HcNavBar } from '../commons/components'
import { HcLoadingDialog } from '../commons/components/HcLoadingDialog'
import { getStudyInfo } from '../commons/request/home'
import { formatTime, logger } from '../commons/utils'
import { StudyTimeCate, StudyTimeData, StudyTimeItem } from '../models'

@Preview
@Entry
@Component
struct StudyTimePage {
  @StorageProp('bottomHeight')bottomHeight: number = 0

  @State data: StudyTimeData = {
    totalTime: 0,
    studyData: []
  }

  dialog: CustomDialogController = new CustomDialogController({
    builder: HcLoadingDialog({ message: '加载中...' }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })
 async  aboutToAppear(): Promise<void> {
   try {
     this.dialog.open()
     this.data = await getStudyInfo()
     logger.info('getStudyInfo' +JSON.stringify(this.data))
   } catch (e) {
     logger.error(e)
   } finally {
     this.dialog.close()
   }

 }
   calcPercentage = (done: number, total: number) => {
  return Math.round(done / total * 100) + '%'
}
  @Builder
  ProgressBuilder(title: string, done: number, total: number, color: string='#87E0CD') {
    GridCol(){
      Column(){
        Row(){
          Text(title)
            .fontColor($r('app.color.common_gray_01'))
            .fontSize(14)
          Text(this.calcPercentage(done, total))
            .fontColor($r('app.color.common_gray_01'))
            .fontSize(14)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({bottom: 5})
        Progress({total: total, value: done})
          .color(color)
          .width('100%')
      }

    }

  }
  @Builder
  DotBuilder(color: string, isDark: boolean) {
    Row(){
      Text()
        .width(7)
        .aspectRatio(1)
        .borderRadius(4)
        .backgroundColor(isDark ? color : $r('app.color.common_gray_01'))
        .margin({ right: 4 })
      Text(isDark ? '已学占比' : '未学占比')
        .fontSize(12)
        .fontColor(isDark ? $r('app.color.common_gray_03') : $r('app.color.common_gray_01'))
    }
  }
  build() {
  Column(){
    HcNavBar({ title: '学习数据', showRight: false })
    Column(){
      Scroll(){

        Column(){
          Row(){
            Text('累计学习时长')
              .margin({ right: 5 })
              .fontColor($r('app.color.common_gray_03'))
            Image($r('sys.media.ohos_ic_public_clock'))
              .width(16)
              .aspectRatio(1)
              .fillColor($r('app.color.common_green'))
          }
          .width('100%')
          .margin({bottom: 8})

          Row() {
            Text(formatTime(this.data.totalTime).replace(/分钟|小时|天/,''))
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.common_green'))
            Text(formatTime(this.data.totalTime).replace(/\d|\./g,''))
              .margin({ bottom: 8, left: 8 })
              .fontColor($r('app.color.common_green'))
          }
          .width('100%')
          .alignItems(VerticalAlign.Bottom)
          ForEach(this.data.studyData, (item: StudyTimeCate) => {
            Text(item.type)
              .margin({ bottom: 10, top: 30 })
              .width('100%')

            GridRow({columns: 2, gutter: 10}){
              ForEach(item.list, (item:StudyTimeItem) => {
                this.ProgressBuilder(item.name, item.done, item.total)

              })

              GridCol({span: 2}){
                Row({ space: 16 }) {
                  this.DotBuilder('#87E0CD', true)
                  this.DotBuilder('#87E0CD', true)
                }
                .margin({ top: 10 })
              }
            }
            .backgroundColor($r('app.color.white'))
            .padding(16)
            .borderRadius(8)
            .shadow({ color: $r('app.color.common_gray_border'), radius: 16 })

          })

        }
        .padding(16)
        .margin({ bottom: this.bottomHeight })
      }
      .scrollBar(BarState.Off)
    }
    .layoutWeight(1)

  }
  .width('100%')
  .height('100%')
  .backgroundImage($r('app.media.study_time_bg'))
  .backgroundImageSize({ width: '100%' })
  .backgroundColor($r('app.color.common_gray_bg'))
  }


}

