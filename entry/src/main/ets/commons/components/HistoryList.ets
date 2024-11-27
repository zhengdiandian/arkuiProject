import { PageData, QuestionItem, QuestionListParams, QuestionPageParams, SortType  } from '../../models'
import { getQuestionList } from '../request/home'
import { http } from '../utils/request'
import { QuestionItemComp } from './QuestionItemComp'
import { promptAction, router } from '@kit.ArkUI'
import { auth } from '../utils/Auth'
import { logger } from '../utils/Logger'

export enum ContentType {
  INTERVIEW = 9,
  QUESTION = 10
}
export enum OptionalType {
  LIKE = 1,
  COLLECT = 2,
  HISTORY = 3
}
export interface OptionalRequestParams {
  optType: OptionalType
  page: number
  questionBankType: ContentType
}
export interface OptionalRouterParams {
  type: OptionalType
  title: string
}
@Entry
@Component
export struct HistoryList {
  @State list: QuestionItem[] = []
  @Prop    typeId:number
  @Prop  @Watch('onChangeSort')  sort:SortType = SortType.Default
  @Prop  activeIndex:number
  @Prop index:number
  @Prop keyword: string = ''
  @State page:number =  1
  @State
  requestParams: OptionalRequestParams = {
    optType: OptionalType.LIKE,
    page: 1,
    questionBankType: ContentType.QUESTION
  }
  // 控制刷新的状态
  @State isRefreshing: boolean = false
  // 是否加载完成
  @State isFinished: boolean = false
  // 正在加载中...
  @State isLoading: boolean = false

  // getQuestionList(): Promise<PageData<QuestionItem>> {
  //   return http.request({
  //
  //   })
  //
  // }
  onPageShow(): void {
    const params = router.getParams() as OptionalRouterParams
    this.requestParams.optType = params.type
    this.onRefresh()

  }
  onChangeSort() {
    // 切换分类的时候，需要等待UI显示后去刷新
    this.onRefresh()


    setTimeout(() => {
      if (this.activeIndex === this.index) {
        this.isRefreshing = true
      }
    })
  }
  async  onRefresh() {
    this.page = 1
    const params = router.getParams() as OptionalRouterParams
    this.requestParams.optType = params.type
    const  res = await getQuestionList({
      url: 'question/opt/list',
      params:   this.requestParams
    })
    this.list = res.rows
    this.isRefreshing = false
    if (this.page >= res.pageTotal) {
      this.isFinished = true
    } else {
      this.isFinished = false
      this.page++
    }
    this.isLoading = false

    promptAction.showToast({ message: '更新成功' })
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
  async  onLoad(){
    logger.info(JSON.stringify({
      type: this.typeId,
      questionBankType: 10,
      sort: this.sort,
      page: this.page,
      pageSize: 10
    }))
    try {


      const  res = await getQuestionList({
        url: 'question/opt/list',
        params:   this.requestParams
      })

      this.list.push( ...res.rows)
      this.isLoading = false
      if(this.page>= res.pageTotal){
        this.isFinished = true
      }else {
        this.page++
      }
    } catch (e) {
      logger.error(e)
    }


  }
  build() {
    Column(){

      Refresh({refreshing: $$this.isRefreshing}){

        List(){

          ForEach(this.list,(item: QuestionItem, i: number) =>{
            ListItem(){
              QuestionItemComp({item} )
                .onClick(() => {
                  auth.checkAuth({
                    url: 'pages/QuestionPage',
                    params: {
                      item,
                      list: []
                    } as QuestionPageParams
                  })
                })
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

        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
      }
      .onRefreshing(() => {
        this.onRefresh()
      })
    } .width('100%')
    .height('100%')

  }


}