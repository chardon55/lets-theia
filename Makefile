ID = lets-theia
NAME = "Let's Theia"
VERSION = "1.43.1"

PWD = `pwd`

ELECTRON_APP_PATH = $(PWD)/applications/electron
DIST_PATH = $(ELECTRON_APP_PATH)/dist/linux-unpacked
DESKTOP_LINK = $(PWD)/$(ID).desktop
EXEC_SH = ${PWD}/$(ID)
ICON_PATH = $(ELECTRON_APP_PATH)/resources/icons/512x512.png

BIN_DIR = /usr/bin
DESKTOP_DIR = /usr/share/applications
INSTALL_DIR = /opt/$(ID)
ICON_DEST = /usr/share/icons/hicolor/512x512/apps/theia.png

.PHONY: all-preview linux-install linux-uninstall

all-preview:
    @yarn download:plugins
	@yarn build
	@yarn package:applications:preview

linux-install: linux-uninstall
	@cp -vrf $(DIST_PATH) $(INSTALL_DIR)
	@cp -vf $(EXEC_SH) $(BIN_DIR)
	@cp -vf $(DESKTOP_LINK) $(DESKTOP_DIR)
	@cp -vf $(ICON_PATH) $(ICON_DEST)

linux-uninstall:
	@rm -vrf $(INSTALL_DIR)
	@rm -vf $(BIN_DIR)/$(ID)
	@rm -vf $(DESKTOP_DIR)/$(ID).desktop
	@rm -vf $(ICON_DEST)
