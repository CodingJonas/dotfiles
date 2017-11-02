#!/bin/bash

xbacklight | awk -F'.' '{print $1"%"}'
