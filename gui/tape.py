from PySide6.QtWidgets import QFrame, QLayout, QHBoxLayout, QVBoxLayout, QGridLayout

from gui.indicator import QIndicator
from gui.tape_element import QTapeElement


class QTape(QFrame):
    def __init__(self, parent=None, blank="#", size=50):
        super().__init__(parent)
        self.is_initialized = False
        self.tapeElements = []
        self.size = size
        self.setGeometry(0, 0, parent.width(), parent.height())
        #layout = QGridLayout(parent)
        #layout.setSpacing(0)
       # layout.setMargin(0)

        #layout.setContentsMargins(0,0,0,0)

        #layout.addWidget(self, 0, 0)
       #parent.setLayout(layout)



        # fill with TapeElements
        i = 0
        while len(self.tapeElements) < (self.width() / self.size):
            my_tape_element = QTapeElement(i * self.size, size/2, self)
            #self.children().append(my_tape_element)
            self.tapeElements.append(my_tape_element)
            i = i + 1
        #
        # add Indicator
        self.indicator = QIndicator(((self.width() / size) / 2) - 1, self, size / 2)
        #self.children().append(self.indicator)

        self.show() # important
