#!/bin/sh
vared -p "Enter commit message: " -c message

printf "\e[33m\nBuilding project...\e[39m\n"
hugo -t bilberry-hugo-theme -d ../clem9669.github.io/blog

printf "\\e[33m\nPushing to clem9669.github.io/blog repository...\e[39m\n\n"
cd ../clem9669.github.io/blog
git add .
git commit -m "$message"
git push origin master
printf "\e[32m\nSuccessfully deployed the website!\e[39m"

printf "\e[33m\n\nNow pushing latest changes to blog repository...\e[39m\n\n"
cd ../../blog
git add .
git commit -m "$message"
git push origin master
printf "\033[0;32m\nSuccessfully pushed changes to the repository!\e[39m\n"