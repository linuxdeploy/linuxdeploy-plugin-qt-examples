#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QAction *action = new QAction(this);
    QIcon icon;
    auto iconThemeName = QStringLiteral("list-add");
    if (QIcon::hasThemeIcon(iconThemeName)) {
        icon = QIcon::fromTheme(iconThemeName);
    } else {
        icon.addFile(QStringLiteral("."), QSize(), QIcon::Normal, QIcon::Off);
    }
    action->setIcon(icon);
    ui->mainToolBar->addAction(action);
}

MainWindow::~MainWindow()
{
    delete ui;
}
