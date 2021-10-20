import sys
from PySide6.QtUiTools import QUiLoader
from PySide6.QtWidgets import QApplication
from PySide6.QtCore import QFile, QIODevice

from gui.tape import QTape

if __name__ == "__main__":
    app = QApplication(sys.argv)

    ui_file_name = "mainwindow.ui"
    ui_file = QFile(ui_file_name)
    if not ui_file.open(QIODevice.ReadOnly):
        print(f"Cannot open {ui_file_name}: {ui_file.errorString()}")
        sys.exit(-1)
    loader = QUiLoader()
    window = loader.load(ui_file)
    ui_file.close()
    if not window:
        print(loader.errorString())
        sys.exit(-1)
    window.show()

    test = QTape(window, size=50)
    window.layout().addWidget(test, 0, 1)
    #self.setLayout(QHBoxLayout(self))  # needed?
    window.tape_frame.children().append(test)
    test.show()
    sys.exit(app.exec())
