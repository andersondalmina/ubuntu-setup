# Colors
Red=\033[0;31m
Green=\033[0;32m
NC=\033[0m

WALLPAPER=rainbow
ZSH_CUSTOM_PATH=$(shell echo $$ZSH_CUSTOM)

setup:
	@make update-dependencies
	@make configure-theme
	@make configure-keyboard
	@make configure-dock
	@make install-brave
	@make install-vscode
	@make install-spotify
	@make install-dconf-editor

update-dependencies:
	@echo "\n${Green}---- Updating dependencies ----${NC}"
	sudo apt update -y
	sudo apt upgrade -y

install-brave:
	@echo "\n${Green}---- Instaling Brave Browser ----${NC}"
	sudo apt install apt-transport-https curl
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	sudo apt install brave-browser

install-vscode:
	@echo "\n${Green}---- Instaling vscode ----${NC}"
	sudo snap install code --classic

install-spotify:
	@echo "\n${Green}---- Instaling spotify ----${NC}"
	sudo snap install spotify

install-dconf-editor:
	@echo "\n${Green}---- Instaling Dconf-editor ----${NC}"
	sudo apt install dconf-editor

install-zsh:
	#@echo "\n${Green}---- Instaling ZSH ----${NC}"
	#sh -c '$(shell curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)'

	echo ${ZSH_CUSTOM_PATH}

	# git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
	# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


install-node:
	@echo "\n${Green}---- Instaling NVM and Node ----${NC}"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	@source ~/.zshrc
	nvm install node
	nvm use node

configure-theme:
	@echo "\n${Green}---- Configuring Theme ----${NC}"
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	gsettings set org.gnome.desktop.interface clock-show-weekday false

configure-keyboard:
	@echo "\n${Green}---- Configuring keyboard ----${NC}"
	echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/hid_apple.conf
	sudo update-initramfs -u -k all

configure-dock:
	@echo "\n${Green}---- Configuring Dock ----${NC}"
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
	gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
	gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
	gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts-network false

configure-wallpaper:
	@echo "\n${Green}---- Configuring Wallpaper ----${NC}"
	gsettings set org.gnome.desktop.background picture-uri file://$(shell pwd)/wallpapers/${WALLPAPER}.jpg
	gsettings set org.gnome.desktop.background picture-uri-dark file://$(shell pwd)/wallpapers/${WALLPAPER}.jpg
