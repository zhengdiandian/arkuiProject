import { PageData, QuestionItem, QuestionListParams, QuestionType, StudyTimeData } from '../../models'
import {http} from '../utils/request'
import { RequestData } from '@kit.BasicServicesKit'
import { AxiosRequestConfig } from '@ohos/axios'

export const   getQuestionTypeList =  async  () =>  {
  return await http.request<QuestionType[]>({ url: 'question/type' })
}

export  const getQuestionList = (params:AxiosRequestConfig<RequestData>): Promise<PageData<QuestionItem>>  =>{

  return http.request(params )

}

export  const getStudyInfo = (): Promise<StudyTimeData> => {
 return http.request<StudyTimeData>({ url: 'studyInfo' })
}