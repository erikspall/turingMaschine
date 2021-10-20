from PySide6.QtCore import Qt, QRect
from PySide6.QtWidgets import QLabel, QFrame


class QTapeElement(QLabel):
    def __init__(self, x, y, parent=None, size=25, blank="#"):
        super().__init__(parent)
        # Set all important style stuff
        self.setAlignment(Qt.AlignCenter | Qt.AlignCenter)
        self.setGeometry(x, y, size, size)
        self.setText(blank)

