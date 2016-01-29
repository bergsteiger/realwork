{*********************************************************}
{*                   STBASE.PAS 3.01                     *}
{*     Copyright (c) TurboPower Software Co., 1996-99    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StBase;
  {-Base unit for SysTools}

{$Include l3XE.inc}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, SysUtils, Messages,
  StSrMgr, STConst;

const
{.Z+}
{$IFDEF WIN32}
  StMaxBlockSize = MaxLongInt;
{$ELSE}
  StMaxBlockSize = 65520;
{$ENDIF}
{.Z-}

{$IFNDEF WIN32}
type
{-Types not defined by Delphi 1.0}
  AnsiChar = AnsiChar;
  DWord = Longint;
  PAnsiChar = PChar;
  ShortString = string;
  PShortString = ^ShortString;
{$ENDIF}

type
{$IFDEF CBuilder}
  TStHwnd = Integer;
{$ELSE}
  TStHwnd = HWND;
{$ENDIF}

{-SysTools exception class tree}
type
  EStException = class(Exception)     {ancestor to all SysTools exceptions}
    protected {private}
      FErrorCode : Longint;

    public
      constructor CreateResTP(Ident : LongInt; Dummy : Word);
      constructor CreateResFmtTP(Ident : Longint; const Args : array of const;
                                 Dummy : Word);
      property ErrorCode : LongInt
        read FErrorCode
        write FErrorCode;
  end;
  EStExceptionClass = class of EStException;

  EStContainerError = class(EStException);   {container exceptions}
  EStSortError = class(EStException);        {sorting exceptions}
  EStRegIniError = class(EStException);      {registry/INI file exceptions}
  EStBCDError = class(EStException);         {Bcd exceptions}
  EStStringError = class(EStException);      {String class exceptions}
  EStVersionInfoError = class(EStException); {Version info exception}
  {$IFDEF WIN32}
  EStShellError = class(EStException);       {Shell version exception}
  EStFileOpError = class(EStException);      {Shell file operation exception}
  EStTrayIconError = class(EStException);    {Tray Icon exception}
  EStDropFilesError = class(EStException);   {Drop files exception}
  EStShortcutError = class(EStException);    {Shortcut exception}
  EStShellFormatError = class(EStException); {Format exception}
  EStInvalidFolder = class(EStException);    {Bad folder exception}
  EStNetException = class(EStException);     {Network exception}
  {$ENDIF}
  EStBarCodeError = class(EStException);     {BarCode exception}
  EStPNBarCodeError = class(EStException);   {PostNet BarCode exception}
  EStStatError = class(EStException);        {statistics exceptions}
  EStFinError = class(EStException);         {Financial exceptions}
  EStMimeError = class(EStException);        {Mime exceptions}
  EStToHTMLError = class(EStException);      {ToHTML exceptions}
  EStSpawnError = class(EStException);       {SpawnApplication errors}
  EStMMFileError = class(EStException);      {MemoryMappedFile errors}
  EStBufStreamError =class(EStException);    {Buffered stream errors}
  EStRegExError = class(EStException);       {RegEx errors}

  EStExprError = class(EStException) {expression evaluator exceptions}
    protected {private}
      FErrorCol : Integer;
  public
    constructor CreateResTPCol(Ident : Longint; Column : Integer; Dummy : Integer);
    property ErrorColumn : Integer
      {-Returns the string position at the start of the token where
        the error was detected}
        read FErrorCol;
  end;


const
{.Z+}
  StMaxFileLen  = 260;

  StRLEMaxCount = 127;      { Used by RLE }
  StRLERunMode = $80;       { Used by RLE }
{.Z-}

const
{.Z+}
  {used by CompareLetterSets for estimating word similarity}
  StLetterValues : array['A'..'Z'] of Byte = (
    3 {A} , 6 {B} , 5 {C} , 4 {D} , 3 {E} , 5 {F} , 5 {G} , 4 {H} , 3 {I} ,
    8 {J} , 7 {K} , 4 {L} , 5 {M} , 3 {N} , 3 {O} , 5 {P} , 7 {Q} , 4 {R} ,
    3 {S} , 3 {T} , 4 {U} , 6 {V} , 5 {W} , 8 {X} , 8 {Y} , 9 {Z} );

  StHexDigits  : array[0..$F] of AnsiChar = '0123456789ABCDEF';
  DosDelimSet  : set of AnsiChar = ['\', ':', #0];
{$IFNDEF VER100}                                                       {!!.01}
  {$IFNDEF VER80}                                                      {!!.01}
    {$IFNDEF VER93}                                                    {!!.01}
    StHexDigitsW : WideString = '0123456789ABCDEF';                    {!!.01}
    DosDelimSetW : WideString = '\:';                                  {!!.01}
    {$ENDIF}                                                           {!!.01}
  {$ENDIF}                                                             {!!.01}
{$ENDIF}                                                               {!!.01}

{.Z-}

type
{.Z+}
  TSmallArray = array[0..StMaxFileLen-1] of AnsiChar;
  BTable  = array[0..255] of Byte;  {Table used by Boyer-Moore search routines}
{$IFDEF WIN32}
  BTableW = array [Word] of Cardinal;
{$ENDIF}
{.Z-}

type
{.Z+}
  PDouble = ^Double;
  TDoubleArray = array[0..(stMaxBlockSize div SizeOf(Double))-1] of Double;
  PDoubleArray = ^TDoubleArray;
  TIntArray = array[0..(StMaxBlockSize div SizeOf(Integer))-1] of Integer;
  PIntArray = ^TIntArray;
{.Z-}

type
  {the SysTools floating point type}
  {$IFDEF WIN32}
  TStFloat = Extended;
  {$ELSE}
    {$IFOPT N+}
    TStFloat = Extended;
    {$ELSE}
    TStFloat = Real;
    {$ENDIF}
  {$ENDIF}

const
  WMCOPYID : DWORD = $AFAF;

{$IFDEF WINDOWS}
const
  WM_COPYDATA = $004A;

type
  PCopyDataStruct = ^TCopyDataStruct;
  tagCOPYDATASTRUCT = packed record
    dwData: DWORD;
    cbData: DWORD;
    lpData: Pointer;
  end;
  TCopyDataStruct = tagCOPYDATASTRUCT;

  TWMCopyData = record
    Msg: Cardinal;
    From: HWND;
    CopyDataStruct: PCopyDataStruct;
    Result: Longint;
  end;
{$ENDIF}


type
  TStNode = class(TPersistent)
{.Z+}
  protected {private}
    FData : Pointer;
{.Z-}
  public
    constructor Create(AData : Pointer);
      virtual;
    property Data : Pointer
       read FData
       write FData;
  end;

{.Z+}
  TStNodeClass = class of TStNode;
{.Z-}

  TStContainer = class;

  TCompareFunc =
    function(Data1, Data2 : Pointer) : Integer;
  TStCompareEvent =
    procedure(Sender : TObject; Data1, Data2 : Pointer;  var Compare : Integer)
    of object;

  TDisposeDataProc =
    procedure(Data : Pointer);
  TStDisposeDataEvent =
    procedure(Sender : TObject; Data : Pointer)
    of object;

  TLoadDataFunc =
    function(Reader : TReader) : Pointer;
  TStLoadDataEvent =
    procedure(Sender : TObject; Reader : TReader; var Data : Pointer)
    of object;

  TStoreDataProc =
    procedure(Writer : TWriter; Data : Pointer);
  TStStoreDataEvent =
    procedure(Sender : TObject; Writer : TWriter; Data : Pointer)
    of object;

  TStringCompareFunc =
    function(const String1, String2 : string) : Integer;
  TStStringCompareEvent =
    procedure(Sender : TObject; const String1, String2 : string; var Compare : Integer)
    of object;

  TUntypedCompareFunc =
    function(const El1, El2) : Integer;
  TStUntypedCompareEvent =
    procedure(Sender : TObject; const El1, El2; var Compare : Integer)
    of object;

  TIterateFunc =
    function(Container : TStContainer; Node : TStNode; OtherData : Pointer) : Boolean;
  TIteratePointerFunc =
    function(Container : TStContainer; Data, OtherData : Pointer) : Boolean;
  TIterateUntypedFunc =
    function(Container : TStContainer; var Data; OtherData : Pointer) : Boolean;

  TStContainer = class(TPersistent)
  {.Z+}
  protected {private}
    {property instance variables}
    FCompare     : TCompareFunc;
    FDisposeData : TDisposeDataProc;
    FLoadData    : TLoadDataFunc;
    FStoreData   : TStoreDataProc;

    {event variables}
    FOnCompare     : TStCompareEvent;
    FOnDisposeData : TStDisposeDataEvent;
    FOnLoadData    : TStLoadDataEvent;
    FOnStoreData   : TStStoreDataEvent;

    {private instance variables}
    {$IFDEF ThreadSafe}
    conThreadSafe  : TRTLCriticalSection;
    {$ENDIF}

    procedure SetCompare(C : TCompareFunc);
    procedure SetDisposeData(D : TDisposeDataProc);
    procedure SetLoadData(L : TLoadDataFunc);
    procedure SetStoreData(S : TStoreDataProc);

  protected
    conNodeClass : TStNodeClass;
    conNodeProt  : Integer;
    FCount       : Longint;

    {protected undocumented methods}
    function AssignPointers(Source : TPersistent; AssignData : TIteratePointerFunc) : boolean;
    function AssignUntypedVars(Source : TPersistent; AssignData : TIterateUntypedFunc) : boolean;
    procedure ForEachPointer(Action : TIteratePointerFunc; OtherData : Pointer);
      virtual;
    procedure ForEachUntypedVar(Action : TIterateUntypedFunc; OtherData : pointer);
      virtual;
    procedure GetArraySizes(var RowCount, ColCount, ElSize : Cardinal);
      virtual;
    procedure SetArraySizes(RowCount, ColCount, ElSize : Cardinal);
      virtual;
    function StoresPointers : boolean;
      virtual;
    function StoresUntypedVars : boolean;
      virtual;

    {protected documented}
    procedure IncNodeProtection;
      {-Prevent container Destroy from destroying its nodes}
    procedure DecNodeProtection;
      {-Allow container Destroy to destroy its nodes}
    procedure EnterCS;
      {-Enter critical section for this instance}
    procedure LeaveCS;
      {-Leave critical section for this instance}
    {.Z-}
  public
    constructor CreateContainer(NodeClass : TStNodeClass; Dummy : Integer);
      {-Create an abstract container (called by descendants)}
    destructor Destroy;
      override;
      {-Destroy a collection, and perhaps its nodes}
    procedure Clear;
      virtual; abstract;
      {-Remove all elements from collection}
    procedure DisposeNodeData(P : TStNode);
      {-Destroy the data associated with a node}

    {wrapper methods for using events or proc/func pointers}
    function DoCompare(Data1, Data2 : Pointer) : Integer;
      virtual;
    procedure DoDisposeData(Data : Pointer);
      virtual;
    function DoLoadData(Reader : TReader) : Pointer;
      virtual;
    procedure DoStoreData(Writer : TWriter; Data : Pointer);
      virtual;

    procedure LoadFromFile(const FileName : string);
      dynamic;
      {-Create a container and its data from a file}
    procedure LoadFromStream(S : TStream);
      dynamic; abstract;
      {-Create a container and its data from a stream}
    procedure StoreToFile(const FileName : string);
      dynamic;
      {-Create a container and its data from a file}
    procedure StoreToStream(S : TStream);
      dynamic; abstract;
      {-Write a container and its data to a stream}

    property Count : LongInt
      {-Return the number of elements in the collection}
      read FCount;

    property Compare : TCompareFunc
      {-Set or read the node comparison function}
      read FCompare
      write SetCompare;

    property DisposeData : TDisposeDataProc
      {-Set or read the node data dispose function}
      read FDisposeData
      write SetDisposeData;

    property LoadData : TLoadDataFunc
      {-Set or read the node data load function}
      read FLoadData
      write SetLoadData;

    property StoreData : TStoreDataProc
      {-Set or read the node data load function}
      read FStoreData
      write SetStoreData;

    {events}
    property OnCompare : TStCompareEvent
      read FOnCompare
      write FOnCompare;

    property OnDisposeData : TStDisposeDataEvent
      read FOnDisposeData
      write FOnDisposeData;

    property OnLoadData : TStLoadDataEvent
      read FOnLoadData
      write FOnLoadData;

    property OnStoreData : TStStoreDataEvent
      read FOnStoreData
      write FOnStoreData;
  end;

  TAssignRowData = record
    RowNum : Integer;
    Data   : array [0..0] of Byte;
  end;

  {base component for SysTools non-visual components}
  {.Z+}
  TStComponent = class(TComponent)
  protected {private}
    function GetVersion : string;
    procedure SetVersion(const Value : string);

  published
    property Version : string
      read GetVersion
      write SetVersion
      stored False;
  end;
  {.Z-}

{---Generic node routines---}
function DestroyNode(Container : TStContainer; Node : TStNode;
                     OtherData : Pointer) : Boolean;
  {-Generic function to pass to iterator to destroy a container node}


{---WIN32 short string routines---}
{$IFDEF WStrings}
function AnsiUpperCaseShort32(const S : string) : string;
  {-Ansi uppercase for H- strings in WIN32}

function AnsiCompareTextShort32(const S1, S2: string): Integer;
  {-Case-insensitive compare function for H- strings in WIN32}

function AnsiCompareStrShort32(const S1, S2: string): Integer;
  {-Case-sensitive compare function for H- strings in WIN32}
{$ENDIF}


{.Z+}
{---Huge memory routines---}
function HugeCompressRLE(const InBuffer; InLen : Longint;
                         var OutBuffer) : Longint;
  {-Run length encode a buffer}

function HugeDecompressRLE(const InBuffer; InLen : Longint;
                           var OutBuffer; OutLen : LongInt) : Longint;
  {-Run length decode a buffer}

procedure HugeFillChar(var Dest; Count : Longint; Value : Byte);
  {-Fill huge memory block with byte value}

procedure HugeFillStruc(var Dest; Count : Longint;
                        const Value; ValSize : Cardinal);
  {-Fill huge memory block with structure value}

procedure HugeMove(const Src; var Dest; Count : LongInt);
  {-Copy huge memory block to another}

procedure HugeGetMem(var P : Pointer; Size : LongInt);
  {-Get huge memory block allocation}

procedure HugeFreeMem(var P : Pointer; Size : LongInt);
  {-Free huge memory block allocation}
{.Z-}


{---General purpose character manipulation---}

function Upcase(C : AnsiChar) : AnsiChar;
  {-Return the uppercase of a character. Provides international character
    support.}

function LoCase(C : AnsiChar) : AnsiChar;
  {-Return the lowercase of a character. Provides international character
    support.}

{.Z+}
{$IFNDEF WIN32}
procedure UpcasePrim;
  {-Calls the Windows AnsiUpper function. Provides international character
    support. Character is returned in AL.}

procedure LoCasePrim;
  {-Calls the Windows AnsiLower function. Provides international character
    support. Character is returned in AL.}
{$ENDIF}
{.Z-}


{---General comparison and searching---}

function CompareLetterSets(Set1, Set2 : LongInt) : Cardinal;
  {-Return the sum of the values of the letters common to Set1 and Set2.}

function CompStruct(const S1, S2; Size : Cardinal) : Integer;
  {-Compare two fixed size structures.}

function Search(const Buffer; BufLength : Cardinal; const Match;
                MatLength : Cardinal; var Pos : Cardinal) : Boolean;
  {-Search a buffer for the specified pattern of bytes.}

function SearchUC(const Buffer; BufLength : Cardinal; const Match;
                  MatLength : Cardinal; var Pos : Cardinal) : Boolean;
  {-Search a buffer for a specified pattern of bytes. This search is not case
    sensitive.}


{---Miscellaneous---}

{.Z+}
function IsOrInheritsFrom(Root, Candidate : TClass) : boolean;
  {-Return true if the classes are equal or Candidate is a descendant of Root}

procedure RaiseContainerError(Code : longint);
  {-Internal routine: raise an exception for a container}

procedure RaiseContainerErrorFmt(Code : Longint; Data : array of const);
  {-Internal routine: raise an exception for a container}

function ProductOverflow(A, B : LongInt) : Boolean;
  {-Return True if A*B exceeds MaxLongInt}

{$IFNDEF HStrings}
function StNewStr(S : string) : PShortString;
  {-Allocate a short string on the heap}

procedure StDisposeStr(PS : PShortString);
  {-Deallocate a short string from the heap}
{$ENDIF}
{.Z-}


{---primitives for converting strings to integers}
procedure ValLongInt(S : ShortString; var LI : Longint; var ErrorCode : integer);
procedure ValSmallint(const S : ShortString; var SI : smallint; var ErrorCode : integer);
procedure ValWord(const S : ShortString; var Wd : word; var ErrorCode : integer);

{.Z+}
{general routine to raise a specific class of SysTools exception}
procedure RaiseStError(ExceptionClass : EStExceptionClass; Code : LongInt);
{.Z-}

{.Z+}
{general routines to raise a specific Win32 exception in SysTools}
{$IFDEF WIN32}
procedure RaiseStWin32Error(ExceptionClass : EStExceptionClass; Code : LongInt);
procedure RaiseStWin32ErrorEx(ExceptionClass : EStExceptionClass; Code : LongInt; Info : string);
{$ENDIF}
{.Z-}

{$IFDEF VER100}                                                        {!!.01}
var                                                                    {!!.01}
  StHexDigitsW : WideString;                                           {!!.01}
  DosDelimSetW : WideString;                                           {!!.01}
{$ENDIF}                                                               {!!.01}


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


procedure RaiseStError(ExceptionClass : EStExceptionClass; Code : LongInt);
var
  E : EStException;
begin
  E := ExceptionClass.CreateResTP(Code, 0);
  E.ErrorCode := Code;
  raise E;
end;

{$IFDEF WIN32}
procedure RaiseStWin32Error(ExceptionClass : EStExceptionClass; Code : LongInt);
var
  E : EStException;
begin
  E := ExceptionClass.Create(SysErrorMessage(Code));
  E.ErrorCode := Code;
  raise E;
end;

procedure RaiseStWin32ErrorEx(ExceptionClass : EStExceptionClass; Code : LongInt;
          Info : string);
var
  E : EStException;
begin
  E := ExceptionClass.Create(SysErrorMessage(Code) + ' [' + Info + ']');
  E.ErrorCode := Code;
  raise E;
end;
{$ENDIF}

constructor EStException.CreateResTP(Ident : LongInt; Dummy : Word);
begin
  {$ifNDef XE}
  inherited Create(SysToolStr[Ident]);
  {$Else}
  assert(false);
  {$EndIf XE}
end;

constructor EStException.CreateResFmtTP(Ident : Longint;
            const Args : array of const; Dummy : Word);
begin
  {$ifNDef XE}
  inherited CreateFmt(SysToolStr[Ident], Args);
  {$Else}
  assert(false);
  {$Endif XE}
end;

constructor EStExprError.CreateResTPCol(Ident : Longint; Column : Integer; Dummy : Integer);
begin
  inherited CreateResTP(Ident, 0);

  FErrorCol := Column;
end;


function AbstractCompare(Data1, Data2 : Pointer) : Integer; far;
begin
  {$ifNDef XE}
  raise ESTContainerError.CreateResTP(stscNoCompare, 0);
  {$Else}
  assert(false);
  {$Endif XE}
end;

{$IFDEF WStrings}
function AnsiCompareStrShort32(const S1, S2: string): Integer; assembler;
asm
  push esi
  push edi
  mov esi,S1
  mov edi,S2
  xor eax,eax
  xor edx,edx
  xor ecx,ecx
  mov dl,[esi]
  inc esi
  mov dh,[edi]
  inc edi
  mov cl,dl
  cmp cl,dh
  jbe @1
  mov cl,dh
@1:
  or ecx, ecx
  je @CheckLengths
  repe cmpsb
  jb @LT
  ja @GT
@CheckLengths:
  cmp dl, dh
  je @Exit
  jb @LT
@GT:
  inc eax
  inc eax
@LT:
  dec eax
@Exit:
  pop edi
  pop esi
end;

function AnsiCompareTextShort32(const S1, S2: string): Integer;
begin
  Result := AnsiCompareStrShort32(AnsiUpperCaseShort32(S1),
                                  AnsiUpperCaseShort32(S2));
end;

function AnsiUpperCaseShort32(const S : string) : string;
begin
  Result := S;
  AnsiUpperBuff(PChar(@Result[1]), Length(S));
end;
{$ENDIF}

function DestroyNode(Container : TStContainer;
                     Node : TStNode;
                     OtherData : Pointer) : Boolean;
begin
  Container.DisposeNodeData(Node);
  Node.Free;
  Result := True;
end;

procedure HugeFillChar(var Dest; Count : Longint; Value : Byte);
begin
{$IFDEF WIN32}
  FillChar(Dest, Count, Value);
{$ELSE}
  asm
    db $66
    xor di,di
    les di,Dest             {es:edi -> Dest}

    mov al,Value            {replicate Value throughout eax}
    mov cl,al
    mov ah,al
    db $66
    shl ax,16
    mov al,cl
    mov ah,al

    db $66
    mov cx,word ptr Count   {ecx = bytes to fill}
    mov bx,cx               {save lower word}

    db $66
    shr cx,2
    cld
    rep
    db $67
    db $66
    stosw                   {move dwords}
    mov cx,bx
    and cx,3
    rep
    db $67
    stosb                   {move last few bytes}
  end;
{$ENDIF}
end;

function HugeCompressRLE(const InBuffer; InLen : Longint;
                         var OutBuffer) : Longint;
    {assumes OutBuffer is at least InLen long}
    {returns -1 if InLen <= 1 or if output length would exceed InLen}
    {otherwise returns compressed length}
    {does not initialize OutBuffer if the result is -1}
{$IFDEF WIN32}
  asm
    {InBuffer = eax, InLen = edx, OutBuffer = ecx}
    push ebx
    push esi
    push edi

    push OutBuffer       {save output base for later}

    cmp InLen,1
    jle @A               {can't compress if input length <= 1}

    mov esi,InBuffer     {esi = current input offset}
    mov edi,OutBuffer    {edi = current output offset}
    mov eax,InLen
    mov ebx,edi          {ebx = control byte offset}
    mov byte ptr [ebx],0 {reset first control byte}
    mov edx,edi
    add edx,eax          {edx = endpoint of output buffer}
    dec edx              {reserve an extra space for control byte}
    mov ecx,esi
    add ecx,eax          {ecx = endpoint of input buffer}
    dec ecx              {reduce by one for convenience below}
    dec esi              {decrement first time through}

@1: inc esi              {next input byte}
    cmp esi,ecx
    ja  @9               {exit at end of input}
    mov al,[esi]         {load compare byte}
    jae @5               {can't be a match if on last byte of input}
    cmp [esi+1],al       {is it a run?}
    jne @5               {jump if not}

    {starting a run}
    mov ebx,edi          {start a new control sequence}
    mov byte ptr [ebx],1 {first byte in run}
    mov [ebx+1],al       {store run byte}
@2: inc esi              {next input byte}
    cmp esi,ecx          {end of input?}
    ja  @3               {exit this loop if so}
    cmp [esi],al         {next byte a match?}
    jne @3               {jump if not a run}
    cmp byte ptr [ebx],StRLEMaxCount {max run length?}
    je  @3               {exit this loop if so}
    inc byte ptr [ebx]   {increment control byte}
    jmp @2               {stay in the run loop}
@3: or byte ptr [ebx],StRLERunMode {flag control byte as a run}
    inc edi              {step past control and run bytes}
    inc edi
    cmp edi,edx          {filled up output buffer?}
    jae @A               {jump if so}
    mov ebx,edi          {set up new control byte}
    mov byte ptr [ebx],0 {first byte in non-run}
    dec esi              {back up one byte}
    jmp @1               {classify run status again}

@5: {not a run}
    cmp edi,ebx          {the start of a new non-run?}
    ja  @6               {jump if not}
    inc edi              {next output position, guaranteed ok}
@6: cmp byte ptr [ebx],StRLEMaxCount {max non-run length?}
    jb  @7
    mov ebx,edi          {start a new control sequence}
    mov byte ptr [ebx],0 {reset control byte}
    inc edi              {next output position}
    cmp edi,edx          {filled up output buffer?}
    jae @A               {jump if so}
@7: inc byte ptr [ebx]   {increment control byte}
    mov [edi],al         {copy input byte}
    inc edi              {next output position}
    cmp edi,edx          {filled up output buffer?}
    jae @A               {jump if so}
    jmp @1               {back to outer loop}

@9: pop eax              {get output base again}
    sub edi,eax          {get output length}
    jmp @B
@A: pop eax              {balance stack}
    mov edi,-1           {could not compress input}
@B: mov eax,edi          {return output length}

    pop edi
    pop esi
    pop ebx
  end;
{$ELSE}
  assembler;
  asm
    push ds
    push word ptr OutBuffer {save output base offset for later}

    db  $66
    mov ax,word ptr InLen {eax = InLen}
    db  $66
    cmp ax,1
    db  $00,$00          {cmp eax,1}
    jle @A               {can't compress if input length <= 1}

    db  $66
    xor si,si
    db  $66
    xor di,di
    lds si,InBuffer      {ds:esi -> input}
    les di,OutBuffer     {es:edi -> output}
    db  $66
    mov bx,di            {ebx = control byte offset}
    db  $67
    mov byte ptr es:[bp+di],0 {reset first control byte}
    db  $66
    mov dx,di
    db  $66
    add dx,ax            {edx = endpoint of output buffer}
    db  $66
    dec dx               {reserve an extra space for control byte}
    db  $66
    mov cx,si
    db  $66
    add cx,ax            {ecx = endpoint of input buffer}
    db  $66
    dec cx               {reduce by one for convenience below}
    db  $66
    dec si               {decrement first time through}

@1: db  $66
    inc si               {next input byte}
    db  $66
    cmp si,cx
    ja  @9               {exit at end of input}
    db  $67
    mov al,[bp]          {load compare byte mov al,[esi]}
    jae @5               {can't be a match if on last byte of input}
    db  $67
    cmp [bp+1],al        {is it a run?}
    jne @5               {jump if not}

    {starting a run}
    db  $66
    mov bx,di            {start a new control sequence}
    db  $67
    mov byte ptr es:[bp+di],1  {first byte in run}
    db  $67
    mov es:[bp+di+1],al  {store run byte}
@2: db  $66
    inc si               {next input byte}
    db  $66
    cmp si,cx            {end of input?}
    ja  @3               {exit this loop if so}
    db  $67
    cmp [bp],al          {next byte a match?}
    jne @3               {jump if not a run}
    db  $67
    cmp byte ptr es:[bp+di],StRLEMaxCount {max run length?}
    je  @3               {exit this loop if so}
    db  $67
    inc byte ptr es:[bp+di] {increment control byte}
    jmp @2               {stay in the run loop}
@3: db  $67
    or byte ptr es:[bp+di],StRLERunMode {flag control byte as a run}
    db  $66
    inc di               {step past control and run bytes}
    db  $66
    inc di
    db  $66
    cmp di,dx            {filled up output buffer?}
    jae @A               {jump if so}
    db  $66
    mov bx,di            {set up new control byte}
    db  $67
    mov byte ptr es:[bp+di],0 {first byte in non-run}
    db  $66
    dec si               {back up one byte}
    jmp @1               {classify run status again}

@5: {not a run}
    db  $66
    cmp di,bx            {the start of a new non-run?}
    ja  @6               {jump if not}
    db  $66
    inc di               {next output position, guaranteed ok}
@6: db $67
    cmp byte ptr es:[bp+di],StRLEMaxCount {max non-run length?}
    jb  @7
    db  $66
    mov bx,di            {start a new control sequence}
    db  $67
    mov byte ptr es:[bp+di],0 {reset control byte}
    db  $66
    inc di               {next output position}
    db  $66
    cmp di,dx            {filled up output buffer?}
    jae @A               {jump if so}
@7: db  $67
    inc byte ptr es:[bp+di]   {increment control byte}
    db  $67
    stosb                {copy input byte to output}
    db  $66
    cmp di,dx            {filled up output buffer?}
    jae @A               {jump if so}
    jmp @1               {back to outer loop}

@9: db  $66
    xor ax,ax
    pop ax               {get output offset again in eax}
    db  $66
    sub di,ax            {get output length}
    jmp @B
@A: pop ax               {balance stack}
    db  $66
    xor di,di
    db  $66
    dec di               {edi = -1, could not compress input}
@B: db  $66
    mov ax,di
    db  $66
    mov dx,ax
    db  $66
    shr dx,16            {return output length in dx:ax}
    pop ds
  end;
{$ENDIF}

function HugeDecompressRLE(const InBuffer; InLen : Longint;
                           var OutBuffer; OutLen : LongInt) : Longint;
    {returns -1 if InLen is <= 0 or output length > OutLen}
    {otherwise returns decompressed length}
{$IFDEF WIN32}
  asm
    {InBuffer = eax, InLen = edx, OutBuffer = ecx, OutLen = stack}
    push ebx
    push esi
    push edi

    push OutBuffer       {save output base for later}

    cmp InLen,0          {anything to decompress?}
    jle @A               {jump if not}

    mov esi,InBuffer     {esi = current input offset}
    mov edi,OutBuffer    {edi = current output offset}
    mov ebx,esi
    add ebx,InLen        {ebx = endpoint of input buffer}
    mov edx,OutLen       {edx = space free in output buffer}

@1: cmp esi,ebx          {end of input?}
    jae @9               {jump if so}
    mov al,[esi]         {get next control byte}
    inc esi              {move to run data byte}
    mov cl,al
    and ecx,StRLEMaxCount{ecx = bytes for output}
    sub edx,ecx          {is there space?}
    jc  @A               {jump if not}
    test al,StRLERunMode {is it a run?}
    jz @5                {jump if not}

    {a run}
    mov al,[esi]         {get run data}
    inc esi              {next input position}
    rep stosb            {store it}
    jmp @1               {loop}

@5: {not a run}
    rep movsb            {copy them}
    jmp @1               {loop}

@9: pop eax              {get output base again}
    sub edi,eax          {get output length}
    jmp @B
@A: pop eax              {balance stack}
    mov edi,-1           {could not decompress input}
@B: mov eax,edi          {return output length}

    pop  edi
    pop  esi
    pop  ebx
  end;
{$ELSE}
  assembler;
  asm
    push ds
    push word ptr OutBuffer {save output base for later}

    db  $66
    mov ax,word ptr InLen {eax = InLen}
    db  $66
    cmp ax,0             {anything to decompress?}
    jle @A               {jump if not}

    db  $66
    xor si,si
    db  $66
    xor di,di
    lds si,InBuffer      {ds:esi -> input}
    les di,OutBuffer     {es:edi -> output}
    db  $66
    mov bx,si
    db  $66
    add bx,ax            {ebx = endpoint of input buffer}
    db  $66
    mov dx,word ptr OutLen {edx = space free in output buffer}

@1: db  $66
    cmp si,bx            {end of input?}
    jae @9               {jump if so}
    db  $67
    mov al,[bp]          {get next control byte}
    db  $66
    inc si               {move to run data byte}
    mov cl,al
    db  $66
    and cx,StRLEMaxCount {ecx = bytes for output}
    db  $00,$00
    db  $66
    sub dx,cx            {is there space?}
    jc  @A               {jump if not}
    test al,StRLERunMode {is it a run?}
    jz  @5               {jump if not}

    {a run}
    db  $67
    mov al,[bp]          {get run data}
    db  $66
    inc si               {next input position}
    db  $67
    rep stosb            {store it}
    jmp @1               {loop}

@5: {not a run}
    db  $67
    rep movsb            {copy them}
    jmp @1               {loop}

@9: db  $66
    xor ax,ax
    pop ax               {get output base again in eax}
    db  $66
    sub di,ax            {get output length}
    jmp @B
@A: pop ax               {balance stack}
    db  $66
    xor di,di
    db  $66
    dec di               {edi = -1, could not decompress input}
@B: db  $66
    mov ax,di            {return output length}
    db  $66
    mov dx,ax
    db  $66
    shr dx,16            {return output length in dx:ax}
    pop ds
  end;
{$ENDIF}

procedure HugeFillStruc(var Dest; Count : Longint;
                        const Value; ValSize : Cardinal); assembler;
{$IFDEF WIN32}
register;
  asm
    {eax = Dest, edx = Count, ecx = Value}
    push ebx
    push esi
    push edi
    mov edi,Dest            {edi -> Dest}
    mov eax,Value           {eax -> Value}
    {mov edx,Count}         {edx = Count, register parameter}
    mov ebp,ValSize         {ebp = ValSize}
    jmp @2
@1: mov ecx,ebp             {ecx = element ValSize}
    mov esi,eax             {esi -> Value}
    mov bx,cx
    shr ecx,2
    rep movsd
    mov cx,bx
    and cx,3
    rep movsb
@2: sub edx,1               {decrement elements left to fill}
    jnc @1                  {loop for all elements}
    pop edi
    pop esi
    pop ebx
  end;
{$ELSE}
  asm
    push ds                 {save ds}
    db $66
    xor di,di
    les di,Dest             {es:edi -> Dest}
    db $66
    xor si,si               {esi = 0}
    db $66
    xor cx,cx               {ecx = 0}
    db $66
    xor ax,ax               {eax = 0}
    lds ax,Value            {ds:eax -> Value}
    cld
    db $66
    mov dx,word ptr Count   {edx = Count}
    push bp
    mov bp,ValSize
    jmp @2
@1: mov cx,bp               {ecx = element ValSize}
    mov si,ax               {ds:esi -> Value}
    mov bx,cx
    shr cx,2
    rep
    db $67
    db $66
    movsw
    mov cx,bx
    and cx,3
    rep
    db $67
    movsb
@2: db $66
    sub dx,1                {decrement elements left to fill}
    jnc @1                  {loop for all elements}
    pop bp                  {restore bp}
    pop ds                  {restore ds}
  end;
{$ENDIF}

procedure HugeFreeMem(var P : Pointer; Size : LongInt);
begin
  if Assigned(P) then begin
{$IFDEF WIN32}
    FreeMem(P, Size);
{$ELSE}
    if Size <= StMaxBlockSize then
      FreeMem(P, Size)
    else
      GlobalFreePtr(P);
{$ENDIF}
    P := nil;
  end;
end;

procedure HugeGetMem(var P : Pointer; Size : LongInt);
begin
{$IFDEF WIN32}
  GetMem(P, Size);
{$ELSE}
  if Size <= StMaxBlockSize then
    {use suballocator whenever possible}
    GetMem(P, Size)
  else begin
    P := GlobalAllocPtr(HeapAllocFlags, Size);
    if not Assigned(P) then
      OutOfMemoryError;
  end;
{$ENDIF}
end;

procedure HugeMove(const Src; var Dest; Count : LongInt);
begin
{$IFDEF WIN32}
  Move(Src, Dest, Count);
{$ELSE}
  {assumes non-overlapping memory blocks}
  asm
    push ds
    db $66
    xor si,si
    db $66
    xor di,di
    lds si,Src
    les di,Dest
    db $66
    mov cx,word ptr Count   {ecx = bytes to move}
    mov bx,cx               {save lower word}
    db $66
    shr cx,2
    cld
    rep
    db $67
    db $66
    movsw                   {move dwords}
    mov cx,bx
    and cx,3
    rep
    db $67
    movsb                   {move last few bytes}
    pop ds
  end;
{$ENDIF}
end;

{$IFDEF WIN32}
function UpCase(C: AnsiChar) : AnsiChar;
asm
  and   eax, 0FFh
  push  eax
  call  CharUpper
end;

function LoCase(C: AnsiChar) : AnsiChar; assembler;
asm
  and   eax, 0FFh
  push  eax
  call  CharLower
end;
{$ELSE}
procedure UpcasePrim; assembler;
  {-Call the Windows AnsiUpper function}
asm
  push    bx
  push    cx
  push    dx
  push    si
  push    di
  push    es
  push    ax
  xor     ah,ah
  xor     bx,bx
  push    bx
  push    ax
  call    AnsiUpper
  pop     bx
  mov     ah,bh
  pop     es
  pop     di
  pop     si
  pop     dx
  pop     cx
  pop     bx
end;


function Upcase(C : AnsiChar) : AnsiChar; assembler;
asm
  mov     al,C
  call    UpcasePrim
end;

procedure LoCasePrim; assembler;
  {-Call the Windows AnsiLower function}
asm
  push    bx
  push    cx
  push    dx
  push    si
  push    di
  push    es
  push    ax
  xor     ah,ah
  xor     bx,bx
  push    bx
  push    ax
  call    AnsiLower
  pop     bx
  mov     ah,bh
  pop     es
  pop     di
  pop     si
  pop     dx
  pop     cx
  pop     bx
end;

function LoCase(C : AnsiChar) : AnsiChar; assembler;
asm
  mov     al,C
  call    LocasePrim
end;
{$ENDIF}

function ProductOverflow(A, B : LongInt) : Boolean;
{$IFDEF WIN32}
register;
asm
  mov ecx,False
  {A is in eax already, B is in edx already}
  imul eax,edx
  jno @1
  mov ecx,True
@1:
  mov eax,ecx
end;
{$ELSE}
var
  Product :
    record
      LoLong : Longint;
      HiLong : Longint;
    end;
  Negative : Boolean;
begin
  Product.LoLong := 0;
  Product.HiLong := 0;
  Negative := (A < 0) xor (B < 0);
  A := Abs(A);
  B := Abs(B);
  asm
    lea bx,Product
    mov ax,word ptr A
    mul word ptr B       {loword(A)*loword(B)}
    mov ss:[bx],ax
    mov ss:[bx+2],dx
    mov ax,word ptr A
    mul word ptr B+2     {loword(A)*hiword(B)}
    add ss:[bx+2],ax
    adc ss:[bx+4],dx
    jnc @1
    inc word ptr ss:[bx+6]
@1: mov ax,word ptr A+2
    mul word ptr B       {hiword(A)*loword(B)}
    add ss:[bx+2],ax
    adc ss:[bx+4],dx
    jnc @2
    inc word ptr ss:[bx+6]
@2: mov ax,word ptr A+2
    mul word ptr B+2     {hiword(A)*hiword(B)}
    add ss:[bx+4],ax
    adc ss:[bx+6],dx
  end;
  Result := (Product.HiLong <> 0) or ((not Negative) and (Product.LoLong < 0));
end;
{$ENDIF}

{$IFDEF WIN32}
function CompareLetterSets(Set1, Set2 : LongInt) : Cardinal;
  {-Returns the sum of the values of the letters common to Set1 and Set2.}
asm
  push   ebx                       { Save registers }
  push   edi
  and    eax, edx                  { EAX = EAX and EDX }
  xor    edx, edx                  { Zero EDX }
  mov    ecx, ('Z'-'A')            { Set up counter }
  mov    edi, offset StLetterValues{ Point EBX to table }
  xor    ebx, ebx
  jmp    @@Start

@@Next:
  dec    ecx                       { Decrement counter }
  shl    eax, 1                    { Shift next bit into position }

@@Start:
  test   eax, 2000000h             { Test 26th bit }
  jnz    @@Add                     { If set, add corresponding letter value }
  or     ecx, ecx
  jz     @@Exit                    { Done if ECX is zero }
  jmp    @@Next                    { Test next bit }

@@Add:
  mov    bl, [ecx+edi]             { Do table lookup }
  add    edx, ebx                  { Add value to result }
  or     ecx, ecx
  jnz    @@Next                    { Test next bit }

@@Exit:
  mov    eax, edx                  { Move EDX to result }
  pop    edi                       { Restore registers }
  pop    ebx
end;

{$ELSE}

function CompareLetterSets(Set1, Set2 : LongInt) : Cardinal; Assembler;
  {-Returns the sum of the values of the letters common to Set1 and Set2.}
asm
  MOV     DI,WORD PTR Set1
  MOV     SI,WORD PTR Set1+2
  AND     DI,WORD PTR Set2                {SI:DI = Set1 and Set2}
  AND     SI,WORD PTR Set2+2
  PUSH    BP
  XOR     BP, BP                          {BP = 0}
  MOV     CX,('Z'-'A')+1                  {Loop count}

@@CLSnext:
  MOV     BX,CX                           {save CX in BX}
  XOR     DX,DX                           {DX:AX = 1}
  MOV     AX,1
  SUB     CX,AX                           {subtract 1 to get bit number}
  JZ      @@CLSnoShift                    {don't shift if CX is 0}

@@CLSshift:                               {DX:AX = 1 shl BitNumber}
  SHL     AX,1                            {shift low word}
  RCL     DX,1                            {shift high word}
  LOOP    @@CLSshift                      {repeat}

@@CLSnoshift:
  MOV     CX,BX                           {restore CX from BX}
  AND     AX,DI                           {DX:AX = DX:AX and SI:DI}
  AND     DX,SI
  OR      AX,DX                           {DX:AX = 0?}
  JNZ     @@CLSadd                        {if not, add letter value}
  LOOP    @@CLSnext                       {else, next element}
  JMP     @@CLSexit                       {done}

@@CLSadd:
  XOR     AH,AH                           {AX has value of the letter}
  MOV     AX,CX                           {AL = loop count}
  DEC     AL                              {convert to index into table}
  LEA     BX,StLetterValues               {DS:BX points to LetterValues}
  XLAT                                    {AL has value of the letter}
  ADD     BP,AX                           {add to result}
  LOOP    @@CLSnext                       {next element}

@@CLSexit:
  MOV     AX,BP                           {Function result into AX}
  POP     BP
end;
{$ENDIF}

{$IFDEF WIN32}
function CompStruct(const S1, S2; Size : Cardinal) : Integer;
  {-Compare two fixed size structures}
asm
  push   edi
  push   esi
  mov    esi, eax
  mov    edi, edx
  xor    eax, eax
  or     ecx, ecx
  jz     @@CSDone

  repe   cmpsb
  je     @@CSDone

  inc    eax
  ja     @@CSDone
  or     eax, -1

@@CSDone:
  pop    esi
  pop    edi
end;

{$ELSE}

function CompStruct(const S1, S2; Size : Cardinal) : Integer; assembler;
  {-Compare two fixed size structures}
asm
  MOV     DX,DS                   {Save DS}
  xor     AX,ax                   {BX holds temporary result (Equal)}

  MOV     CX,Size                 {Size in CX}
  JCXZ    @@CSDone                {Make sure size isn't zero}

  LES     DI,S2                   {ES:DI points to S2}
  LDS     SI,S1                   {DS:SI points to S1}
  CLD                             {Go forward}

  REPE    CMPSB                   {Compare until no match or CX = 0}
  JE      @@CSDone                {If Equal, result ready based on length}

  INC     AX                      {Prepare for Greater}
  JA      @@CSDone                {S1 Greater? Return 1}
  OR      AX,-1                   {Else S1 Less, Return -1}

@@CSDone:
  MOV     DS,DX                   {Restore DS}
end;
{$ENDIF}

{$IFDEF WIN32}
function Search(const Buffer; BufLength : Cardinal; const Match;
                MatLength : Cardinal; var Pos : Cardinal) : Boolean;
asm
  push   ebx
  push   edi
  push   esi

  cld
  mov    edi, eax
  mov    ebx, eax
  mov    esi, ecx
  mov    ecx, edx
  mov    edx, MatLength
  or     edx, edx
  jz     @@NotFound

  mov    al, [esi]
  inc    esi
  dec    edx
  sub    ecx, edx
  jbe    @@NotFound

@@Next:
  repne  scasb
  jne    @@NotFound
  or     edx, edx
  jz     @@Found

  push   ecx
  push   edi
  push   esi

  mov    ecx, edx
  repe   cmpsb

  pop    esi
  pop    edi
  pop    ecx

  jne    @@Next            {Try again if no match}

{Calculate number of bytes searched and return}
@@Found:
  mov    esi, Pos
  dec    edi
  sub    edi, ebx
  mov    eax, 1
  mov    [esi], edi
  jmp    @@SDone

{Match was not found}
@@NotFound:
  xor    eax, eax

@@SDone:
  pop    esi
  pop    edi
  pop    ebx
end;

{$ELSE}

function Search(const Buffer; BufLength : Cardinal; const Match;
                MatLength: Cardinal; var Pos : Cardinal) : Boolean; assembler;
asm
  PUSH    DS                      {Save DS}
  CLD                             {Go forward}

  LES     DI,Buffer               {ES:DI => Buffer}
  MOV     BX,DI                   {BX = Ofs(Buffer)}

  MOV     CX,BufLength            {CX = Length of range to scan}
  MOV     DX,MatLength            {DX = Length of match string}

  TEST    DX,DX                   {Length(Match) = 0?}
  JZ      @@Error                 {If so, we're done}

  LDS     SI,Match                {DS:SI => Match buffer}
  LODSB                           {AL = Match[1]; DS:SI => Match[2]}
  DEC     DX                      {DX = MatLength-1}
  SUB     CX,DX                   {CX = BufLength-(MatLength-1)}
  JBE     @@Error                 {Error if BufLength is less}

{Search for first character in Match}
@@Next:
  REPNE   SCASB                   {Search forward for Match[1]}
  JNE     @@Error                 {Done if not found}
  TEST    DX,DX                   {If Length = 1 (DX = 0) ...}
  JZ      @@Found                 {the "string" was found}

  {Search for remainder of Match}

  PUSH    CX                      {Save CX}
  PUSH    DI                      {Save DI}
  PUSH    SI                      {Save SI}

  MOV     CX,DX                   {CX = Length(Match) - 1}
  REPE    CMPSB                   {Does rest of string match?}

  POP     SI                      {Restore SI}
  POP     DI                      {Restore DI}
  POP     CX                      {Restore CX}

  JNE     @@Next                  {Try again if no match}

{Calculate number of bytes searched and return}
@@Found:
  DEC     DI                      {DI = Offset where found}
  MOV     AX,DI                   {AX = Offset where found}
  SUB     AX,BX                   {Subtract starting offset}
  les     di,Pos
  mov     es:[di],ax              {Set Pos}
  mov     ax,1                    {Result = True}
  JMP     @@SDone                 {Done}

{Match was not found}
@@Error:
  XOR     AX,AX                   {Return False}

@@SDone:
  POP     DS                      {Restore DS}
end;
{$ENDIF}

{$IFDEF WIN32}
function SearchUC(const Buffer; BufLength : Cardinal; const Match;
                  MatLength: Cardinal; var Pos : Cardinal) : Boolean;

asm
  push   ebx                { Save registers }
  push   edi
  push   esi
  push   eax

  mov    edi, eax           { EDI = ^Buffer }
  mov    esi, ecx           { ESI = ^Match }
  mov    ecx, edx           { ECX = BufLength }
  mov    edx, MatLength     { EDX = MatLength }
  xor    ebx, ebx           { EBX will be used for comparison }
  or     edx, edx           { Is MatLength 0? }
  jz     @@NotFound

  mov    al, [esi]          { Get first character }
  inc    esi
  and    eax, 0FFh          { Zero all but lower byte }

  push   ecx                { Save registers }
  push   edx
  push   eax
  call   CharUpper          { Upcase character }
  pop    edx
  pop    ecx

  mov    bl, al             { Move uppercased AnsiChar to BL }
  dec    edx                { Dec MatLength }
  sub    ecx, edx           { Is MatLength > BufLength? }
  jbe    @@NotFound

@@Next:
  mov    al, [edi]
  inc    edi

  push   ecx                { Save registers }
  push   edx
  push   eax
  call   CharUpper          { Upcase character in buffer }
  pop    edx
  pop    ecx

  cmp    bl, al             { Match? }
  je     @@CompRest         { Compare rest of string }
@@RestNoMatch:
  dec    ecx                { End of string? }
  jnz    @@Next             { Try next AnsiChar }
  jmp    @@NotFound         { Done if not found }

@@CompRest:
  or     edx, edx           { Was there only one character? }
  jz     @@Found            { If so, we're done }

  push   ebx                { Save registers }
  push   ecx
  push   edi
  push   esi

  mov    ecx, edx

@@CompLoop:
  mov    al, [esi]
  inc    esi

  push   ecx                { Save registers }
  push   edx
  push   eax
  call   CharUpper          { Upcase character in buffer }

  mov    bl, al
  mov    al, [edi]
  inc    edi

  push   eax
  call   CharUpper          { Upcase character in buffer }
  pop    edx
  pop    ecx

  cmp    bl, al
  jne    @@NoComp
  dec    ecx
  jnz    @@CompLoop

@@NoComp:
  pop    esi                { Restore registers }
  pop    edi
  pop    ecx
  pop    ebx

  jne    @@RestNoMatch      { Try again if no match }

{Calculate number of bytes searched and return}
@@Found:
  pop    ebx
  mov    esi, Pos
  dec    edi
  sub    edi, ebx
  mov    eax, 1
  mov    [esi], edi
  jmp    @@SDone

{Match was not found}
@@NotFound:
  pop    eax
  xor    eax, eax

@@SDone:
  pop    esi
  pop    edi
  pop    ebx
end;

{$ELSE}

function SearchUC(const Buffer; BufLength : Cardinal; const Match;
                  MatLength: Cardinal; var Pos : Cardinal) : Boolean; assembler;

asm
  PUSH    DS                      {Save DS}
  CLD                             {Go forward}

  LES     DI,Buffer               {ES:DI => Buffer}
  MOV     BX,DI                   {BX = Ofs(Buffer)}

  MOV     CX,BufLength            {CX = Length of range to scan}
  MOV     DX,MatLength            {DX = Length of match string}

  TEST    DX,DX                   {Length(Match) = 0?}
  JZ      @@SUCError              {If so, we're done}

  LDS     SI,Match                {DS:SI => Match buffer}
  LODSB                           {AL = Match[1]; DS:SI => Match[2]}
  CALL    UpCasePrim              {Uppercase it}
  DEC     DX                      {DX = MatLength-1}
  SUB     CX,DX                   {CX = BufLength-(MatLength-1)}
  JBE     @@SUCError              {No match if BufLength is less}

{Search for first character in Match}
@@SUCNext:
  JCXZ    @@SUCError              {done if CX is 0}
  MOV     AH,ES:[DI]              {Get next character of buffer}
  INC     DI                      {To next position}
  XCHG    AH,AL
  CALL    UpCasePrim              {Uppercase it}
  XCHG    AH,AL
  CMP     AH,AL                   {A match?}
  LOOPNE  @@SUCNext               {Loop while CX<>0 and AH<>AL}
  JNE     @@SUCError              {Done if not found}
  OR      DX,DX                   {If Length = 1 (DX = 0) ...}
  JZ      @@SUCFound              {the "string" was found}

  {Search for remainder of Match}

  PUSH    AX                      {Save AX}
  PUSH    CX                      {Save CX}
  PUSH    DI                      {Save DI}
  PUSH    SI                      {Save SI}

  MOV     CX,DX                   {CX = Length(Match) - 1}
@@SUCNextM:
  LODSB                           {Next match character in AL}
  CALL    UpCasePrim              {Uppercase it}
  MOV     AH,ES:[DI]              {Next buffer character in AH}
  INC     DI                      {Increment index}
  XCHG    AH,AL
  CALL    UpCasePrim              {Uppercase it}
  XCHG    AH,AL
  CMP     AH,AL                   {A match?}
  LOOPE   @@SUCNextM              {Loop while AH=AL and CX<>0}

  POP     SI                      {Restore SI}
  POP     DI                      {Restore DI}
  POP     CX                      {Restore CX}
  POP     AX                      {Restore AX}

  JNE     @@SUCNext               {Try again if no match}

{Calculate number of bytes searched and return}
@@SUCFound:
  DEC     DI                      {DX = Offset where found}
  MOV     AX,DI                   {AX = Offset where found}
  SUB     AX,BX                   {Subtract starting offset}
  les     di,Pos
  mov     es:[di],ax              {Set Pos}
  mov     ax,1                    {Result = True}
  JMP     @@SUCDone               {Done}

{Match was not found}
@@SUCError:
  XOR     AX,AX                   {Return False}

@@SUCDone:
  POP     DS                      {Restore DS}
end;
{$ENDIF}


{---primitives for converting strings to integers---}
procedure ValLongInt(S : ShortString; var LI : Longint; var ErrorCode : integer);
var
  LenS   : byte absolute S;
  Offset : Integer;
  NBCInx : Integer;
begin
  {trim trailing spaces}
  while (LenS > 0) and (S[LenS] = ' ') do
    dec(LenS);
  {empty strings are invalid}
  if (LenS = 0) then begin
    LI := 0;
    ErrorCode := -1;
  end;
  {from now on S must have at least one non-blank AnsiChar}

  {find the first non-blank AnsiChar}
  NBCInx := 1;
  while (S[NBCInx] = ' ') do
    inc(NBCInx);

  {check for a string of the form nnnnH}
  Offset := 0;
  if (upcase(S[LenS]) = 'H') then begin
    {if the first non-blank AnsiChar is the final character, then the
     string is just of the form <spaces>H and is invalid}
    if (NBCInx = LenS) then begin
      LI := 0;
      ErrorCode := LenS;
      Exit;
    end;
    Move(S[NBCInx], S[NBCInx+1], LenS-NBCInx);
    S[NBCInx] := '$';
    Offset := -1;
  end
  {check for a string of the form 0Xnnnn}
  else begin
    if (NBCInx < LenS) and
       (S[NBCInx] = '0') and (upcase(S[NBCInx+1]) = 'X') then begin
      S[NBCInx] := ' ';
      S[NBCInx+1] := '$';
    end;
  end;
  Val(S, LI, ErrorCode);
  if (ErrorCode <> 0) then begin
    LI := 0;
    Inc(ErrorCode, Offset);
  end;
end;

procedure ValSmallint(const S : ShortString; var SI : smallint; var ErrorCode : integer);
const
  SmallestInt16 = -32767;
  LargestInt16 = 32767;
var
  LI : Longint;
begin
  ValLongInt(S, LI, ErrorCode);
  if (ErrorCode <> 0) then
    SI := 0
  else {the conversion succeeded} begin
    if (SmallestInt16 <= LI) and (LI <= LargestInt16) then
      SI := LI
    else begin
      ErrorCode := length(S);
      SI := 0;
    end;
  end;
end;

procedure ValWord(const S : ShortString; var Wd : word; var ErrorCode : integer);
const
  SmallestWord = 0;
  LargestWord = 65535;
var
  LI : Longint;
begin
  ValLongInt(S, LI, ErrorCode);
  if (ErrorCode <> 0) then
    Wd := 0
  else {the conversion succeeded} begin
    if (SmallestWord <= LI) and (LI <= LargestWord) then
      Wd := LI
    else begin
      ErrorCode := length(S);
      Wd := 0;
    end;
  end;
end;
{---------------------------------------------------}


function IsOrInheritsFrom(Root, Candidate : TClass) : boolean;
  begin
    Result := (Root = Candidate) or Candidate.InheritsFrom(Root);
  end;

procedure RaiseContainerError(Code : LongInt);
var
  E : ESTContainerError;
begin
  E := ESTContainerError.CreateResTP(Code, 0);
  E.ErrorCode := Code;
  raise E;
end;

procedure RaiseContainerErrorFmt(Code : Longint; Data : array of const);
var
  E : ESTContainerError;
begin
  E := ESTContainerError.CreateResFmtTP(Code, Data, 0);
  E.ErrorCode := Code;
  raise E;
end;

{$IFNDEF HStrings}
function StNewStr(S : string) : PShortString;
begin
  GetMem(Result, succ(length(S)));
  Result^ := S;
end;

procedure StDisposeStr(PS : PShortString);
begin
  if (PS <> nil) then
    FreeMem(PS, succ(length(PS^)));
end;
{$ENDIF}

{----------------------------------------------------------------------}

constructor TStNode.Create(AData : Pointer);
begin
  Data := AData;
end;

{----------------------------------------------------------------------}

function TStContainer.AssignPointers(Source : TPersistent;
                                     AssignData : TIteratePointerFunc) : boolean;
begin
  Result := false;
  if (Source is TStContainer) then
    if TStContainer(Source).StoresPointers then
      begin
        Clear;
        TStContainer(Source).ForEachPointer(AssignData, Self);
        Result := true;
      end;
end;

function TStContainer.AssignUntypedVars(Source : TPersistent;
                                        AssignData : TIterateUntypedFunc) : boolean;
var
  RowCount : Cardinal;
  ColCount : Cardinal;
  ElSize : Cardinal;
begin
  Result := false;
  if (Source is TStContainer) then
    if TStContainer(Source).StoresUntypedVars then
      begin
        Clear;
        TStContainer(Source).GetArraySizes(RowCount, ColCount, ElSize);
        SetArraySizes(RowCount, ColCount, ElSize);
        TStContainer(Source).ForEachUntypedVar(AssignData, Self);
        Result := true;
      end;
end;

procedure TStContainer.ForEachPointer(Action : TIteratePointerFunc;
                                      OtherData : pointer);
begin
  {do nothing}
end;

procedure TStContainer.ForEachUntypedVar(Action : TIterateUntypedFunc;
                                            OtherData : pointer);
begin
  {do nothing}
end;

procedure TStContainer.GetArraySizes(var RowCount, ColCount, ElSize : Cardinal);
begin
  RowCount := 0;
  ColCount := 0;
  ElSize := 0;
end;

procedure TStContainer.SetArraySizes(RowCount, ColCount, ElSize : Cardinal);
begin
  {do nothing}
end;

procedure TStContainer.SetCompare(C : TCompareFunc);
begin
  FCompare := C;
end;

procedure TStContainer.SetDisposeData(D : TDisposeDataProc);
begin
  FDisposeData := D;
end;

procedure TStContainer.SetLoadData(L : TLoadDataFunc);
begin
  FLoadData := L;
end;

procedure TStContainer.SetStoreData(S : TStoreDataProc);
begin
  FStoreData := S;
end;

function TStContainer.StoresPointers : boolean;
begin
  Result := false;
end;

function TStContainer.StoresUntypedVars : boolean;
begin
  Result := false;
end;

constructor TStContainer.CreateContainer(NodeClass : TStNodeClass; Dummy : Integer);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
{$IFDEF ThreadSafe}
 {$IFDEF WIN32}
  Windows.InitializeCriticalSection(conThreadSafe);
 {$ELSE}
  DosCreateMutexSem(nil, conThreadSafe, 0, False);
 {$ENDIF}
{$ENDIF}

  FCompare := AbstractCompare;
  conNodeClass := NodeClass;

  inherited Create;
end;

procedure TStContainer.DecNodeProtection;
begin
  Dec(conNodeProt);
end;

destructor TStContainer.Destroy;
begin
  if conNodeProt = 0 then
    Clear;
{$IFDEF ThreadSafe}
 {$IFDEF WIN32}
  Windows.DeleteCriticalSection(conThreadSafe);
 {$ELSE}
  DosCloseMutexSem(conThreadSafe);
 {$ENDIF}
{$ENDIF}
  inherited Destroy;
end;

procedure TStContainer.DisposeNodeData(P : TStNode);
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if Assigned(P) then
      DoDisposeData(P.Data);
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

function TStContainer.DoCompare(Data1, Data2 : Pointer) : Integer;
begin
  Result := 0;
  if Assigned(FOnCompare) then
    FOnCompare(Self, Data1, Data2, Result)
  else if Assigned(FCompare) then
    Result := FCompare(Data1, Data2);
end;

procedure TStContainer.DoDisposeData(Data : Pointer);
begin
  if Assigned(FOnDisposeData) then
    FOnDisposeData(Self, Data)
  else if Assigned(FDisposeData) then
    FDisposeData(Data);
end;

function TStContainer.DoLoadData(Reader : TReader) : Pointer;
begin
  Result := nil;
  if Assigned(FOnLoadData) then
    FOnLoadData(Self, Reader, Result)
  else if Assigned(FLoadData) then
    Result := FLoadData(Reader)
  else
    RaiseContainerError(stscNoLoadData);
end;

procedure TStContainer.DoStoreData(Writer : TWriter; Data : Pointer);
begin
  if Assigned(FOnStoreData) then
    FOnStoreData(Self, Writer, Data)
  else if Assigned(FStoreData) then
    FStoreData(Writer, Data)
  else
    RaiseContainerError(stscNoStoreData);
end;

procedure TStContainer.EnterCS;
begin
{$IFDEF ThreadSafe}
 {$IFDEF WIN32}
  EnterCriticalSection(conThreadSafe);
 {$ELSE}
  DosRequestMutexSem(conThreadSafe, sem_Indefinite_Wait);
 {$ENDIF}
{$ENDIF}
end;

procedure TStContainer.IncNodeProtection;
begin
  Inc(conNodeProt);
end;

procedure TStContainer.LeaveCS;
begin
{$IFDEF ThreadSafe}
 {$IFDEF WIN32}
  LeaveCriticalSection(conThreadSafe);
 {$ELSE}
  DosReleaseMutexSem(conThreadSafe);
 {$ENDIF}
{$ENDIF}
end;

procedure TStContainer.LoadFromFile(const FileName : string);
var
  S : TStream;
begin
  S := TFileStream.Create(FileName, fmOpenRead + fmShareDenyWrite);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

procedure TStContainer.StoreToFile(const FileName : string);
var
  S : TStream;
begin
  S := TFileStream.Create(FileName, fmCreate);
  try
    StoreToStream(S);
  finally
    S.Free;
  end;
end;


{*** TStComponent ***}

function TStComponent.GetVersion : string;
begin
  Result := StVersionStr;
end;

procedure TStComponent.SetVersion(const Value : string);
begin
end;

{$IFDEF VER100}                                                        {!!.01}
initialization                                                         {!!.01}
  StHexDigitsW := '0123456789ABCDEF';                                  {!!.01}
  DosDelimSetW := '\:';                                                {!!.01}
{$ENDIF}                                                               {!!.01}

end.


