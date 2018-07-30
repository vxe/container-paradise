
import sys

class PromptPs1:
 ESCAPE = '\033[%sm'
 ENDC = ESCAPE % '0'
 BOLD = '1;'
 FAINT = '2;' # Not widely supported
 ITALIC = '3;'
 UNDERLINE = '4;'
 SLOW_BLINK = '5;'
 FAST_BLINK = '6;' # Not widely supported
 COLOR = {
     'black': '30',
     'red': '31',
     'green': '32',
     'yellow': '33',
     'blue': '34',
     'magenta': '35',
     'cyan': '36',
     'white': '37',}
 def decorate(self, format, msg):
     format_sequence = self.ESCAPE % format
     return format_sequence + msg + self.ENDC
 def white_bold_underlined(self, msg):
     return self.decorate(self.BOLD + self.UNDERLINE + self.COLOR['white'], msg)
 def green_color(self, msg):
     return self.decorate(self.BOLD + self.COLOR['green'], msg)
 def __init__(self):
     self.count = 0
   
 def __str__(self):
     self.time = datetime.datetime.now().strftime("%H:%M:%S")
     self.path = os.getcwd()
     return "[%s] %s $ " % (self.time, self.green_color(self.path))

class PromptPs2:
    ESCAPE = '\033[%sm'
    ENDC = ESCAPE % '0'
    BOLD = '1;'
    FAINT = '2;' # Not widely supported
    ITALIC = '3;'
    UNDERLINE = '4;'
    SLOW_BLINK = '5;'
    FAST_BLINK = '6;' # Not widely supported
    COLOR = {
        'black': '30',
        'red': '31',
        'green': '32',
        'yellow': '33',
        'blue': '34',
        'magenta': '35',
        'cyan': '36',
        'white': '37',}
    def decorate(self, format, msg):
        format_sequence = self.ESCAPE % format
        return format_sequence + msg + self.ENDC
    def white_bold_underlined(self, msg):
        return self.decorate(self.BOLD + self.UNDERLINE + self.COLOR['white'], msg)
    def green_color(self, msg):
        return self.decorate(self.BOLD + self.COLOR['green'], msg)
    def yellow_color(self, msg):
        return self.decorate(self.BOLD + self.COLOR['yellow'], msg)
    def __init__(self):
        self.count = 0
    def __str__(self):
        self.time = datetime.datetime.now().strftime("%H:%M:%S")
        self.path = os.getcwd()
        return "[%s] %s . " % (self.time, self.yellow_color(self.path))

sys.ps1 = PromptPs1()
sys.ps2 = PromptPs2()

import os

def cd (path):
    os.chdir(os.path.expanduser (path))

def ls(path="."):
    pprint.pprint(sorted(os.listdir(path)))
    return sorted(os.listdir(path))

def cat(file):
    with open(file, 'r') as fin:
        print(fin.read())

def tailf(filepath):
    subprocess.call(['sudo','tail' ,'-f', filepath])

def mkdir(name):
    os.mkdir(name)

def rm(name):
    os.rmdir(name)

def touch(fname, times=None):
    fhandle = open(fname, 'a')
    try:
        os.utime(fname, times)
    finally:
        fhandle.close()

import pip
import os

os.system("pip install -r ~/.python.d/requirements.txt")

import pip

def pip_install(package):
        try:
                importlib.import_module(package)
        except ImportError:
                pip.main(['install', package])
        finally:
                globals()[package] = importlib.import_module(package)

# if sys.version_info[0] == 2 :
#     import emoji

try:
    import readline
except ImportError:
    print("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
