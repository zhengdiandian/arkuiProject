import { LoginParams, PageData, QuestionItem, QuestionListParams, QuestionType, User } from '../../models'
import {http} from '../utils/request'
import { RequestData } from '@kit.BasicServicesKit'
import { AxiosRequestConfig } from '@ohos/axios'



export  const login = (data:LoginParams): Promise<User>  =>{
  return http.request<User>({
    url: 'login', method: 'post', data
  })

}