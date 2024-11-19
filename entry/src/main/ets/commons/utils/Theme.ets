import {ConfigurationConstant } from '@kit.AbilityKit'

export const ColorModeKey = 'zp-color-mode'
class Theme  {
  initTheme(){
    PersistentStorage.persistProp<ConfigurationConstant.ColorMode>(ColorModeKey,ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
    const colorMode = AppStorage.get<ConfigurationConstant.ColorMode>(ColorModeKey)

  }
  setTheme(mode:ConfigurationConstant.ColorMode) {
    AppStorage.set<ConfigurationConstant.ColorMode>(ColorModeKey, mode)
    const context = AppStorage.get<Context>('context')
    context?.getApplicationContext().setColorMode(mode)
  }
  // 跟随系统
  notSet() {
    this.setTheme(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
  }

  // 暗色
  setDark() {
    this.setTheme(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
  }

  // 亮色
  setLight() {
    this.setTheme(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
  }

}
export const theme = new Theme()