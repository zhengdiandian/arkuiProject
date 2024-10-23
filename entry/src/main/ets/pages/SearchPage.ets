import { router } from '@kit.ArkUI'
import { QuestionListComp } from '../commons/components/QuestionListComp'
import { SearchHistory } from './views/SearchHistory'

@Entry({routeName: "SearchPage"})
@Component
struct SearchPage {
  @StorageProp('topHeight') topHeight: number = 0
  @State keyword: string = ''
  @State isSearch: boolean = false

  build() {
    Column() {
      Row({space: 16}){
        Search({placeholder: '请输入试题关键字', value: this.keyword })
          .placeholderFont({size: 14})
          .height(32)
          .layoutWeight(1)
          .defaultFocus(true)
          .onSubmit(value => {
            this.keyword = value
            if (this.keyword) {
              this.isSearch = true
            }
          })
          .onChange(value => {
            this.keyword = value
            if (!value) {
              this.isSearch = false
            }
          })
        Text('取消')
          .fontColor($r('app.color.black'))
          .fontSize(15)
          .fontWeight(500)
          .onClick(() => router.back())
      }
      .height(64)
      .padding({ left: 16, right: 16 })
      .border({ width: { bottom: 0.5 }, color: $r('app.color.common_gray_border') })

      Column(){
        if(this.isSearch){
          QuestionListComp({
            keyword: this.keyword
          })
        }else {
          SearchHistory({
            onSearch: keyword => {
              // TODO 进行搜索
            }
          })

            .layoutWeight(1)

        }
      }
    }
    .padding({ top: this.topHeight })
    .height('100%')
    .width('100%')
  }
}

