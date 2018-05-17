#!/bin/bash

scala -version 2>&1 | grep -Po "(^|\s)+(version )\K([0-9]|\.)*(?=\s|$)"
