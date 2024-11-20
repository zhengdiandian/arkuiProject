import { common, ConfigurationConstant } from '@kit.AbilityKit'

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
    // todo  config.colorMode 只有 COLOR_MODE_DARK 和 COLOR_MODE_LIGHT , 也就是可以判断是否是暗色，COLOR_MODE_NOT_SET时没法判断
    AppStorage.setOrCreate('isDark',
      (context as common.UIAbilityContext).config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
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