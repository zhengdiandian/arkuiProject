import { PipWindowViewComponent } from 'pipwindow';

@Entry({routeName: 'videoDetail'})
@Component
struct VideoDetailPage {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Column() {
      /**
       * 功能描述：本示例主要介绍视频小窗口播放场景，利用媒体的AVPlayer实现视频播放以及相关操作，利用PiPWindow开启悬浮窗从而实现小窗口播放视频。
       * 参数介绍：无
       * README：https://gitee.com/harmonyos-cases/cases/blob/master/CommonAppDevelopment/feature/pipwindow/README.md
       */
      PipWindowViewComponent()
    }
    .height('100%')
    .padding({top: this.topHeight})
    .width('100%')
  }
}