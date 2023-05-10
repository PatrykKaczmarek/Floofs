//
// CatsDataSource.swift
// Floofs
//

import CatsAPI

protocol CatsDataSource {

    var cats: [Cat] { get }

    func fetchCats(completion: ((Bool) -> Void)?)

    func fetchImages(cat: Cat, completion: ((Bool) -> Void)?)
}
