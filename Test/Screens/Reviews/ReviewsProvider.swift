import Foundation

/// Класс для загрузки отзывов.
final class ReviewsProvider {

    private let bundle: Bundle

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

}

// MARK: - Internal

extension ReviewsProvider {

    typealias GetReviewsResult = Result<Data, GetReviewsError>

    enum GetReviewsError: Error {

        case badURL
        case badData(Error)

    }

//    func getReviews(offset: Int = 0, completion: @escaping (GetReviewsResult) -> Void) {
//        print("Извлекаем данные")
//        guard let url = bundle.url(forResource: "getReviews.response", withExtension: "json") else {
//            return completion(.failure(.badURL))
//        }
//
//        // Симулируем сетевой запрос - не менять
//        usleep(.random(in: 100_000...1_000_000))
//
//        do {
//            let data = try Data(contentsOf: url)
//            completion(.success(data))
//        } catch {
//            completion(.failure(.badData(error)))
//        }
//    }
    func getReviews(offset: Int = 0, completion: @escaping (GetReviewsResult) -> Void) {
        print("Извлекаем данные")
        
        DispatchQueue.global(qos: .background).async {
            guard let url = self.bundle.url(forResource: "getReviews.response", withExtension: "json") else {
                DispatchQueue.main.async {
                    completion(.failure(.badURL))
                }
                return
            }

            // Симулируем сетевой запрос - не менять
            usleep(.random(in: 100_000...1_000_000))

            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.badData(error)))
                }
            }
        }
    }


}
