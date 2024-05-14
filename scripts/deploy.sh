#!/usr/bin/env bash

mdbook build
rsync -avhP --stats --del book/ book.acuity.exchange:book.acuity.exchange
