#!/bin/sh

cd `dirname $0`

find `pwd` -maxdepth 1 -name '.*' | grep -v ".git$" | grep -v ".gitmodules" | xargs -I{} ln -fs {} $HOME
