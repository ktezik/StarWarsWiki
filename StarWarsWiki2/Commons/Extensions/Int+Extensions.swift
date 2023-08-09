import UIKit

extension Int {

    private var iPhoneXSize: (width: CGFloat, height: CGFloat) { (375, 812) }
    private var screenSize: CGSize { UIScreen.main.bounds.size }
    
    /// Используется для увеличения различных размеров (шрифтов, высот и ширин). Увеличивает, если высота экрана больше высоты экрана iPhoneX. Если экран меньше, то ничего не делает.
    var fit: CGFloat {
        var ratio: CGFloat = 1
        // Если девайс более новый, чем iPhoneX, и его высота экрана больше, то  можно всё увеличивать пропорционально высоте экрана. Если это старые девайсы, у которых экран по высоте меньше, то можно оставить размер, как он есть.
        if screenSize.height > iPhoneXSize.height {
            ratio = screenSize.height / iPhoneXSize.height
        }
        return CGFloat(self) * ratio
    }
    
    /// Используется для подгонки вертикальных констрейнтов.
    var fitY: CGFloat {
        var ratio: CGFloat = 1
        if screenSize.height >= iPhoneXSize.height {
            ratio = screenSize.height / iPhoneXSize.height
        } else {
            // Констрейнты лейблов привязаны к низу экрана. Для старых девайсов нужно спускать надписи сильнее, чем поднимать для новых, поэтому добавлен коэффициент 1.15, взятый на глаз. Картинки у старых девайсов пропорционально больше, чем у новых девайсов с узкими типоразмерами экранов, и без этого коэффициента они почти слипаются с лейблами.
            ratio = screenSize.height / iPhoneXSize.height / 1.15
        }
        return CGFloat(self) * ratio
    }
    
    /// Подогнать под ширину экрана iPhoneX.
    var fitW: CGFloat {
        let ratio = screenSize.width / iPhoneXSize.width
        return CGFloat(self) * ratio
    }
    
    /// Подогнать под высоту экрана iPhoneX.
    var fitH: CGFloat {
        let ratio = screenSize.height / iPhoneXSize.height
        return CGFloat(self) * ratio
    }
    
    /// Сделать пропорционально ширине экрана iPhoneX, только если ширина текущего устройства больше ширины iPhoneX.
    var fitWMore: CGFloat {
        let ratio = screenSize.width / iPhoneXSize.width
        return ratio > 1 ? CGFloat(self) * ratio : CGFloat(self)
    }
}
