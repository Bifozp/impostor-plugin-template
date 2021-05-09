#!/usr/bin/bash
set -e

DefaultName="ExamplePlugin"
ProjectReplaces="XXtemplateXX"
ProjectLowerReplaces="XLtemplateLX"
AuthorReplaces="XXauthorXX"

function _err(){
    echo "[ ERROR ] $@"
}
function _cmd(){
    echo "$@"
    $@
}
function _replace(){
    ProjectLC=${2,,}
    echo "update \"$1\"..."
    sed -i \
        -e "s/$ProjectReplaces/$2/g" \
        -e "s/$ProjectLowerReplaces/$ProjectLC/g" \
        -e "s/$AuthorReplaces/$3/g" \
        "$1"
}
function _replaceAndRename(){
    _replace "$@"
    NewName=`echo "$1"|sed -e "s/$ProjectReplaces/$2/"`
    echo "\"$1\" => \"$NewName\""
    mv "$1" "$NewName"
}

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
cd $SCRIPT_DIR

echo -n "Project name(Default: $DefaultName): "
read InProjectName
echo -n "Author(Default: $USER): "
read InAuthor
ProjectName=${InProjectName:-$DefaultName}
Author=${InAuthor:-$USER}

_cmd git submodule update --init --recursive
_cmd cp .templates/sparse-checkout ./.git/modules/Impostor/info/sparse-checkout
_cmd cd Impostor
_cmd git config core.sparsecheckout true
_cmd git read-tree -mu HEAD
_cmd cd -

if [ -d "$ProjectName" ]; then
    _err "Directory \"$ProjectName\" already exists."
    exit 1
fi

_cmd cp -r ".templates/$ProjectReplaces" "$ProjectName"
_cmd cd "$ProjectName"
_replaceAndRename "XXtemplateXX.csproj" "$ProjectName" "$Author"
_replaceAndRename "XXtemplateXX.cs" "$ProjectName" "$Author"
_replaceAndRename "XXtemplateXXStartup.cs" "$ProjectName" "$Author"
_replace "Handlers/AnnouncementsListener.cs" "$ProjectName" "$Author"
_replace "Handlers/GameEventListener.cs" "$ProjectName" "$Author"
_replace "Handlers/MeetingEventListener.cs" "$ProjectName" "$Author"
_replace "Handlers/PlayerEventListener.cs" "$ProjectName" "$Author"

# test build
dotnet restore
dotnet build
_cmd cd -
echo "done."
