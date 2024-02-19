#!/usr/bin/env bash

rsync -avhP --stats --del book/ book.acuity.exchange:dex-book
