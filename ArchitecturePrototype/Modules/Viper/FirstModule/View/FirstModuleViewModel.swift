//
//  FirstModuleViewModel.swift
//


// /sourcery/: fileGenerationPath = "../../Modules/Viper/FirstModule/View/Generated"
struct FirstModuleViewModel: AutoObjectDiff, AutoEquatable, AutoLenses {
    static var initial: FirstModuleViewModel {
        .init(idString: nil,
              idsString: nil,
              datesString: nil,
              stringsString: nil,
              searchInProgress: false)
    }

    let idString: String?
    let idsString: String?
    let datesString: String?
    let stringsString: String?
    let searchInProgress: Bool
}
