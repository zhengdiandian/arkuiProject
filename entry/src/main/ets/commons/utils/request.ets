import axios, { AxiosError, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { auth } from './Auth'
import { logger } from './Logger'

export const baseURL = 'https://api-harmony-teach.itheima.net/hm/'

export const instance = axios.create({
  baseURL,
  timeout: 100000
})

// 响应拦截器
instance.interceptors.response.use((res: AxiosResponse) => {
  if (res.data.code === 10000) {
    logger.debug('Req Success', JSON.stringify(res.data.data))
    return res.data.data
  }
  logger.error('Req Error', JSON.stringify(res.data))
  return Promise.reject(res.data)
}, (err: AxiosError) => {
  logger.error('Req Error', JSON.stringify(err))
  return Promise.reject(err)
})
// 请求拦截器
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  const user = auth.getUser()
  if (user.token) {
    config.headers.Authorization = `Bearer ${user.token}`
  }
  return config
}, (err: AxiosError) => {
  return Promise.reject(err)
})

class Http {
  // Get 请求可以省略第二个泛型，因为axios默认是any任何值可传
  request<ResponseData, RequestData = Object>(config: AxiosRequestConfig<RequestData>) {
    return instance<null, ResponseData, RequestData>(config)
  }
}

export const http = new Http()
