{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ Terminate the program with STATUS without calling any of the
   functions registered with `atexit' or `on_exit'.  }
procedure _exit(__status: Integer); cdecl;
  external libc name _PU + '_exit';
{$EXTERNALSYM _Exit}

{ Change the owner and group of FILE.  }
function chown(FileName: MarshaledAString; Owner: uid_t; Group: gid_t): Integer; cdecl;
  external libc name _PU + 'chown';
{$EXTERNALSYM chown}

{ Test for access to NAME using the real UID and real GID.  }
function access(path: MarshaledAString; mode: Integer): Integer; cdecl;
  external libc name _PU + 'access';
{$EXTERNALSYM access}

{$IFDEF LINUX}
{ Test for access to NAME using the effective UID and GID
  (as normal file operations use).  }
function euidaccess(Name: MarshaledAString; Mode: Integer): Integer; cdecl;
  external libc name _PU + 'access';
{$EXTERNALSYM euidaccess}
{$ENDIF LINUX}

function alarm(seconds: Cardinal): Cardinal; cdecl;
  external libc name _PU + 'alarm';
{$EXTERNALSYM alarm}

{$IFNDEF ANDROID}{ missing from bionic }
function confstr(name: Integer; buf: MarshaledAString; len: size_t): size_t; cdecl;
  external libc name _PU + 'confstr';
{$EXTERNALSYM confstr}

function ctermid(s: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'ctermid';
{$EXTERNALSYM ctermid}

function gethostid: LongInt; cdecl;
  external libc name _PU + 'gethostid';
{$EXTERNALSYM gethostid}

function getlogin_r(buf: MarshaledAString; namesize: size_t): Integer; cdecl;
  external libc name _PU + 'getlogin_r';
{$EXTERNALSYM getlogin_r}

function getsid(p1: pid_t): pid_t; cdecl;
  external libc name _PU + 'getsid';
{$EXTERNALSYM getsid}

function getwd(p1: MarshaledAString): MarshaledAString; cdecl; deprecated;
  external libc name _PU + 'getwd';
{$EXTERNALSYM getwd}

function lockf(filedes: Integer; _function: Integer; size: off_t): Integer; cdecl;
  external libc name _PU + 'lockf';
{$EXTERNALSYM lockf}

procedure swab(src: Pointer; dest: Pointer; nbytes: ssize_t); cdecl;
  external libc name _PU + 'swab';
{$EXTERNALSYM swab}

function ualarm(useconds: useconds_t; interval: useconds_t): useconds_t; cdecl;
  external libc name _PU + 'ualarm';
{$EXTERNALSYM ualarm}
{$ENDIF !ANDROID}

function __chdir(path: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'chdir';
{$EXTERNALSYM __chdir}

function __close(filedes: Integer): Integer; cdecl;
  external libc name _PU + 'close';
{$EXTERNALSYM __close}

{
 While this is in POSIX, it is optional, and uses symbol versioning on linux,
 which is broken in ilink right now.
}
//function crypt(const key: PAnsiChar; const salt: PAnsiChar): PAnsiChar; cdecl;
//  external libc name _PU + 'crypt';
//{$EXTERNALSYM crypt}

//procedure encrypt(block: PAnsiChar; edflag: Integer); cdecl;
//  external libc name _PU + 'encrypt';
//{$EXTERNALSYM encrypt}

function dup(filedes: Integer): Integer; cdecl;
  external libc name _PU + 'dup';
{$EXTERNALSYM dup}

function dup2(filedes: Integer; filedes2: Integer): Integer; cdecl;
  external libc name _PU + 'dup2';
{$EXTERNALSYM dup2}

function execl(path: MarshaledAString; arg0: MarshaledAString {...}): Integer; cdecl; varargs;
  external libc name _PU + 'execl';
{$EXTERNALSYM execl}

function execle(path: MarshaledAString; arg0: MarshaledAString {...}): Integer; cdecl; varargs;
  external libc name _PU + 'execle';
{$EXTERNALSYM execle}

function execlp(_file: MarshaledAString; arg0: MarshaledAString {...}): Integer; cdecl; varargs;
  external libc name _PU + 'execlp';
{$EXTERNALSYM execlp}

function execv(path: MarshaledAString; argv: PMarshaledAString): Integer; cdecl;
  external libc name _PU + 'execv';
{$EXTERNALSYM execv}

function execve(path: MarshaledAString; argv: PMarshaledAString; envp: PMarshaledAString): Integer; cdecl;
  external libc name _PU + 'execve';
{$EXTERNALSYM execve}

function execvp(_file: MarshaledAString; argv: PMarshaledAString): Integer; cdecl;
  external libc name _PU + 'execvp';
{$EXTERNALSYM execvp}

function fchown(filedes: Integer; owner: uid_t; group: gid_t): Integer; cdecl;
  external libc name _PU + 'fchown';
{$EXTERNALSYM fchown}

function fchdir(filedes: Integer): Integer; cdecl;
  external libc name _PU + 'fchdir';
{$EXTERNALSYM fchdir}

function fork: pid_t; cdecl;
  external libc name _PU + 'fork';
{$EXTERNALSYM fork}

function fpathconf(filedes: Integer; name: Integer): LongInt; cdecl;
  external libc name _PU + 'fpathconf';
{$EXTERNALSYM fpathconf}

function fsync(filedes: Integer): Integer; cdecl;
  external libc name _PU + 'fsync';
{$EXTERNALSYM fsync}

function ftruncate(filedes: Integer; length: off_t): Integer; cdecl;
  external libc name _PU + 'ftruncate';
{$EXTERNALSYM ftruncate}

function getcwd(buf: MarshaledAString; size: size_t): MarshaledAString; cdecl;
  external libc name _PU + 'getcwd';
{$EXTERNALSYM getcwd}

function getegid: gid_t; cdecl;
  external libc name _PU + 'getegid';
{$EXTERNALSYM getegid}

function geteuid: uid_t; cdecl;
  external libc name _PU + 'geteuid';
{$EXTERNALSYM geteuid}

function getgid: gid_t; cdecl;
  external libc name _PU + 'getgid';
{$EXTERNALSYM getgid}

function getgroups(gidsetsize: Integer; grouplist: Pgid_t): Integer; cdecl;
  external libc name _PU + 'getgroups';
{$EXTERNALSYM getgroups}

function gethostname(name: MarshaledAString; namelen: size_t): Integer; cdecl;
  external libc name _PU + 'gethostname';
{$EXTERNALSYM gethostname}

function getlogin: MarshaledAString; cdecl;
  external libc name _PU + 'getlogin';
{$EXTERNALSYM getlogin}

function getopt(opt: Integer; buf: PMarshaledAString; p3: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'getopt';
{$EXTERNALSYM getopt}

function getpgid(p1: pid_t): pid_t; cdecl;
  external libc name _PU + 'getpgid';
{$EXTERNALSYM getpgid}

function getpgrp: pid_t; cdecl;
  external libc name _PU + 'getpgrp';
{$EXTERNALSYM getpgrp}

function getpid: pid_t; cdecl;
  external libc name _PU + 'getpid';
{$EXTERNALSYM getpid}

function getppid: pid_t; cdecl;
  external libc name _PU + 'getppid';
{$EXTERNALSYM getppid}

function getuid: uid_t; cdecl;
  external libc name _PU + 'getuid';
{$EXTERNALSYM getuid}

{ Return 1 if FD is a valid descriptor associated
   with a terminal, zero if not.  }
function isatty(filedes: Integer): Integer; cdecl;
  external libc name _PU + 'isatty';
{$EXTERNALSYM isatty}

function lchown(path: MarshaledAString; owner: uid_t; group: gid_t): Integer; cdecl;
  external libc name _PU + 'lchown';
{$EXTERNALSYM lchown}

function link(path1: MarshaledAString; path2: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'link';
{$EXTERNALSYM link}

function lseek(filedes: Integer; offset: off_t; whence: Integer): off_t; cdecl;
  external libc name _PU + 'lseek';
{$EXTERNALSYM lseek}

{$IFDEF ANDROID}
function lseek64(filedes: Integer; offset: off64_t; whence: Integer): off64_t; cdecl;
  external libc name _PU + 'lseek64';
{$EXTERNALSYM lseek64}
{$ENDIF ANDROID}

function nice(incr: Integer): Integer; cdecl;
  external libc name _PU + 'nice';
{$EXTERNALSYM nice}

function pathconf(path: MarshaledAString; name: Integer): LongInt; cdecl;
  external libc name _PU + 'pathconf';
{$EXTERNALSYM pathconf}

function pause: Integer; cdecl;
  external libc name _PU + 'pause';
{$EXTERNALSYM pause}

function pipe(PipeDes: PInteger): Integer; cdecl; overload;
  external libc name _PU + 'pipe';
{$EXTERNALSYM pipe}

function pipe(var PipeDes: TPipeDescriptors): Integer; cdecl; overload;
  external libc name _PU + 'pipe';
{$EXTERNALSYM pipe}

function pread(filedes: Integer; buf: Pointer; nbyte: size_t; offset: off_t): ssize_t; cdecl;
  external libc name _PU + 'pread';
{$EXTERNALSYM pread}
//function pread(filedes: Integer; var buf; nbyte: size_t; offset: off_t): ssize_t; cdecl; overload;
//  external libc name _PU + 'pread';
//{$EXTERNALSYM pread}

function pwrite(filedes: Integer; buf: Pointer; nbyte: size_t; offset: off_t): ssize_t; cdecl;
  external libc name _PU + 'pwrite';
{$EXTERNALSYM pwrite}
//function pwrite(filedes: Integer; const buf; nbyte: size_t; offset: off_t): ssize_t; cdecl; overload;
//  external libc name _PU + 'pwrite';
//{$EXTERNALSYM pwrite}

function __read(Handle: Integer; Buffer: Pointer; Count: size_t): ssize_t; cdecl;
  external libc name _PU + 'read';
{$EXTERNALSYM __read}

//function read(Handle: Integer; var Buffer; Count: Cardinal): Cardinal; cdecl;
//  external libc name _PU + 'read';
//$EXTERNALSYM read

function readlink(path: MarshaledAString; buf: MarshaledAString; bufsize: size_t): ssize_t; cdecl;
  external libc name _PU + 'readlink';
{$EXTERNALSYM readlink}

{$IFDEF LINUX}
function readlinkat(filedes: Integer; path: MarshaledAString; buf: MarshaledAString; bufsize: size_t): ssize_t; cdecl;
  external libc name _PU + 'readlinkat';
{$EXTERNALSYM readlinkat}
{$ENDIF LINUX}

function __rmdir(PathName: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'rmdir';
{$EXTERNALSYM __rmdir}

function setegid(gid: gid_t): Integer; cdecl;
  external libc name _PU + 'setegid';
{$EXTERNALSYM setegid}

function seteuid(uid: uid_t): Integer; cdecl;
  external libc name _PU + 'seteuid';
{$EXTERNALSYM seteuid}

function setgid(gid: gid_t): Integer; cdecl;
  external libc name _PU + 'setgid';
{$EXTERNALSYM setgid}

function setpgid(pid: pid_t; pgid: pid_t): Integer; cdecl;
  external libc name _PU + 'setpgid';
{$EXTERNALSYM setpgid}
//TODO: OB_XSI
function setpgrp: pid_t; cdecl;
  external libc name _PU + 'setpgrp';
{$EXTERNALSYM setpgrp}
//TODO: XSI
function setregid(rgid: gid_t; egid: gid_t): Integer; cdecl;
  external libc name _PU + 'setregid';
{$EXTERNALSYM setregid}
//TODO: XSI
function setreuid(ruid: uid_t; euid: uid_t): Integer; cdecl;
  external libc name _PU + 'setreuid';
{$EXTERNALSYM setreuid}

function setsid: pid_t; cdecl;
  external libc name _PU + 'setsid';
{$EXTERNALSYM setsid}

function setuid(uid: uid_t): Integer; cdecl;
  external libc name _PU + 'setuid';
{$EXTERNALSYM setuid}

function __sleep(seconds: Cardinal): Cardinal; cdecl;
  external libc name _PU + 'sleep';
{$EXTERNALSYM __sleep}

function symlink(path1: MarshaledAString; path2: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'symlink';
{$EXTERNALSYM symlink}
//TODO: XSI
procedure sync; cdecl;
  external libc name _PU + 'sync';
{$EXTERNALSYM sync}

function sysconf(name: Integer): LongInt; cdecl;
  external libc name _PU + 'sysconf';
{$EXTERNALSYM sysconf}

function tcgetpgrp(filedes: Integer): pid_t; cdecl;
  external libc name _PU + 'tcgetpgrp';
{$EXTERNALSYM tcgetpgrp}

function tcsetpgrp(filedes: Integer; pgid_id: pid_t): Integer; cdecl;
  external libc name _PU + 'tcsetpgrp';
{$EXTERNALSYM tcsetpgrp}

function __truncate(path: MarshaledAString; length: off_t): Integer; cdecl;
  external libc name _PU + 'truncate';
{$EXTERNALSYM __truncate}

function ttyname(filedes: Integer): MarshaledAString; cdecl;
  external libc name _PU + 'ttyname';
{$EXTERNALSYM ttyname}

function ttyname_r(filedes: Integer; name: MarshaledAString; namesize: size_t): Integer; cdecl;
  external libc name _PU + 'ttyname_r';
{$EXTERNALSYM ttyname_r}

{ Remove the link NAME.  }
function unlink(path: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'unlink';
{$EXTERNALSYM unlink}
//TODO: where is this from?
{ Sleep USECONDS microseconds, or until a signal arrives that is not blocked
   or ignored.  }
procedure usleep(useconds: useconds_t); cdecl;
  external libc name _PU + 'usleep';
{$EXTERNALSYM usleep}
//TODO: where is this from?
function vfork: pid_t; cdecl;
  external libc name _PU + 'vfork';
{$EXTERNALSYM vfork}

function __write(Handle: Integer; Buffer: Pointer; Count: size_t): ssize_t; cdecl;
  external libc name _PU + 'write';
{$EXTERNALSYM __write}

{TODO -otgerdes -cHeader Translation: missing apis: all are missing on OSX
  int faccessat(int, const char *, int, int)
  int fexecve(int, char *const[], char *const[]);
  int linkat(int, const char *, int, const char *, int);
  int symlinkat(const char *, int, const char * );
  int unlinkat(int, const char *, int);
}

