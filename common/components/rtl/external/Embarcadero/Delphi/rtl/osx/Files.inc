{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: Files.h                                }
{          Contains: File Manager Interface             }
{          Copyright (c) Apple, Inc.                    }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//TODO -ocbensen -cImplement : Translate OSUtils.h
type
  QElemPtr = Pointer;

//TODO -ocbensen -cImplement : Translate Finder.h
type
  FInfo = Pointer;
  FXInfo = Pointer;
  DInfo = Pointer;
  DXInfo = Pointer;

{ Finder constants were moved to Finder. }

{ HFSUniStr255 is the Unicode equivalent of Str255 }
type
  HFSUniStr255 = record
    length: UInt16;                        { number of unicode characters }
    unicode: packed array[0..254] of Char; { unicode characters }
  end;
  ConstHFSUniStr255Param = ^HFSUniStr255;
  PHFSUniStr255 = ^HFSUniStr255;

const
{
    File Permissions

    Do not mix and match the following two sets of constants
    see DTS Technote FL 37 "You Want Permission To Do What?!!"
    <http://developer.apple.com/technotes/fl/fl_37.html>
    for a detailed discussion of the two separate models
    and how they are related.
}

{  Permissions for File Manager routines which follow the original model }
  fsCurPerm    = $00;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         { open access permissions in ioPermssn }
  fsRdPerm     = $01;
  fsWrPerm     = $02;
  fsRdWrPerm   = $03;
  fsRdWrShPerm = $04;

{    Permissions for File Manager routines which follow the AFP model
    that is, routines with "OpenDeny" in the name.

    The most useful combinations of these are:
        fsRdAccessPerm -> one writer, multiple readers: the readers
        fsRdAccessPerm + fsWrAccessPerm + fsWrDenyPerm -> one writer, multiple readers: the writer
        fsWrDenyPerm + fsRdAccessPerm -> multiple readers, no writers
        fsRdAccessPerm + fsWrAccessPerm -> shared read/write access
        fsRdAccessPerm + fsWrAccessPerm + fsRdDenyPerm + fsWrDenyPerm -> exclusive access
}
  fsRdAccessPerm = $01;
  fsWrAccessPerm = $02;
  fsRdDenyPerm   = $10;
  fsWrDenyPerm   = $20;

  fsRtParID = 1;
  fsRtDirID = 2;

  fsAtMark    = 0; { positioning modes in ioPosMode }
  fsFromStart = 1;
  fsFromLEOF  = 2;
  fsFromMark  = 3;

{ positionMode (ioPosMode) flags }
  kFSAllowConcurrentAsyncIOBit  = 3;     { allow concurrent execution of async calls }
  kFSAllowConcurrentAsyncIOMask = $0008;
  kFSPleaseCacheBit             = 4;     { please cache this request }
  kFSPleaseCacheMask            = $0010;
  kFSNoCacheBit                 = 5;     { please don't cache this request }
  kFSNoCacheMask                = $0020;
  kFSRdVerifyBit                = 6;     { read verify mode }
  kFSRdVerifyMask               = $0040;
  kFSForceReadBit               = 6;
  kFSForceReadMask              = $0040;
  kFSNewLineBit                 = 7;     { newline mode }
  kFSNewLineMask                = $0080;
  kFSNewLineCharMask            = $FF00; { newline character }

{ CatSearch Search bitmask Constants }
  fsSBPartialName         = $01;
  fsSBFullName            = $02;
  fsSBFlAttrib            = $04;
  fsSBFlFndrInfo          = $08;
  fsSBFlLgLen             = $20;
  fsSBFlPyLen             = $40;
  fsSBFlRLgLen            = $80;
  fsSBFlRPyLen            = $0100;
  fsSBFlCrDat             = $0200;
  fsSBFlMdDat             = $0400;
  fsSBFlBkDat             = $0800;
  fsSBFlXFndrInfo         = $1000;
  fsSBFlParID             = $2000;
  fsSBNegate              = $4000;
  fsSBDrUsrWds            = $08;
  fsSBDrNmFls             = $10;
  fsSBDrCrDat             = $0200;
  fsSBDrMdDat             = $0400;
  fsSBDrBkDat             = $0800;
  fsSBDrFndrInfo          = $1000;
  fsSBDrParID             = $2000;
  fsSBNodeID              = $8000;
  fsSBAttributeModDate    = $00010000;
  fsSBAccessDate          = $00020000;
  fsSBPermissions         = $00040000;
  fsSBSkipPackageContents = $00080000;
  fsSBSkipHiddenItems     = $00100000;
  fsSBUserID              = $00200000;
  fsSBGroupID             = $00400000;

{ CatSearch Search bit value Constants }
  fsSBPartialNameBit         = 0;   {ioFileName points to a substring}
  fsSBFullNameBit            = 1;   {ioFileName points to a match string}
  fsSBFlAttribBit            = 2;   {search includes file attributes}
  fsSBFlFndrInfoBit          = 3;   {search includes finder info}
  fsSBFlLgLenBit             = 5;   {search includes data logical length}
  fsSBFlPyLenBit             = 6;   {search includes data physical length}
  fsSBFlRLgLenBit            = 7;   {search includes resource logical length}
  fsSBFlRPyLenBit            = 8;   {search includes resource physical length}
  fsSBFlCrDatBit             = 9;   {search includes create date}
  fsSBFlMdDatBit             = 10;  {search includes modification date}
  fsSBFlBkDatBit             = 11;  {search includes backup date}
  fsSBFlXFndrInfoBit         = 12;  {search includes extended finder info}
  fsSBFlParIDBit             = 13;  {search includes file's parent ID}
  fsSBNegateBit              = 14;  {return all non-matches}
  fsSBDrUsrWdsBit            = 3;   {search includes directory finder info}
  fsSBDrNmFlsBit             = 4;   {search includes directory valence}
  fsSBDrCrDatBit             = 9;   {directory-named version of fsSBFlCrDatBit}
  fsSBDrMdDatBit             = 10;  {directory-named version of fsSBFlMdDatBit}
  fsSBDrBkDatBit             = 11;  {directory-named version of fsSBFlBkDatBit}
  fsSBDrFndrInfoBit          = 12;  {directory-named version of fsSBFlXFndrInfoBit}
  fsSBDrParIDBit             = 13;  {directory-named version of fsSBFlParIDBit}
  fsSBNodeIDBit              = 15;  { search by range of nodeID }
  fsSBAttributeModDateBit    = 16;  { search by range of attributeModDate }
  fsSBAccessDateBit          = 17;  { search by range of accessDate [CatalogSearch only] }
  fsSBPermissionsBit         = 18;  { search by value/mask of permissions [CatalogSearch only] }
  fsSBSkipPackageContentsBit = 19;  {do not return items inside of packages}
  fsSBSkipHiddenItemsBit     = 20;  {do not return items with an invisible element in their path}
  fsSBUserIDBit              = 21;  { search by userID in permissions field [CatalogSearch only] }
  fsSBGroupIDBit             = 22;  { search by groupID in permissions field [CatalogSearch only] }

{ vMAttrib (GetVolParms) bit position constants }
  bLimitFCBs                   = 31;
  bLocalWList                  = 30;
  bNoMiniFndr                  = 29;
  bNoVNEdit                    = 28;
  bNoLclSync                   = 27;
  bTrshOffLine                 = 26;
  bNoSwitchTo                  = 25;
  bNoDeskItems                 = 20;
  bNoBootBlks                  = 19;
  bAccessCntl                  = 18;
  bNoSysDir                    = 17;
  bHasExtFSVol                 = 16;
  bHasOpenDeny                 = 15;
  bHasCopyFile                 = 14;
  bHasMoveRename               = 13;
  bHasDesktopMgr               = 12;
  bHasShortName                = 11;
  bHasFolderLock               = 10;
  bHasPersonalAccessPrivileges = 9;
  bHasUserGroupList            = 8;
  bHasCatSearch                = 7;
  bHasFileIDs                  = 6;
  bHasBTreeMgr                 = 5;
  bHasBlankAccessPrivileges    = 4;
  bSupportsAsyncRequests       = 3; { asynchronous requests to this volume are handled correctly at any time }
  bSupportsTrashVolumeCache    = 2;

{ vMAttrib (GetVolParms) bit position constants }
  bHasDirectIO = 1;

{ vMExtendedAttributes (GetVolParms) bit position constants }
  bIsEjectable                  = 0;  { volume is in an ejectable disk drive }
  bSupportsHFSPlusAPIs          = 1;  { volume supports HFS Plus APIs directly (not through compatibility layer) }
  bSupportsFSCatalogSearch      = 2;  { volume supports FSCatalogSearch }
  bSupportsFSExchangeObjects    = 3;  { volume supports FSExchangeObjects }
  bSupports2TBFiles             = 4;  { volume supports supports 2 terabyte files }
  bSupportsLongNames            = 5;  { volume supports file/directory/volume names longer than 31 characters }
  bSupportsMultiScriptNames     = 6;  { volume supports file/directory/volume names with characters from multiple script systems }
  bSupportsNamedForks           = 7;  { volume supports forks beyond the data and resource forks }
  bSupportsSubtreeIterators     = 8;  { volume supports recursive iterators not at the volume root }
  bL2PCanMapFileBlocks          = 9;  { volume supports Lg2Phys SPI correctly }
  bParentModDateChanges         = 10; { Changing a file or folder causes its parent's mod date to change }
  bAncestorModDateChanges       = 11; { Changing a file or folder causes all ancestor mod dates to change }
  bSupportsSymbolicLinks        = 13; { volume supports the creation and use of symbolic links (Mac OS X only) }
  bIsAutoMounted                = 14; { volume was mounted automatically (Mac OS X only) }
  bAllowCDiDataHandler          = 17; { allow QuickTime's CDi data handler to examine this volume }
  bSupportsExclusiveLocks       = 18; { volume supports exclusive opens for writing }
  bSupportsJournaling           = 19; { volume supports journal (journal may not be active) }
  bNoVolumeSizes                = 20; { volume is unable to report volume size or free space }
  bIsOnInternalBus              = 21; { device is on an internal bus - see note below }
  bIsCaseSensitive              = 22; { volume is case sensitive }
  bIsCasePreserving             = 23; { volume is case preserving }
  bDoNotDisplay                 = 24; { volume should not be displayed in UI }
  bIsRemovable                  = 25; { device is removable according to IOKit }
  bNoRootTimes                  = 26; { volume does not set reliable times for its root directory }
  bIsOnExternalBus              = 27; { device is on an external bus -- see note below }
  bSupportsExtendedFileSecurity = 28; { volume supports FSFileSecurity objects }

{    Note: A volume can return one of four states via the bIsInternal and bIsExternal bits.  A volume known
        to be on an internal bus will set bIsInternal and clear bIsExternal.  A volume known to
        be on an external bus will clear bIsInternal and set bIsExternal.  A volume on a bus that
        is indeterminate (could be either) will set both bits.  A volume not on a local bus will, such
        as a network volume, will leave both bits clear. }

{ Large Volume Constants }

function kUseWidePositioning: Integer;

const
  kWidePosOffsetBit = 8;
  kMaximumBlocksIn4GB = $007FFFFF;

{ Foreign Privilege Model Identifiers }
  fsUnixPriv = 1;

{ Authentication Constants }
  kNoUserAuthentication  = 1;
  kPassword              = 2;
  kEncryptPassword       = 3;
  kTwoWayEncryptPassword = 6;


{ values of user IDs and group IDs }
  knoUser            = 0;
  kadministratorUser = 1;

  knoGroup = 0;

type
  FSVolumeRefNum = SInt16;
{$IFDEF __LP64__}
  FSIORefNum = Integer;
{$ELSE}
  FSIORefNum = SInt16;
{$ENDIF}

const
  kFSInvalidVolumeRefNum = 0;
  {$EXTERNALSYM kFSInvalidVolumeRefNum}

{ private to File Manager; ¥¥ need symbolic constant }
type
  FSRef = record
    hidden: packed array[0..79] of UInt8;
  end;
  {$EXTERNALSYM FSRef}

  FSRefPtr = ^FSRef;
  {$EXTERNALSYM FSRefPtr}
  PFSRef = ^FSRef;
  {$EXTERNALSYM PFSRef}
  FSFileSecurityRef = Pointer; //TODO -ocbensen -cImplement : Mac OSX: FSFileSecurityRef = ^__FSFileSecurity;
  {$EXTERNALSYM FSFileSecurityRef}

{ Catalog position record }
  CatPositionRec = record
    initialize: SInt32;
    priv: packed array[0..5] of SInt16;
  end;
  {$EXTERNALSYM CatPositionRec}

{$IFDEF __LP64__}
  FSSpec = record
    hidden: array[0..79] of SInt8; { FSSpecs are invalid for 64 bit, but defined in case they appear in shared structs }
  end;
{$ELSE}
  FSSpec = record
    vRefNum: FSVolumeRefNum;
    parID: SInt32;
    name: StrFileName; { a Str63 on MacOS }
  end;
{$ENDIF}

  FSSpecPtr = ^FSSpec;
  FSSpecHandle = ^FSSpecPtr;

{ pointer to array of FSSpecs }
  FSSpecArrayPtr = FSSpecPtr;

{
    The only difference between "const FSSpec*" and "ConstFSSpecPtr" is
    that as a parameter, ConstFSSpecPtr is allowed to be NULL
 }
  ConstFSSpecPtr = ^FSSpec;
{$IFDEF __LP64__}
  ParmBlkPtr = ^VOID;
{$ELSE}
  ParmBlkPtr = ^ParamBlockRec;
{$ENDIF}

  IOCompletionProcPtr = procedure(paramBlock: ParmBlkPtr);
  IOCompletionUPP = IOCompletionProcPtr;

//TODO -ocbensen -cReview : Figure out where the end of this conditional should go
//{$IFNDEF __LP64__}
  IOParam = record
    qLink:            QElemPtr;               { queue link in header }
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioRefNum:         FSIORefNum;             {refNum for I/O operation}
    ioVersNum:        SInt8;                  {version number}
    ioPermssn:        SInt8;                  {Open: permissions (byte)}
    ioMisc:           Ptr;                    {Rename: new name (GetEOF,SetEOF: logical end of file) (Open: optional ptr to buffer) (SetFileType: new type)}
    ioBuffer:         Ptr;                    {data buffer Ptr}
    ioReqCount:       SInt32;                 {requested byte count: also = ioNewDirID}
    ioActCount:       SInt32;                 {actual byte count completed}
    ioPosMode:        SInt16;                 {initial file positioning}
    ioPosOffset:      SInt32;                 {file position offset}
  end;

  IOParamPtr = ^IOParam;

  FileParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioFRefNum:        FSIORefNum;             {reference number}
    ioFVersNum:       SInt8;                  {version number}
    filler1:          SInt8;
    ioFDirIndex:      SInt16;                 {GetFInfo directory index}
    ioFlAttrib:       SInt8;                  {GetFInfo: in-use bit=7, lock bit=0}
    ioFlVersNum:      SInt8;                  {file version number}
    ioFlFndrInfo:     FInfo;                  {user info}
    ioFlNum:          UInt32;                 {GetFInfo: file number; TF- ioDirID}
    ioFlStBlk:        UInt16;                 {start file block (0 if none)}
    ioFlLgLen:        SInt32;                 {logical length (EOF)}
    ioFlPyLen:        SInt32;                 {physical length}
    ioFlRStBlk:       UInt16;                 {start block rsrc fork}
    ioFlRLgLen:       SInt32;                 {file logical length rsrc fork}
    ioFlRPyLen:       SInt32;                 {file physical length rsrc fork}
    ioFlCrDat:        UInt32;                 {file creation date& time (32 bits in secs)}
    ioFlMdDat:        UInt32;                 {last modified date and time}
  end;

  FileParamPtr = ^FileParam;

  VolumeParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    filler2:          UInt32;
    ioVolIndex:       SInt16;                 {volume index number}
    ioVCrDate:        UInt32;                 {creation date and time}
    ioVLsBkUp:        UInt32;                 {last backup date and time}
    ioVAtrb:          UInt16;                 {volume attrib}
    ioVNmFls:         UInt16;                 {number of files in directory}
    ioVDirSt:         UInt16;                 {start block of file directory}
    ioVBlLn:          SInt16;                 {GetVolInfo: length of dir in blocks}
    ioVNmAlBlks:      UInt16;                 {for compatibilty ioVNmAlBlks * ioVAlBlkSiz <= 2 GB}
    ioVAlBlkSiz:      UInt32;                 {for compatibilty ioVAlBlkSiz is <= $0000FE00 (65,024)}
    ioVClpSiz:        UInt32;                 {GetVolInfo: bytes to allocate at a time}
    ioAlBlSt:         UInt16;                 {starting disk(512-byte) block in block map}
    ioVNxtFNum:       UInt32;                 {GetVolInfo: next free file number}
    ioVFrBlk:         UInt16;                 {GetVolInfo: # free alloc blks for this vol}
  end;

  VolumeParamPtr = ^VolumeParam;


  CntrlParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioCRefNum:        FSIORefNum;             {refNum for I/O operation}
    csCode:           SInt16;                 {word for control status code}
    csParam: packed array[0..10] of SInt16;   {operation-defined parameters}
  end;

  CntrlParamPtr = ^CntrlParam;

  SlotDevParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioSRefNum:        FSIORefNum;
    ioSVersNum:       SInt8;
    ioSPermssn:       SInt8;
    ioSMix:           Ptr;
    ioSFlags:         SInt16;
    ioSlot:           SInt8;
    ioID:             SInt8;
  end;

  SlotDevParamPtr = ^SlotDevParam;

  MultiDevParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioMRefNum:        FSIORefNum;
    ioMVersNum:       SInt8;
    ioMPermssn:       SInt8;
    ioMMix:           Ptr;
    ioMFlags:         SInt16;
    ioSEBlkPtr:       Ptr;
  end;

  MultiDevParamPtr = ^MultiDevParam;


  ParamBlockRec = record
    case Integer of
      0: (ioParam:          IOParam;);
      1: (fileParam:        FileParam;);
      2: (volumeParam:      VolumeParam;);
      3: (cntrlParam:       CntrlParam;);
      4: (slotDevParam:     SlotDevParam;);
      5: (multiDevParam:    MultiDevParam;);
  end;

  HFileInfo = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioFRefNum:        FSIORefNum;
    ioFVersNum:       SInt8;
    filler1:          SInt8;
    ioFDirIndex:      SInt16;
    ioFlAttrib:       SInt8;
    ioACUser:         SInt8;
    ioFlFndrInfo:     FInfo;
    ioDirID:          SInt32;
    ioFlStBlk:        UInt16;
    ioFlLgLen:        SInt32;
    ioFlPyLen:        SInt32;
    ioFlRStBlk:       UInt16;
    ioFlRLgLen:       SInt32;
    ioFlRPyLen:       SInt32;
    ioFlCrDat:        UInt32;
    ioFlMdDat:        UInt32;
    ioFlBkDat:        UInt32;
    ioFlXFndrInfo:    FXInfo;
    ioFlParID:        SInt32;
    ioFlClpSiz:       SInt32;
  end;

  DirInfo = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioFRefNum:        FSIORefNum;
    ioFVersNum:       SInt8;
    filler1:          SInt8;
    ioFDirIndex:      SInt16;
    ioFlAttrib:       SInt8;
    ioACUser:         SInt8;
    ioDrUsrWds:       DInfo;
    ioDrDirID:        SInt32;
    ioDrNmFls:        UInt16;
    filler3:          packed array[0..8] of SInt16;
    ioDrCrDat:        UInt32;
    ioDrMdDat:        UInt32;
    ioDrBkDat:        UInt32;
    ioDrFndrInfo:     DXInfo;
    ioDrParID:        SInt32;
  end;

  CInfoPBRec = record
    case Integer of
      0: (hFileInfo:        HFileInfo;);
      1: (dirInfo:          DirInfo;);
  end;

  CInfoPBPtr = ^CInfoPBRec;

  XCInfoPBRec = record
    qLink:            QElemPtr;
    qType:            SInt16;
    ioTrap:           SInt16;
    ioCmdAddr:        Ptr;
    ioCompletion:     ProcPtr;                { --> A pointer to a completion routine }
    ioResult:         {volatile} OSErr;       { --> The result code of the function }
    ioNamePtr:        StringPtr;              { --> Pointer to pathname to object }
    ioVRefNum:        FSVolumeRefNum;         { --> A volume specification }
    filler1:          SInt32;
    ioShortNamePtr:   StringPtr;              { <-> A pointer to the short name string buffer - required! }
    filler2:          SInt16;
    ioPDType:         SInt16;                 { <-- The ProDOS file type }
    ioPDAuxType:      SInt32;                 { <-- The ProDOS aux type }
    filler3:          packed array[0..1] of SInt32;
    ioDirID:          SInt32;                 { --> A directory ID }
  end;

  XCInfoPBPtr = ^XCInfoPBRec;

  DTPBRec = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioDTRefNum:       FSIORefNum;             { desktop refnum }
    ioIndex:          SInt16;
    ioTagInfo:        SInt32;
    ioDTBuffer:       Ptr;
    ioDTReqCount:     SInt32;
    ioDTActCount:     SInt32;
    ioFiller1:        SInt8;
    ioIconType:       UInt8;
    ioFiller2:        SInt16;
    ioDirID:          SInt32;
    ioFileCreator:    OSType;
    ioFileType:       OSType;
    ioFiller3:        SInt32;
    ioDTLgLen:        SInt32;
    ioDTPyLen:        SInt32;
    ioFiller4:        packed array[0..13] of SInt16;
    ioAPPLParID:      SInt32;
  end;

  DTPBPtr = ^DTPBRec;

  HIOParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioRefNum:         FSIORefNum;
    ioVersNum:        SInt8;
    ioPermssn:        SInt8;
    ioMisc:           Ptr;
    ioBuffer:         Ptr;
    ioReqCount:       SInt32;
    ioActCount:       SInt32;
    ioPosMode:        SInt16;
    ioPosOffset:      SInt32;
  end;

  HIOParamPtr = ^HIOParam;

  HFileParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioFRefNum:        FSIORefNum;
    ioFVersNum:       SInt8;
    filler1:          SInt8;
    ioFDirIndex:      SInt16;
    ioFlAttrib:       SInt8;
    ioFlVersNum:      SInt8;
    ioFlFndrInfo:     FInfo;
    ioDirID:          SInt32;
    ioFlStBlk:        UInt16;
    ioFlLgLen:        SInt32;
    ioFlPyLen:        SInt32;
    ioFlRStBlk:       UInt16;
    ioFlRLgLen:       SInt32;
    ioFlRPyLen:       SInt32;
    ioFlCrDat:        UInt32;
    ioFlMdDat:        UInt32;
  end;

  HFileParamPtr = ^HFileParam;

  HVolumeParam = record
    qLink:           QElemPtr;                {queue link in header}
    qType:           SInt16;                  {type byte for safety check}
    ioTrap:          SInt16;                  {FS: the Trap}
    ioCmdAddr:       Ptr;                     {FS: address to dispatch to}
    ioCompletion:    IOCompletionUPP;         {completion routine addr (0 for synch calls)}
    ioResult:        {volatile} OSErr;        {result code}
    ioNamePtr:       StringPtr;               {ptr to Vol:FileName string}
    ioVRefNum:       FSVolumeRefNum;          {volume refnum (DrvNum for Eject and MountVol)}
    filler2:         SInt32;
    ioVolIndex:      SInt16;
    ioVCrDate:       UInt32;
    ioVLsMod:        UInt32;
    ioVAtrb:         SInt16;
    ioVNmFls:        UInt16;
    ioVBitMap:       UInt16;
    ioAllocPtr:      UInt16;
    ioVNmAlBlks:     UInt16;
    ioVAlBlkSiz:     UInt32;
    ioVClpSiz:       UInt32;
    ioAlBlSt:        UInt16;
    ioVNxtCNID:      UInt32;
    ioVFrBlk:        UInt16;
    ioVSigWord:      UInt16;
    ioVDrvInfo:      SInt16;
    ioVDRefNum:      FSIORefNum;
    ioVFSID:         SInt16;
    ioVBkUp:         UInt32;
    ioVSeqNum:       SInt16;
    ioVWrCnt:        UInt32;
    ioVFilCnt:       UInt32;
    ioVDirCnt:       UInt32;
    ioVFndrInfo:     packed array[0..7] of SInt32;
  end;

  HVolumeParamPtr = ^HVolumeParam;

{$ALIGN 2}
  XIOParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioRefNum:         FSIORefNum;
    ioVersNum:        SInt8;
    ioPermssn:        SInt8;
    ioMisc:           Ptr;
    ioBuffer:         Ptr;
    ioReqCount:       SInt32;
    ioActCount:       SInt32;
    ioPosMode:        SInt16;                 { must have kUseWidePositioning bit set }
    ioWPosOffset:     wide;                   { wide positioning offset }
  end;

  XIOParamPtr = ^XIOParam;

  XVolumeParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioXVersion:       UInt32;                 { this XVolumeParam version (0) }
    ioVolIndex:       SInt16;
    ioVCrDate:        UInt32;
    ioVLsMod:         UInt32;
    ioVAtrb:          SInt16;
    ioVNmFls:         UInt16;
    ioVBitMap:        UInt16;
    ioAllocPtr:       UInt16;
    ioVNmAlBlks:      UInt16;
    ioVAlBlkSiz:      UInt32;
    ioVClpSiz:        UInt32;
    ioAlBlSt:         UInt16;
    ioVNxtCNID:       UInt32;
    ioVFrBlk:         UInt16;
    ioVSigWord:       UInt16;
    ioVDrvInfo:       SInt16;
    ioVDRefNum:       SInt16;
    ioVFSID:          SInt16;
    ioVBkUp:          UInt32;
    ioVSeqNum:        SInt16;
    ioVWrCnt:         UInt32;
    ioVFilCnt:        UInt32;
    ioVDirCnt:        UInt32;
    ioVFndrInfo:      packed array[0..7] of SInt32;
    ioVTotalBytes:    UInt64;                 { total number of bytes on volume }
    ioVFreeBytes:     UInt64;                 { number of free bytes on volume }
  end;
{$ALIGN ON}

  XVolumeParamPtr = ^XVolumeParam;

  AccessParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioRefNum:         FSIORefNum;             { <- , ioRefNum ( use to be filler3 ) }
    ioDenyModes:      SInt16;                 {access rights data}
    filler4:          SInt16;
    filler5:          SInt8;
    ioACUser:         SInt8;                  {access rights for directory only}
    filler6:          SInt32;
    ioACOwnerID:      SInt32;                 {owner ID}
    ioACGroupID:      SInt32;                 {group ID}
    ioACAccess:       SInt32;                 {access rights}
    ioDirID:          SInt32;
  end;

  AccessParamPtr = ^AccessParam;

  ObjParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    filler7:          SInt16;
    ioObjType:        SInt16;                 {function code}
    ioObjNamePtr:     StringPtr;              {ptr to returned creator/group name}
    ioObjID:          SInt32;                 {creator/group ID}
  end;

  ObjParamPtr = ^ObjParam;

  CopyParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioDstVRefNum:     FSVolumeRefNum;         {destination vol identifier}
    filler8:          SInt16;
    ioNewName:        StringPtr;              {ptr to destination pathname}
    ioCopyName:       StringPtr;              {ptr to optional name}
    ioNewDirID:       SInt32;                 {destination directory ID}
    filler14:         SInt32;
    filler15:         SInt32;
    ioDirID:          SInt32;
  end;

  CopyParamPtr = ^CopyParam;

  WDParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    ioWDCreated:      SInt16;
    ioWDIndex:        SInt16;
    ioWDProcID:       SInt32;
    ioWDVRefNum:      FSVolumeRefNum;
    filler10:         SInt16;
    filler11:         SInt32;
    filler12:         SInt32;
    filler13:         SInt32;
    ioWDDirID:        SInt32;
  end;

  WDParamPtr = ^WDParam;

  FIDParam = record
    qLink:            QElemPtr;               {queue link in header}
    qType:            SInt16;                 {type byte for safety check}
    ioTrap:           SInt16;                 {FS: the Trap}
    ioCmdAddr:        Ptr;                    {FS: address to dispatch to}
    ioCompletion:     IOCompletionUPP;        {completion routine addr (0 for synch calls)}
    ioResult:         {volatile} OSErr;       {result code}
    ioNamePtr:        StringPtr;              {ptr to Vol:FileName string}
    ioVRefNum:        FSVolumeRefNum;         {volume refnum (DrvNum for Eject and MountVol)}
    filler14:         SInt32;
    ioDestNamePtr:    StringPtr;              { dest file name }
    filler15:         SInt32;
    ioDestDirID:      SInt32;                 { dest file's directory id }
    filler16:         SInt32;
    filler17:         SInt32;
    ioSrcDirID:       SInt32;                 { source file's directory id }
    filler18:         SInt16;
    ioFileID:         SInt32;                 { file ID }
  end;

  FIDParamPtr = ^FIDParam;

//TODO -ocbensen -cTranslate : translate the rest of this file
(*
struct ForeignPrivParam {
  QElemPtr            qLink:                  {queue link in header}
  SInt16              qType:                  {type byte for safety check}
  SInt16              ioTrap:                 {FS: the Trap}
  Ptr                 ioCmdAddr:              {FS: address to dispatch to}
  IOCompletionUPP     ioCompletion:           {completion routine addr (0 for synch calls)}
  volatile OSErr      ioResult:               {result code}
  StringPtr           ioNamePtr:              {ptr to Vol:FileName string}
  FSVolumeRefNum      ioVRefNum:              {volume refnum (DrvNum for Eject and MountVol)}
  SInt32              ioFiller21:
  SInt32              ioFiller22:
  Ptr                 ioForeignPrivBuffer:
  SInt32              ioForeignPrivActCount:
  SInt32              ioForeignPrivReqCount:
  SInt32              ioFiller23:
  SInt32              ioForeignPrivDirID:
  SInt32              ioForeignPrivInfo1:
  SInt32              ioForeignPrivInfo2:
  SInt32              ioForeignPrivInfo3:
  SInt32              ioForeignPrivInfo4:
}:
typedef struct ForeignPrivParam         ForeignPrivParam:
typedef ForeignPrivParam *              ForeignPrivParamPtr:
struct CSParam {
  QElemPtr            qLink:                  {queue link in header}
  SInt16              qType:                  {type byte for safety check}
  SInt16              ioTrap:                 {FS: the Trap}
  Ptr                 ioCmdAddr:              {FS: address to dispatch to}
  IOCompletionUPP     ioCompletion:           {completion routine addr (0 for synch calls)}
  volatile OSErr      ioResult:               {result code}
  StringPtr           ioNamePtr:              {ptr to Vol:FileName string}
  FSVolumeRefNum      ioVRefNum:              {volume refnum (DrvNum for Eject and MountVol)}
  FSSpecPtr           ioMatchPtr:             { match array }
  SInt32              ioReqMatchCount:        { maximum allowable matches }
  SInt32              ioActMatchCount:        { actual match count }
  SInt32              ioSearchBits:           { search criteria selector }
  CInfoPBPtr          ioSearchInfo1:          { search values and range lower bounds }
  CInfoPBPtr          ioSearchInfo2:          { search values and range upper bounds }
  SInt32              ioSearchTime:           { length of time to run search }
  CatPositionRec      ioCatPosition:          { current position in the catalog }
  Ptr                 ioOptBuffer:            { optional performance enhancement buffer }
  SInt32              ioOptBufSize:           { size of buffer pointed to by ioOptBuffer }
}:
typedef struct CSParam                  CSParam:
typedef CSParam *                       CSParamPtr:
union HParamBlockRec {
  HIOParam            ioParam:
  HFileParam          fileParam:
  HVolumeParam        volumeParam:
  AccessParam         accessParam:
  ObjParam            objParam:
  CopyParam           copyParam:
  WDParam             wdParam:
  FIDParam            fidParam:
  CSParam             csParam:
  ForeignPrivParam    foreignPrivParam:
}:
typedef union HParamBlockRec            HParamBlockRec:


typedef HParamBlockRec *                HParmBlkPtr:

struct CMovePBRec {
  QElemPtr            qLink:                  {queue link in header}
  SInt16              qType:                  {type byte for safety check}
  SInt16              ioTrap:                 {FS: the Trap}
  Ptr                 ioCmdAddr:              {FS: address to dispatch to}
  IOCompletionUPP     ioCompletion:           {completion routine addr (0 for synch calls)}
  volatile OSErr      ioResult:               {result code}
  StringPtr           ioNamePtr:              {ptr to Vol:FileName string}
  FSVolumeRefNum      ioVRefNum:              {volume refnum (DrvNum for Eject and MountVol)}
  SInt32              filler1:
  StringPtr           ioNewName:
  SInt32              filler2:
  SInt32              ioNewDirID:
  SInt32              filler3[2]:
  SInt32              ioDirID:
}:
typedef struct CMovePBRec               CMovePBRec:
typedef CMovePBRec *                    CMovePBPtr:
struct WDPBRec {
  QElemPtr            qLink:                  {queue link in header}
  SInt16              qType:                  {type byte for safety check}
  SInt16              ioTrap:                 {FS: the Trap}
  Ptr                 ioCmdAddr:              {FS: address to dispatch to}
  IOCompletionUPP     ioCompletion:           {completion routine addr (0 for synch calls)}
  volatile OSErr      ioResult:               {result code}
  StringPtr           ioNamePtr:              {ptr to Vol:FileName string}
  FSVolumeRefNum      ioVRefNum:              {volume refnum (DrvNum for Eject and MountVol)}
  SInt16              filler1:
  SInt16              ioWDIndex:
  SInt32              ioWDProcID:
  FSVolumeRefNum      ioWDVRefNum:
  SInt16              filler2[7]:
  SInt32              ioWDDirID:
}:
typedef struct WDPBRec                  WDPBRec:
typedef WDPBRec *                       WDPBPtr:
struct FCBPBRec {
  QElemPtr            qLink:                  {queue link in header}
  SInt16              qType:                  {type byte for safety check}
  SInt16              ioTrap:                 {FS: the Trap}
  Ptr                 ioCmdAddr:              {FS: address to dispatch to}
  IOCompletionUPP     ioCompletion:           {completion routine addr (0 for synch calls)}
  volatile OSErr      ioResult:               {result code}
  StringPtr           ioNamePtr:              {ptr to Vol:FileName string}
  FSVolumeRefNum      ioVRefNum:              {volume refnum (DrvNum for Eject and MountVol)}
  FSIORefNum          ioRefNum:
  SInt16              filler:
  SInt16              ioFCBIndx:
  SInt16              filler1:
  SInt32              ioFCBFlNm:
  SInt16              ioFCBFlags:
  UInt16              ioFCBStBlk:
  SInt32              ioFCBEOF:
  SInt32              ioFCBPLen:
  SInt32              ioFCBCrPs:
  FSVolumeRefNum      ioFCBVRefNum:
  SInt32              ioFCBClpSiz:
  SInt32              ioFCBParID:
}:
typedef struct FCBPBRec                 FCBPBRec:
typedef FCBPBRec *                      FCBPBPtr:
struct VCB {
  QElemPtr            qLink:
  SInt16              qType:
  SInt16              vcbFlags:
  UInt16              vcbSigWord:
  UInt32              vcbCrDate:
  UInt32              vcbLsMod:
  SInt16              vcbAtrb:
  UInt16              vcbNmFls:
  SInt16              vcbVBMSt:
  SInt16              vcbAllocPtr:
  UInt16              vcbNmAlBlks:
  SInt32              vcbAlBlkSiz:
  SInt32              vcbClpSiz:
  SInt16              vcbAlBlSt:
  SInt32              vcbNxtCNID:
  UInt16              vcbFreeBks:
  Str27               vcbVN:
  SInt16              vcbDrvNum:
  FSIORefNum          vcbDRefNum:
  SInt16              vcbFSID:
  FSVolumeRefNum      vcbVRefNum:
  Ptr                 vcbMAdr:
  Ptr                 vcbBufAdr:
  SInt16              vcbMLen:
  SInt16              vcbDirIndex:
  SInt16              vcbDirBlk:
  UInt32              vcbVolBkUp:
  UInt16              vcbVSeqNum:
  SInt32              vcbWrCnt:
  SInt32              vcbXTClpSiz:
  SInt32              vcbCTClpSiz:
  UInt16              vcbNmRtDirs:
  SInt32              vcbFilCnt:
  SInt32              vcbDirCnt:
  SInt32              vcbFndrInfo[8]:
  UInt16              vcbVCSize:
  UInt16              vcbVBMCSiz:
  UInt16              vcbCtlCSiz:
  UInt16              vcbXTAlBlks:
  UInt16              vcbCTAlBlks:
  SInt16              vcbXTRef:
  SInt16              vcbCTRef:
  Ptr                 vcbCtlBuf:
  SInt32              vcbDirIDM:
  SInt16              vcbOffsM:
}:
typedef struct VCB                      VCB:
typedef VCB *                           VCBPtr{
struct DrvQEl {
  QElemPtr            qLink:
  SInt16              qType:
  SInt16              dQDrive:
  SInt16              dQRefNum:
  SInt16              dQFSID:
  UInt16              dQDrvSz:
  UInt16              dQDrvSz2:
}:
typedef struct DrvQEl                   DrvQEl{
typedef DrvQEl *                        DrvQElPtr:
{$ENDIF __LP64__}
*)

(*
 *  FSPermissionInfo
 *
 *  Discussion:
 *    This structure is used when kFSCatInfoPermissions is passed to
 *    the HFSPlus API. On return from GetCatalogInfo and
 *    GetCatalogInfoBulk, the userID, groupID, and mode fields are
 *    returned.  When passed to SetCatalogInfo, only the mode field is
 *    set.  See chmod(2) for details about the mode field. This is
 *    supported on Mac OS X only. NOTE: An FSFileSecurityRef retrieved
 *    via FSGetCatalogInfo is a copy and must be released using
 *    CFRelease() when no longer needed.
 *)
type
  FSPermissionInfo = record
    userID: UInt32;
    groupID: UInt32;
    reserved1: UInt8;
    userAccess: UInt8;
    mode: UInt16;
    fileSec: FSFileSecurityRef;
  end;

  FSCatalogInfoBitmap = UInt32;

const
  kFSCatInfoNone                = $00000000;
  kFSCatInfoTextEncoding        = $00000001;
  kFSCatInfoNodeFlags           = $00000002; { Locked (bit 0) and directory (bit 4) only }
  kFSCatInfoVolume              = $00000004;
  kFSCatInfoParentDirID         = $00000008;
  kFSCatInfoNodeID              = $00000010;
  kFSCatInfoCreateDate          = $00000020;
  kFSCatInfoContentMod          = $00000040;
  kFSCatInfoAttrMod             = $00000080;
  kFSCatInfoAccessDate          = $00000100;
  kFSCatInfoBackupDate          = $00000200;
  kFSCatInfoPermissions         = $00000400;
  kFSCatInfoFinderInfo          = $00000800;
  kFSCatInfoFinderXInfo         = $00001000;
  kFSCatInfoValence             = $00002000; { Folders only; zero for files }
  kFSCatInfoDataSizes           = $00004000; { Data fork logical and physical size }
  kFSCatInfoRsrcSizes           = $00008000; { Resource fork logical and physical size }
  kFSCatInfoSharingFlags        = $00010000; { sharingFlags: kioFlAttribMountedBit; kioFlAttribSharePointBit }
  kFSCatInfoUserPrivs           = $00020000; { userPrivileges }
  kFSCatInfoUserAccess          = $00080000; { (OS X only) }
  kFSCatInfoSetOwnership        = $00100000; { (OS X only) }
  kFSCatInfoFSFileSecurityRef   = $00400000; { FSFileSecurity Object; will show up in the permissions field independent of kFSCatInfoPermissions.  This is also not part of settable; gettable since it requires being released }
  kFSCatInfoAllDates            = $000003E0;
  kFSCatInfoGettableInfo        = $0003FFFF;
  kFSCatInfoSettableInfo        = $00001FE3; { flags; dates; permissions; Finder info; text encoding }
  kFSCatInfoReserved            = $FFFC0000; { bits that are currently reserved }


//type
//  IOCompletionProcPtr = function(paramBlock: ParmBlkPtr): CALLBACK_API; cdecl;
//type
//  IOCompletionProcPtr = function(p1: Integer): STACK_UPP_TYPE; cdecl;
{!!! /* }

{  Constants for nodeFlags field of FSCatalogInfo }
const
  kFSNodeLockedBit       = 0;
  kFSNodeLockedMask      = $0001;
  kFSNodeResOpenBit      = 2;
  kFSNodeResOpenMask     = $0004;
  kFSNodeDataOpenBit     = 3;
  kFSNodeDataOpenMask    = $0008;
  kFSNodeIsDirectoryBit  = 4;
  kFSNodeIsDirectoryMask = $0010;
  kFSNodeCopyProtectBit  = 6;
  kFSNodeCopyProtectMask = $0040;
  kFSNodeForkOpenBit     = 7;
  kFSNodeForkOpenMask    = $0080;
  kFSNodeHardLinkBit     = 8;
  kFSNodeHardLinkMask    = $00000100;

{  Constants for sharingFlags field of FSCatalogInfo }
const
  kFSNodeInSharedBit      = 2;
  kFSNodeInSharedMask     = $0004;
  kFSNodeIsMountedBit     = 3;
  kFSNodeIsMountedMask    = $0008;
  kFSNodeIsSharePointBit  = 5;
  kFSNodeIsSharePointMask = $0020;



{
 *  FSCatalogInfo
 *
 *  Discussion:
 *    For each of the items in this structure, if the given bit is set
 *    in the whichInfo paramater to the FSGetCatalogInfo call then the
 *    field will be filled in on return.  Some fields which are not
 *    asked for my be returned as well, but do not depend on this
 *    behaviour.
 }
type
// Begin from UTCUtils.h
  UTCDateTime = record
    highSeconds: UInt16;
    lowSeconds: UInt32;
    fraction: UInt16;
  end;
  UTCDateTimePtr = ^UTCDateTime;
  UTCDateTimeHandle = ^UTCDateTimePtr;
// End from UTCUtils.h

{$ALIGN 2}
  FSCatalogInfo = record
{
   * kFSCatInfoNodeFlags / flag bits set if the file is locked, open,
   * is a directory, etc.
   }
    nodeFlags: UInt16;

{
   * kFSCatInfoVolume / the volume reference of the returned item
   }
    volume: FSVolumeRefNum;

{
   * kFSCatInfoParentDirID / the directory id of the parent of the
   * returned item
   }
    parentDirID: UInt32;

{
   * kFSCatInfoNodeID / the file id of the returned item
   }
    nodeID: UInt32;

{
   * kFSCatInfoSharingFlags / kioFlAttribMountedBit,
   * kioFlAttribSharePointBit
   }
    sharingFlags: UInt8;
    userPrivileges: UInt8;
    reserved1: UInt8;

{
   * Unused
   }
    reserved2: UInt8;

{
   * kFSCatInfoCreateDate / date and time of creation
   }
    createDate: UTCDateTime;

{
   * kFSCatInfoContentMod / date and time of last modification of the
   * content of the returned item
   }
    contentModDate: UTCDateTime;

{
   * kFSCatInfoAttrMod / date and time of the last modification of the
   * attributes of the returned item
   }
    attributeModDate: UTCDateTime;

{
   * kFSCatInfoAccessDate / date and time of the last access to the
   * returned item
   }
    accessDate: UTCDateTime;

{
   * kFSCatInfoBackupDate / date and time of the last backup for the
   * returned item
   }
    backupDate: UTCDateTime;

{
   * kFSCatInfoPermissions / Mac OS X only, file system permissions of
   * the returned item.  Coerce to a FSPermissionInfo to use.
   }
    permissions: FSPermissionInfo;

{
   * kFSCatInfoFinderInfo / file type, creator, flags, location.
   * Coerce to a File/FolderInfo to use.
   }
    finderInfo: packed array[0..15] of UInt8;

{
   * kFSCatInfoFinderXInfo / icon, script, et al.  Coerce to a
   * ExtendedFile/FolderInfo to use.
   }
    extFinderInfo: packed array[0..15] of UInt8;


{
   * kFSCatInfoDataSizes / the logical size of the data fork of the
   * returned item if a file
   }
    dataLogicalSize: UInt64;

{
   * kFSCatInfoDataSizes / the physical size of the data fork of the
   * returned item if a file
   }
    dataPhysicalSize: UInt64;

{
   * kFSCatInfoRsrcSizes / the logical size of the resource fork of the
   * returned item if a file
   }
    rsrcLogicalSize: UInt64;

{
   * kFSCatInfoRsrcSizes / the physical size of the resource fork of
   * the returned item if a file
   }
    rsrcPhysicalSize: UInt64;


{
   * kFSCatInfoValence / folders only, zero for files.
   }
    valence: UInt32;

{
   * kFSCatInfoTextEncoding / the text encoding hint for the returned
   * item
   }
    textEncodingHint: TextEncoding;
  end;
{$ALIGN ON}

  PFSCatalogInfo = ^FSCatalogInfo;

  {
  !!! = record
    nodeFlags: UInt16;
    volume: FSVolumeRefNum;
    parentDirID: UInt32;
    nodeID: UInt32;
    sharingFlags: UInt8;
    userPrivileges: UInt8;
    reserved1: UInt8;
    reserved2: UInt8;
    createDate: UTCDateTime;
    contentModDate: UTCDateTime;
    attributeModDate: UTCDateTime;
    accessDate: UTCDateTime;
    backupDate: UTCDateTime;
    permissions: packed array[0..3] of UInt32;
    finderInfo: packed array[0..15] of UInt8;
    extFinderInfo: packed array[0..15] of UInt8;

    dataLogicalSize: UInt64;
    dataPhysicalSize: UInt64;
    rsrcLogicalSize: UInt64;
    rsrcPhysicalSize: UInt64;

    valence: UInt32;
    textEncodingHint: TextEncoding;
  end;                                          }


  FSCatalogInfoPtr = ^FSCatalogInfo;
{
  FSRefParam = record
    qLink: QElemPtr;
    qType: SInt16;
    ioTrap: SInt16;
    ioCmdAddr: Ptr;
    ioCompletion: IOCompletionUPP;
    !!! OSErr ioResult: !!!;
    ioNamePtr: ConstStringPtr;
    ioVRefNum: FSVolumeRefNum;

    reserved1: SInt16;
    reserved2: UInt8;
    reserved3: UInt8;

    ref: PFSRef;
    whichInfo: FSCatalogInfoBitmap;
    catInfo: PFSCatalogInfo;
    nameLength: UniCharCount;
    name: PUniChar;
    ioDirID: UInt32;
    spec: FSSpecPtr;
    parentRef: PFSRef;
    newRef: PFSRef;
    textEncodingHint: TextEncoding;
    outName: PHFSUniStr255;
  end;
  FSRefParamPtr = ^FSRefParam;
}
{ for use with PBCreateFileAndOpenFork }
{ FSRefForkIOParam = record
    qLink: QElemPtr;
    qType: SInt16;
    ioTrap: SInt16;
    ioCmdAddr: Ptr;
    ioCompletion: IOCompletionUPP;
    !!! OSErr ioResult: !!!;
    parentRef: PFSRef;
    nameLength: UniCharCount;
    name: PUniChar;
    whichInfo: FSCatalogInfoBitmap;
    catInfo: PFSCatalogInfo;
    forkNameLength: UniCharCount;
    forkName: PUniChar;
    permissions: SInt8;
    reserved1: UInt8;
    forkRefNum: FSIORefNum;
    newRef: PFSRef;
  end;
  FSRefForkIOParamPtr = ^FSRefForkIOParam;
const
  kFSIterateFlat     = 0;
  kFSIterateSubtree  = 1;
  kFSIterateDelete   = 2;
  kFSIterateReserved = $FFFFFFFC;

type
  FSIteratorFlags = OptionBits;
  FSSearchParams = record
    searchTime: Duration;
    searchBits: OptionBits;
    searchNameLength: UniCharCount;
    searchName: PUniChar;
    searchInfo1: PFSCatalogInfo;
    searchInfo2: PFSCatalogInfo;
  end;
  FSSearchParamsPtr = ^FSSearchParams;
  FSCatalogBulkParam = record
    qLink: QElemPtr;
    qType: SInt16;
    ioTrap: SInt16;
    ioCmdAddr: Ptr;
    ioCompletion: IOCompletionUPP;
    !!! OSErr ioResult: !!!;
    containerChanged: Boolean;
    reserved: UInt8;

    iteratorFlags: FSIteratorFlags;
    iterator: FSIterator;
    container: PFSRef;
    maximumItems: ItemCount;
    actualItems: ItemCount;
    whichInfo: FSCatalogInfoBitmap;
    catalogInfo: PFSCatalogInfo;
    refs: PFSRef;
    specs: FSSpecPtr;
    names: PHFSUniStr255;
    searchParams: PFSSearchParams;
  end;
  FSCatalogBulkParamPtr = ^FSCatalogBulkParam;
  FSAllocationFlags = UInt16;
const
  kFSAllocDefaultFlags     = $0000;
  kFSAllocAllOrNothingMask = $0001;
  kFSAllocContiguousMask   = $0002;
  kFSAllocNoRoundUpMask    = $0004;
  kFSAllocReservedMask     = $FFF8;

type
  FSForkIOParam = record
    qLink: QElemPtr;
    qType: SInt16;
    ioTrap: SInt16;
    ioCmdAddr: Ptr;
    ioCompletion: IOCompletionUPP;
    !!! OSErr ioResult: !!!;
    reserved1: Pointer;
    reserved2: SInt16;
    forkRefNum: FSIORefNum;
    reserved3: UInt8;
    permissions: SInt8;
    ref: PFSRef;


    buffer: Ptr;
    requestCount: UInt32;
    actualCount: UInt32;
    positionMode: UInt16;
    positionOffset: SInt64;

    allocationFlags: FSAllocationFlags;
    allocationAmount: UInt64;

    forkNameLength: UniCharCount;
    forkName: PUniChar;

    forkIterator: CatPositionRec;
    outForkName: PHFSUniStr255;
  end;
  FSForkIOParamPtr = ^FSForkIOParam;
  FSForkInfoFlags = UInt8;
  FSForkInfo = record
    flags: FSForkInfoFlags;
    permissions: SInt8;
    volume: FSVolumeRefNum;
    reserved2: UInt32;
    nodeID: UInt32;
    forkID: UInt32;
    currentPosition: UInt64;
    logicalEOF: UInt64;
    physicalEOF: UInt64;
    process: UInt64;
  end;
  FSForkInfoPtr = ^FSForkInfo;
  FSForkCBInfoParam = record
    qLink: QElemPtr;
    qType: SInt16;
    ioTrap: SInt16;
    ioCmdAddr: Ptr;
    ioCompletion: IOCompletionUPP;
    !!! OSErr ioResult: !!!;
    desiredRefNum: FSIORefNum;
    volumeRefNum: FSVolumeRefNum;
    iterator: FSIORefNum;
    actualRefNum: FSVolumeRefNum;

    ref: PFSRef;
    forkInfo: PFSForkInfo;
    forkName: PHFSUniStr255;
  end;
  FSForkCBInfoParamPtr = ^FSForkCBInfoParam; }
{ Parameter block for use with 64 bit range lock calls. }
{ FSRangeLockParam = record
    qLink: QElemPtr;
    qType: SInt16;
    ioTrap: SInt16;
    ioCmdAddr: Ptr;
    ioCompletion: IOCompletionUPP;
    !!! OSErr ioResult: !!!;
    forkRefNum: FSIORefNum;
    requestCount: UInt64;
    positionMode: UInt16;
    positionOffset: SInt64;
    rangeStart: UInt64;

  end;
  FSRangeLockParamPtr = ^FSRangeLockParam;
  FSVolumeInfoBitmap = UInt32;
const
  kFSVolInfoNone         = $0000;
  kFSVolInfoCreateDate   = $0001;
  kFSVolInfoModDate      = $0002;
  kFSVolInfoBackupDate   = $0004;
  kFSVolInfoCheckedDate  = $0008;
  kFSVolInfoFileCount    = $0010;
  kFSVolInfoDirCount     = $0020;
  kFSVolInfoSizes        = $0040;
  kFSVolInfoBlocks       = $0080;
  kFSVolInfoNextAlloc    = $0100;
  kFSVolInfoRsrcClump    = $0200;
  kFSVolInfoDataClump    = $0400;
  kFSVolInfoNextID       = $0800;
  kFSVolInfoFinderInfo   = $1000;
  kFSVolInfoFlags        = $2000;
  kFSVolInfoFSInfo       = $4000;
  kFSVolInfoDriveInfo    = $8000;
  kFSVolInfoGettableInfo = $FFFF;
  kFSVolInfoSettableInfo = $3004;
}
{ FSVolumeInfo.flags bits.  These are the same as for ioVAtrb, but with nicer names. }
const
  kFSVolFlagDefaultVolumeBit     = 5;
  kFSVolFlagDefaultVolumeMask    = $0020;
  kFSVolFlagFilesOpenBit         = 6;
  kFSVolFlagFilesOpenMask        = $0040;
  kFSVolFlagHardwareLockedBit    = 7;
  kFSVolFlagHardwareLockedMask   = $0080;
  kFSVolFlagJournalingActiveBit  = 14;
  kFSVolFlagJournalingActiveMask = $4000;
  kFSVolFlagSoftwareLockedBit    = 15;
  kFSVolFlagSoftwareLockedMask   = $8000;

type
(*
  FSVolumeInfo = record
    createDate: UTCDateTime;
    modifyDate: UTCDateTime;
    backupDate: UTCDateTime;
    checkedDate: UTCDateTime;

{ File/Folder counts -- return zero if unknown }
    fileCount: UInt32;
    folderCount: UInt32;
{ Note: no root directory counts }

    totalBytes: UInt64;
    freeBytes: UInt64;

{ HFS and HFS Plus specific.  Set fields to zero if not appropriate }
    blockSize: UInt32;
    totalBlocks: UInt32;
    freeBlocks: UInt32;
    nextAllocation: UInt32;
    rsrcClumpSize: UInt32;
    dataClumpSize: UInt32;
    nextCatalogID: UInt32;
    finderInfo: packed array[0..31] of UInt8;

{ Identifying information }
    flags: UInt16;
    filesystemID: UInt16;
    signature: UInt16;
    driveNumber: UInt16;
    driverRefNum: FSIORefNum;
  end;
  FSVolumeInfoPtr = ^FSVolumeInfo;
  FSVolumeInfoParam = record
    qLink: QElemPtr;
    qType: SInt16;
    ioTrap: SInt16;
    ioCmdAddr: Ptr;
    ioCompletion: IOCompletionUPP;
    !!! OSErr ioResult: !!!;
    ioNamePtr: StringPtr;
    ioVRefNum: FSVolumeRefNum;

    volumeIndex: UInt32;
    whichInfo: FSVolumeInfoBitmap;
    volumeInfo: PFSVolumeInfo;
    volumeName: PHFSUniStr255;
    ref: PFSRef;
  end;
  FSVolumeInfoParamPtr = ^FSVolumeInfoParam;
*)
  GetVolParmsInfoBuffer = packed record
    vMVersion: SInt16;
    vMAttrib: SInt32;
    vMLocalHand: Handle;
    vMServerAdr: SInt32;
{       vMVersion 1 GetVolParmsInfoBuffer ends here }
    vMVolumeGrade: SInt32;
    vMForeignPrivID: SInt16;
{       vMVersion 2 GetVolParmsInfoBuffer ends here }
    vMExtendedAttributes: SInt32;
{       vMVersion 3 GetVolParmsInfoBuffer ends here }
    vMDeviceID: Pointer;
{       vMVersion 4 GetVolParmsInfoBuffer ends here }
    vMMaxNameLength: UniCharCount;
{       vMVersion 5 GetVolParmsInfoBuffer ends here }
  end;
  PGetVolParmsInfoBuffer = ^GetVolParmsInfoBuffer;
(*
{
    The following are structures to be filled out with the _PBGetVolMountInfo call
    and passed back into the _PBVolumeMount call for external file system mounts.
 }
{ the "signature" of the file system }

  VolumeType = OSType;
  !!! = (
    AppleShareMediaType
{!!! /* }
  );
{!!! /* }

{
    VolMount stuff was once in FSM.Å
 }
  VolMountInfoHeader = record
    length: SInt16;
    media: VolumeType;
  end;
  VolMountInfoPtr = ^VolMountInfoHeader;
{ The new volume mount info record.  The old one is included for compatibility.
    the new record allows access by foriegn filesystems writers to the flags
    portion of the record. This portion is now public.
 }
  VolumeMountInfoHeader = record
    length: SInt16;
    media: VolumeType;
    flags: SInt16;
  end;
  VolumeMountInfoHeaderPtr = ^VolumeMountInfoHeader;
{ volume mount flags }
const
  volMountNoLoginMsgFlagBit  = 0;
  volMountNoLoginMsgFlagMask = $0001;
  volMountExtendedFlagsBit   = 7;
  volMountExtendedFlagsMask  = $0080;
  volMountInteractBit        = 15;
  volMountInteractMask       = $8000;
  volMountChangedBit         = 14;
  volMountChangedMask        = $4000;
  volMountFSReservedMask     = $00FF;
  volMountSysReservedMask    = $FF00;


*)
{
type
  AFPVolMountInfo = record
    length: SInt16;
    media: VolumeType;
    flags: SInt16;
    nbpInterval: SInt8;
    nbpCount: SInt8;
    uamType: SInt16;
    zoneNameOffset: SInt16;
    serverNameOffset: SInt16;
    volNameOffset: SInt16;
    userNameOffset: SInt16;
    userPasswordOffset: SInt16;
    volPasswordOffset: SInt16;
    AFPData: packed array[0..143] of Char;
  end;
  AFPVolMountInfoPtr = ^AFPVolMountInfo;
}

{ AFPXVolMountInfo is the new AFP volume mount info record, requires the 3.7 AppleShare Client }
{
  AFPXVolMountInfo = record
    length: SInt16;
    media: VolumeType;
    flags: SInt16;
    nbpInterval: SInt8;
    nbpCount: SInt8;
    uamType: SInt16;
    zoneNameOffset: SInt16;
    serverNameOffset: SInt16;
    volNameOffset: SInt16;
    userNameOffset: SInt16;
    userPasswordOffset: SInt16;
    volPasswordOffset: SInt16;
    extendedFlags: SInt16;
    uamNameOffset: SInt16;
    alternateAddressOffset: SInt16;
    AFPData: packed array[0..175] of Char;
  end;
  AFPXVolMountInfoPtr = ^AFPXVolMountInfo;
const
  kAFPExtendedFlagsAlternateAddressMask = 1;


const
  kAFPTagTypeIP     = $01;
  kAFPTagTypeIPPort = $02;
  kAFPTagTypeDDP    = $03;
  kAFPTagTypeDNS    = $04;


const
  kAFPTagLengthIP     = $06;
  kAFPTagLengthIPPort = $08;
  kAFPTagLengthDDP    = $06;

type
  AFPTagData = record
    fLength: UInt8;
    fType: UInt8;
    fData: packed array[0..0] of UInt8;
  end;
  AFPAlternateAddress = record
    fVersion: UInt8;
    fAddressCount: UInt8;
    fAddressList: packed array[0..0] of UInt8;
  end;
const
  kLargeIconSize     = 256;
  kLarge4BitIconSize = 512;
  kLarge8BitIconSize = 1024;
  kSmallIconSize     = 64;
  kSmall4BitIconSize = 128;
  kSmall8BitIconSize = 256;
}
{
 *  NewIOCompletionUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 }
//function NewIOCompletionUPP(
//  userRoutine: IOCompletionProcPtr): IOCompletionUPP; cdecl;

{
 *  DisposeIOCompletionUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 }
//procedure DisposeIOCompletionUPP(userUPP: IOCompletionUPP); cdecl;

{
 *  InvokeIOCompletionUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 }
//procedure InvokeIOCompletionUPP(paramBlock: ParmBlkPtr;
//  userUPP: IOCompletionUPP); cdecl;


{
	MakeFSRefUnicode
	Create an FSRef for an existing object specified by
	Parent FSRef and Unicode name.
	->  ioCompletion    A pointer to a completion routine
	<-  ioResult        The result code of the function
	->  ref             A pointer to the parent directory FSRef
	->  name            A pointer to Unicode name
	->  nameLength      The length of the Unicode Name
    ->  textEncodingHint A suggested text encoding to use for the name
    <-  newRef          A pointer to an FSRef
 }
{
 *  FSMakeFSRefUnicode()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSMakeFSRefUnicode(const parentRef: PFSRef; nameLength: UniCharCount;
//  const name: PUniChar; textEncodingHint: TextEncoding;
//  newRef: PFSRef): OSErr; cdecl;


{
 *  PBMakeFSRefUnicodeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBMakeFSRefUnicodeSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBMakeFSRefUnicodeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBMakeFSRefUnicodeAsync(paramBlock: PFSRefParam); cdecl;



{
    CompareFSRefs
    Test whether two FSRefs refer to the same file or directory.
    If they do, noErr is returned.  Otherwise, an appropriate error
    (such as errFSRefsDifferent) is returned.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             A pointer to the first FSRef
    ->  parentRef       A pointer to the second FSRef
 }
{
 *  FSCompareFSRefs()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSCompareFSRefs(const ref1: PFSRef; const ref2: PFSRef): OSErr; cdecl;


{
 *  PBCompareFSRefsSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBCompareFSRefsSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBCompareFSRefsAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBCompareFSRefsAsync(paramBlock: PFSRefParam); cdecl;



{
    CreateFileUnicode
    Creates a new file.  The input filename is in Unicode.
    You can optionally set catalog info for the file.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The directory where the file is to be created
    ->  whichInfo       Which catalog info fields to set
    ->  catInfo         The values for catalog info fields to set; may be NULL
    ->  nameLength      Number of Unicode characters in the file's name
    ->  name            A pointer to the Unicode name
    <-  spec            A pointer to the FSSpec for the new directory; may be NULL.  Ignored on 64 bit.
    <-  newRef          A pointer to the FSRef for the new file; may be NULL
 }
{
 *  FSCreateFileUnicode()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSCreateFileUnicode(const parentRef: PFSRef; nameLength: UniCharCount;
//  const name: PUniChar; whichInfo: FSCatalogInfoBitmap;
//  const catalogInfo: PFSCatalogInfo; newRef: PFSRef;
//  newSpec: FSSpecPtr): OSErr; cdecl;


{
 *  PBCreateFileUnicodeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBCreateFileUnicodeSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBCreateFileUnicodeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBCreateFileUnicodeAsync(paramBlock: PFSRefParam); cdecl;



{
    CreateDirectoryUnicode
    Creates a new directory.  The input directory name is in Unicode.
    You can optionally set catalog info for the directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The parent directory where the directory is to be created
    ->  whichInfo       Which catalog info fields to set
    ->  catInfo         The values for catalog info fields to set; may be NULL
    ->  nameLength      Number of Unicode characters in the directory's name
    ->  name            A pointer to the Unicode name
    <-  ioDirID         The DirID of the new directory
    <-  newSpec         A pointer to the FSSpec for the new directory; may be NULL.  Ignored on 64 bit.
    <-  newRef          A pointer to the FSRef for the new directory; may be NULL
 }
{
 *  FSCreateDirectoryUnicode()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSCreateDirectoryUnicode(const parentRef: PFSRef;
//  nameLength: UniCharCount; const name: PUniChar;
//  whichInfo: FSCatalogInfoBitmap; const catalogInfo: PFSCatalogInfo;
//  newRef: PFSRef; newSpec: FSSpecPtr; newDirID: PUInt32): OSErr; cdecl;


{
 *  PBCreateDirectoryUnicodeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBCreateDirectoryUnicodeSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBCreateDirectoryUnicodeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
////procedure PBCreateDirectoryUnicodeAsync(paramBlock: PFSRefParam); cdecl;



{
    DeleteObject
    Deletes an existing file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory to be deleted
 }
{
 *  FSDeleteObject()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSDeleteObject(const ref: PFSRef): OSErr; cdecl;


{
 *  PBDeleteObjectSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBDeleteObjectSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBDeleteObjectAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
////procedure PBDeleteObjectAsync(paramBlock: PFSRefParam); cdecl;



{
    UnlinkObject
    Unlinks an existing file or deletes an existing directory.  This call will succeed on an open file, unlike
    DeleteObject.  This call will unlink an archive directory link (where DeleteObject will treat the ADL as a directory).
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory to be deleted
 }
{
 *  FSUnlinkObject()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function FSUnlinkObject(const ref: PFSRef): OSErr; cdecl;


{
 *  PBUnlinkObjectSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function PBUnlinkObjectSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBUnlinkObjectAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//procedure PBUnlinkObjectAsync(paramBlock: PFSRefParam); cdecl;


{
    MoveObject
    Move an existing file or directory into a different directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory to be moved
    ->  parentRef       The file or directory will be moved into this directory
    <-  newRef          A new FSRef for the file or directory in its new location;
                        optional, may be NULL
    NOTE: Moving an object may change its FSRef.  If you want to continue to
    refer to the object, you should pass a non-NULL pointer in newRef and use
    that returned FSRef to access the object after the move.  The FSRef passed
    in "ref" may or may not be usable to access the object after it is moved.
    "newRef" may point to the same storage as "parentRef" or "ref".
 }
{
 *  FSMoveObject()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSMoveObject(const ref: PFSRef; const destDirectory: PFSRef;
//  newRef: PFSRef): OSErr; cdecl;


{
 *  PBMoveObjectSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBMoveObjectSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBMoveObjectAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBMoveObjectAsync(paramBlock: PFSRefParam); cdecl;



{
    ExchangeObjects
    swap the contents of two files.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The first file
    ->  parentRef       The second file
 }
{
 *  FSExchangeObjects()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSExchangeObjects(const ref: PFSRef;
//  const destRef: PFSRef): OSErr; cdecl;


{
 *  PBExchangeObjectsSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBExchangeObjectsSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBExchangeObjectsAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBExchangeObjectsAsync(paramBlock: PFSRefParam); cdecl;


{
    FSReplaceObject and FSPathReplaceObject

    You can use the FSReplaceObject and FSPathReplaceObject functions to replace
    one object, the original object, with another, the replacement object.
    FSReplaceObject and FSPathReplaceObject are provided to assist in properly
    preserving metadata during safe save operations. These functions allow files
    to replace files, directories to replace directories, directories to replace
    files and files to replace directories (so a package can replace a file, or
    a file can replace a package). Both objects must reside on the same volume.

    If FSReplaceObject or FSPathReplaceObject are successful, the result object
    will exist at the location of the original object. Nothing will exist at the
    location of the replacement object.  By default FSReplaceObject and  FSPathReplaceObject
    will test the object for write access, and fail if write access is not available.
    Write access in this context is ACL_WRITE_DATA for files and ACL_ADD_FILE for directories.
    This check can be bypassed by passing the kFSReplaceObjectDoNotCheckObjectWriteAccess flag.

    FSReplaceObject and FSPathReplaceObject may need to create a temporary object
    when one of the input objects is a directory, or when the
    kFSReplaceObjectSaveOriginalAsABackup option is specified. The temporary object
    is required since the rename system call does not handle non-empty directory
    replacement or file <-> directory replacement. The file replacing file case
    does not use a temporary object (unless the kFSReplaceObjectSaveOriginalAsABackup
    option is specified). If no temporary name is provided and a temporary object
    is required, then the functions will return an error. Providing a temporary
    name will also allow an application to recover the original object should a
    catastrophic failure (such as a power outage) occur during a replacement
    involving a directory. The temporary object will be created with the temporary
    name either in the temporary directory specified by the temporaryDirectory
    parameter, or in the preferred temporary directory (the preferred temporary
    directory can be obtained with the FSGetTemporaryDirectoryForReplaceObject
    or FSPathGetTemporaryDirectoryForReplaceObject functions).

    If the kFSReplaceObjectSaveOriginalAsABackup option is specified, the original
    object will be saved in one of two locations: If the temporaryName parameter
    is provided, the original object will be saved with that temporary name in
    the temporary directory. If the temporaryName parameter is not provided and
    the newName parameter is provided, the original object will be saved with
    its original name in the temporary directory.

    The result object will have the data (or directory contents) from the
    replacement object, but will have the original object's creation date and
    backup date. By default, the result object will have extended attributes
    merged from the original object and the replacement object, using the extended
    attributes of the replacement object if the original object has extended
    attributes with the same name. If the kFSReplaceObjectReplaceMetadata option
    flag is passed, then the extended attributes of the original object will be
    completely overwritten by the extended attributes of the replacement object.

    The kFSReplaceObjectReplaceMetadata also controls how the label, type, creator,
    hidden extension bit, strong binding, custom icon and custom badge are handled.
    For the custom icon, custom badge, label (where a value of 0 is considered not
    present), and strong binding the replacement object's attributes will be
    used if present, otherwise the original object's attributes will be retained.  For
    the extension hidden bit, type, and creator the original object's attribute is
    preserved.  Setting the kFSReplaceObjectReplaceMetadata flag will use the replacement
    object's attributes for all cases.  Type and creator are only handled in the
    file to file case.  Strong bindings are not applicable to plain directories.

    The default handling of ACL and mode info depends on the types of objects
    involved. If the original object and replacement object are of the same type
    (both files or both directories) then the default behavior is to use the ACL
    and mode of the original object. Setting the kFSReplaceObjectReplacePermissionInfo
    flag will use the ACL and mode from the replacementObject.

    If the objects are different types, then the ACL and mode will be based off
    the original object and will translated as follows:

        Mode:
        file r -> dir rx
        file w -> dir wx
        file x -> dir nothing

        dir r -> file r
        dir w -> file w
        dir x -> file nothing

        ACLs:

        ACL_SEARCH will be added to any allow ACE in the file to directory case.
        ACL_EXECUTE will be removed from any ACE in the file to directory case.

        ACL_SEARCH and ACL_DELETE_CHILD will be removed from any ACE in the directory to file case.

        File                Directory
        ACL_READ_DATA   <-> ACL_LIST_DIRECTORY
        ACL_WRITE_DATA  <-> ACL_ADD_FILE
        ACL_APPEND_DATA <-> ACL_ADD_SUBDIRECTORY

        ACL_DELETE , ACL_READ_ATTRIBUTES, ACL_WRITE_ATTRIBUTES, ACL_READ_EXTATTRIBUTES,
        ACL_WRITE_EXTATTRIBUTES, ACL_READ_SECURITY, ACL_WRITE_SECURITY and ACL_CHANGE_OWNER
        are the same for both types and will be left alone.

    This translation behavior can be avoided by passing in either
    kFSReplaceObjectPreservePermissionInfo to use the original object ACL and
    mode info unchanged (except where the bits have different meanings for files
    and directories) or kFSReplaceObjectReplacePermissionInfo to use the ACL and
    mode info of the replacement object (except where the bits have different
    meanings for files and directories). Setting both of these flags is an
    error -- the call will fail with a paramErr. The permissions are only set on
    the top-level object -- the permissions inside a directory are unaffected.

    FSReplaceObject may not be atomic -- it may issue multiple system calls to
    accurately replace and preserve the metadata of a file system object.

    FSReplaceObject may fail if the source or destination files are open or
    the source or destination objects are directories which contain open files.
 }

{
 *  FSReplaceObjectOptions
 *
 *  Discussion:
 *    Options that can be passed to the FSReplaceObject and
 *    FSPathReplaceObject functions. These are mask values that can be
 *    ORed together to set more than one option.
 }
const
  kFSReplaceObjectDefaultOptions              = 0;

{
   * The result object will only have the metadata from the replacement
   * object. The result object will have no metadata from the original
   * object.
   }
  kFSReplaceObjectReplaceMetadata             = $01;

{
   * The original object will be saved with the temporary name in the
   * temporaryDirectory, or will be saved with the original name (if no
   * temporaryName is provided and a newName is provided) in the
   * temporaryDirectory.
   }
  kFSReplaceObjectSaveOriginalAsABackup       = $02;

{
   * ACL and mode info will come from the replacement object.
   }
  kFSReplaceObjectReplacePermissionInfo       = $04;

{
   * ACL and mode info will come from the original object
   }
  kFSReplaceObjectPreservePermissionInfo      = $08;

{
   * FSReplaceObject does not actually require write permission to
   * perform the replace operation, since no actual writing is done to
   * the original object.  By default ReplaceObject will test the
   * object for write permissions and fail if they are not present
   * (tested using accessx_np).  Write permission in this context is
   * defined as ACL_WRITE_DATA for files and ACL_ADD_FILE for
   * directories.  Pass this flag to skip this check (which will allow
   * the replace to operate on "read only" objects).
   }
  kFSReplaceObjectDoNotCheckObjectWriteAccess = $10;

{
 *  FSReplaceObject()
 *
 *  Discussion:
 *    This function will replace the object specified by originalObject
 *    with the object specified by replacementObject. The result object
 *    will be in the same parent directory as the original object.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    originalObject:
 *      The original object to be replaced.
 *
 *    replacementObject:
 *      The object which will replace the original object.
 *
 *    newName:
 *      The new name for the result object. Pass NULL to use the
 *      original object's name.
 *
 *    temporaryName:
 *      The name of a temporary object should the operation require a
 *      temporary object. The temporary object will be created in the
 *      preferred temporary directory or in the directory specified by
 *      the temporaryDirectory parameter.
 *
 *    temporaryDirectory:
 *      The directory where the temporary object (if needed) will be
 *      created. The temporary directory must be on the same volume as
 *      the original object. If NULL is passed, then the preferred
 *      temporary directory is used (as per
 *      FSGetTemporaryDirectoryForReplaceObject).
 *
 *    flags:
 *      A set of options to specify non-default behavior.
 *
 *    resultObject:
 *      A new FSRef for the result object.
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function FSReplaceObject(const originalObject: PFSRef;
//  const replacementObject: PFSRef; newName: CFStringRef;
//  temporaryName: CFStringRef; const temporaryDirectory: PFSRef;
//  flags: OptionBits; resultObject: PFSRef): OSStatus; cdecl;


{
 *  FSPathReplaceObject()
 *
 *  Discussion:
 *    This function will replace the object specified by
 *    originalObjectPath with the object specified by
 *    replacementObjectPath. The result object will be in the same
 *    parent directory as the original object.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    originalObjectPath:
 *      The path to the original object to be replaced.
 *
 *    replacementObjectPath:
 *      The path to the object which will replace the original object.
 *
 *    newName:
 *      The new name for the result object. Pass NULL to use the
 *      original object's name.
 *
 *    temporaryName:
 *      The name of a temporary object should the operation require a
 *      temporary object. The temporary object will be created in the
 *      preferred temporary directory or in the directory specified by
 *      the temporaryDirectory parameter.
 *
 *    temporaryDirectoryPath:
 *      The path to the directory where the temporary object (if
 *      needed) will be created. The temporary directory must be on the
 *      same volume as the original object. If NULL is passed, then the
 *      preferred temporary directory is used (as per
 *      FSPathGetTemporaryDirectoryForReplaceObject).
 *
 *    flags:
 *      A set of options to specify non-default behavior.
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function FSPathReplaceObject(const originalObjectPath: PChar;
//  const replacementObjectPath: PChar; newName: CFStringRef;
//  temporaryName: CFStringRef; const temporaryDirectoryPath: PChar;
//  flags: OptionBits): OSStatus; cdecl;


{
 *  FSGetTemporaryDirectoryForReplaceObject()
 *
 *  Discussion:
 *    This function will return the preferred directory for use as the
 *    temporaryDirectory by FSReplaceObject. It will return an
 *    appropriate temporary location or the parent directory of the
 *    original object.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    originalObject:
 *      The original object to be replaced.
 *
 *    temporaryDirectory:
 *      The preferred temporary directory.
 *
 *    flags:
 *      A set of options to specify non-default behavior. Currently no
 *      flags are defined - pass in 0
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function FSGetTemporaryDirectoryForReplaceObject(const originalObject: PFSRef;
//  temporaryDirectory: PFSRef; flags: OptionBits): OSStatus; cdecl;


{
 *  FSPathGetTemporaryDirectoryForReplaceObject()
 *
 *  Discussion:
 *    This function will return the preferred directory for use as the
 *    temporaryDirectory by FSPathReplaceObject. It will return an
 *    appropriate temporary location or the parent directory of the
 *    original object.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    originalObjectPath:
 *      The path to the original object to be replaced.
 *
 *    temporaryDirectoryPath:
 *      The path to the preferred temporary directory.
 *
 *    maxPathSize:
 *      The size of the buffer pointed to by the temporaryDirectoryPath
 *      parameter.
 *
 *    flags:
 *      A set of options to specify non-default behavior. Currently no
 *      flags are defined - pass in 0
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function FSPathGetTemporaryDirectoryForReplaceObject(
//  const originalObjectPath: PChar; temporaryDirectoryPath: PChar;
//  maxPathSize: UInt32; flags: OptionBits): OSStatus; cdecl;


{
    RenameUnicode
    Change the name of an existing file or directory.  The new name is in
    Unicode.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory to be moved
    ->  nameLength      Number of Unicode characters in the new name
    ->  name            A pointer to the new Unicode name
    ->  textEncodingHint A suggested text encoding to use for the name
    <-  newRef          A new FSRef for the file or directory; may be NULL
    NOTE: Renaming an object may change its FSRef.  If you want to continue to
    refer to the object, you should pass a non-NULL pointer in newRef and use
    that returned FSRef to access the object after the rename.  The FSRef passed
    in "ref" may or may not be usable to access the object after it is renamed.
    "newRef" may point to the same storage as "ref".
 }
{
 *  FSRenameUnicode()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSRenameUnicode(const ref: PFSRef; nameLength: UniCharCount;
//  const name: PUniChar; textEncodingHint: TextEncoding;
//  newRef: PFSRef): OSErr; cdecl;


{
 *  PBRenameUnicodeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBRenameUnicodeSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBRenameUnicodeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBRenameUnicodeAsync(paramBlock: PFSRefParam); cdecl;



{
    GetCatalogInfo
    Returns various information about a given file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory whose information is to be returned
    ->  whichInfo       Which catalog info fields to get
    <-  catInfo         The returned values of catalog info fields; may be NULL
    <-  spec            A pointer to the FSSpec for the object; may be NULL.  Ignored for 64 bit.
    <-  parentRef       A pointer to the FSRef for the object's parent directory; may be NULL
    <-  outName         The Unicode name is returned here.  This pointer may be NULL.
    Note: All of the outputs are optional; if you don't want that particular output, just
    set its pointer to NULL.  This is the call to use to map from an FSRef to an FSSpec.
 }
{
 *  FSGetCatalogInfo()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
 {$IFNDEF IOS}
function FSGetCatalogInfo(const ref: PFSRef; whichInfo: FSCatalogInfoBitmap;
  catalogInfo: PFSCatalogInfo; outName: PHFSUniStr255; fsSpec: FSSpecPtr;
  parentRef: PFSRef): OSErr; cdecl;
{$EXTERNALSYM FSGetCatalogInfo}
{$ENDIF !IOS}


{
 *  PBGetCatalogInfoSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBGetCatalogInfoSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBGetCatalogInfoAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBGetCatalogInfoAsync(paramBlock: PFSRefParam); cdecl;



{
 *  FSSetCatalogInfo()
 *
 *  Summary:
 *    Set catalog information about a given file or directory.
 *
 *  Discussion:
 *    Set the catalog information for the file or directory represented
 *    by ref.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Parameters:
 *
 *    ref:
 *      A pointer to an FSRef specifying the file or directory whose
 *      information is to be changed
 *
 *    whichInfo:
 *      A bitmap specifying which catalog information fields may be
 *      set.  The settable fields are given by the constant
 *      kFSCatInfoSettableInfo; no other bits may be set in whichInfo.
 *      The one exception to this is that processes running as eid 0 or
 *      euid 0  can change the user ID and group ID of a file or
 *      directory by setting kFSCatInfoSetOwnership in whichInfo and
 *      setting the permissions field of catalogInfo.
 *
 *    catalogInfo:
 *      A pointer to the structure containing the new catalog
 *      information. Only some of the catalog information fields may be
 *      set.
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSSetCatalogInfo(const ref: PFSRef; whichInfo: FSCatalogInfoBitmap;
//  const catalogInfo: PFSCatalogInfo): OSErr; cdecl;


{
 *  PBSetCatalogInfoSync()
 *
 *  Summary:
 *    Set catalog information about a given file or directory.
 *
 *  Discussion:
 *    Set the catalog information for the file or directory represented
 *    by ref.  See the description in FSSetCatalogInfo for which items
 *    may be set.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBSetCatalogInfoSync(paramBlock: PFSRefParam): OSErr; cdecl;


{
 *  PBSetCatalogInfoAsync()
 *
 *  Summary:
 *    Set catalog information about a given file or directory.
 *
 *  Discussion:
 *    Set the catalog information for the file or directory represented
 *    by ref.  See the description in FSSetCatalogInfo for which items
 *    may be set.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBSetCatalogInfoAsync(paramBlock: PFSRefParam); cdecl;



{
    OpenIterator
    Creates an FSIterator to iterate over a directory or subtree.  The
    iterator can then be passed to GetCatalogInfoBulk or CatalogSearch.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    <-  iterator        The returned FSIterator
    ->  iteratorFlags   Controls whether the iterator iterates over subtrees
                        or just the immediate children of the container.
    ->  container       An FSRef for the directory to iterate (or root of
                        the subtree to iterate).
 }
{
 *  FSOpenIterator()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSOpenIterator(const container: PFSRef; iteratorFlags: FSIteratorFlags;
//  iterator: PFSIterator): OSErr; cdecl;


{
 *  PBOpenIteratorSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBOpenIteratorSync(paramBlock: PFSCatalogBulkParam): OSErr; cdecl;


{
 *  PBOpenIteratorAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBOpenIteratorAsync(paramBlock: PFSCatalogBulkParam); cdecl;



{
    CloseIterator
    Invalidates and disposes an FSIterator.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  iterator        The returned FSIterator
 }
{
 *  FSCloseIterator()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSCloseIterator(iterator: FSIterator): OSErr; cdecl;


{
 *  PBCloseIteratorSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBCloseIteratorSync(paramBlock: PFSCatalogBulkParam): OSErr; cdecl;


{
 *  PBCloseIteratorAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBCloseIteratorAsync(paramBlock: PFSCatalogBulkParam); cdecl;



{
    GetCatalogInfoBulk
    Iterates over catalog objects and returns information about them.
    For now, iterator must have been created with kFSIterateFlat option.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  iterator        The iterator
    ->  maximumItems    The maximum number of items to return
    <-  actualItems     The actual number of items returned
    <-  containerChanged Set to true if the container's contents changed
    ->  whichInfo       The catalog information fields to return for each item
    <-  catalogInfo     An array of catalog information; one for each returned item
    <-  refs            An array of FSRefs; one for each returned item
    <-  specs           An array of FSSpecs; one for each returned item.  Ignored on 64 bit.
    <-  names           An array of filenames; one for each returned item
    Note: The catalogInfo, refs, specs, names, and containerChanged are all optional outputs;
    if you don't want that particular output, set its pointer to NULL.
 }
{
 *  FSGetCatalogInfoBulk()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSGetCatalogInfoBulk(iterator: FSIterator; maximumObjects: ItemCount;
//  actualObjects: PItemCount; containerChanged: PBoolean;
//  whichInfo: FSCatalogInfoBitmap; catalogInfos: PFSCatalogInfo; refs: PFSRef;
//  specs: FSSpecPtr; names: PHFSUniStr255): OSErr; cdecl;


{
 *  PBGetCatalogInfoBulkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBGetCatalogInfoBulkSync(
//  paramBlock: PFSCatalogBulkParam): OSErr; cdecl;


{
 *  PBGetCatalogInfoBulkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBGetCatalogInfoBulkAsync(paramBlock: PFSCatalogBulkParam); cdecl;


{
    CatalogSearch
    Iterates over catalog objects, searching for objects that match given
    search criteria.  Returns various information about matching objects.
    For now, iterator must have been created with kFSIterateSubtree option
    and the container must have been the root directory of a volume.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  iterator        The iterator
    ->  maximumItems    The maximum number of items to return
    <-  actualItems     The actual number of items returned
    <-  containerChanged Set to true if the container's contents changed
    ->  whichInfo       The catalog information fields to return for each item
    <-  catalogInfo     An array of catalog information; one for each returned item
    <-  refs            An array of FSRefs; one for each returned item
    <-  specs           An array of FSSpecs; one for each returned item.  Ignored on 64 bit.
    <-  names           An array of filenames; one for each returned item
    ->  searchParams    The criteria that controls the matching, including timeout, a bitmap
                        controlling the fields to compare, and the (Unicode) name to compare.
    Note: The catalogInfo, refs, specs, and names are all optional outputs; if you don't want
    that particular output, set its pointer to NULL.
 }
{
 *  FSCatalogSearch()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSCatalogSearch(iterator: FSIterator;
//  const searchCriteria: PFSSearchParams; maximumObjects: ItemCount;
//  actualObjects: PItemCount; containerChanged: PBoolean;
//  whichInfo: FSCatalogInfoBitmap; catalogInfos: PFSCatalogInfo; refs: PFSRef;
//  specs: FSSpecPtr; names: PHFSUniStr255): OSErr; cdecl;


{
 *  PBCatalogSearchSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBCatalogSearchSync(paramBlock: PFSCatalogBulkParam): OSErr; cdecl;


{
 *  PBCatalogSearchAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBCatalogSearchAsync(paramBlock: PFSCatalogBulkParam); cdecl;



{
    CreateFileAndOpenForkUnicode
    Creates a new file and opens the specified fork.  The input filename is in Unicode.
    You can optionally set catalog info for the file.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  parentRef       The directory where the file is to be created
    ->  whichInfo       Which catalog info fields to set
    ->  catalogInfo     The values for catalog info fields to set; may be NULL
    ->  nameLength      Number of Unicode characters in the file's name
    ->  name            A pointer to the Unicode name
    ->  forkNameLength  The length of the fork name (in Unicode characters).
    ->  forkName        The name of the fork to open (in Unicode).  Passing NULL will open the data fork.
    ->  permissions     The access (read and/or write) you want
    <-  forkRefNum      The reference number for accessing the open fork
    <-  newRef          A pointer to the FSRef for the new file; may be NULL
 }
{
 *  FSCreateFileAndOpenForkUnicode()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function FSCreateFileAndOpenForkUnicode(const parentRef: PFSRef;
//  nameLength: UniCharCount; const name: PUniChar;
//  whichInfo: FSCatalogInfoBitmap; const catalogInfo: PFSCatalogInfo;
//  forkNameLength: UniCharCount; const forkName: PUniChar; permissions: SInt8;
//  forkRefNum: PFSIORefNum; newRef: PFSRef): OSStatus; cdecl;


{
 *  PBCreateFileAndOpenForkUnicodeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function PBCreateFileAndOpenForkUnicodeSync(
//  paramBlock: FSRefForkIOParamPtr): OSStatus; cdecl;


{
 *  PBCreateFileAndOpenForkUnicodeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//procedure PBCreateFileAndOpenForkUnicodeAsync(
//  paramBlock: FSRefForkIOParamPtr); cdecl;


{
    CreateFork
    Create a named fork for a file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory
    ->  forkNameLength  The length of the fork name (in Unicode characters)
    ->  forkName        The name of the fork to open (in Unicode)
 }
{
 *  FSCreateFork()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSCreateFork(const ref: PFSRef; forkNameLength: UniCharCount;
//  const forkName: PUniChar): OSErr; cdecl;


{
 *  PBCreateForkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBCreateForkSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBCreateForkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBCreateForkAsync(paramBlock: PFSForkIOParam); cdecl;



{
    DeleteFork
    Delete a named fork of a file or directory.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory
    ->  forkNameLength  The length of the fork name (in Unicode characters)
    ->  forkName        The name of the fork to open (in Unicode)
 }
{
 *  FSDeleteFork()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSDeleteFork(const ref: PFSRef; forkNameLength: UniCharCount;
//  const forkName: PUniChar): OSErr; cdecl;


{
 *  PBDeleteForkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBDeleteForkSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBDeleteForkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBDeleteForkAsync(paramBlock: PFSForkIOParam); cdecl;



{
    IterateForks
    Return the names and sizes of the forks of a file or directory.
    One fork is returned per call.
    ->  ioCompletion    A pointer to a completion routine.
    <-  ioResult        The result code of the function.
    ->  ref             The file or directory containing the forks.
    <-  positionOffset  The length of the fork, in bytes.
    <-  allocationAmount The space allocated to the fork (physical length).
    <-  outForkName     The name of the fork in Unicode.
    <>  forkIterator    Maintains state between calls for a given FSRef.
                        Before the first call, set the initialize field to zero.
 }
{
 *  FSIterateForks()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSIterateForks(const ref: PFSRef; forkIterator: PCatPositionRec;
//  forkName: PHFSUniStr255; forkSize: PSInt64;
//  forkPhysicalSize: PUInt64): OSErr; cdecl;


{
 *  PBIterateForksSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBIterateForksSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBIterateForksAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBIterateForksAsync(paramBlock: PFSForkIOParam); cdecl;



{
    OpenFork
    Open a fork for reading and/or writing.  Allows the opened fork
    to grow beyond 2GB in size.  All volumes should support data and
    resource forks.  Other named forks may be supported by some
    volumes.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The file or directory containing the fork to open
    ->  forkNameLength  The length of the fork name (in Unicode characters)
    ->  forkName        The name of the fork to open (in Unicode)
    ->  permissions     The access (read and/or write) you want
    <-  forkRefNum      The reference number for accessing the open fork
 }
{
 *  FSOpenFork()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSOpenFork(const ref: PFSRef; forkNameLength: UniCharCount;
//  const forkName: PUniChar; permissions: SInt8;
//  forkRefNum: PFSIORefNum): OSErr; cdecl;


{
 *  PBOpenForkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBOpenForkSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBOpenForkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBOpenForkAsync(paramBlock: PFSForkIOParam); cdecl;



{
    ReadFork
    Read data from a fork opened via OpenFork.  The first byte to read is
    indicated by a combination of positionMode and positionOffset.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to read from
    <-  buffer          Pointer to buffer where data will be returned
    ->  requestCount    The number of bytes to read
    <-  actualCount     The number of bytes actually read
    ->  positionMode    The base location for start of read
    ->  positionOffset  The offset from base location for start of read
 }
{
 *  FSReadFork()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSReadFork(forkRefNum: FSIORefNum; positionMode: UInt16;
//  positionOffset: SInt64; requestCount: ByteCount; buffer: Pointer;
//  actualCount: PByteCount): OSErr; cdecl;


{
 *  PBReadForkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBReadForkSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBReadForkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBReadForkAsync(paramBlock: PFSForkIOParam); cdecl;



{
    WriteFork
    Write data to a fork opened via OpenFork.  The first byte to write is
    indicated by a combination of positionMode and positionOffset.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to write to
    ->  buffer          Pointer to data to write
    ->  requestCount    The number of bytes to write
    <-  actualCount     The number of bytes actually written
    ->  positionMode    The base location for start of write
    ->  positionOffset  The offset from base location for start of write
 }
{
 *  FSWriteFork()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSWriteFork(forkRefNum: FSIORefNum; positionMode: UInt16;
//  positionOffset: SInt64; requestCount: ByteCount; const buffer: Pointer;
//  actualCount: PByteCount): OSErr; cdecl;


{
 *  PBWriteForkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBWriteForkSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBWriteForkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBWriteForkAsync(paramBlock: PFSForkIOParam); cdecl;



{
    GetForkPosition
    Get the current (default) position of a fork that was
    opened via OpenFork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    <-  positionOffset  The current position of the fork
 }
{
 *  FSGetForkPosition()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSGetForkPosition(forkRefNum: FSIORefNum;
//  position: PSInt64): OSErr; cdecl;


{
 *  PBGetForkPositionSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBGetForkPositionSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBGetForkPositionAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBGetForkPositionAsync(paramBlock: PFSForkIOParam); cdecl;



{
    SetForkPosition
    Set the current (default) position of a fork that was
    opened via OpenFork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    ->  positionMode    The base location for the new position
    ->  positionOffset  The offset of the new position from the base
 }
{
 *  FSSetForkPosition()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSSetForkPosition(forkRefNum: FSIORefNum; positionMode: UInt16;
//  positionOffset: SInt64): OSErr; cdecl;


{
 *  PBSetForkPositionSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBSetForkPositionSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBSetForkPositionAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBSetForkPositionAsync(paramBlock: PFSForkIOParam); cdecl;



{
    GetForkSize
    Get the current logical size (end-of-file) of an open fork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    <-  positionOffset  The logical size of the fork, in bytes
 }
{
 *  FSGetForkSize()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSGetForkSize(forkRefNum: FSIORefNum;
//  forkSize: PSInt64): OSErr; cdecl;


{
 *  PBGetForkSizeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBGetForkSizeSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBGetForkSizeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBGetForkSizeAsync(paramBlock: PFSForkIOParam); cdecl;



{
    SetForkSize
    Set the logical size (end-of-file) of an open fork.  This
    may cause space to be allocated or deallocated.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    ->  positionMode    The base location for the new size
    ->  positionOffset  The offset of the new size from the base
 }
{
 *  FSSetForkSize()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSSetForkSize(forkRefNum: FSIORefNum; positionMode: UInt16;
//  positionOffset: SInt64): OSErr; cdecl;


{
 *  PBSetForkSizeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBSetForkSizeSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBSetForkSizeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBSetForkSizeAsync(paramBlock: PFSForkIOParam); cdecl;



{
    AllocateFork
    Allocate space to an open fork.  Typically, the space to be
    allocated is beyond the current size of the fork, to reserve
    space so the file will be able to grow later.  Some volume
    formats are unable to allocate space beyond the logical size
    of the fork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork
    ->  positionMode    The base location for start of allocation
    ->  positionOffset  The offset of the start of allocation
    ->  allocationFlags Zero or more of the following flags:
        kFSAllocContiguousMask
                Any newly allocated space must be one contiguous piece.
        kFSAllocAllOrNothingMask
                All of the request space must be available, or the call
                will fail.  (If not set, the call may succeed even though
                some of the requested space wasn't allocated.)
        kFSAllocNoRoundUpMask
                Do not allocate additional space.  (If not set, a volume
                may allocate additional space in order to reduce fragmentation.)
    <>  allocationAmount    The number of bytes to allocate
                            On output, the number of bytes actually added
 }
{
 *  FSAllocateFork()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSAllocateFork(forkRefNum: FSIORefNum; flags: FSAllocationFlags;
//  positionMode: UInt16; positionOffset: SInt64; requestCount: UInt64;
//  actualCount: PUInt64): OSErr; cdecl;


{
 *  PBAllocateForkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBAllocateForkSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBAllocateForkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBAllocateForkAsync(paramBlock: PFSForkIOParam); cdecl;



{
    FlushFork
    Flush a fork.  Any data written to this fork refnum is flushed to the device.
    The volume's control structures are also flushed to the device.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to flush
 }
{
 *  FSFlushFork()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSFlushFork(forkRefNum: FSIORefNum): OSErr; cdecl;


{
 *  PBFlushForkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBFlushForkSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBFlushForkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBFlushForkAsync(paramBlock: PFSForkIOParam); cdecl;



{
    CloseFork
    Flush and close a fork.  Any data written to this fork refnum is flushed
    to the device.  The volume's control structures are also flushed to the device.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to close
 }
{
 *  FSCloseFork()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSCloseFork(forkRefNum: FSIORefNum): OSErr; cdecl;


{
 *  PBCloseForkSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBCloseForkSync(paramBlock: PFSForkIOParam): OSErr; cdecl;


{
 *  PBCloseForkAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBCloseForkAsync(paramBlock: PFSForkIOParam); cdecl;



{
    GetForkCBInfo
    Return information about an open fork.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    <>  desiredRefNum   If non-zero on input, then get information for this refnum;
                        unchanged on output.  If zero on input, iterate over all open
                        forks (possibly limited to a single volume); on output, contains
                        the fork's refnum.
    ->  volumeRefNum    Used when desiredRefNum is zero on input.  Set to 0 to iterate over all
                        volumes, or set to a FSVolumeRefNum to limit iteration to that volume.
    <>  iterator        Used when desiredRefNum is zero on input.  Set to 0 before iterating.
                        Pass the iterator returned by the previous call to continue iterating.
    <-  actualRefNum    The refnum of the open fork.
    <-  ref             The FSRef for the file or directory that contains the fork.
    <-  forkInfo        Various information about the open fork.
    <-  outForkName     The name of the fork
    Note: the foundRefNum, ref, forkInfo, and fork name outputs are all optional; if you don't want
    a particular output, then set its pointer to NULL.  If forkName is NULL, then forkNameLength
    will be undefined.
    Note: Returning the forkInfo generally does not require a disk access.  Returning the
    ref or forkName may cause disk access for some volume formats.
 }
{
 *  FSGetForkCBInfo()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSGetForkCBInfo(desiredRefNum: FSIORefNum; volume: FSVolumeRefNum;
//  iterator: PSmallint; actualRefNum: PFSIORefNum; forkInfo: PFSForkInfo;
//  ref: PFSRef; outForkName: PHFSUniStr255): OSErr; cdecl;


{
 *  PBGetForkCBInfoSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBGetForkCBInfoSync(paramBlock: PFSForkCBInfoParam): OSErr; cdecl;


{
 *  PBGetForkCBInfoAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBGetForkCBInfoAsync(paramBlock: PFSForkCBInfoParam); cdecl;


{
    PBXLockRange
    Lock a range of bytes of the file fork specified by forkRefNum.
    This is only supported on some volume formats.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to read from
    ->  requestCount    The number of bytes to lock
    ->  positionMode    The base location for start of the range
    ->  positionOffset  The offset from base location for start of the range
    <-  rangeStart      Number of the first byte locked
 }
{
 *  FSLockRange()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function FSLockRange(forkRefNum: FSIORefNum; positionMode: UInt16;
//  positionOffset: SInt64; requestCount: UInt64;
//  rangeStart: PUInt64): OSStatus; cdecl;


{
 *  PBXLockRangeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function PBXLockRangeSync(paramBlock: FSRangeLockParamPtr): OSStatus; cdecl;


{
 *  PBXLockRangeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function PBXLockRangeAsync(paramBlock: FSRangeLockParamPtr): OSStatus; cdecl;


{
    PBXUnlockRange
    Unlock a range of bytes of the file fork specified by forkRefNum.
    This is only supported on some volume formats.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  forkRefNum      The reference number of the fork to read from
    ->  requestCount    The number of bytes to lock
    ->  positionMode    The base location for start of the range
    ->  positionOffset  The offset from base location for start of the range
    <-  rangeStart      Number of the first byte unlocked
 }
{
 *  FSUnlockRange()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function FSUnlockRange(forkRefNum: FSIORefNum; positionMode: UInt16;
//  positionOffset: SInt64; requestCount: UInt64;
//  rangeStart: PUInt64): OSStatus; cdecl;


{
 *  PBXUnlockRangeSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function PBXUnlockRangeSync(paramBlock: FSRangeLockParamPtr): OSStatus; cdecl;


{
 *  PBXUnlockRangeAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function PBXUnlockRangeAsync(paramBlock: FSRangeLockParamPtr): OSStatus; cdecl;


{
    GetVolumeInfo
    Returns various information about a given volume, or indexing over all volumes.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    <>  ioVRefNum       On input, the volume reference number or drive number whose
                        information is to be returned (if volumeIndex is 0); same
                        as "volume" input to FSGetVolumeInfo.
                        On output, the actual volume reference number; same as
                        "actualVolume" output of FSGetVolumeInfo.
    ->  volumeIndex     The index of the desired volume, or 0 to use ioVRefNum
    ->  whichInfo       Which volInfo info fields to get
    <-  volumeInfo      The returned values of Volume info fields; may be NULL
    <-  name            The Unicode name is returned here.  This pointer may be NULL.
    Note: All of the outputs are optional; if you don't want that particular output, just
    set its pointer to NULL.
 }
{
 *  FSGetVolumeInfo()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSGetVolumeInfo(volume: FSVolumeRefNum; volumeIndex: ItemCount;
//  actualVolume: PFSVolumeRefNum; whichInfo: FSVolumeInfoBitmap;
//  info: PFSVolumeInfo; volumeName: PHFSUniStr255;
//  rootDirectory: PFSRef): OSErr; cdecl;


{
 *  PBGetVolumeInfoSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBGetVolumeInfoSync(paramBlock: PFSVolumeInfoParam): OSErr; cdecl;


{
 *  PBGetVolumeInfoAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBGetVolumeInfoAsync(paramBlock: PFSVolumeInfoParam); cdecl;



{
    SetVolumeInfo
    Set information about a given volume.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ioVRefNum       The volume whose information is to be changed
    ->  whichInfo       Which catalog info fields to set
    ->  volumeInfo      The new values of volume info fields
    Note: Only some of the volume info fields may be set.  The settable fields
    are given by the constant kFSVolInfoSettableInfo; no other bits may be set in
    whichInfo.
 }
{
 *  FSSetVolumeInfo()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSSetVolumeInfo(volume: FSVolumeRefNum; whichInfo: FSVolumeInfoBitmap;
//  const info: PFSVolumeInfo): OSErr; cdecl;


{
 *  PBSetVolumeInfoSync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBSetVolumeInfoSync(paramBlock: PFSVolumeInfoParam): OSErr; cdecl;


{
 *  PBSetVolumeInfoAsync()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBSetVolumeInfoAsync(paramBlock: PFSVolumeInfoParam); cdecl;


{
    FSGetDataForkName
    Returns the constant for the name of the data fork (the empty string)
 }
{
 *  FSGetDataForkName()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSGetDataForkName(dataForkName: PHFSUniStr255): OSErr; cdecl;


{
    FSGetResourceForkName
    Returns the constant for the name of the resource fork
    (currently "RESOURCE_FORK").
 }
{
 *  FSGetResourceForkName()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSGetResourceForkName(resourceForkName: PHFSUniStr255): OSErr; cdecl;


{
 *  FSRefMakePath()
 *
 *  Summary:
 *    converts an FSRef to a POSIX path
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Parameters:
 *
 *    ref:
 *      the file/dir to get the POSIX path for
 *
 *    path:
 *      a pointer to a buffer which FSRefMakePath will fill with a UTF8
 *      encoded C string representing the path the the specified FSRef
 *
 *    pathBufferSize:
 *      the size of the path buffer in bytes.  This size should include
 *      the NULL terminator for the returned path string.
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Non-Carbon CFM:   not available
 }
//function FSRefMakePath(const ref: PFSRef; path: PUInt8;
//  pathBufferSize: UInt32): OSStatus; cdecl;


{
 *  FSPathMakeRef()
 *
 *  Summary:
 *    converts a POSIX path to an FSRef
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Parameters:
 *
 *    path:
 *      a pointer to a UTF8 encoded C String that is a POSIX path
 *
 *    ref:
 *      a pointer to an FSRef to fill in
 *
 *    isDirectory:
 *      an optional pointer to a Boolean that will be filled in with
 *      whether the specified path is a directory (vs. a file)
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Non-Carbon CFM:   not available
 }
type
  PBoolean = ^Boolean;

{$IFNDEF IOS}
function FSPathMakeRef(const path: PUInt8; ref: PFSRef;
  isDirectory: PBoolean): OSStatus; cdecl;
{$EXTERNALSYM FSPathMakeRef}
{$ENDIF !IOS}



{
 *  FSPathMakeRefOptions
 *
 *  Discussion:
 *    Options that can be passed to the FSPathMakeRefWithOptions call.
 }
const
  kFSPathMakeRefDefaultOptions         = 0;
  kFSPathMakeRefDoNotFollowLeafSymlink = $01;

{
 *  FSPathMakeRefWithOptions()
 *
 *  Summary:
 *    converts a POSIX path to an FSRef allowing for options other than
 *    the default
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    path:
 *      a pointer to a UTF8 encoded C String that is a POSIX path
 *
 *    options:
 *      a set of FSPathMakeRef options
 *
 *    ref:
 *      a pointer to an FSRef to fill in
 *
 *    isDirectory:
 *      an optional pointer to a Boolean that will be filled in with
 *      whether the specified path is a directory (vs. a file)
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function FSPathMakeRefWithOptions(const path: PUInt8; options: OptionBits;
//  ref: PFSRef; isDirectory: PBoolean): OSStatus; cdecl;



{
 *  FSIsFSRefValid()
 *
 *  Summary:
 *    Returns true if ref refers to an existing valid file system
 *    object, false otherwise.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    ref:
 *      FSRef to test
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.4 and later
 *    Non-Carbon CFM:   not available
 }
//function FSIsFSRefValid(const ref: PFSRef): Boolean; cdecl;



{
 *  FNMessage
 *
 *  Discussion:
 *    Messages broadcast about a directory.  If system clients (such as
 *    the Finder) are interested in changes to a directory, they will
 *    receive notifications when application code broadcasts change
 *    messages about that directory.
 }
type
  FNMessage = UInt32;
const
  kFNDirectoryModifiedMessage = 1;

{
 *  FNNotify()
 *
 *  Summary:
 *    Broadcasts notification of changes to the specified directory.
 *
 *  Discussion:
 *    FNNotify is used to notify system clients (such as the Finder) of
 *    modifications to the contents of a directory, specifically
 *    addition or removal of files or folders from the directory. The
 *    Finder and other system clients will refresh their views of the
 *    specified directory when they receive the change notification.
 *    FNNotify is not meant to notify the Finder of changes to a
 *    specific file (for example, changes to a file's type or creator);
 *    for that purpose, use a kAESync AppleEvent sent to the Finder.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Parameters:
 *
 *    ref:
 *      The directory for which to broadcast the notification
 *
 *    message:
 *      An indication of what happened to the target directory
 *
 *    flags:
 *      Options about delivery of the notification (specify kNilOptions
 *      for default behaviour)
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Non-Carbon CFM:   not available
 }
//function FNNotify(const ref: PFSRef; message: FNMessage;
//  flags: OptionBits): OSStatus; cdecl;


{
 *  FNNotifyByPath()
 *
 *  Summary:
 *    Broadcasts notification of changes to the specified directory.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Parameters:
 *
 *    path:
 *      Path to the directory for which to broadcast the notification
 *
 *    message:
 *      An indication of what happened to the target directory
 *
 *    flags:
 *      Options about delivery of the notification (specify kNilOptions
 *      for default behaviour)
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Non-Carbon CFM:   not available
 }
//function FNNotifyByPath(const path: PUInt8; message: FNMessage;
//  flags: OptionBits): OSStatus; cdecl;


{
 *  FNNotifyAll()
 *
 *  Discussion:
 *    Broadcasts notification of changes to the filesystem (should only
 *    be used by installers or programs which make lots of changes and
 *    only send one broadcast).
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Parameters:
 *
 *    message:
 *      An indication of what happened
 *
 *    flags:
 *      Options about delivery of the notification (specify kNilOptions
 *      for default behaviour)
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
 *    Non-Carbon CFM:   not available
 }
//function FNNotifyAll(message: FNMessage; flags: OptionBits): OSStatus; cdecl;




{
 *  FNSubscriptionRef
 *
 *  Discussion:
 *    A token associated with a notification subscription.  The
 *    subscriber gets one back when they subscribe to notifications for
 *    a particular directory, and they supply it when the unsubscribe.
 *    It is also delivered along with the notifications for that
 *    subscription.
 }

{
 *  Discussion:
 *    Options that can be specified at subscription time.
 }
//type
//  !!! = (
//   * Specify this option if you do not want to receive notifications on
//   * this subscription when FNNotifyAll is called; by default any
//   * subscription is also implicitly a subscription to wildcard
//   * notifications
//   }
//  kFNNoImplicitAllSubscription
//{!!! /* }
//
//{
//   * Specify this option if you want to receive notifications on this
//   * subscription when your application is in background.  By default
//   * notifications will be coalesced and and delivered when your
//   * application becomes foreground.
//   }
//  kFNNotifyInBackground
//{!!! /* }
//  );
{!!! /* }


{
 *  FNSubscriptionProcPtr
 *
 *  Discussion:
 *    Callback delivered for directory notifications.
 *
 *  Parameters:
 *
 *    message:
 *      An indication of what happened
 *
 *    flags:
 *      Options about delivery of the notification (typically
 *      kNilOptions)
 *
 *    refcon:
 *      User reference supplied with subscription
 *
 *    subscription:
 *      Subscription corresponding to this notification
 }
//type
//  FNSubscriptionProcPtr = function(message: FNMessage; flags: OptionBits;
//    refcon: Pointer; subscription: FNSubscriptionRef): CALLBACK_API_C; cdecl;
//type
//  FNSubscriptionProcPtr = function(
//    userRoutine: FNSubscriptionProcPtr): STACK_UPP_TYPE; cdecl;

{
 *  DisposeFNSubscriptionUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.1 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Non-Carbon CFM:   available as macro/inline
 }
//procedure DisposeFNSubscriptionUPP(userUPP: FNSubscriptionUPP); cdecl;

{
 *  InvokeFNSubscriptionUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.1 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Non-Carbon CFM:   available as macro/inline
 }
//procedure InvokeFNSubscriptionUPP(message: FNMessage; flags: OptionBits;
//  refcon: Pointer; subscription: FNSubscriptionRef;
//  userUPP: FNSubscriptionUPP); cdecl;

{
 *  FNSubscribe()
 *
 *  Summary:
 *    Subscribe to change notifications for the specified directory.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.1
 *
 *  Parameters:
 *
 *    directoryRef:
 *      Directory for which the caller wants notifications
 *
 *    callback:
 *      Function to call back when a notification arrives
 *
 *    refcon:
 *      User state carried with the subscription
 *
 *    flags:
 *      Options for future use (specify kNilOptions, or one of the
 *      FNSubscriptionOptions)
 *
 *    subscription:
 *      Subscription token for subsequent query or unsubscription
 *
 *  Availability:
 *    Mac OS X:         in version 10.1 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Non-Carbon CFM:   not available
 }
//function FNSubscribe(const directoryRef: PFSRef; callback: FNSubscriptionUPP;
//  refcon: Pointer; flags: OptionBits;
//  subscription: PFNSubscriptionRef): OSStatus; cdecl;


{
 *  FNSubscribeByPath()
 *
 *  Summary:
 *    Subscribe to change notifications for the specified directory.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.1
 *
 *  Parameters:
 *
 *    directoryPath:
 *      Directory for which the caller wants notifications
 *
 *    callback:
 *      Function to call back when a notification arrives
 *
 *    refcon:
 *      User state carried with the subscription
 *
 *    flags:
 *      Options for future use (specify kNilOptions, or one of the
 *      FNSubscriptionOptions)
 *
 *    subscription:
 *      Subscription token for subsequent query or unsubscription
 *
 *  Availability:
 *    Mac OS X:         in version 10.1 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Non-Carbon CFM:   not available
 }
//function FNSubscribeByPath(const directoryPath: PUInt8;
//  callback: FNSubscriptionUPP; refcon: Pointer; flags: OptionBits;
//  subscription: PFNSubscriptionRef): OSStatus; cdecl;


{
 *  FNUnsubscribe()
 *
 *  Summary:
 *    Release a subscription which is no longer needed.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.1
 *
 *  Parameters:
 *
 *    subscription:
 *      Subscription previously returned from FNSubscribe or
 *      FNSubscribeForPath
 *
 *  Availability:
 *    Mac OS X:         in version 10.1 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Non-Carbon CFM:   not available
 }
//function FNUnsubscribe(subscription: FNSubscriptionRef): OSStatus; cdecl;


{
 *  FNGetDirectoryForSubscription()
 *
 *  Summary:
 *    Fetch the directory for which this subscription was originally
 *    entered. There is no path variant because paths are fragile, and
 *    the path may have changed.  If the caller does not care about
 *    this subtlety, she can call FSRefMakePath to get a path from the
 *    returned ref.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.1
 *
 *  Parameters:
 *
 *    subscription:
 *      Subscription previously returned from FNSubscribe or
 *      FNSubscribeForPath
 *
 *    ref:
 *      Directory for which this subscription was created
 *
 *  Availability:
 *    Mac OS X:         in version 10.1 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
 *    Non-Carbon CFM:   not available
 }
//function FNGetDirectoryForSubscription(subscription: FNSubscriptionRef;
//  ref: PFSRef): OSStatus; cdecl;



{ Async Volume Operation Status return values }
//const
//  kAsyncMountInProgress   = 1;
//  kAsyncMountComplete     = 2;
//  kAsyncUnmountInProgress = 3;
//  kAsyncUnmountComplete   = 4;
//  kAsyncEjectInProgress   = 5;
//  kAsyncEjectComplete     = 6;
//
//
//type
//  FSMountStatus = UInt32;
//  FSEjectStatus = UInt32;
//  FSUnmountStatus = UInt32;
//type
//  FSVolumeMountProcPtr = function(volumeOp: FSVolumeOperation;
//    clientData: Pointer; err: OSStatus;
//    mountedVolumeRefNum: FSVolumeRefNum): CALLBACK_API_C; cdecl;
//type
//  FSVolumeUnmountProcPtr = function(volumeOp: FSVolumeOperation;
//    clientData: Pointer; err: OSStatus; volumeRefNum: FSVolumeRefNum;
//    dissenter: pid_t): CALLBACK_API_C; cdecl;
//type
//  FSVolumeEjectProcPtr = function(volumeOp: FSVolumeOperation;
//    clientData: Pointer; err: OSStatus; volumeRefNum: FSVolumeRefNum;
//    dissenter: pid_t): CALLBACK_API_C; cdecl;
//type
//  FSVolumeMountProcPtr = function(
//    p1: FSVolumeUnmountProcPtr): STACK_UPP_TYPE; cdecl;
//type
//  FSVolumeEjectProcPtr = function(
//    userRoutine: FSVolumeMountProcPtr): STACK_UPP_TYPE; cdecl;

{
 *  NewFSVolumeUnmountUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
 *    Non-Carbon CFM:   not available
 }
//function NewFSVolumeUnmountUPP(
//  userRoutine: FSVolumeUnmountProcPtr): FSVolumeUnmountUPP; cdecl;

{
 *  NewFSVolumeEjectUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
 *    Non-Carbon CFM:   not available
 }
//function NewFSVolumeEjectUPP(
//  userRoutine: FSVolumeEjectProcPtr): FSVolumeEjectUPP; cdecl;

{
 *  DisposeFSVolumeMountUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
 *    Non-Carbon CFM:   not available
 }
//procedure DisposeFSVolumeMountUPP(userUPP: FSVolumeMountUPP); cdecl;

{
 *  DisposeFSVolumeUnmountUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
 *    Non-Carbon CFM:   not available
 }
//procedure DisposeFSVolumeUnmountUPP(userUPP: FSVolumeUnmountUPP); cdecl;

{
 *  DisposeFSVolumeEjectUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
 *    Non-Carbon CFM:   not available
 }
//procedure DisposeFSVolumeEjectUPP(userUPP: FSVolumeEjectUPP); cdecl;

{
 *  InvokeFSVolumeMountUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
 *    Non-Carbon CFM:   not available
 }
//procedure InvokeFSVolumeMountUPP(volumeOp: FSVolumeOperation;
//  clientData: Pointer; err: OSStatus; mountedVolumeRefNum: FSVolumeRefNum;
//  userUPP: FSVolumeMountUPP); cdecl;

{
 *  InvokeFSVolumeUnmountUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
 *    Non-Carbon CFM:   not available
 }
//procedure InvokeFSVolumeUnmountUPP(volumeOp: FSVolumeOperation;
//  clientData: Pointer; err: OSStatus; volumeRefNum: FSVolumeRefNum;
//  dissenter: pid_t; userUPP: FSVolumeUnmountUPP); cdecl;

{
 *  InvokeFSVolumeEjectUPP()
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
 *    Non-Carbon CFM:   not available
 }
//procedure InvokeFSVolumeEjectUPP(volumeOp: FSVolumeOperation;
//  clientData: Pointer; err: OSStatus; volumeRefNum: FSVolumeRefNum;
//  dissenter: pid_t; userUPP: FSVolumeEjectUPP); cdecl;

{
 *  Discussion:
 *    Options that can be passed to the FSMountServerVolumeCalls. These
 *    options are not for use with the local volumes.
 }
//type
//  !!! = (
//   * Specify this option if you do want the volume displayed as a stand
//   * along volume in the UI.
//   }
//  kFSMountServerMarkDoNotDisplay
//{!!! /* }
//
//{
//   * Specify this option if you want the volume mounted on the mountdir
//   * passed in instead of in it.
//   }
//  kFSMountServerMountOnMountDir
//{!!! /* }
//  );
//{!!! /* }


{
 *  Discussion:
 *    Deprecated options that can be passed to
 *    FSMountServerVolumeCalls.  The options will have no effect on the
 *    OS version they are noted as deprecated on or later.
 }
//  !!! = (
//   * Specify this option if you do not want other processes notified
//   * that this volume has been mounted.  Deprecated on Mac OS X 10.5.
//   * Use kFSMountServerMarkDoNotDisplay instead.
//   }
//  kFSMountServerMountWithoutNotification
//{!!! /* }
//  );
//{!!! /* }


{
 *  Discussion:
 *    Options that can be passed to the FSEjectVolume calls.
 }
//  !!! = (
//   * Specify this option if you want the volume forcibly ejected.
//   * Force ejecting a volume will very likely result in data loss since
//   * the volume will be ejected even if there are open files on it or
//   * other volumes that share the same device. This option should be
//   * reserved for situations such as the backing store for a volume is
//   * gone (so the data is lost regardless).
//   }
//  kFSEjectVolumeForceEject
//{!!! /* }
//  );
//{!!! /* }


{
 *  Discussion:
 *    Options that can be passed to the FSUnmountVolume calls.
 }
//  !!! = (
//   * Specify this option if you want the volume forcibly unmounted.
//   * Force unmounting a volume will very likely result in data loss
//   * since the volume will be ejected even if there are open files on
//   * it. This option should be reserved for situations such as the
//   * backing store for a volume is gone (so the data is lost
//   * regardless).
//   }
//  kFSUnmountVolumeForceUnmount
//{!!! /* }
//  );
//{!!! /* }

{
 *  FSCreateVolumeOperation()
 *
 *  Discussion:
 *    This routine will return an FSVolumeOperation which can be used
 *    for an async volume operation.  When the operation is completed
 *    the volumeOp should be disposed of to free the memory associated
 *    with the operation using FSDisposeVolumeOperation.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    volumeOp:
 *      The new FSVolumeOperation.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSCreateVolumeOperation(
//  volumeOp: PFSVolumeOperation): OSStatus; cdecl;


{
 *  FSDisposeVolumeOperation()
 *
 *  Discussion:
 *    This routine will release the memory associated with the passed
 *    in volumeOp. It will return paramErr is the volumeOp is in use.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    volumeOp:
 *      The FSVolumeOperation to release.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSDisposeVolumeOperation(
//  volumeOp: FSVolumeOperation): OSStatus; cdecl;


{
 *  FSMountLocalVolumeSync()
 *
 *  Discussion:
 *    This routine will mount the disk specified by diskID at mountDir
 *    (or the default location if mountDir is NULL).  This routine
 *    returns after the mount is complete.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    diskID:
 *      The disk to mount.
 *
 *    mountDir:
 *      Pass in NULL (currently only NULL is supported).
 *
 *    mountedVolumeRefNum:
 *      The volume ref num of the newly mounted volume.
 *
 *    flags:
 *      Options for future use.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSMountLocalVolumeSync(diskID: CFStringRef; mountDir: CFURLRef;
//  mountedVolumeRefNum: PFSVolumeRefNum; flags: OptionBits): OSStatus; cdecl;


{
 *  FSMountLocalVolumeAsync()
 *
 *  Discussion:
 *    This routine will start the process to disk specified by diskID
 *    at mountDir (or the default location if mountDir is NULL).  If a
 *    callback is provided the provided function will be called when
 *    the mount operation is complete.  Once this routine returns noErr
 *    the status of the operation can be found using
 *    FSGetAsyncMountStatus.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    diskID:
 *      The disk to mount.
 *
 *    mountDir:
 *      Pass in NULL (currently only NULL is supported).
 *
 *    volumeOp:
 *      An FSVolumeOperation returned by FSCreateVolumeOperation
 *
 *    clientData:
 *      client data associated with the operation.
 *
 *    flags:
 *      Options for future use.
 *
 *    callback:
 *      Function to call when mount is complete.
 *
 *    runloop:
 *      Runloop to run on.
 *
 *    runloopMode:
 *      Mode for runloop.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSMountLocalVolumeAsync(diskID: CFStringRef; mountDir: CFURLRef;
//  volumeOp: FSVolumeOperation; clientData: Pointer; flags: OptionBits;
//  callback: FSVolumeMountUPP; runloop: CFRunLoopRef;
//  runloopMode: CFStringRef): OSStatus; cdecl;


{
 *  FSMountServerVolumeSync()
 *
 *  Discussion:
 *    This routine will mount the server specified by url at mountDir
 *    (or the default location if mountDir is NULL).  An optional user
 *    and password can be passed in for authentication. If no user or
 *    password is provided then the underlying file system will handle
 *    authentication if required.  This routine returns after the mount
 *    is complete.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    url:
 *      The server to mount.
 *
 *    mountDir:
 *      The directory to mount the server to (default if NULL).
 *
 *    user:
 *      String to pass as user for authentication.
 *
 *    password:
 *      String to pass as password for authenticated log in.
 *
 *    mountedVolumeRefNum:
 *      The volume ref num of the newly mounted volume.
 *
 *    flags:
 *      Options for future use.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSMountServerVolumeSync(url: CFURLRef; mountDir: CFURLRef;
//  user: CFStringRef; password: CFStringRef;
//  mountedVolumeRefNum: PFSVolumeRefNum; flags: OptionBits): OSStatus; cdecl;


{
 *  FSMountServerVolumeAsync()
 *
 *  Discussion:
 *    This routine will start the process to mount the server specified
 *    by url at mountDir (or the default location if mountDir is NULL).
 *     An optional user and password can be passed in for
 *    authentication. If no user or password is provided then the
 *    underlying file system will handle authentication if required.
 *    If a callback is provided the provided function will be called
 *    when the mount operation is complete.  Once this routine returns
 *    noErr the status of the operation can be found using
 *    FSGetAsyncMountStatus.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    url:
 *      The server to mount.
 *
 *    mountDir:
 *      The directory to mount the server to (default if NULL).
 *
 *    user:
 *      String to pass as user for authentication.
 *
 *    password:
 *      String to pass as password for authenticated log in.
 *
 *    volumeOp:
 *      An FSVolumeOperation returned by FSCreateVolumeOperation
 *
 *    clientData:
 *      client data associated with the operation.
 *
 *    flags:
 *      Options for future use.
 *
 *    callback:
 *      Function to call when mount is complete.
 *
 *    runloop:
 *      Runloop run on.
 *
 *    runloopMode:
 *      Mode for runloop.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSMountServerVolumeAsync(url: CFURLRef; mountDir: CFURLRef;
//  user: CFStringRef; password: CFStringRef; volumeOp: FSVolumeOperation;
//  clientData: Pointer; flags: OptionBits; callback: FSVolumeMountUPP;
//  runloop: CFRunLoopRef; runloopMode: CFStringRef): OSStatus; cdecl;


{
 *  FSGetAsyncMountStatus()
 *
 *  Discussion:
 *    This routine returns the current status of an asynchronous mount
 *    operation. A return value of noErr signifies that the status
 *    parameter has been filled with valid information.  If the status
 *    is kAsyncMountComplete then the rest of data returned is valid.
 *    If the status is anything else then the volumeOpStatus and
 *    mountedVolumeRefNum parameters are invalid (The clientData will
 *    be ok).
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    volumeOp:
 *      The async volume operation to get status about.
 *
 *    status:
 *      The status of the operation.
 *
 *    volumeOpStatus:
 *      If status is kAsyncMountComplete then this contains the
 *      OSStatus for the operation.
 *
 *    mountedVolumeRefNum:
 *      If status is kAsyncMountComplete and volumeOpStatus is noErr
 *      then this is the volume ref num for the newly mounted volume.
 *
 *    clientData:
 *      client data associated with the original
 *      FSMountServerVolumeAsync operation.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSGetAsyncMountStatus(volumeOp: FSVolumeOperation;
//  status: PFSMountStatus; volumeOpStatus: POSStatus;
//  mountedVolumeRefNum: PFSVolumeRefNum; clientData: PPVOID): OSStatus; cdecl;



{
 *  FSUnmountVolumeSync()
 *
 *  Discussion:
 *    This routine unmounts the volume specified by vRefNum.  If the
 *    volume cannot be unmounted the pid of the process which denied
 *    the unmount will be returned in the dissenter parameter.  This
 *    routine returns after the unmount is complete.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    vRefNum:
 *      The volume reference number of the volume to unmount.
 *
 *    flags:
 *      Options for future use.
 *
 *    dissenter:
 *      pid of the process which denied the unmount if the unmount is
 *      denied.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSUnmountVolumeSync(vRefNum: FSVolumeRefNum; flags: OptionBits;
//  dissenter: Ppid_t): OSStatus; cdecl;


{
 *  FSUnmountVolumeAsync()
 *
 *  Discussion:
 *    This routine starts the process of unmounting the volume
 *    specified by vRefNum. If a callback is provided the provided
 *    function will be called when the unmount operation is complete.
 *    Once this routine returns noErr the status of the operation can
 *    be found using FSGetAsyncUnmountStatus.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    vRefNum:
 *      The volume reference number of the volume to unmount.
 *
 *    flags:
 *      Options for future use.
 *
 *    volumeOp:
 *      An FSVolumeOperation returned by FSCreateVolumeOperation
 *
 *    clientData:
 *      client data associated with the operation.
 *
 *    callback:
 *      Function to call when unmount is complete.
 *
 *    runloop:
 *      Runloop to run on.
 *
 *    runloopMode:
 *      Mode for runloop.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSUnmountVolumeAsync(vRefNum: FSVolumeRefNum; flags: OptionBits;
//  volumeOp: FSVolumeOperation; clientData: Pointer;
//  callback: FSVolumeUnmountUPP; runloop: CFRunLoopRef;
//  runloopMode: CFStringRef): OSStatus; cdecl;


{
 *  FSGetAsyncUnmountStatus()
 *
 *  Discussion:
 *    This routine returns the current status of an asynchronous
 *    unmount operation. A return value of noErr signifies that the
 *    status parameter has been filled with valid information.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    volumeOp:
 *      The async volume operation to get status about.
 *
 *    status:
 *      The status of the operation.
 *
 *    volumeOpStatus:
 *      If status is kAsyncUnmountComplete then this contains the
 *      OSStatus for the operation.
 *
 *    volumeRefNum:
 *      volume reference number of volume being unmounted.
 *
 *    dissenter:
 *      pid of the process which denied the unmount if the unmount is
 *      denied.
 *
 *    clientData:
 *      client data associated with the original
 *      FSMountServerVolumeAsync operation.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSGetAsyncUnmountStatus(volumeOp: FSVolumeOperation;
//  status: PFSUnmountStatus; volumeOpStatus: POSStatus;
//  volumeRefNum: PFSVolumeRefNum; dissenter: Ppid_t;
//  clientData: PPVOID): OSStatus; cdecl;


{
 *  FSCancelVolumeOperation()
 *
 *  Discussion:
 *    This routine will cancel and outstanding asynchronous volume
 *    mounting operation. It currently is only supported for server
 *    mounts.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    volumeOp:
 *      The async volume operation to cancel.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSCancelVolumeOperation(volumeOp: FSVolumeOperation): OSStatus; cdecl;


{
 *  FSEjectVolumeSync()
 *
 *  Discussion:
 *    This routine ejects the volume specified by vRefNum.  If the
 *    volume cannot be ejected the pid of the process which denied the
 *    unmount will be returned in the dissenter parameter.  This
 *    routine returns after the eject is complete.  Ejecting a volume
 *    will result in the unmounting of other volumes on the same device.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    vRefNum:
 *      The volume reference number of the volume to eject.
 *
 *    flags:
 *      Options for future use.
 *
 *    dissenter:
 *      pid of the process which denied the unmount if the eject is
 *      denied.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSEjectVolumeSync(vRefNum: FSVolumeRefNum; flags: OptionBits;
//  dissenter: Ppid_t): OSStatus; cdecl;


{
 *  FSEjectVolumeAsync()
 *
 *  Discussion:
 *    This routine starts the process of ejecting the volume specified
 *    by vRefNum. If a callback is provided the provided function will
 *    be called when the eject operation is complete.  Once this
 *    routine returns noErr the status of the operation can be found
 *    using FSGetAsyncEjectStatus.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    vRefNum:
 *      The volume reference number of the volume to eject.
 *
 *    flags:
 *      Options for future use.
 *
 *    volumeOp:
 *      An FSVolumeOperation returned by FSCreateVolumeOperation
 *
 *    clientData:
 *      client data associated with the operation.
 *
 *    callback:
 *      Function to call when eject is complete.
 *
 *    runloop:
 *      Runloop to run on.
 *
 *    runloopMode:
 *      Mode for runloop.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSEjectVolumeAsync(vRefNum: FSVolumeRefNum; flags: OptionBits;
//  volumeOp: FSVolumeOperation; clientData: Pointer; callback: FSVolumeEjectUPP;
//  runloop: CFRunLoopRef; runloopMode: CFStringRef): OSStatus; cdecl;


{
 *  FSGetAsyncEjectStatus()
 *
 *  Discussion:
 *    This routine returns the current status of an asynchronous eject
 *    operation. A return value of noErr signifies that the status
 *    parameter has been filled with valid information.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    volumeOp:
 *      The async volume operation to get status about.
 *
 *    status:
 *      The status of the operation.
 *
 *    volumeOpStatus:
 *      If status is kAsyncEjectComplete then this contains the
 *      OSStatus for the operation.
 *
 *    volumeRefNum:
 *      volume reference number of volume being ejected.
 *
 *    dissenter:
 *      pid of the process which denied the unmount if the eject is
 *      denied.
 *
 *    clientData:
 *      client data associated with the original
 *      FSMountServerVolumeAsync operation.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSGetAsyncEjectStatus(volumeOp: FSVolumeOperation;
//  status: PFSEjectStatus; volumeOpStatus: POSStatus;
//  volumeRefNum: PFSVolumeRefNum; dissenter: Ppid_t;
//  clientData: PPVOID): OSStatus; cdecl;


{
 *  FSCopyDiskIDForVolume()
 *
 *  Discussion:
 *    This routine returns a copy of the diskID for the passed in
 *    volume.  The caller is responsible for releasing the CFString
 *    later.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *
 *  Parameters:
 *
 *    vRefNum:
 *      FSVolumeRefNum of the target volume.
 *
 *    diskID:
 *      The diskID string associated with the target volume.
 *
 *  Availability:
 *    Mac OS X:         in version 10.2 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSCopyDiskIDForVolume(vRefNum: FSVolumeRefNum;
//  diskID: PCFStringRef): OSStatus; cdecl;


{
 *  FSCopyURLForVolume()
 *
 *  Discussion:
 *    This routine returns a copy of the url for the passed in volume.
 *    The caller is responsible for releasing the CFURL later.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *
 *  Parameters:
 *
 *    vRefNum:
 *      FSVolumeRefNum of the target volume.
 *
 *    url:
 *      The url associated with the target volume.
 *
 *  Availability:
 *    Mac OS X:         in version 10.3 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSCopyURLForVolume(vRefNum: FSVolumeRefNum;
//  url: PCFURLRef): OSStatus; cdecl;


{
 *  FSGetVolumeForDiskID()
 *
 *  Discussion:
 *    This routine returnes the FSVolumeRefNum for a given diskID.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    diskID:
 *      The diskID string associated with the target volume.
 *
 *    vRefNum:
 *      FSVolumeRefNum of the volume which corresponds to the diskID.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSGetVolumeForDiskID(diskID: CFStringRef;
//  vRefNum: PFSVolumeRefNum): OSStatus; cdecl;


{
 *  FSCopyDADiskForVolume()
 *
 *  Discussion:
 *    This routine returns a copy of the diskID for the passed in
 *    volume.  The caller is responsible for releasing the CFString
 *    later.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    vRefNum:
 *      FSVolumeRefNum of the target volume.
 *
 *    disk:
 *      The DADisk associated with the target volume.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSCopyDADiskForVolume(vRefNum: FSVolumeRefNum;
//  disk: PDADiskRef): OSStatus; cdecl;


{
 *  FSGetVolumeForDADisk()
 *
 *  Discussion:
 *    This routine returns the FSVolumeRefNum associated with the
 *    volume referenced by the passed in DADiskRef.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    disk:
 *      The DADiskRef of the target volume.
 *
 *    vRefNum:
 *      FSVolumeRefNum of the volume which corresponds to the DADiskRef.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSGetVolumeForDADisk(disk: DADiskRef;
//  vRefNum: PFSVolumeRefNum): OSStatus; cdecl;


{ File Operation routines }

//type
//  FSFileOperationStage = UInt32;
//
//{
// *  FSFileOperationClientContext
// *
// *  Discussion:
// *    Structure containing the user-defined data and callbacks for
// *    FSFileOperation client contextual data.
// }
//  FSFileOperationClientContext = record
//   * The version number of the structure type being passed in as a
//   * parameter to FSCopyObjectAsync or FSMoveObjectAsync function.
//   * Valid version number is currently 0.
//   }
//    version: CFIndex;
//
//{
//   * An arbitrary pointer to client-defined data, which can be
//   * associated with the operation and is passed to the callbacks.
//   }
//    info: Pointer;
//
//{
//   * The callback used to add a retain for the operation on the info
//   * pointer for the life of the operation, and may be used for
//   * temporary references the operation needs to take. This callback
//   * returns the actual info pointer to store in the operation, almost
//   * always just the pointer passed as the parameter.
//   }
//    retain: CFAllocatorRetainCallBack;
//
//{
//   * The callback used to remove a retain previously added for the
//   * operation on the info pointer.
//   }
//    release: CFAllocatorReleaseCallBack;
//
//{
//   * The callback used to create a descriptive string representation of
//   * the info pointer (or the data pointed to by the info pointer) for
//   * debugging purposes. This is used by the CFCopyDescription()
//   * function.
//   }
//    copyDescription: CFAllocatorCopyDescriptionCallBack;
//  end;

{
 *  FSFileOperationStatusProcPtr
 *
 *  Discussion:
 *    Callback function which is called to return status of an
 *    operation.  It will be called when an operation changes stages
 *    (including failing due to an error) or as updated information is
 *    available limited by the statusChangeInterval of the operation.
 *
 *  Parameters:
 *
 *    fileOp:
 *      Operation receiving the callback.
 *
 *    currentItem:
 *      FSRef to item operation is currently processing.  If the
 *      operation is complete then currentItem refers to the target
 *      item (the new item corresponding to the source item in the
 *      destination directory).
 *
 *    stage:
 *      Current stage of the operation.
 *
 *    error:
 *      Either noErr or an error value which caused the operation to
 *      fail.
 *
 *    statusDictionary:
 *      A CFDictionary with more detailed status information.  The
 *      caller should not release this item.  If the item is needed
 *      beyond the scope of the callback then it needs to be copied.
 *
 *    info:
 *      The info pointer passed in by the client.
 }
//type
//  FSFileOperationStatusProcPtr = function(fileOp: FSFileOperationRef;
//    const currentItem: PFSRef; stage: FSFileOperationStage; error: OSStatus;
//    statusDictionary: CFDictionaryRef; info: Pointer): CALLBACK_API_C; cdecl;

{
 *  FSPathFileOperationStatusProcPtr
 *
 *  Discussion:
 *    Callback function which is called to return status of an
 *    operation.  It will be called when an operation changes stages
 *    (including failing due to an error) or as updated information is
 *    available limited by the statusChangeInterval of the operation.
 *
 *  Parameters:
 *
 *    fileOp:
 *      Operation receiving the callback.
 *
 *    currentItem:
 *      The UTF-8 path for the item operation is currently processing.
 *      The caller should not release this item.  If the item is needed
 *      beyond the scope of the callback then it needs to be copied.
 *      If the operation is complete then currentItem refers to the
 *      target item (the new item corresponding to the source item in
 *      the destination directory).
 *
 *    stage:
 *      Current stage of the operation.
 *
 *    error:
 *      Either noErr or an error value which caused the operation to
 *      fail.
 *
 *    statusDictionary:
 *      A CFDictionary with more detailed status information.  The
 *      caller should not release this item.  If the item is needed
 *      beyond the scope of the callback then it needs to be copied.
 *
 *    info:
 *      The info pointer passed in by the client.
 }
//type
//  FSPathFileOperationStatusProcPtr = function(fileOp: FSFileOperationRef;
//    const currentItem: PChar; stage: FSFileOperationStage; error: OSStatus;
//    statusDictionary: CFDictionaryRef; info: Pointer): CALLBACK_API_C; cdecl;

{
 *  FSFileOperationOptions
 *
 *  Discussion:
 *    Set of flags that can be passed into an FSMoveObject(A)sync or
 *    FSCopyObject(A)sync call.
 }
const
  kFSFileOperationDefaultOptions             = 0;

{
   * Replace an item in the destDir that has the same name as an item
   * being moved/copied there.
   }
  kFSFileOperationOverwrite                  = $01;

{
   * Skip items that cannot be read and continue copying/moving instead
   * of failing the operation.
   }
  kFSFileOperationSkipSourcePermissionErrors = $02;

{
   * Do not perform a copy/delete to move an item across volume
   * boundries - fail the operation instead.
   }
  kFSFileOperationDoNotMoveAcrossVolumes     = $04;

{
   * Skip the preflight for a directory move/copy.  This will limit the
   * status information that can be returned since the totals will not
   * be calculated.
   }
  kFSFileOperationSkipPreflight              = $08;


{
 *  FSFileOperationStage
 *
 *  Discussion:
 *    The stage corresponds to the state of an asynchronous File
 *    Operation.  The stage is reported in the operation's status
 *    callback or as part of an FSFileOperationCopyStatus call.
 }
const
  kFSOperationStageUndefined    = 0;

{
   * Operation is calulating sizes and number of items involved in the
   * operation.
   }
  kFSOperationStagePreflighting = 1;

{
   * Operation is in progress.
   }
  kFSOperationStageRunning      = 2;

{
   * Operation is done.
   }
  kFSOperationStageComplete     = 3;

{ FSFileOperation status dictionary keys }
{
 *  kFSOperationTotalBytesKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the total number of bytes that will be moved/copied by
 *    this operation as a CFNumber.  This value is not available for a
 *    directory operation if kFSFileOperationSkipPreflight was
 *    specified.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationBytesCompleteKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the number of bytes that have been moved/copied by this
 *    operation at the time the status call was made as a CFNumber.
 *    During the preflight stage this value represents the currently
 *    known number of bytes that will be copied/moved.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationBytesRemainingKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the number of bytes that remain to be moved/copied by
 *    this operation at the time the status call was made as a
 *    CFNumber.  This value is not available for a directory operation
 *    if kFSFileOperationSkipPreflight was specified.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationTotalObjectsKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the total number of objects that will be moved/copied by
 *    this operation as a CFNumber.  This value is not available for a
 *    directory operation if kFSFileOperationSkipPreflight was
 *    specified.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationObjectsCompleteKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the number of objects that have been moved/copied by this
 *    operation at the time the status call was made as a CFNumber.
 *    During the preflight stage this value represents the currently
 *    known number of objects that will be copied/moved.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationObjectsRemainingKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the number of objects that remain to be moved/copied by
 *    this operation at the time the status call was made as a
 *    CFNumber.  This value is not available for a directory operation
 *    if kFSFileOperationSkipPreflight was specified.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationTotalUserVisibleObjectsKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the total number of user visibleobjects that will be
 *    moved/copied by this operation as a CFNumber.  This value is not
 *    available for a directory operation if
 *    kFSFileOperationSkipPreflight was specified.  A packaged
 *    application is one user visible object even though it is made up
 *    of multiple files and directories.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationUserVisibleObjectsCompleteKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the number of user visible objects that have been
 *    moved/copied by this operation at the time the status call was
 *    made as a CFNumber.  During the preflight stage this value
 *    represents the currently known number of objects that will be
 *    copied/moved.  A packaged application is one user visible object
 *    even though it is made up of multiple files and directories.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationUserVisibleObjectsRemainingKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the number of user visible objects that remain to be
 *    moved/copied by this operation at the time the status call was
 *    made as a CFNumber.  This value is not available for a directory
 *    operation if kFSFileOperationSkipPreflight was specified.  A
 *    packaged application is one user visible object even though it is
 *    made up of multiple files and directories.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  kFSOperationThroughputKey
 *
 *  Discussion:
 *    This value associated with this key in a status dictionary
 *    returns the current throughput for the operation in bytes per
 *    second as a CFNumber.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{
 *  FSCopyObjectSync()
 *
 *  Discussion:
 *    This routine will copy the source object into the destination
 *    directory.  The source object can be a file or directory.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    source:
 *      The source object to copy.
 *
 *    destDir:
 *      The destination directory for the copy.
 *
 *    destName:
 *      The name for the new object in the destination directory.  Pass
 *      NULL to use the source object name.
 *
 *    target:
 *      Upon successful completion a ref to the newly created object.
 *      If source is a directory then target will be the corresponding
 *      object in the destination directory.
 *
 *    options:
 *      One or more FSFileOperation flags
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSCopyObjectSync(const source: PFSRef; const destDir: PFSRef;
//  destName: CFStringRef; target: PFSRef; options: OptionBits): OSStatus; cdecl;


{
 *  FSMoveObjectSync()
 *
 *  Discussion:
 *    This routine will move the source object into the destination
 *    directory.  The source object can be a file or directory.  If a
 *    destName is provided then the object will be renamed as well as
 *    moved.  By default a move across volumes will result in a copy
 *    and deletion of the original source.  The
 *    kFSFileOperationDoNotMoveAcrossVolumes flag will cause cross
 *    volume moves to do nothing and return an error.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    source:
 *      The source object to move.
 *
 *    destDir:
 *      The destination directory for the move.
 *
 *    destName:
 *      The name for the object in the destination directory.  Pass
 *      NULL to use the source object name.
 *
 *    target:
 *      Upon successful completion a ref to the object in its new
 *      location.  If source is a directory then target will be the
 *      corresponding object in the destination directory.
 *
 *    options:
 *      One or more FSFileOperation flags
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
////function FSMoveObjectSync(const source: PFSRef; const destDir: PFSRef;
//  destName: CFStringRef; target: PFSRef; options: OptionBits): OSStatus; cdecl;


{
 *  FSMoveObjectToTrashSync()
 *
 *  Discussion:
 *    This routine will move the source object into the trash.  The
 *    source object can be a file or directory.  If the volume the
 *    source object resides on does not support a trash folder then
 *    this call will return an error (this is the same circumstance
 *    that triggers the delete immediately behavior in the Finder).
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    source:
 *      The source object to move to the trash.
 *
 *    target:
 *      Upon successful completion a ref the object in the trash.  If
 *      source is a directory then target will be the corresponding
 *      object in the destination directory.
 *
 *    options:
 *      One or more FSFileOperation flags
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
////function FSMoveObjectToTrashSync(const source: PFSRef; target: PFSRef;
//  options: OptionBits): OSStatus; cdecl;


{
 *  FSPathCopyObjectSync()
 *
 *  Discussion:
 *    This routine will copy the source object into the destination
 *    directory.  The source object can be a file or directory.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    sourcePath:
 *      The UTF-8 path string of the source object to copy.
 *
 *    destDirPath:
 *      The UTF-8 path of the destination directory for the copy.
 *
 *    destName:
 *      The name for the new object in the destination directory.  Pass
 *      NULL to use the source object name.
 *
 *    targetPath:
 *      A pointer to a char * to allow returning the path to the newly
 *      created object.  The path is allocated using malloc and it is
 *      the caller's responsibility to free.  The pointer will be set
 *      to NULL if the copy failed.
 *
 *    options:
 *      One or more FSFileOperation flags
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
////function FSPathCopyObjectSync(const sourcePath: PChar; const destDirPath: PChar;
//  destName: CFStringRef; targetPath: PPChar;
//  options: OptionBits): OSStatus; cdecl;


{
 *  FSPathMoveObjectSync()
 *
 *  Discussion:
 *    This routine will move the source object into the destination
 *    directory.  The source object can be a file or directory.  If a
 *    destName is provided then the object will be renamed as well as
 *    moved.  By default a move across volumes will result in a copy
 *    and deletion of the original source.  The
 *    kFSFileOperationDoNotMoveAcrossVolumes flag will cause cross
 *    volume moves to do nothing and return an error.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    sourcePath:
 *      The UTF-8 path string of the source object to move.
 *
 *    destDirPath:
 *      The UTF-8 path of the destination directory for the move.
 *
 *    destName:
 *      The name for the moved object in the destination directory.
 *      Pass NULL to use the source object name.
 *
 *    targetPath:
 *      A pointer to a char * to allow returning the path to the newly
 *      created object.  The path is allocated using malloc and it is
 *      the caller's responsibility to free.  The pointer will be set
 *      to NULL if the move failed.
 *
 *    options:
 *      One or more FSFileOperation flags
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSPathMoveObjectSync(const sourcePath: PChar; const destDirPath: PChar;
//  destName: CFStringRef; targetPath: PPChar;
//  options: OptionBits): OSStatus; cdecl;


{
 *  FSPathMoveObjectToTrashSync()
 *
 *  Discussion:
 *    This routine will move the source object into the trash.  The
 *    source object can be a file or directory.  If the volume the
 *    source object resides on does not support a trash folder then
 *    this call will return an error (this is the same circumstance
 *    that triggers the delete immediately behavior in the Finder).
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    sourcePath:
 *      The UTF-8 path string of the source object to move.
 *
 *    targetPath:
 *      A pointer to a char * to allow returning the path to the newly
 *      created object.  The path is allocated using malloc and it is
 *      the caller's responsibility to free.  The pointer will be set
 *      to NULL if the move failed.
 *
 *    options:
 *      One or more FSFileOperation flags
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function FSPathMoveObjectToTrashSync(const sourcePath: PChar;
//  targetPath: PPChar; options: OptionBits): OSStatus; cdecl;


{
 *  FSFileOperationGetTypeID()
 *
 *  Discussion:
 *    This routine will return the CFTypeID for the FSFileOpeation type.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Result:
 *    the CFTypeID for the FSFileOperation type.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileOperationGetTypeID: CFTypeID; cdecl;


{
 *  FSFileOperationCreate()
 *
 *  Discussion:
 *    This routine will create an FSFileOperation for use with either
 *    FSCopyObjectAsync or FSMoveObjectAsync.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    alloc:
 *      The CFAllocator to use.  Pass NULL for the default allocator.
 *
 *  Result:
 *    A reference to the newly created object or NULL if the creation
 *    failed.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileOperationCreate(
//  alloc: CFAllocatorRef): FSFileOperationRef; cdecl;


{
 *  FSFileOperationScheduleWithRunLoop()
 *
 *  Discussion:
 *    Schedule the given operation on the specified runloop and mode. A
 *    FSFileOperation can be scheduled on multiple runloop/mode
 *    combinations. An opertion must be scheduled on at least one
 *    runloop.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation to schedule.
 *
 *    runLoop:
 *      The runLoop on which to schedule the operation.  Must be
 *      non-NULL.
 *
 *    runLoopMode:
 *      The mode on which to schedule the operation.  Must be non-NULL.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileOperationScheduleWithRunLoop(fileOp: FSFileOperationRef;
//  runLoop: CFRunLoopRef; runLoopMode: CFStringRef): OSStatus; cdecl;


{
 *  FSFileOperationUnscheduleFromRunLoop()
 *
 *  Discussion:
 *    Unschedule the given operation from the specified runloop and
 *    mode.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation to unschedule.
 *
 *    runLoop:
 *      The runLoop from which to unschedule the operation.  Must be
 *      non-NULL.
 *
 *    runLoopMode:
 *      The mode from which to unschedule the operation.  Must be
 *      non-NULL.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileOperationUnscheduleFromRunLoop(fileOp: FSFileOperationRef;
//  runLoop: CFRunLoopRef; runLoopMode: CFStringRef): OSStatus; cdecl;


{
 *  FSCopyObjectAsync()
 *
 *  Discussion:
 *    This routine will start an asynchronous copy of the object
 *    specified by source to the directory specified by destDir.  If
 *    destName is provided then the new object will be renamed to
 *    destName.  If destName is not provided then the name of the
 *    source object will be used.  Status callbacks will occur on one
 *    of the runloop/mode combinations that the operation was scheduled
 *    on (and is running).
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation object created for this operation.
 *
 *    source:
 *      The source object to copy.
 *
 *    destDir:
 *      The destination directory for the copy.
 *
 *    destName:
 *      The name for the new object in the destination directory.  Pass
 *      NULL to use the source object name.
 *
 *    flags:
 *      One or more FSFileOperation flags
 *
 *    callback:
 *      An optional FSFileOperationStatusProcPtr which will be called
 *      with status updates as the copy proceeds.
 *
 *    statusChangeInterval:
 *      The minimum time between callbacks within a single stage of an
 *      operation.
 *
 *    clientContext:
 *      Client contextual information to associate with this operation.
 *       The info pointer will be passed to status callbacks.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSCopyObjectAsync(fileOp: FSFileOperationRef; const source: PFSRef;
//  const destDir: PFSRef; destName: CFStringRef; flags: OptionBits;
//  callback: FSFileOperationStatusProcPtr; statusChangeInterval: CFTimeInterval;
//  clientContext: PFSFileOperationClientContext): OSStatus; cdecl;


{
 *  FSMoveObjectAsync()
 *
 *  Discussion:
 *    This routine will start an asynchronous move of the object
 *    specified by source to the directory specified by destDir.  If
 *    destName is provided then the new object will be renamed to
 *    destName.  If destName is not provided then the name of the
 *    source object will be used.  Status callbacks will occur on one
 *    of the runloop/mode combinations that the operation was scheduled
 *    on (and is running).  By default a move across volumes will
 *    result in a copy and deletion of the original source. The
 *    kFSFileOperationDoNotMoveAcrossVolumes flag will cause cross
 *    volume moves to do nothing and return an error.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation object created for this operation.
 *
 *    source:
 *      The source object to move.
 *
 *    destDir:
 *      The destination directory for the move.
 *
 *    destName:
 *      The name for the object in the destination directory.  Pass
 *      NULL to leave the name unchanged.
 *
 *    flags:
 *      One or more FSFileOperation flags
 *
 *    callback:
 *      An optional FSFileOperationStatusProcPtr which will be called
 *      with status updates as the copy proceeds.
 *
 *    statusChangeInterval:
 *      The minimum time between callbacks within a single stage of an
 *      operation.
 *
 *    clientContext:
 *      Client contextual information to associate with this operation.
 *       The info pointer will be passed to status callbacks.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSMoveObjectAsync(fileOp: FSFileOperationRef; const source: PFSRef;
//  const destDir: PFSRef; destName: CFStringRef; flags: OptionBits;
//  callback: FSFileOperationStatusProcPtr; statusChangeInterval: CFTimeInterval;
//  clientContext: PFSFileOperationClientContext): OSStatus; cdecl;


{
 *  FSMoveObjectToTrashAsync()
 *
 *  Discussion:
 *    This routine will start an asynchronous move of the object
 *    specified by source to the trash.  If the volume the source
 *    object resides on does not support a trash folder then the
 *    operation will return an error (this is the same circumstance
 *    that triggers the delete immediately behavior in the Finder).
 *    Status callbacks will occur on one of the runloop/mode
 *    combinations that the operation was scheduled on (and is
 *    running).   Upon successul complettion of the operation the last
 *    currentItem (from either the last status callback or retrieved by
 *    FSFileOperationCopyStatus) will be object in the trash.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation object created for this operation.
 *
 *    source:
 *      The source object to move.
 *
 *    flags:
 *      One or more FSFileOperation flags
 *
 *    callback:
 *      An optional FSFileOperationStatusProcPtr which will be called
 *      with status updates as the move proceeds.
 *
 *    statusChangeInterval:
 *      The minimum time between callbacks within a single stage of an
 *      operation.
 *
 *    clientContext:
 *      Client contextual information to associate with this operation.
 *       The info pointer will be passed to status callbacks.
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function FSMoveObjectToTrashAsync(fileOp: FSFileOperationRef;
//  const source: PFSRef; flags: OptionBits;
//  callback: FSFileOperationStatusProcPtr; statusChangeInterval: CFTimeInterval;
//  clientContext: PFSFileOperationClientContext): OSStatus; cdecl;


{
 *  FSPathCopyObjectAsync()
 *
 *  Discussion:
 *    This routine will start an asynchronous copy of the object
 *    specified by source to the directory specified by destDir.  If
 *    destName is provided then the new object will be renamed to
 *    destName.  If destName is not provided then the name of the
 *    source object will be used.  Status callbacks will occur on one
 *    of the runloop/mode combinations that the operation was scheduled
 *    on (and is running).
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation object created for this operation.
 *
 *    sourcePath:
 *      The UTF-8 path string of the source object to copy.
 *
 *    destDirPath:
 *      The UTF-8 path of the destination directory for the copy.
 *
 *    destName:
 *      The name for the new object in the destination directory.  Pass
 *      NULL to use the source object name.
 *
 *    flags:
 *      One or more FSFileOperation flags
 *
 *    callback:
 *      An optional FSPathFileOperationStatusProcPtr which will be
 *      called with status updates as the copy proceeds.
 *
 *    statusChangeInterval:
 *      The minimum time between callbacks within a single stage of an
 *      operation.
 *
 *    clientContext:
 *      Client contextual information to associate with this operation.
 *       The info pointer will be passed to status callbacks.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSPathCopyObjectAsync(fileOp: FSFileOperationRef;
//  const sourcePath: PChar; const destDirPath: PChar; destName: CFStringRef;
//  flags: OptionBits; callback: FSPathFileOperationStatusProcPtr;
//  statusChangeInterval: CFTimeInterval;
//  clientContext: PFSFileOperationClientContext): OSStatus; cdecl;


{
 *  FSPathMoveObjectAsync()
 *
 *  Discussion:
 *    This routine will start an asynchronous move of the object
 *    specified by source to the directory specified by destDir.  If
 *    destName is provided then the new object will be renamed to
 *    destName.  If destName is not provided then the name of the
 *    source object will be used.  Status callbacks will occur on one
 *    of the runloop/mode combinations that the operation was scheduled
 *    on (and is running).  By default a move across volumes will
 *    result in a copy and deletion of the original source. The
 *    kFSFileOperationDoNotMoveAcrossVolumes flag will cause cross
 *    volume moves to do nothing and return an error.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation object created for this operation.
 *
 *    sourcePath:
 *      The UTF-8 path string of the source object to move.
 *
 *    destDirPath:
 *      The UTF-8 path of the destination directory for the move.
 *
 *    destName:
 *      The name for the object in the destination directory.  Pass
 *      NULL to leave the name unchanged.
 *
 *    flags:
 *      One or more FSFileOperation flags
 *
 *    callback:
 *      An optional FSPathFileOperationStatusProcPtr which will be
 *      called with status updates as the move proceeds.
 *
 *    statusChangeInterval:
 *      The minimum time between callbacks within a single stage of an
 *      operation.
 *
 *    clientContext:
 *      Client contextual information to associate with this operation.
 *       The info pointer will be passed to status callbacks.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSPathMoveObjectAsync(fileOp: FSFileOperationRef;
//  const sourcePath: PChar; const destDirPath: PChar; destName: CFStringRef;
//  flags: OptionBits; callback: FSPathFileOperationStatusProcPtr;
//  statusChangeInterval: CFTimeInterval;
//  clientContext: PFSFileOperationClientContext): OSStatus; cdecl;


{
 *  FSPathMoveObjectToTrashAsync()
 *
 *  Discussion:
 *    This routine will start an asynchronous move of the object
 *    specified by source to the trash.  If the volume the source
 *    object resides on does not support a trash folder then this call
 *    will return an error (this is the same circumstance that triggers
 *    the delete immediately behavior in the Finder). Status callbacks
 *    will occur on one of the runloop/mode combinations that the
 *    operation was scheduled on (and is running).  Note that the
 *    object may be renamed when placed in the trash.  Upon successful
 *    completion of the operation the last currentItem (from either the
 *    last status callback or retrieved by
 *    FSPathFileOperationCopyStatus) will be object in the trash.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation object created for this operation.
 *
 *    sourcePath:
 *      The UTF-8 path string of the source object to move.
 *
 *    flags:
 *      One or more FSFileOperation flags
 *
 *    callback:
 *      An optional FSPathFileOperationStatusProcPtr which will be
 *      called with status updates as the move proceeds.
 *
 *    statusChangeInterval:
 *      The minimum time between callbacks within a single stage of an
 *      operation.
 *
 *    clientContext:
 *      Client contextual information to associate with this operation.
 *       The info pointer will be passed to status callbacks.
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available
 *    Non-Carbon CFM:   not available
 }
//function FSPathMoveObjectToTrashAsync(fileOp: FSFileOperationRef;
//  const sourcePath: PChar; flags: OptionBits;
//  callback: FSPathFileOperationStatusProcPtr;
//  statusChangeInterval: CFTimeInterval;
//  clientContext: PFSFileOperationClientContext): OSStatus; cdecl;


{
 *  FSFileOperationCancel()
 *
 *  Discussion:
 *    Cancels the specified FSFileOperation. This makes the operation
 *    ineligible to run on any runloop.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation to cancel.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileOperationCancel(fileOp: FSFileOperationRef): OSStatus; cdecl;


{
 *  FSFileOperationCopyStatus()
 *
 *  Discussion:
 *    This routine returns the current status of an FSFileOperation.
 *    The status dictionary must be released by the caller.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation from which to retrieve status information.
 *
 *    currentItem:
 *      FSRef to item operation is currently processing.  If the
 *      operation is complete then currentItem refers to the target
 *      item (the new item corresponding to the source item in the
 *      destination directory).
 *
 *    stage:
 *      current stage of the operation.
 *
 *    error:
 *      Either noErr or an error value which caused the operation to
 *      fail.
 *
 *    statusDictionary:
 *      A CFDictionary with more detailed status information. The
 *      caller is responsible for releasing the object when done with
 *      it.
 *
 *    info:
 *      The info pointer passed in by the client.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileOperationCopyStatus(fileOp: FSFileOperationRef;
//  currentItem: PFSRef; stage: PFSFileOperationStage; error: POSStatus;
//  statusDictionary: PCFDictionaryRef; info: PPVOID): OSStatus; cdecl;


{
 *  FSPathFileOperationCopyStatus()
 *
 *  Discussion:
 *    This routine returns the current status of an FSFileOperation.
 *    The status dictionary must be released by the caller.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileOp:
 *      The FSFileOperation from which to retrieve status information.
 *
 *    currentItem:
 *      A path to the item operation is currently processing.  The
 *      caller is responsible for calling free to dispose of the path
 *      string.  If the operation is complete then currentItem refers
 *      to the target item (the new item corresponding to the source
 *      item in the destination directory).
 *
 *    stage:
 *      current stage of the operation.
 *
 *    error:
 *      Either noErr or an error value which caused the operation to
 *      fail.
 *
 *    statusDictionary:
 *      A CFDictionary with more detailed status information.  The
 *      caller is responsible for releasing the object when done with
 *      it.
 *
 *    info:
 *      The info pointer passed in by the client.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSPathFileOperationCopyStatus(fileOp: FSFileOperationRef;
//  currentItem: PPChar; stage: PFSFileOperationStage; error: POSStatus;
//  statusDictionary: PCFDictionaryRef; info: PPVOID): OSStatus; cdecl;


{ String conversion functions }
{
 *  FSCreateStringFromHFSUniStr()
 *
 *  Discussion:
 *    Creates a CFString from a HFSUniStr255.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    alloc:
 *      The CFAllocator to use.  Pass NULL for the default allocator.
 *
 *    uniStr:
 *      A HFSUniStr255 to use as the source value for the CFString.
 *
 *  Result:
 *    A CFStringRef created from the HFSUniStr255 or NULL.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSCreateStringFromHFSUniStr(alloc: CFAllocatorRef;
//  const uniStr: PHFSUniStr255): CFStringRef; cdecl;


{
 *  FSGetHFSUniStrFromString()
 *
 *  Discussion:
 *    Convert a CFString into a HFSUniStr255.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    theString:
 *      The CFString to convert to a HFSUniStr255.
 *
 *    uniStr:
 *      A pointer to a HFSUniStr255 which will be filled in using the
 *      value of theString.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSGetHFSUniStrFromString(theString: CFStringRef;
//  uniStr: PHFSUniStr255): OSStatus; cdecl;


{ ACL support }

{
 *  FSFileSecurityGetTypeID()
 *
 *  Discussion:
 *    This routine will return the CFTypeID for the FSFileSecurity type.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Result:
 *    the CFTypeID for the FSFilSecurity type.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityGetTypeID: CFTypeID; cdecl;


{
 *  FSFileSecurityCreate()
 *
 *  Discussion:
 *    This routine will create an FSFileSecurity object.  The object
 *    should be released using CFRelease when it is no longer needed.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    alloc:
 *      The CFAllocator to use.  Pass NULL for the default allocator.
 *
 *  Result:
 *    A reference to the newly created object or NULL if the creation
 *    failed.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityCreate(alloc: CFAllocatorRef): FSFileSecurityRef; cdecl;


{
 *  FSFileSecurityCreateWithFSPermissionInfo()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityCreateWithFSPermissionInfo(alloc: CFAllocatorRef;
//  const permissions: PFSPermissionInfo): FSFileSecurityRef; cdecl;


{
 *  FSFileSecurityRefCreateCopy()
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityRefCreateCopy(alloc: CFAllocatorRef;
//  fileSec: FSFileSecurityRef): FSFileSecurityRef; cdecl;


{ get and set properties }

{
 *  FSFileSecurityGetOwnerUUID()
 *
 *  Discussion:
 *    This routine will get the owner UUID associated with the passed
 *    in FSFileSecurityRef.  In there is no owner UUID property
 *    associated with the FSFileSecurity object then
 *    errFSPropertyNotValid will be returned.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to get the owner UUID
 *      from.
 *
 *    owner:
 *      A pointer to storage for the owner UUID associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityGetOwnerUUID(fileSec: FSFileSecurityRef;
//  owner: PCFUUIDBytes): OSStatus; cdecl;


{
 *  FSFileSecuritySetOwnerUUID()
 *
 *  Discussion:
 *    This routine will set the owner UUID associated with the passed
 *    in FSFileSecurityRef.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to set the owner UUID
 *      for.
 *
 *    owner:
 *      The UUID to set as the owner UUID associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecuritySetOwnerUUID(fileSec: FSFileSecurityRef;
//  const owner: PCFUUIDBytes): OSStatus; cdecl;


{
 *  FSFileSecurityGetGroupUUID()
 *
 *  Discussion:
 *    This routine will get the group UUID associated with the passed
 *    in FSFileSecurityRef.  In there is no group UUID property
 *    associated with the FSFileSecurity object then
 *    errFSPropertyNotValid will be returned.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to get the group UUID
 *      from.
 *
 *    group:
 *      A pointer to storage for the owner UUID associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityGetGroupUUID(fileSec: FSFileSecurityRef;
//  group: PCFUUIDBytes): OSStatus; cdecl;


{
 *  FSFileSecuritySetGroupUUID()
 *
 *  Discussion:
 *    This routine will set the group UUID associated with the passed
 *    in FSFileSecurityRef.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to set the group UUID
 *      for.
 *
 *    group:
 *      The UUID to set as the group UUID associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecuritySetGroupUUID(fileSec: FSFileSecurityRef;
//  const group: PCFUUIDBytes): OSStatus; cdecl;


{
 *  FSFileSecurityCopyAccessControlList()
 *
 *  Discussion:
 *    This routine will copy the acl_t associated with the passed in
 *    FSFileSecurityRef.  The accessControlList returned by this
 *    routine is a copy and must be released using acl_free.  The
 *    accessControlList is an acl_t and is meant to be manipulated
 *    using the acl calls defined in <sys/acl.h>.   If there is no acl
 *    property associated with the FSFileSecurity object then
 *    errFSPropertyNotValid will be returned.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to set the group for.
 *
 *    accessControlList:
 *      A pointer to storage for the acl_t associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityCopyAccessControlList(fileSec: FSFileSecurityRef;
//  accessControlList: Pacl_t): OSStatus; cdecl;


{
 *  FSFileSecuritySetAccessControlList()
 *
 *  Discussion:
 *    This routine will set the acl associated with the passed in
 *    FSFileSecurityRef. To request removal of an ACL from a filesystem
 *    object pass in kFSFileSecurityRemoveACL as the accessControlList
 *    and set the fileSec on the target object using FSSetCatalogInfo.
 *    Setting the accessControlList to NULL will result in the property
 *    being unset.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to set the group for.
 *
 *    accessControlList:
 *      The acl_t to set as the acl associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecuritySetAccessControlList(fileSec: FSFileSecurityRef;
//  accessControlList: acl_t): OSStatus; cdecl;


{
 *  FSFileSecurityGetOwner()
 *
 *  Discussion:
 *    This routine will get the owner uid associated with the passed in
 *    FSFileSecurityRef.  In there is no owner property associated with
 *    the FSFileSecurity object then errFSPropertyNotValid will be
 *    returned.  Note that this value is not the owner UUID which is
 *    returned by FSFileSecurityGetOwnerUUID.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to get the owner from.
 *
 *    owner:
 *      A pointer to storage for the owner uid associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityGetOwner(fileSec: FSFileSecurityRef;
//  owner: PUInt32): OSStatus; cdecl;


{
 *  FSFileSecuritySetOwner()
 *
 *  Discussion:
 *    This routine will set the owner uid associated with the passed in
 *    FSFileSecurityRef.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to set the owner for.
 *
 *    owner:
 *      The uid to set as the owner associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecuritySetOwner(fileSec: FSFileSecurityRef;
//  owner: UInt32): OSStatus; cdecl;


{
 *  FSFileSecurityGetGroup()
 *
 *  Discussion:
 *    This routine will get the group gid associated with the passed in
 *    FSFileSecurityRef.  In there is no group property associated with
 *    the FSFileSecurity object then errFSPropertyNotValid will be
 *    returned.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to get the owner from.
 *
 *    group:
 *      A pointer to storage for the group gid associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityGetGroup(fileSec: FSFileSecurityRef;
//  group: PUInt32): OSStatus; cdecl;


{
 *  FSFileSecuritySetGroup()
 *
 *  Discussion:
 *    This routine will set the group gid associated with the passed in
 *    FSFileSecurityRef.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to set the group for.
 *
 *    group:
 *      The gid to set as the group associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecuritySetGroup(fileSec: FSFileSecurityRef;
//  group: UInt32): OSStatus; cdecl;


{
 *  FSFileSecurityGetMode()
 *
 *  Discussion:
 *    This routine will get the mode associated with the passed in
 *    FSFileSecurityRef.  In there is no mode property associated with
 *    the FSFileSecurity object then errFSPropertyNotValid will be
 *    returned.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to set the group for.
 *
 *    mode:
 *      A pointer to storage for the mode associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecurityGetMode(fileSec: FSFileSecurityRef;
//  mode: PUInt16): OSStatus; cdecl;


{
 *  FSFileSecuritySetMode()
 *
 *  Discussion:
 *    This routine will set the mode associated with the passed in
 *    FSFileSecurityRef.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.4
 *
 *  Parameters:
 *
 *    fileSec:
 *      A reference to the FSFileSecurity object to set the group for.
 *
 *    mode:
 *      The mode to set as the mode associated with fileSec.
 *
 *  Availability:
 *    Mac OS X:         in version 10.4 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFileSecuritySetMode(fileSec: FSFileSecurityRef;
//  mode: UInt16): OSStatus; cdecl;



const
  pleaseCacheBit  = 4;
  pleaseCacheMask = $0010;
  noCacheBit      = 5;
  noCacheMask     = $0020;
  rdVerifyBit     = 6;
  rdVerifyMask    = $0040;
  rdVerify        = 64;
  forceReadBit    = 6;
  forceReadMask   = $0040;
  newLineBit      = 7;
  newLineMask     = $0080;
  newLineCharMask = $FF00;


{ mapping codes (ioObjType) for MapName & MapID }
const
  kOwnerID2Name    = 1;
  kGroupID2Name    = 2;
  kOwnerName2ID    = 3;
  kGroupName2ID    = 4;
  kReturnNextUser  = 1;
  kReturnNextGroup = 2;
  kReturnNextUG    = 3;

{ vcbFlags bits }
const
  kVCBFlagsIdleFlushBit     = 3;
  kVCBFlagsIdleFlushMask    = $0008;
  kVCBFlagsHFSPlusAPIsBit   = 4;
  kVCBFlagsHFSPlusAPIsMask  = $0010;
  kVCBFlagsHardwareGoneBit  = 5;
  kVCBFlagsHardwareGoneMask = $0020;
  kVCBFlagsVolumeDirtyBit   = 15;
  kVCBFlagsVolumeDirtyMask  = $8000;

{ ioVAtrb bits returned by PBHGetVInfo and PBXGetVolInfo }
const
  kioVAtrbDefaultVolumeBit   = 5;
  kioVAtrbDefaultVolumeMask  = $0020;
  kioVAtrbFilesOpenBit       = 6;
  kioVAtrbFilesOpenMask      = $0040;
  kioVAtrbHardwareLockedBit  = 7;
  kioVAtrbHardwareLockedMask = $0080;
  kioVAtrbSoftwareLockedBit  = 15;
  kioVAtrbSoftwareLockedMask = $8000;

{ ioFlAttrib bits returned by PBGetCatInfo }
const
  kioFlAttribLockedBit      = 0;
  kioFlAttribLockedMask     = $01;
  kioFlAttribResOpenBit     = 2;
  kioFlAttribResOpenMask    = $04;
  kioFlAttribDataOpenBit    = 3;
  kioFlAttribDataOpenMask   = $08;
  kioFlAttribDirBit         = 4;
  kioFlAttribDirMask        = $10;
  ioDirFlg                  = 4;
  ioDirMask                 = $10;
  kioFlAttribCopyProtBit    = 6;
  kioFlAttribCopyProtMask   = $40;
  kioFlAttribFileOpenBit    = 7;
  kioFlAttribFileOpenMask   = $80;
  kioFlAttribInSharedBit    = 2;
  kioFlAttribInSharedMask   = $04;
  kioFlAttribMountedBit     = 3;
  kioFlAttribMountedMask    = $08;
  kioFlAttribSharePointBit  = 5;
  kioFlAttribSharePointMask = $20;

{ ioFCBFlags bits returned by PBGetFCBInfo }
{ IMPORTANT: These ioFCBFlags bit constants are for the SInt16 FCBPBRec.ioFCBFlags field returned }
{ by PBGetFCBInfoSync and PBGetFCBInfoAsync. Do not use them with the FSForkInfo.flags }
{ field returned by the FSGetForkCBInfo, PBGetForkCBInfoSync and PBGetForkCBInfoAsyn functions. }
const
  kioFCBWriteBit        = 8;
  kioFCBWriteMask       = $0100;
  kioFCBResourceBit     = 9;
  kioFCBResourceMask    = $0200;
  kioFCBWriteLockedBit  = 10;
  kioFCBWriteLockedMask = $0400;
  kioFCBLargeFileBit    = 11;
  kioFCBLargeFileMask   = $0800;
  kioFCBSharedWriteBit  = 12;
  kioFCBSharedWriteMask = $1000;
  kioFCBFileLockedBit   = 13;
  kioFCBFileLockedMask  = $2000;
  kioFCBOwnClumpBit     = 14;
  kioFCBOwnClumpMask    = $4000;
  kioFCBModifiedBit     = 15;
  kioFCBModifiedMask    = $8000;

{ IMPORTANT: These FSForkInfoFlags constants are for use with the FSForkInfo.flags }
{ field returned by the FSGetForkCBInfo, PBGetForkCBInfoSync and PBGetForkCBInfoAsyn functions. }
{ Do not use them with the FCBPBRec.ioFCBFlags field returned by PBGetFCBInfoSync and PBGetFCBInfoAsync. }
//type
//  !!! = (
//  kForkInfoFlagsWriteBit
//{!!! /* }
//  kForkInfoFlagsWriteMask
//{!!! /* }
//  kForkInfoFlagsResourceBit
//{!!! /* }
//  kForkInfoFlagsResourceMask
//{!!! /* }
//  );
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }
{!!! /* }

{ ioACUser bits returned by PBGetCatInfo }
{ Note: you must clear ioACUser before calling PBGetCatInfo because some file systems do not use this field }
const
  kioACUserNoSeeFolderBit    = 0;
  kioACUserNoSeeFolderMask   = $01;
  kioACUserNoSeeFilesBit     = 1;
  kioACUserNoSeeFilesMask    = $02;
  kioACUserNoMakeChangesBit  = 2;
  kioACUserNoMakeChangesMask = $04;
  kioACUserNotOwnerBit       = 7;
  kioACUserNotOwnerMask      = $80;

{ Folder and File values of access privileges in ioACAccess }
const
  kioACAccessOwnerBit           = 31;
  kioACAccessOwnerMask          = $80000000;
  kioACAccessBlankAccessBit     = 28;
  kioACAccessBlankAccessMask    = $10000000;
  kioACAccessUserWriteBit       = 26;
  kioACAccessUserWriteMask      = $04000000;
  kioACAccessUserReadBit        = 25;
  kioACAccessUserReadMask       = $02000000;
  kioACAccessUserSearchBit      = 24;
  kioACAccessUserSearchMask     = $01000000;
  kioACAccessEveryoneWriteBit   = 18;
  kioACAccessEveryoneWriteMask  = $00040000;
  kioACAccessEveryoneReadBit    = 17;
  kioACAccessEveryoneReadMask   = $00020000;
  kioACAccessEveryoneSearchBit  = 16;
  kioACAccessEveryoneSearchMask = $00010000;
  kioACAccessGroupWriteBit      = 10;
  kioACAccessGroupWriteMask     = $00000400;
  kioACAccessGroupReadBit       = 9;
  kioACAccessGroupReadMask      = $00000200;
  kioACAccessGroupSearchBit     = 8;
  kioACAccessGroupSearchMask    = $00000100;
  kioACAccessOwnerWriteBit      = 2;
  kioACAccessOwnerWriteMask     = $00000004;
  kioACAccessOwnerReadBit       = 1;
  kioACAccessOwnerReadMask      = $00000002;
  kioACAccessOwnerSearchBit     = 0;
  kioACAccessOwnerSearchMask    = $00000001;
  kfullPrivileges               = $00070007;
  kownerPrivileges              = $00000007;


{  Volume Characteristics }
{
 *  FSGetVolumeParms()
 *
 *  Discussion:
 *    Returns information about the specified volume in the passed in
 *    GetVolParmsInfoBuffer.
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *
 *  Parameters:
 *
 *    volume:
 *      The volume to get the information about.
 *
 *    buffer:
 *      A GetVolParmsInfoBuffer to fill out
 *
 *    bufferSize:
 *      the size of the passed in buffer
 *
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
{$IFNDEF IOS}
function FSGetVolumeParms(volume: FSVolumeRefNum;
  buffer: PGetVolParmsInfoBuffer; bufferSize: ByteCount): OSStatus; cdecl;
{$EXTERNALSYM FSGetVolumeParms}
{$ENDIF !IOS}


{  VolumeMount }
{
 *  FSGetVolumeMountInfoSize()
 *
 *  Discussion:
 *    Returns the size of the MountInfo block associated with the
 *    specified volume.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Parameters:
 *    
 *    volume:
 *      The volume to get the MountInfo size for.
 *    
 *    size:
 *      The size of the buffer required to store the MountInfo data
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSGetVolumeMountInfoSize(volume: FSVolumeRefNum;
//  size: PByteCount): OSStatus; cdecl;


{ 
 *  FSGetVolumeMountInfo()
 *  
 *  Discussion:
 *    Returns the MountInfo data for the specified volume.  If the
 *    buffer passed in is too small then errFSBadBuffer is returned and
 *    actualSize will contain the required buffer size to hold the
 *    MountInfo data.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Parameters:
 *    
 *    volume:
 *      The volume to get the MountInfo for.
 *    
 *    buffer:
 *      A pointer to the buffer to copy the MountInfo data into
 *    
 *    bufferSize:
 *      The size of the buffer passed in
 *    
 *    actualSize:
 *      The actual size of the MountInfo data
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSGetVolumeMountInfo(volume: FSVolumeRefNum; buffer: BytePtr;
//  bufferSize: ByteCount; actualSize: PByteCount): OSStatus; cdecl;


{ 
 *  FSVolumeMount()
 *  
 *  Discussion:
 *    Will attempt to remount a volume using the passed in MountInfo
 *    buffer
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Parameters:
 *    
 *    buffer:
 *      A pointer to the buffer with the MountInfo data.
 *    
 *    mountedVolume:
 *      the FSVolumeRefNum of the volume that was mounted
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSVolumeMount(buffer: BytePtr;
//  mountedVolume: PFSVolumeRefNum): OSStatus; cdecl;


{  Volume flushing }
{ 
 *  FSFlushVolume()
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSFlushVolume(vRefNum: FSVolumeRefNum): OSStatus; cdecl;


{ 
 *  PBFlushVolumeSync()
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function PBFlushVolumeSync(paramBlock: FSRefParamPtr): OSStatus; cdecl;


{ 
 *  PBFlushVolumeAsync()
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function PBFlushVolumeAsync(paramBlock: FSRefParamPtr): OSStatus; cdecl;


{ CopyFile }
{ 
    PBFSCopyFile
    Copies a file on a volume that supports the CopyFile system call (which can be
    determined from the bHasCopyFile GetVolParms bit).
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ref             The source item to copy
    ->  parentRef       The destination to copy to
    ->  nameLength      Number of Unicode characters in the optional new name.  Pass in 0 to use the source name
    ->  name            A pointer to the optional new Unicode name; Pass in NULL to use the source name
    <-  newRef          A pointer to the FSRef for the new object; may be NULL
 }
{ 
 *  PBFSCopyFileSync()
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function PBFSCopyFileSync(paramBlock: FSRefParamPtr): OSStatus; cdecl;


{ 
 *  PBFSCopyFileAsync()
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function PBFSCopyFileAsync(paramBlock: FSRefParamPtr): OSStatus; cdecl;


{ Node ID Resolution }
{ 
 *  FSResolveNodeID()
 *  
 *  Discussion:
 *    Returns an FSRef to the item on volume with the specified node id.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Parameters:
 *    
 *    volume:
 *      The FSVolumeRefNum of the volume the item is on
 *    
 *    nodeID:
 *      The node id to resolve
 *    
 *    newRef:
 *      A pointer to storage for the FSRef of the item with the
 *      corresponding node id
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function FSResolveNodeID(volume: FSVolumeRefNum; nodeID: UInt32;
//  newRef: FSRefPtr): OSStatus; cdecl;


{ 
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ioVRefNum       The FSVolumeRefNum of the volume the item is on
    ->  ioDirID         The node id to resolve (can be file as well as a directory node id)
    <-  newRef          A pointer to storage for the FSRef of the item with the corresponding node id
 }
{ 
 *  PBFSResolveNodeIDSync()
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function PBFSResolveNodeIDSync(paramBlock: FSRefParamPtr): OSStatus; cdecl;


{ 
 *  PBFSResolveNodeIDAsync()
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.5
 *  
 *  Availability:
 *    Mac OS X:         in version 10.5 and later in CoreServices.framework
 *    CarbonLib:        not available in CarbonLib 1.x
 *    Non-Carbon CFM:   not available
 }
//function PBFSResolveNodeIDAsync(paramBlock: FSRefParamPtr): OSStatus; cdecl;


{ Calls beyond this point are deprecated }

{ 
    MakeFSRef
    Create an FSRef for an existing object specified by a combination
    of volume refnum, parent directory, and pathname.
    ->  ioCompletion    A pointer to a completion routine
    <-  ioResult        The result code of the function
    ->  ioNamePtr       A pointer to a pathname
    ->  ioVRefNum       A volume specification
    ->  ioDirID         A directory ID
    <-  newRef          A pointer to an FSRef
   This //function is deprecated in Mac OS X 10.5. Use FSMakeFSRefUnicode instead.
 }
//{$IFNDEF __LP64__}
{ 
 *  FSpMakeFSRef()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function FSpMakeFSRef(const source: PFSSpec; newRef: PFSRef): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBMakeFSRefUnicodeSync instead. }
{ 
 *  PBMakeFSRefSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBMakeFSRefSync(paramBlock: PFSRefParam): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBMakeFSRefUnicodeAsync instead. }
{ 
 *  PBMakeFSRefAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//procedure PBMakeFSRefAsync(paramBlock: PFSRefParam); cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBCloseForkSync instead. }
{ 
 *  PBCloseSync()   *** DEPRECATED ***
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBCloseSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBCloseForkAsync instead. }
{ 
 *  PBCloseAsync()   *** DEPRECATED ***
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBCloseAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBReadForkSync instead. }
{ 
 *  PBReadSync()   *** DEPRECATED ***
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBReadSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBReadForkAsync instead. }
{ 
 *  PBReadAsync()   *** DEPRECATED ***
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBReadAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBWriteForkSync instead. }
{ 
 *  PBWriteSync()   *** DEPRECATED ***
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBWriteSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBWriteForkAsync instead. }
{ 
 *  PBWriteAsync()   *** DEPRECATED ***
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBWriteAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. It was never implemented on OS X. }
{ 
 *  PBWaitIOComplete()   *** DEPRECATED ***
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 }
//function PBWaitIOComplete(paramBlock: ParmBlkPtr;
//  timeout: Duration): OSErr; cdecl;


{  Volume Characteristics }
{ This //function is deprecated in Mac OS X 10.5. Use FSGetVolumeParms instead. }
{ 
 *  PBHGetVolParmsSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetVolParmsSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSGetVolumeParms instead. }
{ 
 *  PBHGetVolParmsAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetVolParmsAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{  VolumeMount }
{ This //function is deprecated in Mac OS X 10.5. Use FSGetVolumeMountInfoSize instead. }
{ 
 *  PBGetVolMountInfoSize()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetVolMountInfoSize(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSGetVolumeMountInfo instead. }
{ 
 *  PBGetVolMountInfo()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetVolMountInfo(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSVolumeMount instead. }
{ 
 *  PBVolumeMount()   *** DEPRECATED ***
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBVolumeMount(paramBlock: ParmBlkPtr): OSErr; cdecl;


{  Volume flushing }
{ This //function is deprecated in Mac OS X 10.5. Use FSFlushVolume instead. }
{ 
 *  FlushVol()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FlushVol(volName: ConstStr63Param;
//  vRefNum: FSVolumeRefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBFlushVolumeSync instead. }
{ 
 *  PBFlushVolSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBFlushVolSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBFlushVolumeAsync instead. }
{ 
 *  PBFlushVolAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBFlushVolAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBOpenForkSync with deny pos modes instead. }
{ 
 *  PBHOpenDenySync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenDenySync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBOpenForkAsync with deny pos modes instead. }
{ 
 *  PBHOpenDenyAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenDenyAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBOpenForkSync with deny pos modes instead. }
{ 
 *  PBHOpenRFDenySync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenRFDenySync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBOpenForkAsync with deny pos modes instead. }
{ 
 *  PBHOpenRFDenyAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenRFDenyAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSGetCatalogInfo instead. }
{ 
 *  PBHGetDirAccessSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetDirAccessSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSGetCatalogInfo instead. }
{ 
 *  PBHGetDirAccessAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetDirAccessAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSSetCatalogInfo instead. }
{ 
 *  PBHSetDirAccessSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHSetDirAccessSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSSetCatalogInfo instead. }
{ 
 *  PBHSetDirAccessAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHSetDirAccessAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. See getpwnam() and getpwuid(). }
{ 
 *  PBHMapIDSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHMapIDSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. See getpwnam() and getpwuid(). }
{ 
 *  PBHMapIDAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHMapIDAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. See getpwnam() and getpwuid(). }
{ 
 *  PBHMapNameSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHMapNameSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. See getpwnam() and getpwuid(). }
{ 
 *  PBHMapNameAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHMapNameAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBFSCopyFileSync instead. }
{ 
 *  PBHCopyFileSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHCopyFileSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use PBFSCopyFileAsync instead. }
{ 
 *  PBHCopyFileAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHCopyFileAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSGetCatalogInfo to get the node id. }
{ 
 *  PBCreateFileIDRefSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBCreateFileIDRefSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSGetCatalogInfo to get the node id. }
{ 
 *  PBCreateFileIDRefAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBCreateFileIDRefAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSGetCatalogInfo to get the node id. }
{ 
 *  PBResolveFileIDRefSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBResolveFileIDRefSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. Use FSGetCatalogInfo to get the node id. }
{ 
 *  PBResolveFileIDRefAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBResolveFileIDRefAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. It is obsolete and has no replacement. }
{ 
 *  PBDeleteFileIDRefSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDeleteFileIDRefSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.5. It is obsolete and has no replacement. }
{ 
 *  PBDeleteFileIDRefAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.5
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDeleteFileIDRefAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSGetVolumeInfo instead. }
{ 
 *  PBXGetVolInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 }
//function PBXGetVolInfoSync(paramBlock: XVolumeParamPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSGetVolumeInfo instead. }
{ 
 *  PBXGetVolInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 }
//function PBXGetVolInfoAsync(paramBlock: XVolumeParamPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBAllocateForkSync instead. }
{ 
 *  PBAllocateSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBAllocateSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBAllocateForkAsync instead. }
{ 
 *  PBAllocateAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBAllocateAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetForkSizeSync instead. }
{ 
 *  PBGetEOFSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetEOFSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetForkSizeAsync instead. }
{ 
 *  PBGetEOFAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetEOFAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetForkSizeSync instead. }
{ 
 *  PBSetEOFSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetEOFSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetForkSizeAsync instead. }
{ 
 *  PBSetEOFAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetEOFAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetForkPositionSync instead. }
{ 
 *  PBGetFPosSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetFPosSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetForkPositionAsync instead. }
{ 
 *  PBGetFPosAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetFPosAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetForkPositionSync instead. }
{ 
 *  PBSetFPosSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetFPosSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetForkPositionAsync instead. }
{ 
 *  PBSetFPosAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetFPosAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBFlushForkSync instead. }
{ 
 *  PBFlushFileSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBFlushFileSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBFlushForkAsync instead. }
{ 
 *  PBFlushFileAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBFlushFileAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSEjectVolumeSync instead. }
{ 
 *  PBUnmountVol()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBUnmountVol(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBCatalogSearchSync instead. }
{ 
 *  PBCatSearchSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBCatSearchSync(paramBlock: CSParamPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBCatalogSearchAsync instead. }
{ 
 *  PBCatSearchAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBCatSearchAsync(paramBlock: CSParamPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSEjectVolumeSync instead. }
{ 
 *  UnmountVol()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function UnmountVol(volName: ConstStr63Param;
//  vRefNum: FSVolumeRefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. The routines which use the default volume concept have been deprecated. }
{ 
 *  HSetVol()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HSetVol(volName: ConstStr63Param; vRefNum: FSVolumeRefNum;
//  dirID: SInt32): OSErr; cdecl;


{ AddDrive() was moved to Devices.h }

{ This //function is deprecated in Mac OS X 10.4. Use FSCloseFork instead. }
{ 
 *  FSClose()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSClose(refNum: FSIORefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSReadFork instead. }
{ 
 *  FSRead()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSRead(refNum: FSIORefNum; count: PSInt32;
//  buffPtr: Pointer): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSWriteFork instead. }
{
 *  FSWrite()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSWrite(refNum: FSIORefNum; count: PSInt32;
//  const buffPtr: Pointer): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSAllocateFork instead. }
{ 
 *  Allocate()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function Allocate(refNum: FSIORefNum; count: PSInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSGetForkSize instead. }
{ 
 *  GetEOF()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function GetEOF(refNum: FSIORefNum; logEOF: PSInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSSetForkSize instead. }
{ 
 *  SetEOF()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function SetEOF(refNum: FSIORefNum; logEOF: SInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSGetForkPosition instead. }
{ 
 *  GetFPos()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function GetFPos(refNum: FSIORefNum; filePos: PSInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSSetForkPosition instead. }
{ 
 *  SetFPos()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function SetFPos(refNum: FSIORefNum; posMode: SInt16;
//  posOff: SInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSGetCatalogInfo instead. }
{
 *  GetVRefNum()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function GetVRefNum(fileRefNum: FSIORefNum;
//  vRefNum: PFSVolumeRefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBXLockRangeSync or FSLockRange instead. }
{ 
 *  PBLockRangeSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBLockRangeSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBXLockRangeAsync instead. }
{ 
 *  PBLockRangeAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBLockRangeAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBXUnlockRangeSync or FSUnlockRange instead. }
{ 
 *  PBUnlockRangeSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBUnlockRangeSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBXUnlockRangeAsync instead. }
{ 
 *  PBUnlockRangeAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBUnlockRangeAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. The routines which use the default volume concept have been deprecated. }
{ 
 *  PBHSetVolSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHSetVolSync(paramBlock: WDPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. The routines which use the default volume concept have been deprecated. }
{ 
 *  PBHSetVolAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHSetVolAsync(paramBlock: WDPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. The routines which use the default volume concept have been deprecated. }
{ 
 *  PBHGetVolSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetVolSync(paramBlock: WDPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. The routines which use the default volume concept have been deprecated. }
{ 
 *  PBHGetVolAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetVolAsync(paramBlock: WDPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBMoveObjectSync instead. }
{ 
 *  PBCatMoveSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBCatMoveSync(paramBlock: CMovePBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBMoveObjectAsync instead. }
{ 
 *  PBCatMoveAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBCatMoveAsync(paramBlock: CMovePBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBCreateDirectoryUnicodeSync instead. }
{ 
 *  PBDirCreateSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDirCreateSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBCreateDirectoryUnicodeAsync instead. }
{ 
 *  PBDirCreateAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDirCreateAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetForkCBInfoSync instead. }
{ 
 *  PBGetFCBInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetFCBInfoSync(paramBlock: FCBPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetForkCBInfoAsync instead. }
{ 
 *  PBGetFCBInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetFCBInfoAsync(paramBlock: FCBPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetCatalogInfoSync instead. }
{ 
 *  PBGetCatInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetCatInfoSync(paramBlock: CInfoPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetCatalogInfoAsync instead. }
{ 
 *  PBGetCatInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetCatInfoAsync(paramBlock: CInfoPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetCatalogInfoSync instead. }
{ 
 *  PBSetCatInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetCatInfoSync(paramBlock: CInfoPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetCatalogInfoAsync instead. }
{ 
 *  PBSetCatInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetCatInfoAsync(paramBlock: CInfoPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBAllocateForkSync instead. }
{ 
 *  PBAllocContigSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBAllocContigSync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBAllocateForkAsync instead. }
{ 
 *  PBAllocContigAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBAllocContigAsync(paramBlock: ParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetVolumeInfoSync instead. }
{ 
 *  PBSetVInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetVInfoSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetVolumeInfoAsync instead. }
{ 
 *  PBSetVInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetVInfoAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetVolumeInfoSync instead. }
{ 
 *  PBHGetVInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetVInfoSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetVolumeInfoAsync instead. }
{ 
 *  PBHGetVInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetVInfoAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBOpenForkSync instead. }
{ 
 *  PBHOpenSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBOpenForkAsync instead. }
{ 
 *  PBHOpenAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBOpenForkSync instead. }
{ 
 *  PBHOpenRFSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenRFSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBOpenForkAsync instead. }
{ 
 *  PBHOpenRFAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenRFAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBOpenForkSync instead. }
{ 
 *  PBHOpenDFSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenDFSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBOpenForkAsync instead. }
{ 
 *  PBHOpenDFAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHOpenDFAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBCreateFileUnicodeSync instead. }
{ 
 *  PBHCreateSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHCreateSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBCreateFileUnicodeAsync instead. }
{ 
 *  PBHCreateAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHCreateAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBDeleteObjectSync instead. }
{ 
 *  PBHDeleteSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHDeleteSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBDeleteObjectAsync instead. }
{ 
 *  PBHDeleteAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHDeleteAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBRenameUnicodeSync instead. }
{ 
 *  PBHRenameSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHRenameSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBRenameUnicodeAsync instead. }
{ 
 *  PBHRenameAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHRenameAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetCatalogInfoSync instead. }
{ 
 *  PBHRstFLockSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHRstFLockSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetCatalogInfoAsync instead. }
{ 
 *  PBHRstFLockAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHRstFLockAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetCatalogInfoSync instead. }
{ 
 *  PBHSetFLockSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHSetFLockSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetCatalogInfoAsync instead. }
{ 
 *  PBHSetFLockAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHSetFLockAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetCatalogInfoSync instead. }
{ 
 *  PBHGetFInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetFInfoSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBGetCatalogInfoAsync instead. }
{ 
 *  PBHGetFInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetFInfoAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetCatalogInfoSync instead. }
{ 
 *  PBHSetFInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHSetFInfoSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBSetCatalogInfoAsync instead. }
{ 
 *  PBHSetFInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHSetFInfoAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBMakeFSRefUnicodeSync instead. }
{ 
 *  PBMakeFSSpecSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBMakeFSSpecSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBMakeFSRefUnicodeAsync instead. }
{ 
 *  PBMakeFSSpecAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBMakeFSSpecAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. The routines which use the default volume concept have been deprecated. }
{ 
 *  HGetVol()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HGetVol(volName: StringPtr; vRefNum: PFSVolumeRefNum;
//  dirID: PSInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSOpenFork instead. }
{
 *  HOpen()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HOpen(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param; permission: SInt8;
//  refNum: PFSIORefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSOpenFork instead. }
{ 
 *  HOpenDF()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HOpenDF(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param; permission: SInt8;
//  refNum: PFSIORefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSOpenFork instead. }
{
 *  HOpenRF()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HOpenRF(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param; permission: SInt8;
//  refNum: PFSIORefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSAllocateFork instead. }
{ 
 *  AllocContig()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function AllocContig(refNum: FSVolumeRefNum; count: PSInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSCreateFileUnicode instead. }
{ 
 *  HCreate()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HCreate(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param; creator: OSType; fileType: OSType): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSCreateDirectoryUnicode instead. }
{
 *  DirCreate()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function DirCreate(vRefNum: FSVolumeRefNum; parentDirID: SInt32;
//  directoryName: ConstStr255Param; createdDirID: PSInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSDeleteObject instead. }
{ 
 *  HDelete()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HDelete(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSGetCatalogInfo instead. }
{
 *  HGetFInfo()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HGetFInfo(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param; fndrInfo: PFInfo): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSSetCatalogInfo instead. }
{ 
 *  HSetFInfo()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HSetFInfo(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param; const fndrInfo: PFInfo): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSSetCatalogInfo instead. }
{
 *  HSetFLock()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HSetFLock(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSSetCatalogInfo instead. }
{ 
 *  HRstFLock()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HRstFLock(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSRenameUnicode instead. }
{
 *  HRename()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function HRename(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  oldName: ConstStr255Param; newName: ConstStr255Param): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSMoveObject instead. }
{ 
 *  CatMove()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function CatMove(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  oldName: ConstStr255Param; newDirID: SInt32;
//  newName: ConstStr255Param): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBHGetLogInInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetLogInInfoSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBHGetLogInInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHGetLogInInfoAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ 
   This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X.
   Use FSMoveObjectSync instead.
 }
{ 
 *  PBHMoveRenameSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHMoveRenameSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ 
   This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X.
   Use FSMoveObjectAsync instead.
 }
{ 
 *  PBHMoveRenameAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBHMoveRenameAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBGetXCatInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 }
//function PBGetXCatInfoSync(paramBlock: XCInfoPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBGetXCatInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 }
//function PBGetXCatInfoAsync(paramBlock: XCInfoPBPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBExchangeObjectsSync instead. }
{ 
 *  PBExchangeFilesSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBExchangeFilesSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use PBExchangeObjectsAsync instead. }
{ 
 *  PBExchangeFilesAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBExchangeFilesAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBGetForeignPrivsSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetForeignPrivsSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBGetForeignPrivsAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetForeignPrivsAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBSetForeignPrivsSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetForeignPrivsSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBSetForeignPrivsAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBSetForeignPrivsAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{  Desktop Manager  }


//{$IFNDEF __LP64__}
const
  kLargeIcon      = 1; 
  kLarge4BitIcon  = 2; 
  kLarge8BitIcon  = 3; 
  kSmallIcon      = 4; 
  kSmall4BitIcon  = 5; 
  kSmall8BitIcon  = 6; 
  kicnsIconFamily = 239;



//{$IFNDEF __LP64__}
{ 
 *  PBDTGetPath()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetPath(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTCloseDown()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTCloseDown(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTAddIconSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTAddIconSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTAddIconAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTAddIconAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetIconSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetIconSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetIconAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetIconAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetIconInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetIconInfoSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetIconInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetIconInfoAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTAddAPPLSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTAddAPPLSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTAddAPPLAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTAddAPPLAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTRemoveAPPLSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTRemoveAPPLSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTRemoveAPPLAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTRemoveAPPLAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetAPPLSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetAPPLSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetAPPLAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetAPPLAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTSetCommentSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTSetCommentSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTSetCommentAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTSetCommentAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTRemoveCommentSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTRemoveCommentSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTRemoveCommentAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTRemoveCommentAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetCommentSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetCommentSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetCommentAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetCommentAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTFlushSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTFlushSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTFlushAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTFlushAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTResetSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTResetSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTResetAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTResetAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetInfoSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetInfoSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTGetInfoAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTGetInfoAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTOpenInform()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTOpenInform(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTDeleteSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTDeleteSync(paramBlock: DTPBPtr): OSErr; cdecl;


{ 
 *  PBDTDeleteAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.2
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBDTDeleteAsync(paramBlock: DTPBPtr): OSErr; cdecl;


{  FSp traps  }
{ This //function is deprecated in Mac OS X 10.4. Use FSMakeFSRefUnicode instead. }
{ 
 *  FSMakeFSSpec()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSMakeFSSpec(vRefNum: FSVolumeRefNum; dirID: SInt32;
//  fileName: ConstStr255Param; spec: PFSSpec): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSOpenFork instead. }
{
 *  FSpOpenDF()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpOpenDF(const spec: PFSSpec; permission: SInt8;
//  refNum: PFSIORefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSOpenFork instead. }
{ 
 *  FSpOpenRF()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpOpenRF(const spec: PFSSpec; permission: SInt8;
//  refNum: PFSIORefNum): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSCreateFileUnicode instead. }
{
 *  FSpCreate()   *** DEPRECATED ***
 *
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpCreate(const spec: PFSSpec; creator: OSType; fileType: OSType;
//  scriptTag: ScriptCode): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSCreateDirectoryUnicode instead. }
{ 
 *  FSpDirCreate()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpDirCreate(const spec: PFSSpec; scriptTag: ScriptCode;
//  createdDirID: PSInt32): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSDeleteObject instead. }
{ 
 *  FSpDelete()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpDelete(const spec: PFSSpec): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSGetCatalogInfo instead. }
{ 
 *  FSpGetFInfo()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpGetFInfo(const spec: PFSSpec; fndrInfo: PFInfo): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSSetCatalogInfo instead. }
{ 
 *  FSpSetFInfo()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpSetFInfo(const spec: PFSSpec;
//  const fndrInfo: PFInfo): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSSetCatalogInfo instead. }
{ 
 *  FSpSetFLock()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpSetFLock(const spec: PFSSpec): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSSetCatalogInfo instead. }
{ 
 *  FSpRstFLock()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpRstFLock(const spec: PFSSpec): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSRenameUnicode instead. }
{ 
 *  FSpRename()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpRename(const spec: PFSSpec;
//  newName: ConstStr255Param): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSMoveObject instead. }
{ 
 *  FSpCatMove()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpCatMove(const source: PFSSpec; const dest: PFSSpec): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. Use FSExchangeObjects instead. }
{ 
 *  FSpExchangeFiles()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function FSpExchangeFiles(const source: PFSSpec;
//  const dest: PFSSpec): OSErr; cdecl;



{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBShareSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBShareSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBShareAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBShareAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBUnshareSync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBUnshareSync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBUnshareAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBUnshareAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBGetUGEntrySync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetUGEntrySync(paramBlock: HParmBlkPtr): OSErr; cdecl;


{ This //function is deprecated in Mac OS X 10.4. It was never implemented on OS X. }
{ 
 *  PBGetUGEntryAsync()   *** DEPRECATED ***
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.0
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.4
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 }
//function PBGetUGEntryAsync(paramBlock: HParmBlkPtr): OSErr; cdecl;




//{$IFNDEF __LP64__}
{
    The PBxxx() routines are obsolete.  
    
    Use the PBxxxSync() or PBxxxAsync() version instead.
 }
//TODO: PBGetVInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBXGetVolInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBGetVol Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetVol Parameterized Macro Definition: 
(*
/* *)
//TODO: PBFlushVol Parameterized Macro Definition: 
(*
/* *)
//TODO: PBCreate Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDelete Parameterized Macro Definition: 
(*
/* *)
//TODO: PBOpenDF Parameterized Macro Definition: 
(*
/* *)
//TODO: PBOpenRF Parameterized Macro Definition: 
(*
/* *)
//TODO: PBRename Parameterized Macro Definition: 
(*
/* *)
//TODO: PBGetFInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetFInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetFLock Parameterized Macro Definition: 
(*
/* *)
//TODO: PBRstFLock Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetFVers Parameterized Macro Definition: 
(*
/* *)
//TODO: PBAllocate Parameterized Macro Definition: 
(*
/* *)
//TODO: PBGetEOF Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetEOF Parameterized Macro Definition: 
(*
/* *)
//TODO: PBGetFPos Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetFPos Parameterized Macro Definition: 
(*
/* *)
//TODO: PBFlushFile Parameterized Macro Definition: 
(*
/* *)
//TODO: PBCatSearch Parameterized Macro Definition: 
(*
/* *)
//TODO: PBOpenWD Parameterized Macro Definition: 
(*
/* *)
//TODO: PBCloseWD Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHSetVol Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHGetVol Parameterized Macro Definition: 
(*
/* *)
//TODO: PBCatMove Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDirCreate Parameterized Macro Definition: 
(*
/* *)
//TODO: PBGetWDInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBGetFCBInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBGetCatInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetCatInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBAllocContig Parameterized Macro Definition: 
(*
/* *)
//TODO: PBLockRange Parameterized Macro Definition: 
(*
/* *)
//TODO: PBUnlockRange Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetVInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHGetVInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHOpen Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHOpenRF Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHOpenDF Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHCreate Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHDelete Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHRename Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHRstFLock Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHSetFLock Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHGetFInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHSetFInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBMakeFSSpec Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHGetVolParms Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHGetLogInInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHGetDirAccess Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHSetDirAccess Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHMapID Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHMapName Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHCopyFile Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHMoveRename Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHOpenDeny Parameterized Macro Definition: 
(*
/* *)
//TODO: PBHOpenRFDeny Parameterized Macro Definition: 
(*
/* *)
//TODO: PBExchangeFiles Parameterized Macro Definition: 
(*
/* *)
//TODO: PBCreateFileIDRef Parameterized Macro Definition: 
(*
/* *)
//TODO: PBResolveFileIDRef Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDeleteFileIDRef Parameterized Macro Definition: 
(*
/* *)
//TODO: PBGetForeignPrivs Parameterized Macro Definition: 
(*
/* *)
//TODO: PBSetForeignPrivs Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTAddIcon Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTGetIcon Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTGetIconInfo Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTAddAPPL Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTRemoveAPPL Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTGetAPPL Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTSetComment Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTRemoveComment Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTGetComment Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTFlush Parameterized Macro Definition: 
(*
/* *)
//TODO: PBDTReset Parameterized Macro Definition:
(*
/* *)
//TODO: PBDTGetInfo Parameterized Macro Definition:
(*
/* *)
//TODO: PBDTDelete Parameterized Macro Definition:
(*
/* *)
