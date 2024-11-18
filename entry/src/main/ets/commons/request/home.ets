import { PageData, QuestionItem, QuestionListParams, QuestionType, StudyTimeData, User } from '../../models'
import {http} from '../utils/request'
import { RequestData } from '@kit.BasicServicesKit'
import { AxiosRequestConfig, FormData } from '@ohos/axios'

export const   getQuestionTypeList =  async  () =>  {
  return await http.request<QuestionType[]>({ url: 'question/type' })
}

export  const getQuestionList = (params:AxiosRequestConfig<RequestData>): Promise<PageData<QuestionItem>>  =>{

  return http.request(params )

}

export  const getStudyInfo = (): Promise<StudyTimeData> => {
 return http.request<StudyTimeData>({ url: 'studyInfo' })
}
export const  updateNickName = (user: User):Promise<User> => {
  return http.request<User, User>({
    url: 'userInfo/profile',
    method: 'post',
    data: user
  })
}
export  const setAvatar = (formData : FormData, context: Context):Promise<User> => {
  return http.request<User>({
    url: 'userInfo/avatar',
    method: 'post',
    data: formData,
    headers: { 'Content-Type': 'multipart/form-data' },
    context
  })
}
export const  getUserInfo = ():Promise<User> => {
  return http.request<User>({
    url: 'userInfo',
    method: 'get',
  })
}
