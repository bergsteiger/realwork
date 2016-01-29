{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
  IOCPARM_MASK	  = $1FFF;
  {$EXTERNALSYM IOCPARM_MASK}
  IOCPARM_MAX	    = (IOCPARM_MASK + 1);
  {$EXTERNALSYM IOCPARM_MAX}
  IOC_VOID        = $20000000;
  {$EXTERNALSYM IOC_VOID}
  IOC_OUT         = $40000000;
  {$EXTERNALSYM IOC_OUT}
  IOC_IN          = $80000000;
  {$EXTERNALSYM IOC_IN}
  IOC_INOUT       = (IOC_IN or IOC_OUT);
  {$EXTERNALSYM IOC_INOUT}
  IOC_DIRMASK     = $E0000000;
  {$EXTERNALSYM IOC_DIRMASK}
  FIOCLEX         = IOC_VOID or ((0 and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 1;  { _IO('f', 1) } // set close on exec on fd
  {$EXTERNALSYM FIOCLEX}
  FIONCLEX        = IOC_VOID or ((0 and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 2;  { _IO('f', 2) } // remove close on exec
  {$EXTERNALSYM FIONCLEX}
  FIONREAD        = IOC_OUT or ((SizeOf(NativeInt) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 127;  { _IOR('f', 127, int) }	// get # bytes to read
  {$EXTERNALSYM FIONREAD}
  FIONBIO         = IOC_IN or ((SizeOf(NativeInt) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 126;  { _IOW('f', 126, int) }	// set/clear non-blocking i/o */
  {$EXTERNALSYM FIONBIO}
  FIOASYNC        = IOC_IN or ((SizeOf(NativeInt) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 125;  { _IOW('f', 125, int) }	// set/clear async i/o */
  {$EXTERNALSYM FIOASYNC}
  FIOSETOWN       = IOC_IN or ((SizeOf(NativeInt) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 124;  { _IOW('f', 124, int) }	// set owner */
  {$EXTERNALSYM FIOSETOWN}
  FIOGETOWN       = IOC_OUT or ((SizeOf(NativeInt) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 123;  { _IOR('f', 123, int) }	// get owner */
  {$EXTERNALSYM FIOGETOWN}
  FIODTYPE        = IOC_OUT or ((SizeOf(NativeInt) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 122;  { _IOR('f', 122, int) }	// get d_type */
  {$EXTERNALSYM FIODTYPE}

function _IOC(inout, group, num, len: UInt32): UInt32; inline;
{$EXTERNALSYM _IOC}
function _IO(g, n: UInt32): UInt32; inline;
{$EXTERNALSYM _IO}
function __IOR(g, n, t: UInt32): UInt32; inline; { t is SizeOf(type) instead type}
{.$EXTERNALSYM __IOR} // Renamed because of implementation change
function __IOW(g, n, t: UInt32): UInt32; inline; { t is SizeOf(type) instead type}
{.$EXTERNALSYM __IOW} // Renamed because of implementation change
function __IOWR(g, n, t: UInt32): UInt32; inline; { t is SizeOf(type) instead type}
{.$EXTERNALSYM __IOWR} // Renamed because of implementation change
function IOCPARM_LEN(x: UInt32): UInt32; inline;
{$EXTERNALSYM IOCPARM_LEN}
function IOCBASECMD(x: UInt32): UInt32; inline;
{$EXTERNALSYM IOCBASECMD}

