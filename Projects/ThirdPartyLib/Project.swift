import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdPartyLib",
    product: .framework,
    packages: [],
    dependencies: [
        .external(name: "SnapKit"),
        .external(name: "SwiftyJSON"),
        .external(name: "Kingfisher"),
        .external(name: "Then"),
        .external(name: "Alamofire")
    ]
)
