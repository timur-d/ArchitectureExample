//
// Created by Mikhail Mulyar on 2018-11-30.
// Copyright (c) 2018 Den Ree. All rights reserved.
//

import Foundation


// MARK: - Sourcery Markers
/*
 Use them only for models, for which you want to generate code
*/
protocol AutoEquatable {}


protocol AutoInitializable {}


protocol AutoLenses {}


protocol AutoObjectDiff: AutoLenses {}


protocol AutoDatabaseMappable {}


// MARK: - DI generation
protocol AutoInjectableService {}


protocol AutoInjectableModule {}


protocol AutoInjectableCoordinator {}


protocol AutoFactoryImplementation {}
