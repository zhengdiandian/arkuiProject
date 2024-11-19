import { QuestionItemComp } from '../../../commons/components/QuestionItemComp'
import { QuestionListComp } from '../../../commons/components/QuestionListComp'
import { FilterButton, HcSkeleton, HcSkeletonItem } from '../../../commons/components/index'
import { getQuestionTypeList } from '../../../commons/request/home'
import { QuestionType, SortType } from '../../../models'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { logger } from '../../../commons/utils/Logger'
import { emitter } from '@kit.BasicServicesKit'
import { LOGIN_EVENT } from '../../../constants'

@Extend(Text)
function textTitle() {
  .fontSize(14)
  .fontWeight(500)
  .fontColor($r('app.color.black'))
  .width('100%')
  .margin({ top: 20 })
}
const mockData: QuestionType[] = [
  { id: 1, name: 'ArkTS', displayNewestFlag: 0 },
  { id: 2, name: 'ArkUI', displayNewestFlag: 1 },
  { id: 3, name: 'Hap', displayNewestFlag: 1 },
  { id: 4, name: 'Hsp', displayNewestFlag: 0 },
  { id: 5, name: 'Har', displayNewestFlag: 0 },
  { id: 6, name: 'Ability', displayNewestFlag: 0 },
  { id: 7, name: 'Stage', displayNewestFlag: 0 },
  { id: 8, name: 'Kit', displayNewestFlag: 0 }
]
@Component
export struct HomeCategory{
  @StorageProp('isDark') isDark: boolean = false
  @State questionTypeList:QuestionType[] = []
  @State activeIndex: number = 0
  @State isShow:boolean = false
  @State filterDataIndex: number = 0
  @State filterDataSort: SortType = SortType.Default
  @State sort: SortType = SortType.Default
  @State isLoading : boolean = false
  @Builder
  FilterSheetBuilder(){
    Column(){
      Row(){
        Text('重置')
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.common_gray_03'))
          .onClick(() => {
            this.filterDataIndex = 0
            this.filterDataSort = SortType.Default
          })
        Text('筛选题目')
          .layoutWeight(1)
          .fontSize(18)
          .fontWeight(500)
          .fontColor($r('app.color.black'))
          .textAlign(TextAlign.Center)
        Text('完成')
          .fontWeight(500)
          .fontSize(16)
          .fontColor($r('app.color.common_main_color'))
          .onClick(() => {
            this.activeIndex = this.filterDataIndex

            this.sort = this.filterDataSort
            this.isShow = false
            logger.debug('filterDataIndex'+ this.filterDataIndex)
          })
      }
      .margin({top: 4, bottom: 4})
      Text('题目排序')
        .textTitle()
      // TODO 筛选按钮
      // 排序方式
      Flex({ wrap: FlexWrap.Wrap }) {
        FilterButton({ text: '默认', selected: this.filterDataSort === SortType.Default})
          .onClick(() => {
            this.filterDataSort = SortType.Default
          })
        FilterButton({
          text: '浏览量',
          isSort: true,
          selected: this.filterDataSort === SortType.ViewLow ||
            this.filterDataSort === SortType.ViewHigh,
          sort: this.filterDataSort
        })
          .onClick(() => {
            if (this.filterDataSort === SortType.ViewLow || this.filterDataSort === SortType.ViewHigh) {
              this.filterDataSort = this.filterDataSort === SortType.ViewLow ? SortType.ViewHigh : SortType.ViewLow
            } else {
              this.filterDataSort = SortType.ViewLow
            }
          })
        FilterButton({
          text: '难度',
          isSort: true,
          selected: this.filterDataSort === SortType.DifficultyLow ||
            this.filterDataSort === SortType.DifficultyHigh,
          sort: this.filterDataSort
        })
          .onClick(() => {
            if (this.filterDataSort === SortType.DifficultyLow || this.filterDataSort === SortType.DifficultyHigh) {
              this.filterDataSort =
                this.filterDataSort === SortType.DifficultyLow ? SortType.DifficultyHigh : SortType.DifficultyLow
            } else {
              this.filterDataSort = SortType.DifficultyLow
            }
          })
        FilterButton({ text: '推荐', selected: this.filterDataSort === SortType.Commend})
          .onClick(() => {
            this.filterDataSort = SortType.Commend
          })
      }

      Text('选择分类')
        .textTitle()
      // 选择分类
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.questionTypeList, (item: QuestionType, i: number) => {
          FilterButton({
            text: item.name,
            isNew: item.displayNewestFlag === 1,
            selected: this.filterDataIndex === i
          })
            .onClick(() => {
              this.filterDataIndex = i
            })
        })
      }
      // TODO 筛选按钮
    }
    .padding(16)
    .backgroundColor($r('app.color.white'))
    .height('100%')
  }

  @Builder
  TabBarBuilder(item: QuestionType, index: number) {
   Row(){
     Stack({alignContent: Alignment.Bottom}){

       Text(item.name)
         .fontSize(15)
         .fontColor(this.activeIndex === index? $r('app.color.black'): $r('app.color.common_gray_01'))
         .height(44)
       Text()
         .width(this.activeIndex === index ? 20 : 0)
         .height(2)
         .backgroundColor($r('app.color.black'))
         .animation({ duration: this.activeIndex === index ? 300 : 0 })

     }
     if(item.displayNewestFlag ===1) {
       Image($r('app.media.ic_home_new'))
         .width(32)
         .height(14)
         .objectFit(ImageFit.Contain)
         .margin({ left: 4 })
     }
   }
   .padding({left: 16, right: this.questionTypeList.length ===index+1? 16: 0})
  }
  @Builder
  SkeletonBuilder() {
    HcSkeleton() {
      Column() {
        Row({ space: 16 }) {
          HcSkeletonItem({ widthValue: 60 })
          HcSkeletonItem({ widthValue: 100 })
          HcSkeletonItem({ widthValue: 80 })
          HcSkeletonItem({ widthValue: 40 })
        }
        .height(44)
        .width('100%')

        ForEach([1, 2, 3, 4, 5, 6], () => {
          Column({ space: 10 }) {
            HcSkeletonItem({ widthValue: '90%' })
            HcSkeletonItem({ widthValue: '45%' })
          }
          .height(80)
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
        })
      }
      .padding({ left: 16, right: 16 })
    }
  }
   async  getData() {


   }
  async  aboutToAppear() {
    try {

      this.isLoading = true
      emitter.on(LOGIN_EVENT, this.getData)

      const res =  await getQuestionTypeList()
      this.questionTypeList = res
      this.isLoading = false

    } catch (e) {
      logger.error(e)
    }


  }
  build() {
    if(this.isLoading){
      this.SkeletonBuilder()
    }else {
      Stack({alignContent: Alignment.TopEnd}){
        // 和 Tabs 同级，外面 Stack 组件，左上角对齐 Stack({ alignContent: Alignment.TopEnd }) {}

        Tabs({index: this.activeIndex}){
          ForEach(this.questionTypeList, (item: QuestionType, i: number) => {
            TabContent(){
              // TODO 试题列表
              QuestionListComp({typeId: item.id, sort: this.sort,activeIndex: this.activeIndex, index: i })
              // QuestionItemComp({
              //   item: {
              //     id: '100',
              //     stem: '请说下ArkUI的容器组件有哪些？',
              //     difficulty: 3,
              //     likeCount: 23,
              //     views: 423,
              //     readFlag: 1
              //   }
              // })

            }
            .tabBar(this.TabBarBuilder(item, i))
          })
        }
        .onTabBarClick((index: number) => this.activeIndex = index)
        .barMode(BarMode.Scrollable)
        .scrollable(false)
        .barHeight(44)
        .divider({strokeWidth: .5, color: $r('app.color.common_gray_border')})
        Row() {
          Image($r('app.media.ic_home_filter'))
            .width(24)
            .aspectRatio(1)
        }
        .width(56)
        .height(44)
        .justifyContent(FlexAlign.Center)
        .linearGradient({
          angle: 90,
          colors: [[this.isDark ? '#131313' : '#FFFFFF', 0], [this.isDark ? '#131313' : '#FFFFFF', 0.285]]
        })
        .bindSheet($$this.isShow, this.FilterSheetBuilder(), {
          showClose: false,
          height: 400
        })
        .onClick(() => {
          this.filterDataIndex = this.activeIndex
          this.isShow = true

        })
      }

    }

  }
}

