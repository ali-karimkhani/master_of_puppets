#!/bin/bash

echo "Building sample GO app ..."
/usr/local/go/bin/go install sample

echo "Running sample GO app ..."
/home/go_app/bin/sample &
