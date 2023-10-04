import UIKit

struct Paintings {
    let id: Int
    let image: UIImage
    let artist: String
    let name: String
    let price: Double
}

struct PaintingsModel {
    
    static let paintings: [Paintings] = [
        Paintings(id: 1,
                  image: UIImage.matisse!,
                  artist: "Henri Matisse",
                  name: "Dance",
                  price: 1000000),
        Paintings(id: 2,
                  image: UIImage.matisse2!,
                  artist: "Henri Matisse",
                  name: "Red Room",
                  price: 1200000),
        Paintings(id: 3,
                  image: UIImage.demon!,
                  artist: "Mikhail Vrubel",
                  name: "Demon Seated",
                  price: 900000),
        Paintings(id: 4,
                  image: UIImage.lebed!,
                  artist: "Mikhail Vrubel",
                  name: "The Swan Princess",
                  price: 1100000),
        Paintings(id: 5,
                  image: UIImage.knight!,
                  artist: "Mikhail Vrubel",
                  name: "Bogatyr",
                  price: 1300000),
        Paintings(id: 6,
                  image: UIImage.sunflowers!,
                  artist: "Vincent van Gogh",
                  name: "Sunflowers",
                  price: 1400000),
        Paintings(id: 7,
                  image: UIImage.lilies!,
                  artist: "Claude Monet",
                  name: "Water Lilies",
                  price: 1500000),
        Paintings(id: 8,
                  image: UIImage.impression!,
                  artist: "Claude Monet",
                  name: "Impression, Sunrise",
                  price: 1600000),
        Paintings(id: 9,
                  image: UIImage.dali1!,
                  artist: "Salvador Dalí",
                  name: "The Persistence of Memory",
                  price: 1700000),
        Paintings(id: 10,
                  image: UIImage.dali2!,
                  artist: "Salvador Dalí",
                  name: "Swans Reflecting Elephants",
                  price: 1800000)
    ]
}
