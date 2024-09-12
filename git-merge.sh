#!/usr/bin/env bash
set -e

headrev=$(git describe --tags upstream/master)
headtag=${headrev%%-*}
if [ $headtag != $headrev ]; then
    # inexact tag
    rest=${headrev#b*-}
    tnum=${headtag#b}
    nrev=${rest%%-*}
    newtag=b$((tnum + nrev))
    git tag $newtag upstream/master
    echo "$headrev -> $newtag"
    headrev=$newtag
fi
echo merging $headrev
git merge $headrev && git tag $headrev-toaster
