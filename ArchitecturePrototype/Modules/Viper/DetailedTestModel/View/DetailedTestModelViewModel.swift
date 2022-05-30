//
//  DetailedTestModelViewModel.swift
//


// /sourcery/: fileGenerationPath = "../../Modules/Viper/DetailedTestModel/View/Generated"
struct DetailedTestModelViewModel: AutoObjectDiff, AutoEquatable, AutoLenses {
    static var initial: DetailedTestModelViewModel {
        .init(id: nil, strings: nil)
    }

    let id: String?
    let strings: String?
}
