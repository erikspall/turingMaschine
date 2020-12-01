#ifndef QTAPE_H
#define QTAPE_H

#include <QFrame>
#include <QLabel>
#include <QList>

class QTape
{
public:
    QTape(QFrame *frame, int size, QChar blank);
    void initPanels();
    void adjustPanels();
    int panelCount();
    void write(QChar c);
    void moveLeft();
private:
    int sizing;
    QFrame* frame;
    QList<QLabel*> tapeLabels;
    QLabel* labelIndicator;
    QList<QChar> tapeContent;
    QChar blank;
    qint64 indexInContent, index;
    bool isMoving;
    void onAnimationLeftEnd();
};

#endif // QTAPE_H
