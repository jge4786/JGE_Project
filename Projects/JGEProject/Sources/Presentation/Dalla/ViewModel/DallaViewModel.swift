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
        APIService.shared.getDallaBannerData { [weak self] apiData in
                        guard let self = self,
                              let data = apiData as? [DallaBannerInfo] else { return }
            self.data.value = data
            self.changeListType(to: .bj)
        }
    }
    
    func changeListType(to type: TopTenType) {
        listType.value = type
        guard let data = data.value else { return }
        switch type {
        case .bj:
            topList.value = Array(data[0...4])
        case .fan:
            topList.value = [data[5]]
        case .team:
            topList.value = Array(data[6...data.count-1])
        }
    }
    
    func changeData(to data: [DallaBannerInfo]) {
        self.data.value = data
    }
}
