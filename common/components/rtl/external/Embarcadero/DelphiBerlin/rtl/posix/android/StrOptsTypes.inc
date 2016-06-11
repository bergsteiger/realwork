{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ Macros used as `request' argument to `ioctl'.  }
const
  _IOC_NRBITS   = 8;
  {$EXTERNALSYM _IOC_NRBITS}
  _IOC_TYPEBITS = 8;
  {$EXTERNALSYM _IOC_TYPEBITS}
  _IOC_SIZEBITS = 14;
  {$EXTERNALSYM _IOC_SIZEBITS}
  _IOC_DIRBITS  = 2;
  {$EXTERNALSYM _IOC_DIRBITS}

  _IOC_NRMASK   = (1 shl _IOC_NRBITS) - 1;
  {$EXTERNALSYM _IOC_NRMASK}
  _IOC_TYPEMASK = (1 shl _IOC_TYPEBITS) - 1;
  {$EXTERNALSYM _IOC_TYPEMASK}
  _IOC_SIZEMASK = (1 shl _IOC_SIZEBITS) - 1;
  {$EXTERNALSYM _IOC_SIZEMASK}
  _IOC_DIRMASK  = (1 shl _IOC_DIRBITS) - 1;
  {$EXTERNALSYM _IOC_DIRMASK}

  _IOC_NRSHIFT   = 0;
  {$EXTERNALSYM _IOC_NRSHIFT}
  _IOC_TYPESHIFT = _IOC_NRSHIFT + _IOC_NRBITS;
  {$EXTERNALSYM _IOC_TYPESHIFT}
  _IOC_SIZESHIFT = _IOC_TYPESHIFT + _IOC_TYPEBITS;
  {$EXTERNALSYM _IOC_SIZESHIFT}
  _IOC_DIRSHIFT  = _IOC_SIZESHIFT + _IOC_SIZEBITS;
  {$EXTERNALSYM _IOC_DIRSHIFT}

  _IOC_NONE   = 0;
  {$EXTERNALSYM _IOC_NONE}
  _IOC_WRITE  = 1;
  {$EXTERNALSYM _IOC_WRITE}
  _IOC_READ   = 2;
  {$EXTERNALSYM _IOC_READ}
  __invalid_size_argument_for_IOC  = 100;
  {$EXTERNALSYM __invalid_size_argument_for_IOC}

  FIONREAD  = $541B;
  {$EXTERNALSYM FIONREAD}
  IOC_IN = _IOC_WRITE shl _IOC_DIRSHIFT;
  {$EXTERNALSYM IOC_IN}
  IOC_OUT = _IOC_READ shl _IOC_DIRSHIFT;
  {$EXTERNALSYM IOC_OUT}
  IOC_INOUT = (_IOC_WRITE or _IOC_READ) shl _IOC_DIRSHIFT;
  {$EXTERNALSYM IOC_INOUT}
  IOCSIZE_MASK = _IOC_SIZEMASK shl _IOC_SIZESHIFT;
  {$EXTERNALSYM IOCSIZE_MASK}
  IOCSIZE_SHIFT = _IOC_SIZESHIFT;
  {$EXTERNALSYM IOCSIZE_SHIFT}

  {These constants are not posix but necesary for Posix.Termios.inc}
  TCXONC = $540A;
  {$EXTERNALSYM TCXONC}
  TIOCGSID = $5429;
  {$EXTERNALSYM TIOCGSID}
  TCSBRKP = $5425;
  {$EXTERNALSYM TCSBRKP}
  TCGETS = $5401;
  {$EXTERNALSYM TCGETS}
  TCFLSH = $540B;
  {$EXTERNALSYM TCFLSH}


function _IOC(dir, atype, nr, size: UInt32): UInt32; inline;
{$EXTERNALSYM _IOC}

function _IO(atype, nr: UInt32): UInt32; inline;
{$EXTERNALSYM _IOC}

function _IOR(atype, nr, size: UInt32): UInt32; inline;
{$EXTERNALSYM _IOR}

function _IOW(atype, nr, size: UInt32): UInt32; inline;
{$EXTERNALSYM _IOW}

function _IOWR(atype, nr, size: UInt32): UInt32; inline;
{$EXTERNALSYM _IOWR}

function _IOR_BAD(atype, nr, size: UInt32): UInt32; inline;
{$EXTERNALSYM _IOR_BAD}

function _IOW_BAD(atype, nr, size: UInt32): UInt32; inline;
{$EXTERNALSYM _IOW_BAD}

function _IOWR_BAD(atype, nr, size: UInt32): UInt32; inline;
{$EXTERNALSYM _IOWR_BAD}

function _IOC_DIR(nr: UInt32): UInt32; inline;
{$EXTERNALSYM _IOC_DIR}

function _IOC_TYPE(nr: UInt32): UInt32; inline;
{$EXTERNALSYM _IOC_TYPE}

function _IOC_NR(nr: UInt32): UInt32; inline;
{$EXTERNALSYM _IOC_NR}

function _IOC_SIZE(nr: UInt32): UInt32; inline;
{$EXTERNALSYM _IOC_SIZE}


