#!/usr/bin/env bash

set -e #Variable pour que le script s'arrète si une erreur arrive
temp_actuelle=$(date +%Y_%m)
prefixe="a_nettoyer"
nom="${prefixe}_$temp_actuelle"
cd "$HOME/Downloads"
mkdir -p "$nom"
echo " Dossier ${nom} crée"
find . -maxdepth 1 -mindepth 1 -not -name "${prefixe}*" -exec mv {} "${nom}/" \;
echo "dossier remplie"
