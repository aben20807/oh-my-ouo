bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

mkdir ~/.oh-my-bash/themes/ouo/
curl -fLo ~/.oh-my-bash/themes/ouo/ouo.theme.sh https://raw.githubusercontent.com/aben20807/oh-my-ouo/master/themes/ouo/ouo.theme.sh

sed -i 's/^\(OSH_THEME\s*=\s*\).*$/\1\"ouo\"/' .bashrc
exit 0
