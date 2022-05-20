//
//  ThirdModuleViewModel.swift
//


// /sourcery/: fileGenerationPath = "../../Modules/Viper/ThirdModule/View/Generated"
struct ThirdModuleViewModel: AutoObjectDiff, AutoEquatable, AutoLenses {
    static var initial: ThirdModuleViewModel {
        .init(value: false)
    }

    let value: Bool
}
