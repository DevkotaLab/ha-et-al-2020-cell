#!/bin/sh

aws s3 sync \
    deliverables/ \
    s3://share.steinbaugh.com/devkota/deliverables/
