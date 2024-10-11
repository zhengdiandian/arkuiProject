import { logger, statusBar } from '../commons/utils';
logger.info('IndexPage', '这是首页的日志')
@Entry
@Component
struct Index {
  @StorageProp('topHeight') topHeight: number = 0
  @StorageProp('bottomHeight') bottomHeight: number = 0

  build() {
    Column() {
      Text('top')
      Row() {
        Button('Light')
          .onClick(() => {
            statusBar.setLightBar()

          })
        Button('Dark')
          .onClick(() => {
            statusBar.setDarkBar()
          })
      }
      Blank()
      Text('bottom11')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('red')
    .padding({ top: this.topHeight, bottom: this.bottomHeight })
  }
}