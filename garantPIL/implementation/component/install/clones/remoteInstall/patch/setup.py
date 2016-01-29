from distutils.core import setup
import py2exe

setup(
    console=['run.py'],
    options={
        "py2exe":{
            "optimize": 2
        }
    }
) 