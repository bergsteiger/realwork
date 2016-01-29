{*********************************************************}
{*                   STUTILS.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$I+} {I/O Checking On}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{$IFDEF Win32}
  {$H+} {force huge strings}
{$ENDIF}

unit StUtils;
  {-Assorted utility routines}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  SysUtils, Classes, StConst, StBase, StDate,
  {$IFNDEF Win32} FileCtrl, {$ENDIF}                                   
  {$IFDEF Win32} StStrL; {$ELSE} StStrS; {$ENDIF}

type
  DiskClass = ( Floppy360, Floppy720, Floppy12, Floppy144, OtherFloppy,
    HardDisk, RamDisk, UnknownDisk, InvalidDrive, RemoteDrive, CDRomDisk );
    {This enumerated type defines the nine classes of disks that can be
     identified by GetDiskClass, as well as several types used as error
     indications}

  PMediaIDType = ^MediaIDType;
  MediaIDType = packed record
  {This type describes the information that DOS 4.0 or higher writes
   in the boot sector of a disk when it is formatted}
    InfoLevel : Word;                        {Reserved for future use}
    SerialNumber : LongInt;                  {Disk serial number}
    VolumeLabel : array[0..10] of AnsiChar;  {Disk volume label}
    FileSystemID : array[0..7] of AnsiChar;  {String for internal use by the OS}
  end;

  TIncludeItemFunc = function (const SR : TSearchRec;
                               ForInclusion : boolean) : Boolean;
    {Function type for the routine passed to EnumerateFiles and
     EnumerateDirectories. It will be called in two ways: to request
     confirmation to include the entity described in SR into the
     string list (ForInclusion = true); or to ask whether to recurse
     into a particular subdirectory (ForInclusion = false).}

function SignL(L : LongInt) : Integer;
  {-return sign of LongInt value}
function SignF(F : Extended) : Integer;
  {-return sign of floating point value}

function MidWord(W1, W2, W3 : Word) : Word;
  {-return the middle of three Word values}
function MidLong(L1, L2, L3 : LongInt) : LongInt;
  {-return the middle of three LongInt values}
function MidFloat(F1, F2, F3 : Extended) : Extended;
  {-return the middle of three floating point values}

function MinFloat(F1, F2 : Extended) : Extended;
  {-return the lesser of two floating point values}
function MaxFloat(F1, F2 : Extended) : Extended;
  {-return the greater of two floating point values}

function IsDirectoryEmpty(const S : string) : Integer;
  {-checks if there are any entries in the directory}
function IsFileHidden(const S : string) : Integer;
  {-checks if file's hidden attribute is set}
function IsFileSystem(const S : string) : Integer;
  {-checks if file's system attribute is set}
function IsFileReadOnly(const S : string) : Integer;
  {-checks if file's readonly attribute is set}
function IsFileArchive(const S : string) : Integer;
  {-checks if file's archive attribute is set}

procedure EnumerateFiles(StartDir : string; FL : TStrings;
                         SubDirs : Boolean;
                         IncludeItem : TIncludeItemFunc);

procedure EnumerateDirectories(StartDir : string; FL : TStrings;
                               SubDirs : Boolean;
                               IncludeItem : TIncludeItemFunc);

function FileTimeToStDateTime(FileTime : LongInt) : TStDateTimeRec;
function StDateTimeToFileTime(FileTime : TStDateTimeRec) : LongInt;

function UnixTimeToStDateTime(UnixTime : Longint) : TStDateTimeRec;
{-converts a time in Unix base (1970) to a TStDateTimeRec}
function StDateTimeToUnixTime(DT1 : TStDateTimeRec) : Longint;
{-converts a TStDateTimeRec to a time in Unix base (1970)}

function GlobalDateTimeToLocal(UTC: TStDateTimeRec; MinOffset: Integer): TStDateTimeRec;
  {-adjusts a global date/time (UTC) to the local date/time}
function LocalDateTimeToGlobal(DT1: TStDateTimeRec; MinOffset: Integer): TStDateTimeRec;
  {-adjusts a local date/time to the global (UTC) date/time}


{-Assorted utility routines.  16 bit versions are inline }

function MakeInteger16(H, L : Byte): SmallInt;
  {-Construct an integer from two bytes}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax    ;low byte into AL}
    $5B/                   {pop bx    ;high byte into BL}
    $88/$DC);              {mov ah,bl ;high byte into AH}
{$ENDIF}

function MakeWord(H, L : Byte) : Word;
  {-Construct a word from two bytes}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax    ;low byte into AL}
    $5B/                   {pop bx    ;high byte into BL}
    $88/$DC);              {mov ah,bl ;high byte into AH}
{$ENDIF}

function SwapNibble(B : Byte) : Byte;
  {-Swap the high and low nibbles of a byte}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax}
    $B1/$04/               {mov cl,4}
    $D2/$C8);              {ror al,cl}
{$ENDIF}

function SwapWord(L : LongInt) : LongInt;
  {-Swap the low- and high-order words of a long integer}
{$IFNDEF WIN32}
  inline(
    $5A/                   {pop dx ;pop low word into DX}
    $58);                  {pop ax ;pop high word into AX}
{$ENDIF}

procedure SetFlag(var Flags : Word; FlagMask : Word);
  {-Set bit(s) in the parameter Flags. The bits to set are specified in FlagMask}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax        ;FlagMask into AX}
    $5F/                   {pop di}
    $07/                   {pop es        ;ES:DI => Flags}
    $26/$09/$05);          {or es:[di],ax ;Flags := Flags or FlagMask}
{$ENDIF}

procedure ClearFlag(var Flags : Word; FlagMask : Word);
  {-Clear bit(s) in the parameter Flags. The bits to clear are specified in Flagmask}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax         ;FlagMask into AX}
    $5F/                   {pop di}
    $07/                   {pop es         ;ES:DI => Flags}
    $F7/$D0/               {not ax         ;FlagMask := not FlagMask}
    $26/$21/$05);          {and es:[di],ax ;Flags := Flags and not FlagMask}
{$ENDIF}

function FlagIsSet(Flags, FlagMask : Word) : Boolean;
  {-Return True if the bit specified by FlagMask is set in Flags}
{$IFNDEF WIN32}
  inline(
    $5A/                   {pop dx    ;FlagMask into DX}
    $58/                   {pop ax    ;Flags into AX}
    $21/$D0/               {and ax,dx ;Mask out everything not in FlagMask}
    $74/$03/               {jz  Exit}
    $B8/$01/$00);          {mov ax,1  ;AX = Ord(True)}
                           {Exit:}
{$ENDIF}

procedure SetByteFlag(var Flags : Byte; FlagMask : Byte);
  {-Set bit(s) in the parameter Flags. The bits to set are specified in FlagMask}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax        ;FlagMask into AL}
    $5F/                   {pop di}
    $07/                   {pop es        ;ES:DI => Flags}
    $26/$08/$05);          {or es:[di],al ;Flags := Flags or FlagMask}
{$ENDIF}

procedure ClearByteFlag(var Flags : Byte; FlagMask : Byte);
  {-Clear bit(s) in the parameter Flags. The bits to clear are specified in FlagMask}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax         ;FlagMask into AL}
    $5F/                   {pop di}
    $07/                   {pop es         ;ES:DI => Flags}
    $F6/$D0/               {not al         ;AL := not AL}
    $26/$20/$05);          {and es:[di],al ;Flags := Flags and not FlagMask}
{$ENDIF}

function ByteFlagIsSet(Flags, FlagMask : Byte) : Boolean;
  {-Return True if the bit specified by FlagMask is set in the Flags parameter}
{$IFNDEF WIN32}
  inline(
    $5A/                   {pop dx    ;FlagMask into DL}
    $58/                   {pop ax    ;Flags into AL}
    $30/$E4/               {xor ah,ah ;Zero out AH}
    $20/$D0/               {and al,dl ;Mask out everything not in FlagMask}
    $74/$02/               {jz  Exit}
    $B0/$01);              {mov al,1  ;AX = Ord(True)}
                           {Exit:}
{$ENDIF}

procedure SetLongFlag(var Flags : LongInt; FlagMask : LongInt);
  {-Set bit(s) in the parameter Flags. The bits to set are specified in FlagMask}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax        ;FlagMask into DX:AX}
    $5A/                   {pop dx}
    $5F/                   {pop di}
    $07/                   {pop es        ;ES:DI => Flags}
    $26/$09/$05/           {or es:[di],ax ;Flags := Flags or FlagMask}
    $26/$09/$55/$02);      {or es:[di+2],dx}
{$ENDIF}

procedure ClearLongFlag(var Flags : LongInt; FlagMask : LongInt);
  {-Clear bit(s) in the parameter Flags. The bits to clear are specified in FlagMask}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax         ;FlagMask into DX:AX}
    $5A/                   {pop dx}
    $5F/                   {pop di}
    $07/                   {pop es         ;ES:DI => Flags}
    $F7/$D0/               {not ax         ;FlagMask := not FlagMask}
    $F7/$D2/               {not dx}
    $26/$21/$05/           {and es:[di],ax ;Flags := Flags and not FlagMask}
    $26/$21/$55/$02);      {and es:[di+2],dx}
{$ENDIF}

function LongFlagIsSet(Flags, FlagMask : LongInt) : Boolean;
  {-Return True if the bit specified by FlagMask is set in Flags}
{$IFNDEF WIN32}
  inline(
    $5B/                   {pop bx    ;FlagMask into CX:BX}
    $59/                   {pop cx}
    $58/                   {pop ax    ;Flags into DX:AX}
    $5A/                   {pop dx}
    $21/$D8/               {and ax,bx ;Mask out everything not in FlagMask}
    $21/$CA/               {and dx,cx}
    $09/$D0/               {or  ax,dx}
    $74/$03/               {jz  Exit}
    $B8/$01/$00);          {mov ax,1  ;AX = Ord(True)}
                           {Exit:}
{$ENDIF}

procedure ExchangeBytes(var I, J : Byte);
  {-Exchange the values in two bytes}
{$IFNDEF WIN32}
  inline(
    $8C/$DB/               {mov bx,ds       ;save DS}
    $5E/                   {pop si}
    $1F/                   {pop ds          ;DS:SI => J}
    $5F/                   {pop di}
    $07/                   {pop es          ;ES:DI => I}
    $8A/$04/               {mov al,[si]     ;AL = J}
    $26/$86/$05/           {xchg al,es:[di] ;I = J, AL = I}
    $88/$04/               {mov [si],al     ;J = I}
    $8E/$DB);              {mov ds,bx       ;restore DS}
{$ENDIF}

procedure ExchangeWords(var I, J : Word);
  {-Exchange the values in two words}
{$IFNDEF WIN32}
  inline(
    $8C/$DB/               {mov bx,ds       ;save DS}
    $5E/                   {pop si}
    $1F/                   {pop ds          ;DS:SI => J}
    $5F/                   {pop di}
    $07/                   {pop es          ;ES:DI => I}
    $8B/$04/               {mov ax,[si]     ;AX = J}
    $26/$87/$05/           {xchg ax,es:[di] ;I = J, AX = I}
    $89/$04/               {mov [si],ax     ;J = I}
    $8E/$DB);              {mov ds,bx       ;restore DS}
{$ENDIF}

procedure ExchangeLongInts(var I, J : LongInt);
  {-Exchange the values in two long integers}
{$IFNDEF WIN32}
  inline(
    $8C/$DB/               {mov bx,ds       ;save DS}
    $5E/                   {pop si}
    $1F/                   {pop ds          ;DS:SI => J}
    $5F/                   {pop di}
    $07/                   {pop es          ;ES:DI => I}
    $FC/                   {cld}
    $26/$8B/$05/           {mov ax,es:[di]}
    $A5/                   {movsw}
    $89/$44/$FE/           {mov [si-2],ax}
    $8B/$04/               {mov ax,[si]}
    $26/$87/$05/           {xchg ax,es:[di]}
    $89/$04/               {mov [si],ax}
    $8E/$DB);              {mov ds,bx       ;restore DS}
{$ENDIF}

procedure ExchangeStructs(var I, J; Size : Cardinal);
  {-Exchange the values in two structures}
{$IFNDEF WIN32}
  inline(
    $FC/                   {cld       ;go forward}
    $8C/$DA/               {mov dx,ds       ;save DS}
    $59/                   {pop cx          ;CX = Size}
    $5E/                   {pop si}
    $1F/                   {pop ds          ;DS:SI => J}
    $5F/                   {pop di}
    $07/                   {pop es          ;ES:DI => I}
    $D1/$E9/               {shr cx,1        ;move by words}
    $E3/$0C/               {jcxz odd}
    $9C/                   {pushf}
                           {start:}
    $89/$F3/               {mov bx,si}
    $26/$8B/$05/           {mov ax,es:[di]  ;exchange words}
    $A5/                   {movsw}
    $89/$07/               {mov [bx],ax}
    $E2/$F6/               {loop start      ;again?}
    $9D/                   {popf}
                           {odd:}
    $73/$07/               {jnc exit}
    $8A/$04/               {mov al,[si]     ;exchange the odd bytes}
    $26/$86/$05/           {xchg al,es:[di]}
    $88/$04/               {mov [si],al}
                           {exit:}
    $8E/$DA);              {mov ds,dx       ;restore DS}
{$ENDIF}

function MinWord(A, B : Word) : Word;
  {-Return the smaller of A and B}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax}
    $5B/                   {pop bx}
    $39/$C3/               {cmp bx,ax}
    $73/$02/               {jae done}
    $89/$D8);              {mov ax,bx}
                           {done:}
{$ENDIF}

function Maxword(A, B : Word) : Word;
  {-Return the greater of A and B}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax}
    $5B/                   {pop bx}
    $39/$C3/               {cmp bx,ax}
    $76/$02/               {jbe done}
    $89/$D8);              {mov ax,bx}
                           {done:}
{$ENDIF}

function MinLong(A, B : LongInt) : LongInt;
  {-Return the smaller of A and B}
{$IFNDEF WIN32}
  inline(
    $5B/                   {pop bx       ;CX:BX = B}
    $59/                   {pop cx}
    $58/                   {pop ax       ;DX:AX = A}
    $5A/                   {pop dx}
    $39/$CA/               {cmp dx,cx    ;compare high byte}
    $7C/$0A/               {jl  done1    ;A < B?}
    $7F/$04/               {jg  greater  ;A > B?}
    $39/$D8/               {cmp ax,bx    ;compare low byte}
    $76/$04/               {jbe done1    ;A <= B?}
                           {greater:}
    $89/$CA/               {mov dx,cx    ;A is greater}
    $89/$D8);              {mov ax,bx}
                           {done1:}
{$ENDIF}

function MaxLong(A, B : LongInt) : LongInt;
  {-Return the greater of A and B}
{$IFNDEF WIN32}
  inline(
    $5B/                   {pop bx       ;CX:BX = B}
    $59/                   {pop cx}
    $58/                   {pop ax       ;DX:AX = A}
    $5A/                   {pop dx}
    $39/$CA/               {cmp dx,cx    ;compare high byte}
    $7F/$0A/               {jg  done2    ;A > B?}
    $7C/$04/               {jl  less     ;A < B?}
    $39/$D8/               {cmp ax,bx    ;compare low byte}
    $73/$04/               {jae done2    ;A >= B?}
                           {less:}
    $89/$CA/               {mov dx,cx    ;B is greater}
    $89/$D8);              {mov ax,bx}
                           {done2:}
{$ENDIF}

procedure FillWord(var Dest; Count : Cardinal; Filler : Word);
  {-Fill memory with a word-sized filler}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax    ;AX = Filler}
    $59/                   {pop cx    ;CX = Count}
    $5F/                   {pop di    ;ES:DI => Dest}
    $07/                   {pop es}
    $FC/                   {cld       ;go forward}
    $F2/$AB);              {rep stosw ;fill memory}
{$ENDIF}

procedure FillStruct(var Dest; Count : Cardinal; var Filler; FillerSize : Cardinal);
  {-Fill memory with a variable sized filler}
{$IFNDEF WIN32}
  inline(
    $58/                   {pop ax     ;AX = FillerSize}
    $5B/                   {pop bx     ;DX:BX => Filler}
    $5A/                   {pop dx}
    $59/                   {pop cx     ;CX = Count}
    $5F/                   {pop di     ;ES:DI => Dest}
    $07/                   {pop es}
    $E3/$11/               {jcxz done  ;done if Count = 0}
    $FC/                   {cld        ;go forward}
    $1E/                   {push ds    ;save DS}
    $8E/$DA/               {mov ds,dx  ;DS:BX => Filler}
                           {again:}
    $89/$CA/               {mov dx,cx  ;save loop count}
    $89/$DE/               {mov si,bx  ;DS:SI => Filler}
    $89/$C1/               {mov cx,ax  ;CX = FillerSize}
    $F2/$A4/               {rep movsb  ;fill}
    $89/$D1/               {mov cx,dx  ;restore loop count}
    $E2/$F4/               {loop again ;repeat}
    $1F);                  {pop ds     ;restore DS}
                           {done:}
{$ENDIF}

function AddWordToPtr(P : Pointer; W : Word) : Pointer;
  {-Add a word to a pointer.}
{$IFNDEF WIN32}
  inline(
    $5B/                   {pop bx     ;bx = W}
    $58/                   {pop ax     ;ax = Ofs(P^)}
    $5A/                   {pop dx     ;dx = Seg(P^)}
    $01/$D8);              {add ax,bx  ;ax = Ofs(P^)+W}
{$ENDIF}

{Assorted operating system routines.}

function GetDiskInfo(Drive : AnsiChar; var ClustersAvailable, TotalClusters,
                     BytesPerSector, SectorsPerCluster : Cardinal) : Boolean;
  {-Return technical information about the specified drive.}

{$IFDEF CBuilder}
function GetDiskSpace(Drive : AnsiChar;
                  var UserSpaceAvail  : Double;           {space available to user}
                  var TotalSpaceAvail : Double;           {total space available}
                  var DiskSize        : Double) : Boolean;{disk size}
  {-Return space information about the drive.}
{$ELSE}
function GetDiskSpace(Drive : AnsiChar;
                  var UserSpaceAvail  : Comp;           {space available to user}
                  var TotalSpaceAvail : Comp;           {total space available}
                  var DiskSize        : Comp) : Boolean;{disk size}
  {-Return space information about the drive.}
{$ENDIF}

function GetDiskClass(Drive : AnsiChar) : DiskClass;
  {-Return the disk class for the specified drive}

function FlushOsBuffers(Handle : Integer) : Boolean;
  {-Flush the OS buffers for the specified file handle.}

function FileHandlesLeft(MaxHandles : Cardinal) : Cardinal;
  {-Return the number of available file handles.}

{$IFNDEF WIN32}
function FileHandlesOpen(CountDevices : Boolean) : Cardinal;
  {-Return the number of open files owned by a program.}
{$ENDIF}

function IsDirectory(const FName : string) : Boolean;
  {-Return True if FName is a directory.}

function SameFile(const FilePath1, FilePath2 : string; var ErrorCode : Integer) : Boolean;
  {-Return True if FilePath1 and FilePath2 refer to the same physical file.}

function CopyFile(const SrcPath, DestPath : string) : Cardinal;
  {-Copy a file.}

function ReadVolumeLabel(var VolName : string; Drive : AnsiChar) : Cardinal;
  {-Get the volume label for the specified drive.}

function WriteVolumeLabel(const VolName : string; Drive : AnsiChar) : Cardinal;
  {-Sets the volume label for the specified drive.}

function DeleteVolumeLabel(Drive : AnsiChar) : Cardinal;
  {-Deletes an existing volume label on Drive. Returns 0 for success,
  or OS error code.}

function GetMediaID(Drive : AnsiChar; var MediaIDRec : MediaIDType) : Cardinal;
  {-Get the media ID record for the specified drive.}

function SetMediaID(Drive : AnsiChar; var MediaIDRec : MediaIDType) : Cardinal;
  {-Set the media ID record for the specified drive.}

function ValidDrive(Drive : AnsiChar) : Boolean;
  {-Determine if the drive is a valid drive.}


implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  Forms,
  IniFiles,
  ShellAPI,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}


const
  ecOutOfMemory = 8;

{$IFDEF WIN32}
const
  FILE_ANY_ACCESS = 0;
  METHOD_BUFFERED = 0;
  IOCTL_DISK_BASE = $00000007;
  VWIN32_DIOC_DOS_IOCTL = 1;
  IOCTL_DISK_GET_MEDIA_TYPES = ((IOCTL_DISK_BASE shl 16) or
    (FILE_ANY_ACCESS shl 14) or ($0300 shl 2) or METHOD_BUFFERED);

type
  TMediaType =
    ( Unknown,                { Format is unknown }
      F5_1Pt2_512,            { 5.25", 1.2MB,  512 bytes/sector }
      F3_1Pt44_512,           { 3.5",  1.44MB, 512 bytes/sector }
      F3_2Pt88_512,           { 3.5",  2.88MB, 512 bytes/sector }
      F3_20Pt8_512,           { 3.5",  20.8MB, 512 bytes/sector }
      F3_720_512,             { 3.5",  720KB,  512 bytes/sector }
      F5_360_512,             { 5.25", 360KB,  512 bytes/sector }
      F5_320_512,             { 5.25", 320KB,  512 bytes/sector }
      F5_320_1024,            { 5.25", 320KB,  1024 bytes/sector }
      F5_180_512,             { 5.25", 180KB,  512 bytes/sector }
      F5_160_512,             { 5.25", 160KB,  512 bytes/sector }
      RemovableMedia,         { Removable media other than floppy }
      FixedMedia );           { Fixed hard disk media }

  PDiskGeometry = ^TDiskGeometry;
  TDiskGeometry = record
    Cylinders1 : DWORD;
    Cylinders2 : Integer;
    MediaType : TMediaType;
    TracksPerCylinder : DWORD;
    SectorsPerTrack : DWORD;
    BytesPerSector : DWORD;
  end;
{$ELSE}
type

  TTriStateValue = (tsvUnknown,
                    tsvFalse,
                    tsvTrue);
  TDeviceBPB = packed record
    dbBytesPerSec : word;
    dbSecPerClust : byte;
    dbReservedSec : word;
    dbFATCount    : byte;
    dbMaxRootDirs : word;
    dbSecCount    : word;
    dbMediaDesc   : byte;
    dbSecPerFAT   : word;
    dbSecPerTrack : word;
    dbHeadCount   : word;
    dbHiddenSecs  : longint;
    dbSecCount2   : longint;
    dbReserved    : array [0..5] of byte;
  end;
  TDeviceParameterBlock = packed record
    dpbSpecFunc   : byte;
    dpbDevType    : byte;
    dpbDevAttr    : word;
    dpbCylCount   : word;
    dpbMediaType  : byte;
    dpbDevBPB     : TDeviceBPB;
  end;


  DescriptorTableEntry = record
    LimitL : Word;
    BaseL  : Word;
    Words : array[0..1] of Word;
  end;

  OS = record
    O, S : Word;
  end;

  XFCBrec = record
    Flag : Byte;                      {should be $FF}
    Reserved0 : array[1..5] of Byte;  {should be all zeroes}
    AttrByte : Byte;                  {should be 8}
    DriveCode : Byte;
    FileSpec : array[1..11] of AnsiChar;
    Reserved1 : array[1..25] of Byte;
  end;

  DTABuf = array[0..63] of AnsiChar;

  DPMIRegisters = record
    DI : LongInt;
    SI : LongInt;
    BP : LongInt;
    Reserved : LongInt;
    case integer of
    1 : ( BX : LongInt;
          DX : LongInt;
          CX : LongInt;
          AX : LongInt;
          Flags : Word;
          ES : Word;
          DS : Word;
          FS : Word;
          GS : Word;
          IP : Word;
          CS : Word;
          SP : Word;
          SS : Word );
    2 : ( BL, BH : Byte; EBXH : Word;
          DL, DH : Byte; EDXH : Word;
          CL, CH : Byte; ECXH : Word;
          AL, AH : Byte; EAXH : Word );
  end;
{$ENDIF}

type
  DevIOCtlRegisters = record
    reg_EBX : LongInt;
    reg_EDX : LongInt;
    reg_ECX : LongInt;
    reg_EAX : LongInt;
    reg_EDI : LongInt;
    reg_ESI : LongInt;
    reg_Flags : LongInt;
  end;

{$IFDEF WIN32}   { 32-bit replacements for 16-bit inline }

function MakeInteger16(H, L : Byte): SmallInt;
begin
  Result := (SmallInt(H) shl 8) or L;
end;

function SwapNibble(B : Byte) : Byte;
begin
  Result := (B shr 4) or (B shl 4);
end;

function SwapWord(L : LongInt) : LongInt; register;
asm
  ror eax,16;
end;

procedure SetFlag(var Flags : Word; FlagMask : Word);
begin
  Flags := Flags or FlagMask;
end;

procedure ClearFlag(var Flags : Word; FlagMask : Word);
begin
  Flags := Flags and (not FlagMask);
end;


function FlagIsSet(Flags, FlagMask : Word) : Boolean;
begin
  Result := (FlagMask AND Flags <> 0);
end;

procedure SetByteFlag(var Flags : Byte; FlagMask : Byte);
begin
  Flags := Flags or FlagMask;
end;

procedure ClearByteFlag(var Flags : Byte; FlagMask : Byte);
begin
  Flags := Flags and (not FlagMask);
end;

function ByteFlagIsSet(Flags, FlagMask : Byte) : Boolean;
begin
  Result := (FlagMask AND Flags <> 0);
end;

procedure SetLongFlag(var Flags : LongInt; FlagMask : LongInt);
begin
  Flags := Flags or FlagMask;
end;

procedure ClearLongFlag(var Flags : LongInt; FlagMask : LongInt);
begin
  Flags := Flags and (not FlagMask);
end;

function LongFlagIsSet(Flags, FlagMask : LongInt) : Boolean;
begin
  Result := FlagMask = (Flags and FlagMask);
end;

procedure ExchangeBytes(var I, J : Byte);
{$IFDEF WIN32}
register;
asm
{$ELSE}
asm
  mov  eax,i
  mov  edx,j
{$ENDIF}
  mov  cl, [eax]
  mov  ch, [edx]
  mov  [edx], cl
  mov  [eax], ch
end;

procedure ExchangeWords(var I, J : Word);
{$IFDEF WIN32}
register;
asm
{$ELSE}
asm
  mov  eax,i
  mov  edx,j
{$ENDIF}
  mov  cx, [eax]
  push ecx
  mov  cx, [edx]
  mov  [eax], cx
  pop  ecx
  mov  [edx], cx
end;

procedure ExchangeLongInts(var I, J : LongInt);
{$IFDEF WIN32}
register;
asm
{$ELSE}
asm
  mov  eax,i
  mov  edx,j
{$ENDIF}
  mov  ecx, [eax]
  push ecx
  mov  ecx, [edx]
  mov  [eax], ecx
  pop  ecx
  mov  [edx], ecx
end;

procedure ExchangeStructs(var I, J; Size : Cardinal);
{$IFDEF WIN32}
register;
asm
{$ELSE}
asm
  mov  eax,i
  mov  edx,j
  mov  ecx,Size
{$ENDIF}
  push edi
  push ebx
  push ecx
  shr  ecx, 2
  jz   @@LessThanFour

@@AgainDWords:
  mov  ebx, [eax]
  mov  edi, [edx]
  mov  [edx], ebx
  mov  [eax], edi
  add  eax, 4
  add  edx, 4
  dec  ecx
  jnz  @@AgainDWords

@@LessThanFour:
  pop  ecx
  and  ecx, $3
  jz   @@Done
  mov  bl, [eax]
  mov  bh, [edx]
  mov  [edx], bl
  mov  [eax], bh
  inc  eax
  inc  edx
  dec  ecx
  jz   @@Done

  mov  bl, [eax]
  mov  bh, [edx]
  mov  [edx], bl
  mov  [eax], bh
  inc  eax
  inc  edx
  dec  ecx
  jz   @@Done

  mov  bl, [eax]
  mov  bh, [edx]
  mov  [edx], bl
  mov  [eax], bh

@@Done:
  pop  ebx
  pop  edi
end;

procedure FillWord(var Dest; Count : Cardinal; Filler : Word);
asm
{$IFDEF WIN32}
  push edi
{$ENDIF}
  mov   edi,Dest
  mov   ax,Filler
  mov   ecx,Count
  cld
  rep  stosw
{$IFDEF WIN32}
  pop   edi
{$ENDIF}
end;

procedure FillStruct(var Dest; Count : Cardinal; var Filler;
  FillerSize : Cardinal);
{$IFDEF WIN32}
register;
asm
{$ELSE}
asm
  mov  eax,Dest
  mov  edx,Count
  mov  ecx,Filler
{$ENDIF}
  or   edx, edx
  jz   @@Exit

  push edi
  push esi
  push ebx
  mov  edi, eax
  mov  ebx, ecx

@@NextStruct:
  mov  esi, ebx
  mov  ecx, FillerSize
  shr  ecx, 1
  rep  movsw
  adc  ecx, ecx
  rep  movsb
  dec  edx
  jnz  @@NextStruct

  pop  ebx
  pop  esi
  pop  edi

@@Exit:
end;

function AddWordToPtr(P : Pointer; W : Word) : Pointer;
begin
  Result := Pointer(LongInt(P)+W);
end;

function MakeWord(H, L : Byte) : Word;
begin
  Result := (Word(H) shl 8) or L;
end;

function MinWord(A, B : Word) : Word;
begin
  if A < B then
     Result := A
  else
     Result := B;
end;

function MaxWord(A, B : Word) : Word;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function MinLong(A, B : LongInt) : LongInt;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function MaxLong(A, B : LongInt) : LongInt;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

{$ENDIF}     { End of 32-bit replacements for 16-bit inline }

{Operating system utilities}

{$IFNDEF WIN32}  { 16 bit utility functions }
function GetCPUFlags : Byte; assembler;
asm
  lahf
  mov     al,ah
end;

function FreeLDTDescriptor(Selector : Word) : Word; assembler;
asm
  mov  bx,Selector
  mov  ax,0001h
  int  31h
  jc   @@ExitPoint

  xor  ax,ax

@@ExitPoint:
end;

function AllocLDTDescriptors(NumOfDesc : Word; var BaseSelector : Word) : Word; assembler;
asm
  mov  cx,NumOfDesc
  xor  ax,ax
  int  31h
  jc   @@ExitPoint

  les  di,BaseSelector
  mov  es:[di],ax
  xor  ax,ax

@@ExitPoint:
end;

function SetSegmentBaseAddr(Selector : Word; BaseAddress : LongInt) : Word; assembler;
asm
  mov  bx,Selector
  mov  dx,word ptr BaseAddress
  mov  cx,word ptr BaseAddress+2
  mov  ax,0007h
  int  31h
  jc   @@ExitPoint

  xor  ax,ax

@@ExitPoint:
end;

function GetDescriptor(Selector : Word;
                       var Descriptor : DescriptorTableEntry) : Word; assembler;
asm
  mov  ax,000Bh
  mov  bx,Selector
  les  di,Descriptor
  int  31h
  jc   @@ExitPoint

  xor  ax,ax

@@ExitPoint:
end;

function GetDTA : Pointer; assembler;
asm
  mov  ah,2Fh
  int  21h
  mov  ax,bx
  mov  dx,es
end;

procedure SetDTA(var DTA); assembler;
asm
  push ds
  lds  dx,DTA
  mov  ah,1Ah
  int  21h
  pop  ds
end;

function SetLimitPrim(Selector : Word; Limit : LongInt) : Word; assembler;
asm
  mov  bx,Selector
  mov  dx,word ptr Limit
  mov  cx,word ptr Limit+2
  mov  ax,0008h
  int  31h
  jc   @@ExitPoint

  xor  ax,ax

@@ExitPoint:
end;

function SetRightsPrim(Selector : Word; Rights : Word) : Word; assembler;
asm
  mov  bx,Selector
  mov  cx,Rights
  mov  ax,0009h
  int  31h
  jc   @@ExitPoint

  xor  ax,ax

@@ExitPoint:
end;

function SimulateRealModeInt(IntNo : Byte;
                             var Regs : DPMIRegisters) : Word; Assembler;
asm
  xor     bx,bx
  mov     bl,IntNo
  xor     cx,cx       {StackWords = 0}
  les     di,Regs
  mov     ax,0300h
  int     31h
  jc      @@ExitPoint

  xor     ax,ax
@@ExitPoint:
end;

function Linear(P : Pointer) : LongInt;
begin
  with OS(P) do
    Result := (LongInt(S) shl 4) + LongInt(O);
end;

function GetSegmentAccessRights(Selector : Word; var Rights : Word) : Word;
var
  Status : Word;
  Descriptor : DescriptorTableEntry;
begin
  Status := GetDescriptor(Selector, Descriptor);
  if Status = 0 then
    with Descriptor do
      Rights := (Words[0] shr 8) or ((Words[1] and $00F0) shl 8);
  Result := Status;
end;

function SetSegmentLimit(Selector : Word; Limit : LongInt) : Word;
var
  Rights : Word;
  Status : Word;
begin
  {Handle limit granularity}
  Status := GetSegmentAccessRights(Selector, Rights);
  if Status <> 0 then begin
    Result := Status;
    Exit;
  end;
  if Limit > $FFFFF then begin
    {Segment larger than 1MB}
    if Limit and $FFF <> $FFF then begin
      {Not page aligned}
      Result := $8021;
      Exit;
    end;
    Rights := Rights or $8000;       {Page-granular}
  end else
    Rights := Rights and not $8000;  {Byte-granular}

   {Assure no overflow when granularity changed}
  Status := SetLimitPrim(Selector, 0);
  if Status = 0 then
    Status := SetRightsPrim(Selector, Rights);
  if Status = 0 then
    Result := SetLimitPrim(Selector, Limit);
  Result := Status;
end;

function GetSelectorForRealMem(RealPtr : Pointer; Limit : LongInt; var Selector : Word) : Word;

  procedure FreeSele;
  begin
    FreeLDTDescriptor(Selector);
  end;

var
  ErrorCode : Word;

begin
  ErrorCode := AllocLDTDescriptors(1, Selector);
  if ErrorCode = 0 then begin
    ErrorCode := SetSegmentBaseAddr(Selector, Linear(RealPtr));
    if ErrorCode = 0 then begin
      ErrorCode := SetSegmentLimit(Selector, Limit);
      if ErrorCode <> 0 then
        FreeSele;
    end else
      FreeSele;
  end;
  Result := ErrorCode;
end;

function DosFCBCreate(var XFCB : XFCBRec) : Byte;
type
  DoubleWord = record LoWord, HiWord : word; end;
var
  Regs : DPMIRegisters;
  L : LongInt;
  RP, PP : ^XFCBRec;
begin
  L := GlobalDosAlloc(SizeOf(XFCBRec));
  if L = 0 then begin
    Result := ecOutOfMemory;
    Exit;
  end;
  RP := Ptr(DoubleWord(L).HiWord, 0);
  PP := Ptr(DoubleWord(L).LoWord, 0);
  FillChar(Regs, SizeOf(Regs), 0);
  Move(XFCB, PP^, SizeOf(XFCBRec));
  with Regs do begin
    DS := OS(RP).S;
    DX := OS(RP).O;
    AX := $1600;
    SimulateRealModeInt($21, Regs);
    Result := Lo(DoubleWord(AX).LoWord);
  end;
  Move(PP^, XFCB, Sizeof(XFCBRec));
  GlobalDosFree(OS(PP).S);
end;

function DosFCBClose(var XFCB : XFCBRec) : Byte;
type
  DoubleWord = record LoWord, HiWord : word; end;
var
  Regs : DPMIRegisters;
  L : LongInt;
  RP, PP : ^XFCBRec;
begin
  L := GlobalDosAlloc(SizeOf(XFCBRec));
  if L = 0 then begin
    Result := ecOutOfMemory;
    Exit;
  end;
  RP := Ptr(DoubleWord(L).HiWord, 0);
  PP := Ptr(DoubleWord(L).LoWord, 0);
  FillChar(Regs, SizeOf(Regs), 0);
  Move(XFCB, PP^, SizeOf(XFCBRec));
  with Regs do begin
    DS := OS(RP).S;
    DX := OS(RP).O;
    AX := $1000;
    SimulateRealModeInt($21, Regs);
    Result := Lo(DoubleWord(AX).LoWord);
  end;
  GlobalDosFree(OS(PP).S);
end;

procedure SelectDrive(Drive : AnsiChar); assembler;
asm
  mov  dl,Drive
  cmp  dl,'z'
  ja   @@ExitPoint

  cmp  dl,'a'
  jb   @@GotDrive

  sub  dl,32

@@GotDrive:
  sub  dl,'A'
  mov  ah,0Eh
  int  21h

@@ExitPoint:
end;

function DefaultDrive : AnsiChar; assembler;
asm
  mov  ah,19h
  int  21h
  add  al,'A'
end;

function IsDriveRemovable16(aDriveNum : byte) : TTriStateValue;
assembler;
asm
  mov ax, $4408
  mov bl, aDriveNum
  int $21
  mov bl, 0
  jc @@Exit
  inc bl
  inc bl
  sub bl, al
@@Exit:
  mov al, bl
end;

function IsDriveRemote16(aDriveNum : byte) : TTriStateValue;
assembler;
asm
  mov ax, $4409
  mov bl, aDriveNum
  int $21
  mov bl, 0
  jc @@Exit
  inc bl
  and dx, $1000
  jz @@Exit
  inc bl
@@Exit:
  mov al, bl
end;

function IsDriveCDROM16(aDriveNum : byte) : TTriStateValue;
assembler;
asm
  mov ax,150Bh
  mov cl, aDriveNum
  dec cl
  int $2F
  mov cx, ax
  mov al, 0
  jc @@Exit
  inc al
  cmp bx, 0ADADh
  jne @@Exit
  or cx, cx
  jz @@Exit
  inc al
@@Exit:
end;

procedure GetDriveParameters(aDriveNum : byte;
                         var aDriveBlk : TDeviceParameterBlock);
assembler;
asm
  push ds
  mov ax, $440D
  mov bl, aDriveNum
  mov cx, $0860
  lds dx, aDriveBlk
  int $21
  pop ds
end;

function MSCDEXIsLoaded16 : boolean;
assembler;
asm
  mov ax, $1500
  xor bx, bx
  int $2F
  mov al, 0
  or bx, bx
  jz @@Exit
  inc al
@@Exit:
end;

{$ENDIF}  { End 16-bit utility functions }

{$IFDEF WIN32}
function GetDiskInfo(Drive : AnsiChar; var ClustersAvailable, TotalClusters,
                     BytesPerSector, SectorsPerCluster : Cardinal) : Boolean;
var
  Root : string;
begin
  if Drive <> ' ' then begin
    Root := AnsiChar(Upcase(Drive)) + ':\';
    Result := GetDiskFreeSpaceA(PAnsiChar(Root), DWORD(SectorsPerCluster),
      DWORD(BytesPerSector), DWORD(ClustersAvailable), DWORD(TotalClusters));
  end else
    Result := GetDiskFreeSpaceA(nil, DWORD(SectorsPerCluster),
      DWORD(BytesPerSector), DWORD(ClustersAvailable), DWORD(TotalClusters));
end;
{$ELSE}
function GetDiskInfo(Drive : AnsiChar; var ClustersAvailable, TotalClusters,
           BytesPerSector, SectorsPerCluster : Cardinal) : Boolean; assembler;
asm
  xor  dl,dl
  cmp  Drive,' '
  je   @@1
  mov  al,Drive
  call UpcasePrim
  mov  dl,40h
  sub  al,dl
  mov  dl,al
@@1:
  mov  ah,36h
  int  21h
  cmp  ax,0FFFFh
  je   @@Error

  les  di,SectorsPerCluster
  mov  es:[di],ax
  les  di,BytesPerSector
  mov  es:[di],cx
  les  di,TotalClusters
  mov  es:[di],dx
  les  di,ClustersAvailable
  mov  es:[di],bx
  mov  ax,1
  jmp  @@ExitPoint

@@Error:
  xor  ax,ax

@@ExitPoint:
end;
{$ENDIF}

{$IFDEF CBuilder}
function GetDiskSpace(Drive : AnsiChar;
                  var UserSpaceAvail  : Double;           {space available to user}
                  var TotalSpaceAvail : Double;           {total space available}
                  var DiskSize        : Double) : Boolean;{disk size}
type
  TGetDiskFreeSpace = function (Drive : PAnsiChar;
                            var UserFreeBytes : Comp;
                            var TotalBytes : Comp;
                            var TotalFreeBytes : Comp) : Bool; stdcall;
  LH = packed record L,H : word; end;
var
  UserFree, Total, Size : Comp;
  VerInfo : TOSVersionInfo;
  LibHandle : THandle;
  GDFS : TGetDiskFreeSpace;
  Root : string;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  Result := False;
  {get the version info}
  VerInfo.dwOSVersionInfoSize := sizeof(VerInfo);
  if GetVersionEx(VerInfo) then begin
    with VerInfo do begin
      if ((dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and
          (LH(dwBuildNumber).L <> 1000)) or
         ((dwPlatformId = VER_PLATFORM_WIN32_NT) and
          (dwMajorVersion >= 4)) then begin
        LibHandle := LoadLibrary('KERNEL32.DLL');
        if (LibHandle <> 0) then begin
          @GDFS := GetProcAddress(LibHandle, 'GetDiskFreeSpaceExA');
          if Assigned(GDFS) then begin
            Root := AnsiChar(Upcase(Drive)) + ':\';
            if GDFS(PAnsiChar(Root), UserFree, Size, Total) then begin
              UserSpaceAvail := UserFree;
              DiskSize := Size;
              TotalSpaceAvail := Total;
              Result := true;
            end;
          end;
        end;
      end;
    end;
  end;
end;
{$ELSE}
function GetDiskSpace(Drive : AnsiChar;
                  var UserSpaceAvail  : Comp;           {space available to user}
                  var TotalSpaceAvail : Comp;           {total space available}
                  var DiskSize        : Comp) : Boolean;{disk size}
{$IFDEF Win32}
type
  TGetDiskFreeSpace = function (Drive : PAnsiChar;
                            var UserFreeBytes : Comp;
                            var TotalBytes : Comp;
                            var TotalFreeBytes : Comp) : Bool; stdcall;
  LH = packed record L,H : word; end;
{$ENDIF}
var
  CA, TC, BPS, SPC : Cardinal;
  {$IFDEF Win32}
  VerInfo : TOSVersionInfo;
  LibHandle : THandle;
  GDFS : TGetDiskFreeSpace;
  Root : string;
  {$ENDIF}
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  Result := false;
  {$IFDEF Win32}
  {get the version info}
  VerInfo.dwOSVersionInfoSize := sizeof(VerInfo);
  if GetVersionEx(VerInfo) then begin
    with VerInfo do begin
      if ((dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) and
          (LH(dwBuildNumber).L <> 1000)) or
         ((dwPlatformId = VER_PLATFORM_WIN32_NT) and
          (dwMajorVersion >= 4)) then begin
        LibHandle := LoadLibrary('KERNEL32.DLL');
        if (LibHandle <> 0) then begin
          @GDFS := GetProcAddress(LibHandle, 'GetDiskFreeSpaceExA');
          if Assigned(GDFS) then begin
            Root := AnsiChar(Upcase(Drive)) + ':\';
            if GDFS(PAnsiChar(Root), UserSpaceAvail, DiskSize, TotalSpaceAvail) then
              Result := true;
          end;
        end;
      end;
    end;
  end;
  {$ENDIF}
  if not Result then begin
    if GetDiskInfo(Drive, CA, TC, BPS, SPC) then begin
      Result := true;
      DiskSize := BPS;
      DiskSize := DiskSize * SPC * TC;
      TotalSpaceAvail := BPS;
      TotalSpaceAvail := TotalSpaceAvail * SPC * CA;
      UserSpaceAvail := TotalSpaceAvail;
    end;
  end;
end;
{$ENDIF}

{$IFDEF WIN32}
function GetDiskClass(Drive : AnsiChar) : DiskClass;
var
  Root : array[0..3] of AnsiChar;
  Root2 : array[0..6] of AnsiChar;
  ReturnedByteCount,
  SectorsPerCluster,
  BytesPerSector,
  NumberOfFreeClusters,
  TotalNumberOfClusters : DWORD;
  SupportedGeometry : array[1..20] of TDiskGeometry;
  HDevice : THandle;
  I : Integer;
  VerInfo : TOSVersionInfo;
  Found : Boolean;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  Result := InvalidDrive;
  Found := False;
  StrCopy(Root, '%:\');
  Root[0] := Drive;
  case GetDriveTypeA(Root) of
    0 : Result := UnknownDisk;
    1 : Result := InvalidDrive;
    DRIVE_REMOVABLE :
      begin
        GetVersionEx(VerInfo);
        if VerInfo.dwPlatformID = VER_PLATFORM_WIN32_NT then begin
          StrCopy(Root2, '\\.\%:');
          Root2[4] := Drive;
          HDevice := CreateFileA(Root2, 0, FILE_SHARE_READ,
            nil, OPEN_ALWAYS, 0, 0);
          if HDevice = INVALID_HANDLE_VALUE then Exit;
          if not DeviceIoControl(HDevice, IOCTL_DISK_GET_MEDIA_TYPES, nil, 0,
            @SupportedGeometry, SizeOf(SupportedGeometry), ReturnedByteCount, nil)
          then Exit;
          for I := 1 to (ReturnedByteCount div SizeOf(TDiskGeometry)) do begin
            case SupportedGeometry[I].MediaType of
              F5_1Pt2_512 : begin
                Result := Floppy12;
                Exit;
              end;
              F3_1Pt44_512 : begin
                Result := Floppy144;
                Exit;
              end;
              F3_720_512 : begin
                Result := Floppy720;
                Found := True;
              end;
              F5_360_512 : begin
                Result := Floppy360;
                Found := True;
              end;
            end;
          end;
          if Found then Exit;
          Result := OtherFloppy;
        end else begin
          GetDiskFreeSpaceA(Root, SectorsPerCluster, BytesPerSector,
            NumberOfFreeClusters, TotalNumberOfClusters);
          case TotalNumberOfClusters of
             354 : Result := Floppy360;
             713,
            1422 : Result := Floppy720;
            2371 : Result := Floppy12;
            2847 : Result := Floppy144;
          else Result := OtherFloppy;
          end;
        end;
      end;
    DRIVE_FIXED : Result := HardDisk;
    DRIVE_REMOTE : Result := RemoteDrive;
    DRIVE_CDROM : Result := CDRomDisk;
    DRIVE_RAMDISK : Result := RamDisk;
  end;
end;

{$ELSE}

function GetDiskClass(Drive : AnsiChar) : DiskClass;
var
  DriveNum : integer;
  DrvParms : TDeviceParameterBlock;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  {assume an invalid drive}
  Result := InvalidDrive;
  {convert drive letter to drive number}
  case Drive of
    'A'..'Z' : DriveNum := ord(Drive) - ord('A') + 1;
    'a'..'z' : DriveNum := ord(Drive) - ord('a') + 1;
  else
    {we're given a bad drive letter, so just get out}
    Exit;
  end;{case}
  {work out if the drive is remote}
  case IsDriveRemote16(DriveNum) of
    tsvFalse :   {drive is not labelled as remote}
      begin
        {get the drive parameters}
        FillChar(DrvParms, sizeof(DrvParms), 0);               
        GetDriveParameters(DriveNum, DrvParms);
        case DrvParms.dpbDevType of
          0 : Result := Floppy360;
          1 : Result := Floppy12;
          2 : Result := Floppy720;
          5 : Result := HardDisk;
          7 : {= 'other' block device}
            begin
              {check whether it's removable, indicating a floppy}
              if (IsDriveRemovable16(DriveNum) = tsvTrue) then begin
                if (DrvParms.dpbDevBPB.dbMediaDesc = $F0) then
                  Result := Floppy144
                else
                  Result := OtherFloppy;
              end
              else
                Result := UnknownDisk;
            end;
        else
          Result := UnknownDisk;
        end;{case}
      end;
    tsvTrue :    {drive is labelled as remote}
      begin
        {assume the drive is remote}
        Result := RemoteDrive;
        {MSCDEX labels local CDROM drives as remote, so we need to
         check for a CDROM drive before completing this check}
        if MSCDEXIsLoaded16 then
          if (IsDriveCDROM16(DriveNum) = tsvTrue) then
            Result := CDRomDisk;
      end;
  end;{case}
end;
{$ENDIF}

{$IFDEF WIN32}
function FlushOsBuffers(Handle : Integer) : Boolean;
  {-Flush the OS's buffers for the specified file}
begin
  Result := FlushFileBuffers(Handle);
end;

{$ELSE}

function FlushOsBuffers(Handle : Integer) : Boolean; assembler;
  {-Flush OS's buffers for the specified file}
asm
  mov  ah,45h
  mov  bx,Handle
  int  21h             {DUP the handle}
  mov  dx,0            {assume failure}
  jc   @@ExitPoint

  mov  bx,ax
  mov  ah,3Eh
  int  21h             {close the DUP}
  jc   @@ExitPoint

  inc  dx              {indicate success}

@@ExitPoint:
  mov  ax,dx           {set function result}
end;
{$ENDIF}

{$IFDEF WIN32}
{.$HINTS OFF}
function FileHandlesLeft(MaxHandles : Cardinal) : Cardinal;
  {-Returns the number of available file handles. In 32-bit, this can be a
    large number.  Use MaxHandles to limit the number of handles counted.
    The maximum is limited by HandleLimit - you can increase HandleLimit if
    you wish.  A temp file is required because Win95 seems to have some
    limit on the number of times you can open NUL.}
const
  HandleLimit = 1024;
type
  PHandleArray = ^THandleArray;
  THandleArray = array[0..Pred(HandleLimit)] of Integer;
var
  Handles : PHandleArray;
  MaxH, I : Integer;
  TempPath, TempFile : PChar;
begin
  Result := 0;
  MaxH := MinLong(HandleLimit, MaxHandles);
  TempFile := nil;
  TempPath := nil;
  Handles := nil;
  try
    TempFile := StrAlloc(256);
    TempPath := StrAlloc(256);
    GetMem(Handles, MaxH * SizeOf(Integer));
    GetTempPath(255, TempPath);
    GetTempFileName(TempPath, 'ST', 0, TempFile);
    for I := 0 to Pred(MaxH) do begin
      Handles^[I] := CreateFile(TempFile, 0, FILE_SHARE_READ, nil,
        OPEN_EXISTING, FILE_FLAG_DELETE_ON_CLOSE, 0);
      if Handles^[I] <> LongInt(INVALID_HANDLE_VALUE) then             
        Inc(Result) else Break;
    end;
    for I := 0 to Pred(Result) do
      FileClose(Handles^[I]);
  finally
    if Assigned(Handles) then
      FreeMem(Handles, MaxH * SizeOf(Integer));
    StrDispose(TempFile);
    StrDispose(TempPath);
  end;
end;
{.$HINTS ON}
{$ELSE}
function FileHandlesLeft(MaxHandles : Cardinal) : Cardinal; assembler;
  {-Returns the number of available file handles}
const
  NullName : array[1..4] of AnsiChar = 'NUL'#0;
  HandleLimit = 255;
var
  Handles : array[1..HandleLimit] of Word;
  N : Byte;
asm
  mov   cx,MaxHandles    {CX = MaxHandles}
  cmp   cx,HandleLimit
  jle   @@1
  mov   cx,HandleLimit

@@1:
  mov   bl,cl            {Save MaxHandles or HandleLimit}
  lea   dx,NullName      {DS:DX => NullName}
  lea   si,Handles       {SI has offset for Handles[1]}

@@Next:
  mov   ax,3D02h         {DOS open file function}
  push  cx
  int   21h              {call DOS}
  pop   cx
  jc    @@Close          {start closing if CF set}

  mov   ss:[si],ax       {save the Handle}
  inc   si               {inc pointer into Handles}
  inc   si
  loop  @@Next           {repeat if CX > 0}

@@Close:
  sub   bl,cl
  mov   N,bl             {save handle count in N}
  mov cl, bl             {calculate handles to close}
  jcxz  @@Done           {done if count is 0}

@@CloseOne:
  dec   si               {dec pointer into Handles}
  dec   si
  mov   bx,ss:[si]       {get the handle into BX}
  mov   ax,3E00h         {DOS close file function}
  push  cx
  int   21h              {call DOS, ignore error}
  pop   cx
  loop  @@CloseOne       {do it again}

@@Done:
  xor   ax,ax
  mov   al,N
end;
{$ENDIF}

{$IFNDEF WIN32}
function FileHandlesOpen(CountDevices : Boolean) : Cardinal;
  {-Return the number of open files owned by a program}
type
  HandleTable = array[0..254] of Byte;
var
  P : Pointer;
  HandlesPtr : ^HandleTable;
  Sele : Word;
  I, N, Max : Byte;
begin
  Result := 0;
  {pointer to file handles table at PrefixSeg:$34}
  LongInt(P) := MemL[PrefixSeg:$34];
  if not GetSelectorForRealMem(P, $100, Sele) = 0 then
    Exit;
  HandlesPtr := Ptr(Sele, 0);

  {size of file handles table at PrefixSeg:$32}
  Max := Mem[PrefixSeg:$0032]-1;

  N := 0;
  for I := 0 to Max do
    if HandlesPtr^[I] <> $FF then
      case I of
        0..4 : Inc(N, Ord(CountDevices));
        else   Inc(N);
      end;
  if FreeLDTDescriptor(Sele) = 0 then ;
  Result := N;
end;
{$ENDIF}

function IsDirectory(const FName : string) : Boolean;
 {-Return true if FName is a directory}
var
  SLen : Cardinal;
  D, CurDir,
  CurDestDir : string;
  DiffDrive : Boolean;
begin
  Result := False;
  GetDir(0, CurDir);
  SLen := Length(FName);
  if SLen = 0 then Exit;
  if ((SLen > 3) or (FName[2] <> ':')) and (FName[SLen] = '\') then Exit;
  if (SLen >= 2) and (FName[2] = ':') and (FName[1] <> CurDir[1]) then
  begin
    {Checking on a different drive}
    DiffDrive := True;
    D := System.Copy(FName, 1, 2);
    try
      ChDir(D);
    except
      on EInOutError do Exit;
    end;
    GetDir(0, CurDestDir);
  end else
    DiffDrive := False;

  try
    ChDir(FName);
    Result := True;
  except
    on EInOutError do Result := False;
  end;

  if DiffDrive then
    ChDir(CurDestDir);

  ChDir(CurDir);
end;

function SameFile(const FilePath1, FilePath2 : string;
                  var ErrorCode : Integer) : Boolean;
  {-Return true if FilePath1 and FilePath2 refer to the same physical file.
    Error codes:
      0 - Success (no error)
      1 - Invalid FilePath1
      2 - Invalid FilePath2
      3 - Error on FileSetAttr/FileGetAttr }
var
  Attr1, Attr2, NewAttr : Integer;


  {$IFDEF Win32}
  function DirectoryExists(const Name : string): Boolean;
  var
    Code : Integer;
    Buf  : array[0..254] of Char;
  begin
    StrPLCopy(Buf, Name, SizeOf(Buf)-1);
    Code := GetFileAttributes(Buf);
    Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
  end;
  {$ENDIF}

begin
  Result := False;
  ErrorCode := 0;
  Attr1 := FileGetAttr(FilePath1);
  if Attr1 < 0 then begin
    ErrorCode := 1;
    Exit;
  end;
  Attr2 := FileGetAttr(FilePath2);
  if Attr2 < 0 then begin
    {leave ErrorCode at 0 if file not found but path is valid}
    if not DirectoryExists(ExtractFilePath(FilePath2)) then
      ErrorCode := 2;
    Exit;
  end;
  if Attr1 <> Attr2 then
    Exit;
  if ((Attr1 and faArchive) = 0) then
    NewAttr := Attr1 or faArchive
  else
    NewAttr := Attr1 and (not faArchive);
  if FileSetAttr(FilePath1, NewAttr) <> 0 then begin
    ErrorCode := 3;
    Exit;
  end;
  Attr2 := FileGetAttr(FilePath2);
  if Attr2 < 0 then
    ErrorCode := 3;

  Result := (Attr2 = NewAttr) or (Attr2 = $80);
  { If the attribute is set to $00, Win32 automatically sets it to $80. }

  if FileSetAttr(FilePath1, Attr1) <> 0 then
    ErrorCode := 3;
end;

function CopyFile(const SrcPath, DestPath : string) : Cardinal;
  {-Copy the file specified by SrcPath into DestPath. DestPath must specify
    a complete filename, it may not be the name of a directory without the
    file portion.  This a low level routine, and the input pathnames are not
    checked for validity.}
const
  BufferSize = 4 * 1024;

var
  BytesRead, BytesWritten : LongInt;                                   
  FileDate : LongInt;
  Src, Dest, Mode, SaveFAttr : Integer;
  Buffer : Pointer;

begin
  Src := 0;
  Dest := 0;
  Buffer := nil;
  Result := 1;
  try
    GetMem(Buffer, BufferSize);
    Mode := FileMode and $F0;
    SaveFAttr := FileGetAttr(SrcPath);
    if SaveFAttr < 0 then begin
      Result := 1;
      Exit;
    end;
    Src := FileOpen(SrcPath, Mode);
    if Src < 0 then begin
      Result := 1;                     {unable to open SrcPath}
      Exit;
    end;
    Dest := FileCreate(DestPath);
    if Dest < 0 then begin
      Result := 2;                     {unable to open DestPath}
      Exit;
    end;
    repeat
      BytesRead := FileRead(Src, Buffer^, BufferSize);
      if (BytesRead = -1) then begin
        Result := 3;                   {error reading SrcPath}
        Exit;
      end;
      BytesWritten := FileWrite(Dest, Buffer^, BytesRead);
      if (BytesWritten = -1) or                            
         (BytesWritten <> BytesRead) then begin
        Result := 4;                   {error reading SrcPath}
        Exit;
      end;
    until BytesRead < BufferSize;
    FileDate := FileGetDate(Src);
    if FileDate = -1 then begin
      Result := 5;                     {error getting SrcPath's Date/Time}
      Exit;
    end;
    FileSetDate(Dest, FileDate);
    FileSetAttr(DestPath, SaveFAttr);
    Result := 0;
  finally
    if Assigned(Buffer) then
      FreeMem(Buffer, BufferSize);
    if Src > 0 then FileClose(Src);
    if Dest > 0 then begin
      FileClose(Dest);
      if Result <> 0 then SysUtils.DeleteFile(DestPath);
    end;
  end;
end;

{$IFDEF WIN32}
function ReadVolumeLabel(var VolName : string; Drive : AnsiChar) : Cardinal;
var
  Root : string;
  {$IFDEF WIN32}
  Flags, MaxLength : DWORD;
  {$ELSE}
  Flags, MaxLength : Integer;
  {$ENDIF}
  NameSize : Integer;
begin
  NameSize := 0;
  Root := Drive + ':\';
  if Length(VolName) < 12 then
    SetLength(VolName, 12);
  if GetVolumeInformation(PChar(Root), PChar(VolName), Length(VolName),
    nil, MaxLength, Flags, nil, NameSize)
  then
    Result := 0
  else
    Result := GetLastError;
end;

{$ELSE}

function ReadVolumeLabel(var VolName : string; Drive : AnsiChar) : Cardinal;
const
  AllMask = '%:\*.*';
var
  DosError : Integer;
  SearchRec : TSearchRec;
  Temp : string;
  Mask : string;
  P : Cardinal;
begin
  Mask := AllMask;
  Mask[1] := Drive;
  DosError := Abs(FindFirst(Mask, faVolumeID, SearchRec));
  if DosError = 18 then begin
    {no Volume ID found}
    Result := 0;
    VolName := '';
  end else begin
    Result := DosError;
    if DosError = 0 then begin
      VolName := SearchRec.Name;
      P := Pos('.', VolName);
      case P of
        0 : ;
        9 : System.Delete(VolName, P, 1);
        else begin
          Temp := System.Copy(VolName, Succ(P), 3);
          VolName := Format('%-8s', [System.Copy(VolName, 1, Pred(P))]) + Temp;
        end;
      end;
    end
    else
      VolName := '';
  end;
  FindClose(SearchRec);
end;
{$ENDIF}

{$IFDEF WIN32}
function WriteVolumeLabel(const VolName : string; Drive : AnsiChar) : Cardinal;
var
  Temp : string;
  Vol : array[0..11] of AnsiChar;
  Root : array[0..3] of AnsiChar;
begin
  Temp := VolName;
  StrCopy(Root, '%:\');
  Root[0] := Drive;
  if Length(Temp) > 11 then
    SetLength(Temp, 11);
  StrPCopy(Vol, Temp);
  if Windows.SetVolumeLabelA(Root, Vol) then
    Result := 0
  else Result := GetLastError;
end;

{$ELSE}

function WriteVolumeLabel(const VolName : string; Drive : AnsiChar) : Cardinal;
var
  XFCB : XFCBRec;
  DTA : DTABuf;
  SaveDTA : Pointer;
  MediaID : MediaIDType;
  DriveNo : Byte;
  VName : array[0..10] of AnsiChar;
  MediaBlockExists : Boolean;
  ErrorCode : Byte;
begin
  SaveDTA := GetDTA;
  SetDTA(DTA);
  FillChar(XFCB, SizeOf(XFCB), 0);
  FillChar(XFCB.FileSpec, 11, '?');
  XFCB.Flag := $FF;
  XFCB.AttrByte := 8;
  DriveNo := Ord(UpCase(Drive)) - (Ord('A') - 1);
  XFCB.DriveCode := DriveNo;
  MediaBlockExists := (GetMediaID(Drive, MediaID) = 0);
  FillChar(VName, SizeOf(VName), ' ');
  Move(VolName[1], VName, MinWord(Length(VolName), SizeOf(VName)));
  asm
    push ds
    mov  ax,ss
    mov  ds,ax
    mov  es,ax
    lea  dx,XFCB
    mov  ah,11h
    int  21h
    or   al,al
    jnz  @@NoLabel

    lea  di,DTA
    mov  dx,di
    add  di,18h
    cld
    mov  cx,ss
    mov  ds,cx
    lea  si,VName
    mov  cx,11
    rep  movsb
    mov  ax,ss
    mov  ds,ax
    mov  ah,17h
    int  21h
    mov  ErrorCode,al
    jmp  @@ExitPoint

  @@NoLabel:
    lea  di,XFCB
    push ss
    push di
    add  di,8
    mov  cx,ss
    mov  ds,cx
    mov  es,cx
    lea  si,VName
    cld
    mov  cx,11
    rep  movsb
    call DosFCBCreate
    mov  ErrorCode,al
    cmp  al,0
    ja   @@ExitPoint

    lea  di,XFCB
    push ss
    push di
    call DosFCBClose
    mov  ErrorCode,al

  @@ExitPoint:
    pop  ds
  end;
  if MediaBlockExists and (ErrorCode = 0) then begin
    Move(VName[0], MediaID.VolumeLabel, SizeOf(MediaID.VolumeLabel));
    ErrorCode := SetMediaID(Drive, MediaID);
  end;
  SetDTA(SaveDTA^);
  Result := ErrorCode;
end;
{$ENDIF}

{$IFDEF WIN32}
function DeleteVolumeLabel(Drive : AnsiChar) : Cardinal;
var
  Root : array[0..3] of AnsiChar;
begin
  StrCopy(Root, '%:\');
  Root[0] := Drive;
  if Windows.SetVolumeLabelA(Root, '') then
    Result := 0
  else Result := GetLastError;
end;

{$ELSE}

function DeleteVolumeLabel(Drive : AnsiChar) : Cardinal;
var
  XFCB : XFCBRec;
  DTA  : DTABuf;
  MediaID : MediaIDType;
  SaveDTA : Pointer;
  ErrorCode : Byte;
  DriveNo : Byte;
  MediaBlockExists : Boolean;
  VolName: array[0..10] of AnsiChar;
begin
  SaveDTA := GetDTA;
  SetDTA(DTA);
  FillChar(VolName, SizeOf(VolName), ' ');
  VolName[10] := #0;
  FillChar(XFCB, SizeOf(XFCB), 0);
  FillChar(XFCB.FileSpec, 11, '?');
  XFCB.Flag := $FF;
  XFCB.AttrByte := faVolumeID;
  DriveNo := Ord(Upcase(Drive)) - (Ord('A') - 1);
  XFCB.DriveCode := DriveNo;
  MediaBlockExists := (GetMediaID(Drive, MediaID) = 0);
  asm
    push     ds
    lea      dx,XFCB
    mov      ax,ss
    mov      ds,ax
    mov      ah,13h
    int      21h
    pop      ds
    mov      ErrorCode,al
  end;
  if MediaBlockExists and (ErrorCode = 0) then begin
    Move(VolName[1], MediaID.VolumeLabel, SizeOf(MediaID.VolumeLabel));
    if SetMediaID(Drive, MediaID) = 0 then ;
  end;
  SetDTA(SaveDTA^);
  Result := ErrorCode;
end;
{$ENDIF}

{$IFDEF WIN32}   {!! Does not work for NT}
function GetMediaID(Drive : AnsiChar; var MediaIDRec : MediaIDType) : Cardinal;
var
  PMid : PMediaIDType;
  Regs : DevIOCtlRegisters;
  CB   : DWord;
  HDevice : THandle;
  SA   : TSecurityAttributes;
begin
  PMid := @MediaIDRec;
  with SA do begin
    nLength := SizeOf(SA);
    lpSecurityDescriptor := nil;
    bInheritHandle := True;
  end;
  with Regs do begin
    reg_EAX := $440D;
    reg_EBX := Ord(UpCase(Drive)) - (Ord('A') - 1);
    reg_ECX := $0866;
    reg_EDX := LongInt(PMid);
    reg_Flags := $1;                                                 
  end;
  HDevice := CreateFile('\\.\vwin32', GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE,
    Pointer(@SA), OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  if HDevice <> INVALID_HANDLE_VALUE then begin
    if DeviceIOControl(HDevice, VWIN32_DIOC_DOS_IOCTL, Pointer(@Regs), SizeOf(Regs),
      Pointer(@Regs), SizeOf(Regs), CB, nil) and                     
      ((Regs.Reg_Flags and $1) <> $1) then
        Result := 0
    else
      Result := GetLastError;
    CloseHandle(HDevice);
  end else
    Result := GetLastError;
end;

{$ELSE}

function GetMediaID(Drive : AnsiChar; var MediaIDRec : MediaIDType) : Cardinal;
type
  DoubleWord = record LoWord, HiWord : word; end;
var
  L : LongInt;
  RP, PP : ^MediaIDType;
  Regs : DPMIRegisters;
begin
  L := GlobalDosAlloc(SizeOf(MediaIDType));
  if L = 0 then begin
    Result := ecOutOfMemory;
    Exit;
  end;
  RP := Ptr(DoubleWord(L).HiWord, 0);
  PP := Ptr(DoubleWord(L).LoWord, 0);
  FillChar(Regs, SizeOf(Regs), 0);
  with Regs do begin
    DS := OS(RP).S;
    DX := OS(RP).O;
    AX := $440D;
    BX := Ord(UpCase(Drive)) - (Ord('A') - 1);
    CX := $0866;
    Flags := GetCPUFlags;
  end;
  SimulateRealModeInt($21, Regs);
  if Odd(Regs.Flags) then
    Result := Regs.AX
  else begin
    MediaIDRec := PP^;
    Result := 0;
  end;
  GlobalDosFree(OS(PP).S);
end;
{$ENDIF}

{$IFDEF WIN32}   {!! Does not work for NT}
function SetMediaID(Drive : AnsiChar; var MediaIDRec : MediaIDType) : Cardinal;
var
  PMid : PMediaIDType;
  Regs : DevIOCtlRegisters;
  CB   : DWord;
  HDevice : THandle;
  SA   : TSecurityAttributes;
begin
  PMid := @MediaIDRec;
  with SA do begin
    nLength := SizeOf(SA);
    lpSecurityDescriptor := nil;
    bInheritHandle := True;
  end;
  with Regs do begin
    reg_EAX := $440D;
    reg_EBX := Ord(UpCase(Drive)) - (Ord('A') - 1);
    reg_ECX := $0846;
    reg_EDX := LongInt(PMid);
  end;
  HDevice := CreateFile('\\.\vwin32', GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE,
    Pointer(@SA), OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if HDevice <> INVALID_HANDLE_VALUE then begin
    if DeviceIOControl(HDevice, VWIN32_DIOC_DOS_IOCTL, Pointer(@Regs), SizeOf(Regs),
      Pointer(@Regs), SizeOf(Regs), CB, nil)
    then
      Result := 0
    else
      Result := GetLastError;
    CloseHandle(HDevice);
  end else
    Result := GetLastError;
end;

{$ELSE}

function SetMediaID(Drive : AnsiChar; var MediaIDRec : MediaIDType) : Cardinal;
type
  DoubleWord = record LoWord, HiWord : word; end;
var
  L : LongInt;
  RP, PP : ^MediaIDType;
  Regs : DPMIRegisters;
begin
  L := GlobalDosAlloc(SizeOf(MediaIDType));
  if L = 0 then begin
    Result := ecOutOfMemory;
    Exit;
  end;
  RP := Ptr(DoubleWord(L).HiWord, 0);
  PP := Ptr(DoubleWord(L).LoWord, 0);
  PP^ := MediaIDRec;
  FillChar(Regs, SizeOf(Regs), 0);
  with Regs do begin
    DS := OS(RP).S;
    DX := OS(RP).O;
    AX := $440D;
    BX := Ord(UpCase(Drive)) - (Ord('A') - 1);
    CX := $0846;
    Flags := GetCPUFlags;
  end;
  SimulateRealModeInt($21, Regs);
  if Odd(Regs.Flags) then
    Result := Regs.AX
  else
    Result := 0;
  GlobalDosFree(OS(PP).S);
end;
{$ENDIF}

{$IFDEF WIN32}
function ValidDrive(Drive : AnsiChar) : Boolean;
var
  DriveBits : LongInt;
  DriveLtr : AnsiChar;
begin
  DriveLtr := UpCase(Drive);
  DriveBits := GetLogicalDrives shr (Ord(DriveLtr)-Ord('A'));
  Result := LongFlagIsSet(DriveBits, $00000001);
end;
{$ELSE}
function ValidDrive(Drive : AnsiChar) : Boolean;
var
  CurDrive : AnsiChar;
begin
  Drive := UpCase(Drive);
  CurDrive := DefaultDrive;
  SelectDrive(Drive);
  Result := (DefaultDrive = Drive);
  SelectDrive(CurDrive);
end;
{$ENDIF}

function SignL(L : LongInt) : Integer;
  {-return sign of LongInt value}
begin
  if L < 0 then
    Result := -1
  else if L = 0 then
    Result := 0
  else
    Result := 1;
end;

function SignF(F : Extended) : Integer;
  {-return sign of floating point value}
begin
  if F < 0 then
    Result := -1
  else if F = 0 then
    Result := 0
  else
    Result := 1;
end;

function MidWord(W1, W2, W3 : Word) : Word;
  {return the middle of three Word values}
begin
  Result := StUtils.MinWord(StUtils.MinWord(StUtils.MaxWord(W1, W2),
                            StUtils.MaxWord(W2, W3)), StUtils.MaxWord(W1, W3));
end;

function MidLong(L1, L2, L3 : LongInt) : LongInt;
  {return the middle of three LongInt values}
begin
  Result := StUtils.MinLong(StUtils.MinLong(StUtils.MaxLong(L1, L2),
                            StUtils.MaxLong(L2, L3)), StUtils.MaxLong(L1, L3));
end;

function MidFloat(F1, F2, F3 : Extended) : Extended;
  {return the middle of three floating point values}
begin
  Result := MinFloat(MinFloat(MaxFloat(F1, F2), MaxFloat(F2, F3)), MaxFloat(F1, F3));
end;

function MinFloat(F1, F2 : Extended) : Extended;
  {-return the lesser of two floating point values}
begin
  if F1 <= F2 then
    Result := F1
  else
    Result := F2;
end;

function MaxFloat(F1, F2 : Extended) : Extended;
  {-return the greater of two floating point values}
begin
  if F1 > F2 then
    Result := F1
  else
    Result := F2;
end;

function IsDirectoryEmpty(const S : string) : Integer;
  {-checks if there are any entries in the directory}
var
  SR : TSearchRec;
  R  : Integer;
  DS : string;
begin
  Result := 1;
  if IsDirectory(S) then begin
{$IFDEF Win32}
 {$IFOPT H+}
    DS := AddBackSlashL(S);
 {$ELSE}
    DS := AddBackSlashS(S);
 {$ENDIF}
{$ELSE}
    DS := AddBackSlashS(S);
{$ENDIF}
    R := Abs(FindFirst(DS + '*.*', faAnyFile, SR));
    if R <> 18 then begin
      if (R = 0) then
      repeat
        if (SR.Attr and faDirectory = faDirectory) then begin
          if (SR.Name <> '.') and (SR.Name <> '..') then begin
            Result := 0;
            break;
          end;
        end else begin
          Result := 0;
          break;
        end;
        R := Abs(FindNext(SR));
      until R = 18;
    end;
    FindClose(SR);
  end else
    Result := -1;
end;

function IsFileHidden(const S : string) : Integer;
  {-checks if file's hidden attribute is set}
begin
  if FileExists(S) then
    Result := Integer((FileGetAttr(S) and faHidden) = faHidden)
  else
    Result := -1;
end;

function IsFileSystem(const S : string) : Integer;
  {-checks if file's system attribute is set}
begin
  if FileExists(S) then
    Result := Integer((FileGetAttr(S) and faSysFile) = faSysFile)
  else
    Result := -1;
end;

function IsFileReadOnly(const S : string) : Integer;
  {-checks if file's readonly attribute is set}
begin
  if FileExists(S) then
    Result := Integer((FileGetAttr(S) and faReadOnly) = faReadOnly)
  else
    Result := -1;
end;

function IsFileArchive(const S : string) : Integer;
  {-checks if file's archive attribute is set}
begin
  if FileExists(S) then
    Result := Integer((FileGetAttr(S) and faArchive) = faArchive)
  else
    Result := -1;
end;

procedure EnumerateFiles(StartDir : string;
                         FL : TStrings;
                         SubDirs : Boolean;
                         IncludeItem : TIncludeItemFunc);

    procedure SearchBranch;
    var
      SR    : TSearchRec;
      Error : SmallInt;
      Dir   : string;
    begin
      Error := FindFirst('*.*', faAnyFile, SR);
      GetDir(0, Dir);
      if Dir[Length(Dir)] <> '\' then
        Dir := Dir + '\';
      while Error = 0 do
      begin
        try
          if (@IncludeItem = nil) or (IncludeItem(SR, true)) then
            FL.Add(Dir + SR.Name);
        except
          on EOutOfMemory do
          begin
            raise EOutOfMemory.Create('String list is full');
          end;
        end;
        Error := FindNext(SR);
      end;
      FindClose(SR);

      if SubDirs then
      begin
        Error := FindFirst('*.*', faAnyFile, SR);                      {!!.01}
        while Error = 0 do
        begin
          if ((SR.Attr and faDirectory = faDirectory) and
              (SR.Name <> '.') and (SR.Name <> '..')) then
          begin
            if (@IncludeItem = nil) or (IncludeItem(SR, false)) then
            begin
              ChDir(SR.Name);
              SearchBranch;
              ChDir('..');
            end;
          end;
          Error := FindNext(SR);
        end;
        FindClose(SR);
      end;
    end;

var
  OrgDir : string;

begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  if IsDirectory(StartDir) then
  begin
    GetDir(0, OrgDir);
    try
      ChDir(StartDir);
      SearchBranch;
    finally
      ChDir(OrgDir);
    end;
  end else
    raise Exception.Create('Invalid starting directory');
end;


procedure EnumerateDirectories(StartDir : string; FL : TStrings;
                               SubDirs : Boolean;
                               IncludeItem : TIncludeItemFunc);

    procedure SearchBranch;
    var
      SR    : TSearchRec;
      Error : SmallInt;
      Dir   : string;
    begin
      Error := FindFirst('*.*', faDirectory, SR);
      GetDir(0, Dir);
      if Dir[Length(Dir)] <> '\' then
        Dir := Dir + '\';
      while Error = 0 do
      begin
        try
          if (@IncludeItem = nil) or (IncludeItem(SR, true)) then
          begin
            if (SR.Attr and faDirectory = faDirectory) and
               (SR.Name <> '.') and (SR.Name <> '..') then
              FL.Add(Dir + SR.Name);
          end;
        except
          on EOutOfMemory do
          begin
            raise EOutOfMemory.Create('String list is full');
          end;
        end;
        Error := FindNext(SR);
      end;
      FindClose(SR);

      if SubDirs then
      begin
        Error := FindFirst('*.*', faDirectory, SR);
        while Error = 0 do
        begin
          if ((SR.Attr and faDirectory = faDirectory) and
              (SR.Name <> '.') and (SR.Name <> '..')) then
          begin
            if (@IncludeItem = nil) or (IncludeItem(SR, false)) then
            begin
              ChDir(SR.Name);
              SearchBranch;
              ChDir('..');
            end;
          end;
          Error := FindNext(SR);
        end;
        FindClose(SR);
      end;
    end;

var
  OrgDir : string;

begin
  if IsDirectory(StartDir) then
  begin
    GetDir(0, OrgDir);
    try
      ChDir(StartDir);
      SearchBranch;
    finally
      ChDir(OrgDir);
    end;
  end else
    raise Exception.Create('Invalid starting directory');
end;

function FileTimeToStDateTime(FileTime : LongInt) : TStDateTimeRec;
var
  DDT : TDateTime;
begin
  DDT := FileDateToDateTime(FileTime);
  Result.D := DateTimeToStDate(DDT);
  Result.T := DateTimeToStTime(DDT);
end;

function StDateTimeToFileTime(FileTime : TStDateTimeRec) : LongInt;
var
  DDT : TDateTime;
begin
  DDT := Int(StDateToDateTime(FileTime.D)) + Frac(StTimeToDateTime(FileTime.T));
  Result := DateTimeToFileDate(DDT);
end;

function UnixTimeToStDateTime(UnixTime : Longint) : TStDateTimeRec;
begin
  Result.D := Date1970 + (UnixTime div SecondsInDay);
  Result.T := UnixTime mod SecondsInDay;
end;

function StDateTimeToUnixTime(DT1 : TStDateTimeRec) : Longint;
begin
  Result := ((DT1.D - Date1970) * SecondsInDay) + DT1.T;
end;

function GlobalDateTimeToLocal(UTC: TStDateTimeRec; MinOffset: Integer): TStDateTimeRec;
{$IFNDEF VERSION4}
const
  TIME_ZONE_ID_INVALID  = DWORD($FFFFFFFF);
  TIME_ZONE_ID_UNKNOWN  = 0;
  TIME_ZONE_ID_STANDARD = 1;
  TIME_ZONE_ID_DAYLIGHT = 2;
{$ENDIF}
var
  Minutes : LongInt;
  {$IFDEF Win32}
  TZ : TTimeZoneInformation;
  {$ENDIF}
begin
  Minutes := (UTC.D * MinutesInDay) + (UTC.T div 60);
  {$IFDEF Win32}
  case GetTimeZoneInformation(TZ) of
    TIME_ZONE_ID_UNKNOWN :
      Minutes := Minutes - TZ.Bias;
    TIME_ZONE_ID_INVALID :
      Minutes := Minutes - MinOffset;
    TIME_ZONE_ID_STANDARD:
      Minutes := Minutes - (TZ.Bias + TZ.StandardBias);
    TIME_ZONE_ID_DAYLIGHT:
      Minutes := Minutes - (TZ.Bias + TZ.DaylightBias);
  end;
  {$ELSE}
  Minutes := Minutes - MinOffset;
  {$ENDIF}

  Result.D := (Minutes div MinutesInDay);
  Result.T := ((Minutes mod MinutesInDay) * SecondsInMinute) + (UTC.T mod SecondsInMinute);
end;

function LocalDateTimeToGlobal(DT1: TStDateTimeRec; MinOffset: Integer): TStDateTimeRec;
{$IFNDEF VERSION4}
const
  TIME_ZONE_ID_INVALID  = DWORD($FFFFFFFF);
  TIME_ZONE_ID_UNKNOWN  = 0;
  TIME_ZONE_ID_STANDARD = 1;
  TIME_ZONE_ID_DAYLIGHT = 2;
{$ENDIF}
var
  Minutes : LongInt;
  {$IFDEF Win32}
  TZ : TTimeZoneInformation;
  {$ENDIF}
begin
  Minutes := (DT1.D * MinutesInDay) + (DT1.T div 60);
  {$IFDEF Win32}
  case GetTimeZoneInformation(TZ) of
    TIME_ZONE_ID_UNKNOWN : { Time Zone transition dates not used }
      Minutes := Minutes + TZ.Bias;
    TIME_ZONE_ID_INVALID :
      Minutes := Minutes + MinOffset;
    TIME_ZONE_ID_STANDARD:
      Minutes := Minutes + (TZ.Bias + TZ.StandardBias);
    TIME_ZONE_ID_DAYLIGHT:
      Minutes := Minutes + (TZ.Bias + TZ.DaylightBias);
  end;
  {$ELSE}
  Minutes := Minutes + MinOffset;
  {$ENDIF}

  Result.D := (Minutes div MinutesInDay);
  Result.T := ((Minutes mod MinutesInDay) * SecondsInMinute) + (DT1.T mod SecondsInMinute);
end;



end.



