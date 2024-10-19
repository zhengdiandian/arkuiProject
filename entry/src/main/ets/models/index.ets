export interface QuestionType {
  id: number
  name: string
  displayNewestFlag: 0 | 1
}
export interface QuestionItem {
  id: string;
  /* 题干 */
  stem: string;
  /* 难度 */
  difficulty: number;
  /* 点赞数 */
  likeCount: number;
  /* 浏览数 */
  views: number;
  /* 是否已看 */
  readFlag: 0 | 1;
}
export interface PageData<T> {
  total: number
  pageTotal: number
  rows: T[]
}

export enum SortType {
  Default = 0,
  DifficultyLow = 10,
  DifficultyHigh = 11,
  ViewLow = 20,
  ViewHigh = 21,
  Commend = 30
}

export interface QuestionListParams {
  type: number
  questionBankType: 9 | 10
  sort?: SortType
  page?: number
  pageSize?: number
}
export interface User {
  id: string
  username: string
  avatar: string
  token: string
  nickName?: string
  // 学习时长
  totalTime?: number
  // 打卡次数
  clockinNumbers?: number
}
export interface LoginParams{
  username: string
  password:string
}