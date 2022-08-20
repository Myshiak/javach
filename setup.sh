#!/usr/bin/bash
get_os() {
    for i in $(uname -a)
    do
        os=$i
    done
    echo $i
}
program=javach
pdir="/usr/bin"
go=$(get_os)
cpmv=cp
if [[ $go == "Android" ]]
then
    pdir="/data/data/com.termux/files/usr/bin"
fi
if [[ $1 == "install" ]]
then
    if [[ $2 == "clean" ]]
    then
        cpmv=mv
    fi
    printf "Copying $program to $pdir... "
    $cpmv $program $pdir && echo "done" && \
    printf "Making $program executable... " && \
    chmod +x $pdir/$program && echo "done" && \
    echo "Installed"
elif [[ $1 == "uninstall" ]]
then
    if [[ -e $pdir/$program ]]
    then
        printf "Removing $program from $pdir... "
        if ! [[ -e $PWD/$program ]]
        then
            cp $pdir/$program $PWD
        fi
        rm $pdir/$program && echo "done" && \
        echo "Uninstalled"
    else
        echo "$program is not installed"
    fi
else
    echo "setup.sh install         installing"
    echo "setup.sh install clean   installing and removing $program from $PWD"
    echo "setup.sh uninstall       uninstalling"
fi
