ID = lets-theia
NAME = "Let's Theia"
VERSION = "1.43.1"

PWD = `pwd`

ELECTRON_APP_PATH = $(PWD)/applications/electron
TARGET = LetsTheia.AppImage
DIST_PATH = $(ELECTRON_APP_PATH)/dist/$(TARGET)
DESKTOP_LINK = $(PWD)/$(ID).desktop
EXEC_SH = ${PWD}/$(ID)
ICON_PATH = $(ELECTRON_APP_PATH)/resources/icons/512x512.png

BIN_DIR = /usr/bin
DESKTOP_DIR = /usr/share/applications
INSTALL_DEST = /opt/$(TARGET)
ICON_DEST = /usr/share/icons/hicolor/512x512/apps/theia.png

.PHONY: all-preview linux-install linux-uninstall

all:
	@yarn build
    @yarn download:plugins
	@yarn package:applications

linux-install:
	@cp -vf $(DIST_PATH) $(INSTALL_DEST)
	@cp -vf $(EXEC_SH) $(BIN_DIR)
	@cp -vf $(DESKTOP_LINK) $(DESKTOP_DIR)
	@cp -vf $(ICON_PATH) $(ICON_DEST)

linux-uninstall:
	@rm -v $(INSTALL_DEST)
	@rm -v $(BIN_DIR)/$(ID)
	@rm -v $(DESKTOP_DIR)/$(ID).desktop
	@rm -v $(ICON_DEST)
