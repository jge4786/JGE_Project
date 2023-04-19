// MARK: - BannerList
struct BannerList: Codable {
    let memNo, subjectType: String
    let idx: Int
    let buttonNm: String
    let typeImage: Int
    let thumbsURL, risingYn: String
    let bannerListImageProfile, thumbnailURL: String
    let contents, memNick, title: String
    let isCookie: Int
    let imageBackground: String
    let badgeSpecial: Int
    let linkURL: String
    let popupType, isTitleView: Int
    let memSex: String
    let conDjYn, isButtonView: Int
    let roomNo: String
    let imageProfile: ImageProfile
    let badgeNewdj: Int
    let bjGradeBadgeList: BjGradeBadgeList
    let linkType, djGrade, bannerURL: String

    enum CodingKeys: String, CodingKey {
        case memNo = "mem_no"
        case subjectType = "subject_type"
        case idx, buttonNm
        case typeImage = "type_image"
        case thumbsURL = "thumbsUrl"
        case risingYn
        case bannerListImageProfile = "image_profile"
        case thumbnailURL = "thumbnailUrl"
        case contents
        case memNick = "mem_nick"
        case title
        case isCookie = "is_cookie"
        case imageBackground = "image_background"
        case badgeSpecial
        case linkURL = "linkUrl"
        case popupType = "popup_type"
        case isTitleView = "is_title_view"
        case memSex = "mem_sex"
        case conDjYn
        case isButtonView = "is_button_view"
        case roomNo = "room_no"
        case imageProfile, badgeNewdj, bjGradeBadgeList, linkType, djGrade
        case bannerURL = "bannerUrl"
    }
}

// MARK: - BjGradeBadgeList
struct BjGradeBadgeList: Codable {
    let resourceType, code: String
}

// MARK: - ImageProfile
struct ImageProfile: Codable {
    let thumb292X292, thumb500X500, thumb120X120, thumb62X62: String
    let thumb700X700: String
    let isDefaultImg: Bool
    let thumb336X336, thumb100X100, thumb80X80, url: String
    let path: String
    let thumb50X50, thumb190X190, thumb88X88, thumb150X150: String

    enum CodingKeys: String, CodingKey {
        case thumb292X292 = "thumb292x292"
        case thumb500X500 = "thumb500x500"
        case thumb120X120 = "thumb120x120"
        case thumb62X62 = "thumb62x62"
        case thumb700X700 = "thumb700x700"
        case isDefaultImg
        case thumb336X336 = "thumb336x336"
        case thumb100X100 = "thumb100x100"
        case thumb80X80 = "thumb80x80"
        case url, path
        case thumb50X50 = "thumb50x50"
        case thumb190X190 = "thumb190x190"
        case thumb88X88 = "thumb88x88"
        case thumb150X150 = "thumb150x150"
    }
}
