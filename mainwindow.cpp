#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->frameTape->setGeometry(0,0,800,75); //Not the best solution, but it works for now (better onShow but it doesnt exist)
    tape = new QTape(ui->frameTape, 50); //init the tape
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

void MainWindow::on_actionRunButton_triggered()
{


}
