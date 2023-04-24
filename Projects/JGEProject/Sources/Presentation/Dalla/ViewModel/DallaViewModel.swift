class DallaViewModel {
    enum TopTenType {
        case bj
        case fan
        case team
    }
    
    var data: Observable<[DallaBannerInfo]?> = Observable(nil)
    var topList: Observable<[DallaBannerInfo]?> = Observable(nil)
    var listType: Observable<TopTenType> = Observable(.bj)
    
    init() {
//        data = APIService.shared.getDallaBannerData {
            //            guard let self = self,
            //                  let data = data as? [DallaBannerInfo] else { return }
            //
            //
            //
            //            self.mainBannerScrollView.initialize(data: data)
//        }
        data.value = APIService.shared.mock
        changeListType(to: .bj)
    }
    
    func changeListType(to type: TopTenType) {
//        listType.value = type
        guard let data = data.value else { return }
        switch type {
        case .bj:
            topList.value = [data[0], data[2]]
        case .fan:
            topList.value = [data[1]]
        case .team:
            topList.value = [data[3]]
        }
    }
    
    func changeData(to data: [DallaBannerInfo]) {
        self.data.value = data
    }
}
