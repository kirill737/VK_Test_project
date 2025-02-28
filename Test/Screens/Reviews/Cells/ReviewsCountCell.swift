import UIKit

struct ReviewsCountCellConfig {
    /// Количество отзывов
    let reviewsCount: Int
    
    fileprivate let layout = ReviewsCountCellLayout()
}

// MARK: - TableCellConfig

extension ReviewCellConfig: TableCellConfig {
    
    /// Метод обновления ячейки.
    /// Вызывается из cellForRowAt: у dataSource таблицы.
    func update(cell: UITableViewCell) {
        // TODO: count
        guard let cell = cell as? ReviewsCountCell else { return }
        cell.avatarImageView.image = image
        cell.usernameLabel.attributedText = username
        cell.ratingImageView.image = ratingRender.ratingImage(rating)
        cell.reviewTextLabel.attributedText = reviewText
        cell.reviewTextLabel.numberOfLines = maxLines
        cell.createdLabel.attributedText = created
        cell.config = self
    }
    
    /// Метод, возвращаюший высоту ячейки с данным ограничением по размеру.
    /// Вызывается из heightForRowAt: делегата таблицы.
    func height(with size: CGSize) -> CGFloat {
        layout.height(config: self, maxWidth: size.width)
        
    }
}
    
// MARK: - Cell

final class ReviewCell: UITableViewCell {
    fileprivate var config: Config?
 
    fileprivate let reviewsCountLabel = UILabel()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = config?.layout else { return }
        reviewsCountLabel.frame = layout.reviewCountLabelFrame
    }

}

// MARK: - Private

private extension ReviewsCountCell {

    func setupCell() {
        setupReviewsCountLabel()
    }
    // TODO:  setup
    func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = ReviewCellLayout.avatarCornerRadius
        avatarImageView.layer.masksToBounds = true
    }
    func setupReviewsCountLabel() {
        contentView.addSubview(reviewsCountLabel)
        reviewsCountLabel.lineBreakMode = .byWordWrapping
    }
}

// MARK: - Layout

/// Класс, в котором происходит расчёт фреймов для сабвью ячейки отзыва.
/// После расчётов возвращается актуальная высота ячейки.
private final class ReviewsCountCellLayout {

    // MARK: - Фреймы
    
    private(set) var reviewsCountLabelFrame = CGRect.zero
    
    // MARK: - Отступы
    
    /// Отступы от краёв ячейки до её содержимого.
    private let insets = UIEdgeInsets(top: 9.0, left: 12.0, bottom: 9.0, right: 12.0)
    
    // MARK: - Расчёт фреймов и высоты ячейки
    
    /// Возвращает высоту ячейку с данной конфигурацией `config` и ограничением по ширине `maxWidth`.
    func height(config: Config, maxWidth: CGFloat) -> CGFloat {
        let width = maxWidth - insets.left - insets.right
        
        var maxY = insets.top
        let minX = insets.left
        
        reviewsCountLabelFrame = CGRect(
            origin: CGPoint(x: minX, y: maxY),
            size: config..boundingRect(width: width).size
        )

        return reviewsCountLabelFrame.maxY + insets.bottom
    }
}

// MARK: - Typealias

fileprivate typealias Config = ReviewsCountCellConfig
fileprivate typealias Layout = ReviewsCountCellLayout
