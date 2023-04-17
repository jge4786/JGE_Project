
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "JGEProject",
    platform: .iOS,
    product: .app,
    dependencies: [
        .project(target: "ThirdPartyLib", path: .relativeToRoot("Projects/ThirdPartyLib")),
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
