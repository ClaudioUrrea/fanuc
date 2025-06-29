#!/usr/bin/env bash
pip install -r requirements.txt
conda env update --file environment.yml --prune
