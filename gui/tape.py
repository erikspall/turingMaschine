from PySide6.QtWidgets import QFrame

from gui.tape_element import QTapeElement


class QTape(QFrame):
    def __init__(self, parent=None, blank="#", size=25):
        self.is_initialized = False
        self.tapeElements = []
        self.size = size

        super().__init__(parent)
        # fill with TapeElements
        i = 0
        while len(self.tapeElements) < (self.width() / self.size):
            my_tape_element = QTapeElement(i * self.size, size / 2, self)
            self.layout().addWidget(my_tape_element)
            self.tapeElements.append(my_tape_element)
            i = i + 1
        #
        # add Indicator


