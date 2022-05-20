//
//  SecondModuleViewModel.swift
//


// /sourcery/: fileGenerationPath = "../../Modules/Viper/SecondModule/View/Generated"
struct SecondModuleViewModel: AutoObjectDiff, AutoEquatable, AutoLenses {
    static var initial: SecondModuleViewModel {
        .init(value: false)
    }

    let value: Bool
}
