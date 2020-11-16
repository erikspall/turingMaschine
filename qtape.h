#ifndef QTAPE_H
#define QTAPE_H

#include <QFrame>
#include <QLabel>
#include <QList>

class QTape
{
public:
    QTape(QFrame *frame, int size);
    void adjustPanels();
private:
    int sizing;
    QFrame* frame;
    QList<QLabel*> tapeLabels;
    QLabel* labelIndicator;
};

#endif // QTAPE_H
