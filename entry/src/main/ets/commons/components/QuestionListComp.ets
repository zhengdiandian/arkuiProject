import { QuestionItem } from '../../models'
import { QuestionItemComp } from './QuestionItemComp'

@Component
export struct QuestionListComp {
  @State list: QuestionItem[] = new Array(10).fill(0).map((item: number, i: number) => {
    return {
      id: '100'+ i,
      stem: '000请说下ArkUI的容器组件有哪些？',
      difficulty: 3,
      likeCount: 23,
      views: 423,
      readFlag: 1
    } as QuestionItem
  })
  // 控制刷新的状态
  @State isRefreshing: boolean = false
  // 是否加载完成
  @State isFinished: boolean = false
  // 正在加载中...
  @State isLoading: boolean = false
  onRefresh() {
    setTimeout(() => {
      this.list = []
      for (let i = 0; i < 10; i++) {
        this.list.push( {
          id: '100',
          stem: '1111请说下ArkUI的容器组件有哪些？',
          difficulty: 3,
          likeCount: 23,
          views: 423,
          readFlag: 1
        } as QuestionItem)
      }
      this.isRefreshing = false
      this.isFinished = false
    }, 1000)
  }


  @Builder
  LoadMoreBuilder() {
    ListItem(){
      if(this.isFinished){
        Row(){
          Text('没有更多了~~~')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_03'))
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      } else if(this.isLoading) {
        ListItem(){
          Row({space: 4}){
            LoadingProgress()
            Text('正在加载...')
              .fontSize(14)
              .fontColor($r('app.color.common_gray_03'))
          }.justifyContent(FlexAlign.Center)
          .width('100%')
        }
      }
    }
  }
  onLoad(){
    setTimeout(() => {
      for (let index = 0; index < 10; index++) {
        this.list.push({
          id: '100',
          stem: '2222请说下ArkUI的容器组件有哪些？',
          difficulty: 3,
          likeCount: 23,
          views: 423,
          readFlag: 1
        } as QuestionItem)

      }
      this.isLoading = false
      if(this.list.length>= 40){
        this.isFinished = true
      }
    })
  }
  build() {
    Refresh({refreshing: $$this.isRefreshing}){
      List(){
        ForEach(this.list,(item: QuestionItem, i: number) =>{
          ListItem(){
            QuestionItemComp({item} )
          }


        })
      }
      .onReachEnd(() => {
        if(this.isLoading || this.isRefreshing || this.isFinished){
          return
        }
        this.isLoading = true
        this.onLoad()
      })
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border'),
        startMargin: 16,
        endMargin: 16
      })
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
    }
    .onRefreshing(() => {
      this.onRefresh()
    })
  }

}