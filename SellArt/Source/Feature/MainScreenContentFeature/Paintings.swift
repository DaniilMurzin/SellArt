import UIKit

struct Paintings {
    let id: Int
    let image: UIImage
    let artist: String
    let name: String
    let price: Double
    let dimensions: String
    let type: String
    let material: String
    let city: String
    var view: Int {
        Int.random(in: 0...10000)
     }
    var isFavorite: Bool

}

struct PaintingsModel {
    
    static let paintings: [Paintings] = [
        Paintings(id: 1,
                  image: UIImage.matisse!,
                  artist: "Анри Матисс",
                  name: "Танец",
                  price: 1000000,
                  dimensions: "200x150 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Москва",
                  isFavorite: false),
        Paintings(id: 2,
                  image: UIImage.matisse2!,
                  artist: "Анри Матисс",
                  name: "Красная комната",
                  price: 1200000,
                  dimensions: "180x160 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Лондон",
                  isFavorite: false),
        
        Paintings(id: 3,
                  image: UIImage.demon!,
                  artist: "Михаил Врубель",
                  name: "Демон сидящий",
                  price: 900000,
                  dimensions: "210x145 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Лондон",
                  isFavorite: false),
        Paintings(id: 4,
                  image: UIImage.lebed!,
                  artist: "Михаил Врубель",
                  name: "Лебедевая царевна",
                  price: 1100000,
                  dimensions: "195x170 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Москва",
                  isFavorite: false),
        Paintings(id: 5,
                  image: UIImage.knight!,
                  artist: "Михаил Врубель",
                  name: "Богатырь",
                  price: 1300000,
                  dimensions: "220x185 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Санкт-Петербург",
                  isFavorite: false),
        Paintings(id: 6,
                  image: UIImage.sunflowers!,
                  artist: "Винсент ван Гог",
                  name: "Подсолнухи",
                  price: 1400000,
                  dimensions: "165x150 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Лондон",
                  isFavorite: false),
        Paintings(id: 7,
                  image: UIImage.lilies!,
                  artist: "Клод Моне",
                  name: "Кувшинки",
                  price: 1500000,
                  dimensions: "210x170 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Москва",
                  isFavorite: false),
        Paintings(id: 8,
                  image: UIImage.impression!,
                  artist: "Клод Моне",
                  name: "Впечатление, восход солнца",
                  price: 1600000,
                  dimensions: "190x160 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Москва",
                  isFavorite: false),
        Paintings(id: 9,
                  image: UIImage.dali1!,
                  artist: "Сальвадор Дали",
                  name: "Сохранение памяти",
                  price: 1700000,
                  dimensions: "240x210 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Москва",
                  isFavorite: false),
        Paintings(id: 10,
                  image: UIImage.dali2!,
                  artist: "Сальвадор Дали",
                  name: "Лебеди, отражающие слонов",
                  price: 1800000,
                  dimensions: "250x220 см",
                  type: "Живопись",
                  material: "Холст и масло",
                  city: "Москва",
                  isFavorite: false)
    ]
}
