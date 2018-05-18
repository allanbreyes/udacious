ARCH := x64
NAME := Udacious
URL  := https://classroom.udacity.com

.PHONY: all setup linux osx windows tarballs clean

all: setup
all: udacious-linux-64
all: Udacious-darwin-x64
all: Udacious-win32-x64
all: tarballs

setup:
	@yarn install || npm install

linux: udacious-linux-64
udacious-linux-64:
	@echo "\n== Linux build =="
	@yarn run nativefier "$(URL)" --name $(NAME) -a $(ARCH) -p linux

osx: Udacious-darwin-x64
Udacious-darwin-x64:
	@echo "\n== OSX build =="
	@yarn run nativefier "$(URL)" --name $(NAME) -a $(ARCH) -p osx

windows: Udacious-win32-x64
Udacious-win32-x64: setup
	@echo "\n== Windows build =="
	@yarn run nativefier "$(URL)" --name $(NAME) -a $(ARCH) -p windows

tarballs:
	@echo "\n== Packaging tarballs =="
	@for dir in [uU]dacious-*/; do tar -czvf "$${dir%/}".tar.gz "$$dir"; done

clean:
	rm -rf [uU]dacious-*;
