#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QLabel *lbl = new QLabel;
    lbl->setText("Du Hurensohn");
    statusBar()->addWidget(lbl);
}

MainWindow::~MainWindow()
{
    delete ui;
}

