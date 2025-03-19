set -e

echo "=> Kostja.me Dev is for use on fresh Ubuntu 24.04 Only"
echo -e "\nBegin installation (or abort with ctrl+c)..."


sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning install scripts:"
rm -rf ~/.local/share/kostja-me-dev
git clone https://github.com/kostja-me/dev ~/.local/share/kostja-me-dev >/dev/null
if [[ $KOSTJA_ME_DEV_REF != "master" ]]; then
	cd ~/.local/share/kostja-me-dev
	git fetch origin "${KOSTJA_ME_DEV_REF:-stable}" && git checkout "${KOSTJA_ME_DEV_REF:-stable}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/kostja-me-dev/install.sh
