/// Модель отзыва.
struct Review: Decodable {
    /// Имя пользователя
    let first_name: String
    let last_name: String
    /// Оценка пользователя
    let rating: Int
    /// Текст отзыва.
    let text: String
    /// Время создания отзыва.
    let created: String

}
