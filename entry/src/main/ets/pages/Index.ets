import { logger, statusBar } from '../commons/utils';
import { auth } from '../commons/utils/Auth';
import { theme } from '../commons/utils/Theme';
import { TabBarModel } from '../models/TabBarModel';
import { HomePage } from './HomePage';
import { InterviewPage } from './InterviewPage';
import { AudioPage } from './AudioPage';
import { MinePage } from './MinePage';
import { ProjectPage } from './ProjectPage';
import { promptAction } from '@kit.ArkUI';
import app from '@system.app';
auth.initUser()
theme.initTheme()
logger.info('MinePage', '这是首页的日志')
// struct Index 数据
const tabList: TabBarModel[] = [
  {
    icon: $r('app.media.tabbar_home'),
    activeIcon: $r('app.media.tabbar_home_fill'),
    name: '首页'
  },
  {
    icon: $r('app.media.tabbar_project'),
    activeIcon: $r('app.media.tabbar_project_fill'),
    name: '视频'
  },
  {
    icon: $r('app.media.tabbar_interview'),
    activeIcon: $r('app.media.tabbar_interview_fill'),
    name: '录音'
  },
  {
    icon: $r('app.media.tabbar_mine'),
    activeIcon: $r('app.media.tabbar_mine_fill'),
    name: '我的'
  }
]
@Entry
@Component
struct Index {
  @StorageProp('topHeight') topHeight: number = 0
  @StorageProp('bottomHeight') bottomHeight: number = 0
  @State activeIndex: number= 0
  private lastExitTime: number = -1;               // 记录点击时间

  @State count: number = 0;
  @Builder
  TabBarBuilder(item: TabBarModel, index: number){
      Column({space: 5}){
        Image(this.activeIndex === index ? item.activeIcon : item.icon)
          .width('22vp')
          .aspectRatio(1)
        Text(item.name)
          .fontSize(12)
          .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.common_gray_01'))
      }

  }

  onBackPress() {
    if (-1 == this.lastExitTime) {                 // 第一次点击返回键，提示toast
      this.lastExitTime = new Date().getTime();
      promptAction.showToast({
        message: "再按一次退出应用"
      })
      return true;
    } else {
      let currentTime = new Date().getTime();
      if(currentTime - this.lastExitTime > 2000) { // 时间大于2000提示
        promptAction.showToast({
          message: "再按一次退出应用"
        })
        this.lastExitTime = currentTime;
        return true;
      } else {                                     // 2秒内点击，退出APP
        app.terminate();
      }
    }
    return false;
  }

  build() {
    Column() {
     Tabs({index: this.activeIndex}){
       ForEach(tabList,(item: TabBarModel, i:number) => {
         TabContent(){
           if(i===0){
             HomePage()
           }else if(i === 1){
             ProjectPage()
           }else  if(i ===2){
             AudioPage()
           }else {
             MinePage()
           }
         }
         .tabBar(this.TabBarBuilder(item,i))

       })
     }
     .divider({strokeWidth: .5, color: $r('app.color.common_gray_border')})
     .barPosition(BarPosition.End)
     .scrollable(false)
     .margin({bottom: this.bottomHeight})
      .onTabBarClick((i => {
        this.activeIndex = i
      }))
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.white'))
    // .padding({ top: this.topHeight, bottom: this.bottomHeight })
  }
}