#!/bin/bash

OS=$(uname -s)

case "$OS" in
"Linux")
  if [ -f /etc/arch-release ]; then
    echo " 󰣇 " # Arch
  elif [ -f /etc/fedora-release ]; then
    echo " 󰣛 " # Fedora
  elif [ -f /etc/debian_version ]; then
    if [ -f /etc/linuxmint/info ]; then
      echo " 󰣭 " # Mint
    else
      echo " 󰣚 " # Debian
    fi
  elif [ -f /etc/ubuntu-release ] || { [ -f /etc/lsb-release ] && grep -q "Ubuntu" /etc/lsb-release; }; then
    echo " 󰕈 " # Ubuntu
  elif [ -f /etc/centos-release ]; then
    echo "  " # CentOS (generic server icon)
  elif [ -f /etc/redhat-release ]; then
    echo " 󱄛 " # RedHat
  elif [ -f /etc/SuSE-release ]; then
    echo "  " # SUSE (use chameleon or generic Linux icon)
  elif [ -f /etc/gentoo-release ]; then
    echo " 󰣨 " # Gentoo
  elif [ -f /etc/alpine-release ]; then
    echo "  " # Alpine (generic container icon)
  elif [ -f /etc/manjaro-release ]; then
    echo "  " # Manjaro
  else
    echo " 󰈹 " # Generic Linux
  fi
  ;;
"Darwin")
  echo " 󰀵 " # macOS
  ;;
"MINGW"* | "MSYS"* | "CYGWIN"*)
  echo " 󰍲 " # Windows
  ;;
*)
  echo "  " # Unknown (default Linux)
  ;;
esac
