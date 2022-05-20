//
//  FirstModuleViewModel.swift
//


// /sourcery/: fileGenerationPath = "../../Modules/Viper/FirstModule/View/Generated"
struct FirstModuleViewModel: AutoObjectDiff, AutoEquatable, AutoLenses {
    static var initial: FirstModuleViewModel {
        .init(value: false)
    }

    let value: Bool
}
