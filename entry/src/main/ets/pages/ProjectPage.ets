import { VideoListAutoplayComponent } from "videolistautoplay";

@Component
export struct ProjectPage {
  build() {
    /**
     * 功能描述：利用onScrollIndex获取List显示区域内中间子组件索引值的能力来判断播放，利用懒加载场景会预加载List显示区域外cachedCount的内容的能力来实现视频连续播放的功能。
     * 参数介绍：无
     * README：https://gitee.com/harmonyos-cases/cases/blob/master/CommonAppDevelopment/feature/videolistautoplay/README.md
     */
    VideoListAutoplayComponent()
  }
}