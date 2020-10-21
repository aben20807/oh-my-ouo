bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

mkdir ~/.oh-my-bash/themes/ouo/
cp ./themes/ouo/ouo.theme.sh ~/.oh-my-bash/themes/ouo/

sed -i 's/^\(OSH_THEME\s*=\s*\).*$/\1\"ouo\"/' .bashrc
exit 0
