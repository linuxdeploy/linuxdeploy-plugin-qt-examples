#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // There is no warranty that a given icon will be present in the target platform icons theme
    // therefore we must provide a fallback
    QIcon addIcon = QIcon::fromTheme("list-add", QIcon(":/scalable/list-add.svg"));
    QAction *addAction = new QAction(addIcon, tr("&Add..."), this);

    ui->mainToolBar->addAction(addAction);
}

MainWindow::~MainWindow()
{
    delete ui;
}
