#include "qtape.h"
#include "QPixmap"
QTape::QTape(QFrame *frame, int size)
{
    this->frame = frame;
    sizing = size;
    adjustPanels();
    labelIndicator = new QLabel(frame);
    QPixmap pixmap(":/icons/icons/ic_arrow_downward.png");
    labelIndicator->setGeometry((((tapeLabels.length()/2)-2)*sizing)+12.5,0,25,25); //Sizing may change
    labelIndicator->setPixmap(pixmap.scaled(25,25,Qt::KeepAspectRatio));
}

void QTape::adjustPanels(){
    for (int i = -1; i<(frame->width()/sizing)+1;i++){
        QLabel* myLbl = new QLabel(frame);
        myLbl->setText("#");
        myLbl->setStyleSheet("border: 1px solid black");
        myLbl->setAlignment(Qt::AlignCenter);
        myLbl->setGeometry(sizing*i,25,sizing,sizing);
        tapeLabels.append(myLbl);
  }
}
