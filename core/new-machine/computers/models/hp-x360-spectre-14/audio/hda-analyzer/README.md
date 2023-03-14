HDA Analyzer
Jump to navigationJump to search
The HDA analyzer tool provides a graphical interface to access the raw HD-audio control, based on pyGTK2 binding. The program gives you an easy-to-use GUI stuff for showing the widget information and adjusting the amp values, as well as the proc-compatible output.

This tool can parse also proc files (/proc/asound/card#/codec*) and output from alsa-info.sh script and monitor mode (check --help option);

Get the basic run.py script:

   wget -O run.py http://www.alsa-project.org/hda-analyzer.py
Quick run:

   python run.py
Quick help:

   python run.py --help
Quick alsa-info.sh file analyzer:

   python run.py /tmp/alsa-info.txt
Quick monitor mode:

   python run.py --monitor
Do not forget to install pygtk2 or python-gtk package (depends on distribution).