#!/bin/bash
set -euo pipefail


: '
https://askubuntu.com/questions/1263178/20-04-no-speaker-audio-on-hp-spectre-x360-2020-15t-eb000

This solution is supplied (as an edit to my answer) by @BlizzardWyvern
@BlizzardWyvern : please create your own answer to get the credit

The audio chip has an amplifier pin that needs to be set. It is pin 1. After installing the correct topology (e.g. from here https://github.com/EvanCarroll/sof-bin/tree/stable-v1.5) a device named something like "hwC0D0" should show up in /dev/snd/. Using hda-verb from alsa-tools you can get two of the four installed speakers to work by entering these commands:
coment
'

sudo hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x01

sudo hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x01

sudo hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x01

sudo hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x00

: '
This solution worked for me except the device is hwC1D0 and I used topology from

git clone -b stable-v1.6 https://github.com/thesofproject/sof-bin.git
aplay -l

card 1: sofhdadsp [sof-hda-dsp], device 0: HDA Analog (*) []
  Subdevices: 0/1
  Subdevice #0: subdevice #0
'