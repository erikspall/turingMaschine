#include "qtape.h"
#include "QPixmap"
#include <QPropertyAnimation>
#include <QParallelAnimationGroup>

QTape::QTape(QFrame *frame, int size, QChar blank)
{
    this->blank = blank;
    this->frame = frame; // Sets Containerframe
    sizing = size; //   Sets size of tapePanels
    isMoving=false;
    frame->setMinimumHeight(sizing+(sizing/2));
    frame->setGeometry(0,0,440,sizing+(sizing/2));
    frame->show();
    initPanels();

}

void QTape::initPanels(){                    //could be 1?
    for (int i = -1; ((frame->width()/sizing)+2) > tapeLabels.length();i++){
        QLabel* myLbl = new QLabel(frame);
        myLbl->setText("#");
        myLbl->setStyleSheet("border: 1px solid black");
        myLbl->setAlignment(Qt::AlignCenter);
        myLbl->setGeometry(sizing*i,sizing/2,sizing,sizing);
        tapeLabels.append(myLbl);
        tapeContent.append('#');
    }

    //  Sets Panel with Indicator
    labelIndicator = new QLabel(frame);
    QPixmap pixmap(":/icons/icons/ic_arrow_downward.png");
    labelIndicator->setGeometry((((tapeLabels.length()-2)/2)*sizing)+(sizing/4),0,sizing/2,sizing/2); //Sizing may change
    labelIndicator->setPixmap(pixmap.scaled(sizing/2,sizing/2,Qt::KeepAspectRatio));
    //

    index = tapeLabels.length()/2;
    indexInContent = index;
}
void QTape::adjustPanels(){
    while (((frame->width() / sizing) + 2 > tapeLabels.length())){
        // If amount of Panels is even
        if ((tapeLabels.length() % 2) != 0) {
            for (QLabel* lbl: tapeLabels){
                //  Move all tapeLabels to the right
                lbl->setGeometry(lbl->geometry().x() + sizing, sizing/2, sizing, sizing);
            }

            // Correct position of Indicator
            labelIndicator->setGeometry(labelIndicator->geometry().x() + sizing, 0, sizing/2, sizing/2);

            // New tapeElement
            QLabel* myLbl = new QLabel(frame);

            myLbl->setStyleSheet("border: 1px solid black");
            myLbl->setAlignment(Qt::AlignCenter);


            //If content then load content, else add content
            if (indexInContent - (index + 1) >= 0) {
                myLbl->setText(tapeContent.at(indexInContent - (index + 1)));
            } else {
                myLbl->setText(blank);
                tapeContent.append(blank);
            }

            //  Add myLbl to GUI and adjust index
             myLbl->setGeometry(-sizing,25,sizing,sizing);
             myLbl->show();
             tapeLabels.insert(0, myLbl);
             index++;
        } else {
            // New tapeElement
            QLabel* myLbl = new QLabel(frame);
            myLbl->setStyleSheet("border: 1px solid black");
            myLbl->setAlignment(Qt::AlignCenter);

            if (indexInContent + (tapeLabels.length() - index) < tapeContent.length()) {
                myLbl->setText(tapeContent.at(indexInContent + (tapeLabels.length() - index)));
            } else {
                myLbl->setText(blank);
                tapeContent.append(blank);
            }

            //  Add myLbl to GUI and adjust index
             myLbl->setGeometry((tapeLabels.length()-1) * sizing,sizing/2,sizing,sizing);
             myLbl->show();
             tapeLabels.append(myLbl);
        }
    }

    // While there is no room for lbls
    while ((frame->width() / sizing) + 2 < tapeLabels.length()-1){
        //  if even
        if ((tapeLabels.length() % 2) == 0){
            // Move Elements to left
            for (QLabel* lbl : tapeLabels){
                lbl->setGeometry(lbl->geometry().x() - sizing, sizing/2, sizing, sizing);
            }

            // Adjust Indicator
            labelIndicator->setGeometry(labelIndicator->geometry().x()-sizing, 0 ,sizing/2, sizing/2);

            //Delete tapeLbls
           tapeLabels.at(0)->deleteLater();
           tapeLabels.removeAt(0);
           index--;
        } else {
            // Delete TapeElement
            tapeLabels.at(tapeLabels.length()-1)->deleteLater();
            tapeLabels.removeAt(tapeLabels.length() - 1);

        }
    }
  //  frame->update();
}

int QTape::panelCount(){
    return tapeLabels.length();
}

void QTape::write(QChar c){
    tapeContent.removeAt(indexInContent);
    tapeContent.insert(indexInContent, c);
    tapeLabels.at(index)->setText(c);
}

void QTape::moveLeft(){
    if (!isMoving){
        isMoving=true;

        QLabel* myLbl = new QLabel(frame);
        myLbl->setText(blank);
        myLbl->setStyleSheet("border: 1px solid black");
        myLbl->setAlignment(Qt::AlignCenter);
        myLbl->setGeometry(sizing*(tapeLabels.length()-1),sizing/2,sizing,sizing);

        if (indexInContent + (tapeLabels.length() - index) < tapeContent.length()) {
            myLbl->setText(tapeContent.at(indexInContent + (tapeLabels.length() - index)));
        } else {
            myLbl->setText(blank);
            tapeContent.append(blank);
        }
        myLbl->show();
        tapeLabels.append(myLbl);

        QParallelAnimationGroup *group = new QParallelAnimationGroup();

        for (QLabel *lbl:tapeLabels){
            // Implementiere QParallelAnimationGroup!!! https://stackoverflow.com/questions/46529155/qt-c-moving-several-labels-at-the-same-time
            QPropertyAnimation *animationLeft = new QPropertyAnimation(nullptr,"geometry");
            animationLeft->setDuration(1000);
            animationLeft->setTargetObject(lbl);
            animationLeft->setStartValue(lbl->geometry());
            animationLeft->setEndValue(QRect(lbl->geometry().x()-sizing,lbl->geometry().y(),sizing,sizing));
            group->addAnimation(animationLeft);
        }
        group->start();
        indexInContent++;
    }
}


