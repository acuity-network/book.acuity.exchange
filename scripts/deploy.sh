#!/usr/bin/env bash

rsync -avhP --stats --del book/ jbrown@104.200.30.231:dex-book
