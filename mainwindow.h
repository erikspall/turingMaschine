#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <qtape.h>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void updateStatusBar(int steps,int state);
     void resizeEvent(QResizeEvent*);
    void on_actionRunButton_triggered();

private:
    Ui::MainWindow *ui;
    QTape *tape;

};
#endif // MAINWINDOW_H
