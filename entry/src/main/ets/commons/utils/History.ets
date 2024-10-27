import { preferences } from '@kit.ArkData'

class History {
  store: preferences.Preferences | null = null

  getStore() {
    if (!this.store) {
      const context = AppStorage.get<Context>('context')
      this.store = preferences.getPreferencesSync(context, { name: 'history-store' })
    }
    return this.store
  }

  async setItem(keyword: string) {
    this.getStore().putSync(keyword, keyword)
    await this.getStore().flush()
  }

  async delItem(keyword: string) {
    this.getStore().deleteSync(keyword)
    this.getStore().flush()
  }

  async clear() {
    this.getStore().clearSync()
    await this.getStore().flush()
  }

  getAll() {
    const obj = this.getStore().getAllSync()
    return Object.keys(obj)
  }
}

export const history = new History()