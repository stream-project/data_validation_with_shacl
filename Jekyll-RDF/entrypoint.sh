#!/bin/bash

jekyll build
jekyll serve &
jekyll build --watch
