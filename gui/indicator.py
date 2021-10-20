from PySide6.QtWidgets import QLabel


class QIndicator(QLabel):
    def __init__(self, x, parent=None, size=12):
        super().__init__(parent)
        self.setGeometry(x, 0, size, size)

