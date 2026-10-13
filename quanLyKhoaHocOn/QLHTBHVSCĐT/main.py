import sys

from PyQt6.QtWidgets import QApplication, QDialog

from CuaSo.DangNhap import LoginDialog
from CuaSo.Trangchu import MainWindow


def main():
    app = QApplication(sys.argv)

    login_dialog = LoginDialog()

    # Nếu đăng nhập thất bại hoặc bấm Thoát
    if login_dialog.exec() != QDialog.DialogCode.Accepted:
        sys.exit(0)

    # Đăng nhập thành công thì mở Trang chủ
    window = MainWindow()
    window.show()

    sys.exit(app.exec())


if __name__ == "__main__":
    main()