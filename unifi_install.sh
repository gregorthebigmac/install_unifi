#!/bin/bash

# List of scripts in order:
# d8 = Debian 8
# d9 = Debian 9
# d10 = Debian 10
# u1604 = Ubuntu 16.04
# u1804 = Ubuntu 18.04 / Mint 18
# u1810 = Ubuntu 18.10 / Mint 19
# u1904 = Ubuntu 19.04

d8="https://get.glennr.nl/unifi/5.6.42/D8/unifi-5.6.42.sh"
d9="https://get.glennr.nl/unifi/5.6.42/D9/unifi-5.6.42.sh"
d10="https://get.glennr.nl/unifi/5.6.42/D10/unifi-5.6.42.sh"
u1604="https://get.glennr.nl/unifi/5.6.42/U1604/unifi-5.6.42.sh"
u1804="https://get.glennr.nl/unifi/5.6.42/U1804/unifi-5.6.42.sh"
u1810="https://get.glennr.nl/unifi/5.6.42/U1810/unifi-5.6.42.sh"
u1904="https://get.glennr.nl/unifi/5.6.42/U1904/unifi-5.6.42.sh"

distro=""
version=""
script_number=""

help_wall_of_text="Usage:
unifi_install.sh
unifi_install.sh -d [distro_code] -v [version_number]

List of supported options:
-d [distro_code]    Choose your distro. Supported distros and their codes are as follows:
                        Debian  = d
                        Ubuntu  = u
                        Mint    = m

-v [version_number] Choose your distro version. Supported distro versions are as follows:
                        Ubuntu: 1604, 1804, 1810, 1904
                        Debian: 8, 9, 10
                        Mint:   18, 19
    Examples:
        ---------- Debian -----------
        unifi_install.sh -d d -v 8
        unifi_install.sh -d d -v 9
        unifi_install.sh -d d -v 10
        ---------- Ubuntu -----------
        unifi_install.sh -d u -v 1604
        unifi_install.sh -d u -v 1804
        unifi_install.sh -d d -v 1810
        unifi_install.sh -d d -v 1904
        ---------- Debian -----------
        unifi_install.sh -d m -v 18
        unifi_install.sh -d d -v 19
"
while getopts ':d:v:h:' OPTION; do
    case $OPTION in
        d)  distro="$OPTARG"
            ;;
        v)  version="$OPTARG"
            ;;
        h)  echo "$help_wall_of_text"
            exit 1
            ;;
        ?)  echo "$help_wall_of_text"
            exit 1
            ;;
    esac
done

if [[ -z "$distro" ]]; then
    echo "What distro are you running? Ubuntu, Mint, or Debian? [u/m/d]"
    read distro
    if [[ "$distro" == "u" ]]; then
        distro="Ubuntu"
        echo "What version of $distro are you running? [1604/1804/1810/1904]"
        read version
    elif [[ "$distro" == "m" ]]; then
        distro="Mint"
        echo "What version of $distro are you running? [18/19]"
        read version
    elif [[ "$distro" == "d" ]]; then
        distro="Debian"
        echo "What version of $distro are you running? [8/9/10]"
        read version
    else
        echo "Sorry, but $distro is not supported. Please run this script again with the -h"
        echo "option to see the full list of supported distros and their respective versions."
        exit 2
    fi
elif [[ "$distro" == "u" ]]; then distro="Ubuntu"
elif [[ "$distro" == "m" ]]; then distro="Mint"
elif [[ "$distro" == "d" ]]; then distro="Debian"
fi

if [[ "$distro" == "Ubuntu" ]]; then
    if [[ "$version" == "1604" ]]; then
        echo "Downloading install script for $distro $version..."
        script_number="${distro}_${version}_install.sh"
        wget -c "${u1604}" -o "${script_number}"
    elif [[ "$version" == "1804" ]]; then
        script_number="${distro}_${version}_install.sh"
        wget -c "${u1804}" -o "${script_number}"
    elif [[ "$version" == "1810" ]]; then
        script_number="${distro}_${version}_install.sh"
        wget -c "${u1810}" -o "${script_number}"
    elif [[ "$version" == "1904" ]]; then
        script_number="${distro}_${version}_install.sh"
        wget -c "${u1904}" -o "${script_number}"
    else
        echo "Sorry, but $distro version $version wasn't an option. Try running this script"
        echo "with -h for a list of supported distros and their versions."
        exit 3
    fi
elif [[ "$distro" == "Mint" ]]; then
    if [[ "$version" == "18" ]]; then
        script_number="${distro}_${version}_install.sh"
        wget -c "${u1804}" -o "${script_number}"
    elif [[ "$version" == "19" ]]; then
        script_number="${distro}_${version}_install.sh"
        wget -c "${u1810}" -o "${script_number}"
    else
        echo "Sorry, but $distro version $version wasn't an option. Try running this script"
        echo "with -h for a list of supported distros and their versions."
        exit 4
    fi
fi

if [[ "$distro" == "Debian" ]]; then
    if [[ "$version" == "8" ]]; then
        script_number="${distro}_${version}_install.sh"
        wget -c "${d8}" -o "${script_number}"
    elif [[ "$version" == "9" ]]; then
        script_number="${distro}_${version}_install.sh"
        wget -c "${d9}" -o "${script_number}"
    elif [[ "$version" == "10" ]]; then
        script_number="${distro}_${version}_install.sh"
        wget -c "${d10}" -o "${script_number}"
    else
        echo " Sorry, but $distro version $version wasn't an option. Try running this script"
        echo "with -h for a list of supported distros and their versions."
        exit 5
    fi
fi

chmod 755 "${script_number}"
rm unifi-5.6.42.sh
sudo sh "${script_number}"
