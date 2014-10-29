#!/bin/bash

ps aux | grep "[s]pring" | awk '{print $2}' | xargs kill

