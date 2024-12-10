/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * 视频信息，包括标题、视频地址、首帧图片、视频详情
 */
export class NewsItem {
  newsName: string; // 标题
  newsVideoSrc: string; // 视频地址
  newsImage: ResourceStr; // 首帧图片
  newsDetails: ResourceStr; // 详情

  constructor(newsName: string, newsVideoSrc: string, newsImage: ResourceStr, newsDetails: ResourceStr) {
    this.newsName = newsName;
    this.newsVideoSrc = newsVideoSrc;
    this.newsImage = newsImage;
    this.newsDetails = newsDetails;
  }
}

export const NEWS_LIST_DATA = [
  // new NewsItem(
  //   "Tech Giant Releases New Smartphone",
  //   "https://example.com/videos/tech-giant-new-smartphone.mp4",
  //   "https://example.com/images/tech-giant-new-smartphone.jpg",
  //   "The latest smartphone from the tech giant features an innovative design and cutting-edge technology."
  // ),
  // new NewsItem(
  //   "Global Markets Rally Amid Economic Optimism",
  //   "https://example.com/videos/global-markets-rally.mp4",
  //   "https://example.com/images/global-markets-rally.jpg",
  //   "Global stock markets saw significant gains today, fueled by optimism over the economic outlook."
  // ),
  // new NewsItem(
  //   "Breakthrough in Renewable Energy Technology",
  //   "https://example.com/videos/renewable-energy-breakthrough.mp4",
  //   "https://example.com/images/renewable-energy-breakthrough.jpg",
  //   "Scientists have made a major breakthrough in renewable energy technology that could revolutionize the industry."
  // ),
  // new NewsItem(
  //   "Historic Peace Agreement Signed",
  //   "https://example.com/videos/peace-agreement-signed.mp4",
  //   "https://example.com/images/peace-agreement-signed.jpg",
  //   "Leaders from both countries signed a historic peace agreement today, ending years of conflict."
  // ),
  // new NewsItem(
  //   "Sports Update: Championship Results",
  //   "https://example.com/videos/championship-results.mp4",
  //   "https://example.com/images/championship-results.jpg",
  //   "In the latest sports update, we cover the results of the championship games held over the weekend."
  // ),
  new NewsItem('AI伦理讨论峰会',
    'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video1.MP4',
    $r('app.media.video_list_autoplay_preview1'), '欢迎收看本次AI伦理讨论峰会视频！此次峰会汇聚了全球顶尖的人工智能专家、伦理学家、政策制定者以及技术行业领导者，共同探讨AI在社会中的应用及其潜在的伦理挑战。视频内容涵盖隐私保护、公平性、透明度、决策自主性等关键议题，旨在促进多方对话与合作，推动负责任的AI发展。通过专家的深入分析和讨论，我们期待为构建一个更安全、更公正、更具包容性的AI未来提供有力支持。敬请关注，启发思考，共同探索AI的伦理边界。'),
  new NewsItem('祝贺！谷神星一号海射型遥二运载火箭发射成功',
    'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video2.MP4',
    $r('app.media.video_list_autoplay_preview2'), '2024年11月7日，谷神星一号海射型遥二运载火箭在黄海海域成功发射，顺利将多颗卫星送入预定轨道。这次发射是中国航天领域的重要里程碑，标志着中国在海上发射技术方面取得了重大突破。火箭发射过程平稳顺利，点火升空、一级分离、二级分离、卫星部署等关键步骤执行完美，展示了中国航天科技的强大实力。此次成功发射为未来的海上发射任务积累了宝贵经验，进一步提升了中国在全球航天领域的竞争力。'),
  new NewsItem('超高速磁悬浮列车',
    'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video3.MP4',
    $r('app.media.video_list_autoplay_preview3'), '中国最近在高速磁悬浮列车技术方面取得了重大突破。这款新型超高速磁悬浮列车可以达到每小时1000公里（621英里）的速度。该前沿运输系统利用超导磁铁，并在低真空管道中运行，使得旅行效率和速度极为高效。在山西省进行的成功测试中，列车展示了稳定的悬浮、精确的导航和安全的停靠能力​\n'),
  new NewsItem('中国首台可用于临床的科研型7T磁共振投入使用',
    'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video4.MP4',
    $r('app.media.video_list_autoplay_preview4'), '中国首台可用于临床的科研型7T磁共振成像设备近日正式投入使用。该设备由国内顶尖科研团队自主研发，具有超高分辨率和更强的磁场强度，能够提供比传统3T磁共振更清晰的影像，极大提升了疾病诊断的准确性和研究能力。7T磁共振的投入使用标志着中国在高端医疗设备领域实现重大突破，将为神经科学、心血管疾病、肿瘤等领域的临床研究和诊断提供强有力的支持，有望推动医疗科技和临床治疗水平的进一步提升'),
  new NewsItem('太阳能技术革新',
    'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video1.MP4',
    $r('app.media.video_list_autoplay_preview1'), '本视频将带您走进太阳能技术的前沿领域，展示最新的革新成果。了解如何通过高效光伏电池、先进的太阳能集热系统，以及创新的储能技术，实现能源利用的最大化。探索太阳能技术在全球范围内的广泛应用，从家庭供电到大规模太阳能发电站，揭示其在减少碳排放和推动可持续发展中的关键作用。通过专家访谈和实际案例，我们将展示太阳能技术如何改变未来能源格局，助力建设绿色地球。'),
  new NewsItem('量子加密通信网',
    'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video2.MP4',
    $r('app.media.video_list_autoplay_preview2'), '量子加密通信网是一种利用量子力学原理确保信息安全的新型通信技术。它通过量子态的叠加和纠缠特性，实现了不可复制和不可破译的通信方式。在量子加密通信中，任何对量子密钥的窃听行为都会改变量子态，进而被检测到，确保通信的绝对安全。这种技术被认为是未来信息安全的重要保障，广泛应用于金融、军事和政府通信等高安全性领域。视频将展示量子加密通信的基本原理、实际应用和未来发展前景，带您深入了解这项前沿科技。'),
  new NewsItem('深海探索潜水器',
    'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video3.MP4',
    $r('app.media.video_list_autoplay_preview3'), '这段视频展示了一艘先进的深海探索潜水器在海底的探险之旅。潜水器配备了高强度的聚光灯和高清摄像头，穿越黑暗的深海环境，捕捉到了丰富多彩的海洋生物和神秘的地形。视频中可以看到潜水器灵活地在海底山脉和珊瑚礁间穿梭，同时探测并记录海洋生物的活动。潜水器的机械臂伸展，轻轻采集样本，为科学研究提供珍贵数据。整个过程展现了人类技术在探索海洋深处的惊人能力和对未知世界的无尽好奇。'),
  new NewsItem('环保材料研发',
    'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video4.MP4',
    $r('app.media.video_list_autoplay_preview4'), '我们的环保材料研发视频展示了最新的创新技术和材料科学突破，致力于减少对环境的影响。视频详细介绍了如何利用可再生资源和废弃物，开发出高性能、低碳排放的材料，适用于建筑、包装和日常生活中。通过先进的实验室测试和实际应用示范，我们展示了这些环保材料的卓越性能和可持续性。科研团队的专家们分享了研发背后的理念和未来愿景，旨在推动绿色科技发展，实现可持续未来。加入我们，探索环保材料的无限可能！'),
  // new NewsItem('太空旅行计划',
  //   'https://gitee.com/harmonyos-cases/cases/raw/master/CommonAppDevelopment/feature/mediafullscreen/src/main/resources/rawfile/media_full_screen_video1.MP4',
  //   $r('app.media.video_list_autoplay_preview1'), '这是视频详情'),
]
