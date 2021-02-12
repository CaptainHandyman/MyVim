import os
import ycm_core
import os.path as p
import subprocess

flags = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-ferror-limit=10000',
    '-DNDEBUG',
    '-std=c++2a',
    '-xc',
    '-isystem',
    '/usr/include/',
    '-isystem',
    '/usr/local/include',
    '-isystem',
    '/usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9',
    '-isystem',
    '/usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../../include/x86_64-linux-gnu/c++/9',
    '-isystem',
    '/usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/backward',
]

SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', ]


def FlagsForFile(filename, **kwargs):
    return {
        'flags': flags,
        'do_cache': True
    }


DIR_OF_THIS_SCRIPT = p.abspath(p.dirname(__file__))
DIR_OF_THIRD_PARTY = p.join(DIR_OF_THIS_SCRIPT, 'third_party')


def GetStandardLibraryIndexInSysPath(sys_path):
    for index, path in enumerate(sys_path):
        if p.isfile(p.join(path, 'os.py')):
            return index
    raise RuntimeError('Could not find standard library path in Python path.')


def PythonSysPath(**kwargs):
    sys_path = kwargs['sys_path']

    dependencies = [p.join(DIR_OF_THIS_SCRIPT, 'python'),
                    p.join(DIR_OF_THIRD_PARTY, 'requests-futures'),
                    p.join(DIR_OF_THIRD_PARTY, 'ycmd'),
                    p.join(DIR_OF_THIRD_PARTY, 'requests_deps', 'idna'),
                    p.join(DIR_OF_THIRD_PARTY, 'requests_deps', 'chardet'),
                    p.join(DIR_OF_THIRD_PARTY,
                           'requests_deps',
                           'urllib3',
                           'src'),
                    p.join(DIR_OF_THIRD_PARTY, 'requests_deps', 'certifi'),
                    p.join(DIR_OF_THIRD_PARTY, 'requests_deps', 'requests')]

    # The concurrent.futures module is part of the standard library on Python 3.
    interpreter_path = kwargs['interpreter_path']
    major_version = int(subprocess.check_output([
        interpreter_path, '-c', 'import sys; print( sys.version_info[ 0 ] )']
    ).rstrip().decode('utf8'))
    if major_version == 2:
        dependencies.append(p.join(DIR_OF_THIRD_PARTY, 'pythonfutures'))

    sys_path[0:0] = dependencies
    sys_path.insert(GetStandardLibraryIndexInSysPath(sys_path) + 1,
                    p.join(DIR_OF_THIRD_PARTY, 'python-future', 'src'))

    return sys_path
