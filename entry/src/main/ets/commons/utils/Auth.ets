import { User } from '../../models'
import { router } from '@kit.ArkUI'

export const UserStoreKey = 'hc-user'
class Auth {
  initUser() {
    PersistentStorage.persistProp<User>(UserStoreKey, {} as User)
  }
  getUser() {
    return AppStorage.get<User>(UserStoreKey) || {} as  User
  }
  setUser(user: User) {
    return AppStorage.setOrCreate<User>(UserStoreKey , user)
  }
  /**
   * @param options 是路由跳转参数 或 是一个回调函数
   */
  checkAuth(options: router.RouterOptions | Function) {
    const user = this.getUser()
    if (user.token) {
      // 已登录，路由跳转和函数调用正常放行
      if (typeof options === 'function') {
        options()
      } else {
        router.pushUrl(options)
      }
    } else {
      // 未登录，拦截到登录页
      if (typeof options === 'function') {
        router.pushUrl({ url: 'pages/LoginPage' })
      } else {
        // 带上 return_url 用户登录回跳
        const params = options.params as Record<string, string> || {}
        params.return_url = options.url
        router.pushUrl({ url: 'pages/LoginPage', params })
      }
    }
  }
}
export const auth = new Auth()