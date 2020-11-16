#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}



//call with updateStatusBar(&steps,&state);
void MainWindow::updateStatusBar(int *steps, int *state){
    for (int i=0;i<statusBar()->children().length();i++){
        statusBar()->removeWidget(static_cast<QWidget*>(statusBar()->children().at(i)));
    }
    statusBar()->addWidget(new QLabel("Schritte: " + (new QString)->setNum(*steps) + "\t"));
    statusBar()->addWidget(new QLabel("Zustand: " + (new QString)->setNum(*state) + "\t"));
}
