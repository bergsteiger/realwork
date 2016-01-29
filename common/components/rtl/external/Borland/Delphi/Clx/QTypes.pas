{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 2000-2002 Borland Software Corporation                        }
{                                                                             }
{ This file may be distributed and/or modified under the terms of the GNU     }
{ General Public License (GPL) version 2 as published by the Free Software    }
{ Foundation and appearing at http://www.borland.com/kylix/gpl.html.          }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit QTypes;

{$R-,T-,H+,X+}

interface

uses
  {$IFDEF LINUX}
  Libc,
  {$ENDIF}
  Qt, SysUtils, Types, Classes;

const
  QEventType_CMDestroyWidget = QEventType(Integer(QEventType_ClxBase) + $01);
  QEventType_CMQuit = QEventType(Integer(QEventType_ClxBase) + $02);
  QEventType_CMRelease = QEventType(Integer(QEventType_ClxBase) + $03);
  QEventType_CMScrolled = QEventType(Integer(QEventType_ClxBase) + $04);
  QEventType_CMActionExecute = QEventType(Integer(QEventType_ClxBase) + $05);
  QEventType_CMActionUpdate = QEventType(Integer(QEventType_ClxBase) + $06);
  QEventType_CMPaletteReset = QEventType(Integer(QEventType_ClxBase) + $07);

  QEventType_LBClick = QEventType(Integer(QEventType_ClxBase) + $20);
  QEventType_MenuClick = QEventType(Integer(QEventType_ClxBase) + $40);
  QEventType_DesignMenuClick = QEventType(Integer(QEventType_ClxBase) + $42);
  QEventType_AniRepeat = QEventType(Integer(QEventType_ClxBase) + $60);
  QEventType_AniStop = QEventType(Integer(QEventType_ClxBase) + $61);
  QEventType_AniError = QEventType(Integer(QEventType_ClxBase) + $62);

type
(*$HPPEMIT '#ifdef __linux__' *)
(*$HPPEMIT '  #include <sys/stat.h>' *)
(*$HPPEMIT '  namespace Qtypes' *)
(*$HPPEMIT '  {' *)
(*$HPPEMIT '    typedef struct stat _stat;' *)
(*$HPPEMIT '  }' *)
(*$HPPEMIT '#endif' *)

TFileInfo = record
    SR: TSearchRec;
{$IFDEF LINUX}
    stat: TStatBuf;
    LinkTarget: string;
{$ENDIF}
    ImageIndex: Integer;
    Desc: string;
  end;
  PFileInfo = ^TFileInfo;
  TFileInfos = array of PFileInfo;

type
  TQtItemCompareFunc = function(const W1, W2: WideString): Integer;
  EHandleComponentException = class(Exception);
  EInvalidParam = class(Exception);

  TCaption = type WideString;

  THandleComponent = class(TComponent)
  private
    FHooks: QObject_hookH;
    FParentWidget: QWidgetH;
    FHelpContext: THelpContext;
    FHelpKeyword: string;
    FHelpFile: string;
    FHelpType: THelpType;
    function GetHooks: QObject_hookH;
    procedure DestroyedHook; cdecl;
    function GetHandle: QObjectH;
    function GetParentWidget: QWidgetH;
    procedure SetParentWidget(const Value: QWidgetH);
    function IsHelpContextStored: Boolean;
    function MainEventFilter(Sender: QObjectH; Event: QEventH): Boolean; cdecl;
  protected
    FHandle: QObjectH;
    procedure CreateHandle; virtual;
    procedure CreateWidget; virtual; abstract;
    procedure DestroyWidget; virtual;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; virtual;
    procedure HookEvents; virtual;
    procedure InitWidget; virtual;
    procedure InvokeHelp; virtual;
    procedure SetHelpContext(const Value: THelpContext);
    procedure SetHelpKeyword(const Value: String);
    procedure WidgetDestroyed; virtual;
    property HelpFile: string read FHelpFile write FHelpFile;
    property HelpType: THelpType read FHelpType write FHelpType default htKeyword;
    property HelpKeyword: string read FHelpKeyword write SetHelpKeyword;
    property HelpContext: THelpContext read FHelpContext write SetHelpContext stored IsHelpContextStored default 0;
  public
    destructor Destroy; override;
    procedure HandleNeeded;
    function HandleAllocated: Boolean;
    property Handle: QObjectH read GetHandle;
    property Hooks: QObject_hookH read GetHooks write FHooks;
    property ParentWidget: QWidgetH read GetParentWidget write SetParentWidget;
  end;

  TMimeSource = class(TPersistent)
  private
    FOwnHandle: Boolean;
    function GetHandle: QMimeSourceH;
    procedure SetHandle(const Value: QMimeSourceH);
    procedure HandleNeeded;
  protected
    FHandle: QMimeSourceH;
    procedure CreateHandle; virtual;
    function HandleAllocated: Boolean;
  public
    constructor Create(AHandle: QMimeSourceH = nil); 
    destructor Destroy; override;
    function SaveToStream(const Format: string; Stream: TStream): Boolean;
    procedure SupportedFormats(List: TStrings);
    function Provides(const Format: string): Boolean;
    procedure OwnHandle;
    procedure ReleaseHandle;
    property Handle: QMimeSourceH read GetHandle write SetHandle;
  end;

  TClxMimeSource = class(TMimeSource)
  private
    function GetHandle: QClxMimeSourceH;
    procedure SetHandle(const Value: QClxMimeSourceH);
  public
    constructor Create(const Format: string; Data: TStream); overload;
    constructor Create(MimeSourceH: QClxMimeSourceH); overload;
    procedure LoadFromStream(Stream: TStream; const Format: string);
    property Handle: QClxMimeSourceH read GetHandle write SetHandle;
  end;

procedure CheckItemCompare;
procedure CopyQStringListToTStrings(Handle: QStringListH; Strings: TStrings);
function QStringListToTStringList(Handle: QStringListH): TStringList;
function TStringsToQStringList(Strings: TStrings): QStringListH;

function IODeviceFromStream(Stream: TStream; Owned: Boolean = False): QIODeviceH;

var
  QtItemCompareFunc: TQtItemCompareFunc = nil;

implementation

uses QControls, QForms, QConsts, BindHelp
{$IFDEF MSWINDOWS}
  , Windows
{$ENDIF}
;

var
  CompareAssigned: Boolean = False;

function DefaultQItemCompareFunc(const W1, W2: WideString): Integer;
begin
  Result := WideCompareText(W1, W2);
end;

function InternalQItemCompare(const P1, P2: PWideChar; N1, N2: Integer): Integer; cdecl;
var
  W1, W2: WideString;
begin
  Result := 0;
  try
    // Necessary to restore byte order we (and Linux) expect...
    CopyUnicodeToPWideString(P1, W1, N1);
    CopyUnicodeToPWideString(P2, W2, N2);
    if not Assigned(QtItemCompareFunc) then
      Result := DefaultQItemCompareFunc(W1, W2)
    else
      Result := QtItemCompareFunc(W1, W2);
  except
    Application.HandleException(nil);
  end;
end;

type
  TSetQtItemCompareFunc = procedure(Func: Pointer); cdecl;

procedure CheckItemCompare;
{$IFDEF LINUX}
 var
  LibQt,
  SetCompareFunc: Pointer;
{$ENDIF}
{$IFDEF MSWINDOWS}
 var
  LibQt : HMODULE;
  SetCompareFunc: Pointer;
{$ENDIF}
begin
  if not CompareAssigned then
  begin
{$IFDEF LINUX}
    LibQt := dlopen(PChar(QtLib), RTLD_LAZY);
    if Assigned(LibQt) then
    begin
      SetCompareFunc := dlsym(LibQt, QtNamePrefix + 'setListBoxCompare');  //do not localize
      if Assigned(SetCompareFunc) then
        TSetQtItemCompareFunc(SetCompareFunc)(@InternalQItemCompare);
      SetCompareFunc := dlsym(LibQt, QtNamePrefix + 'setIconViewCompare'); //do not localize
      if Assigned(SetCompareFunc) then
        TSetQtItemCompareFunc(SetCompareFunc)(@InternalQItemCompare);
      SetCompareFunc := dlsym(LibQt, QtNamePrefix + 'setListViewCompare'); //do not localize
      if Assigned(SetCompareFunc) then
        TSetQtItemCompareFunc(SetCompareFunc)(@InternalQItemCompare);
    end;
{$ENDIF}
{$IFDEF MSWINDOWS}
    LibQt := GetModuleHandle(QtLib);
    if LibQt <> 0 then
    begin
      SetCompareFunc := GetProcAddress(LibQt, QtNamePrefix + 'setListBoxCompare');  //do not localize
      if Assigned(SetCompareFunc) then
        TSetQtItemCompareFunc(SetCompareFunc)(@InternalQItemCompare);
      SetCompareFunc := GetProcAddress(LibQt, QtNamePrefix + 'setIconViewCompare'); //do not localize
      if Assigned(SetCompareFunc) then
        TSetQtItemCompareFunc(SetCompareFunc)(@InternalQItemCompare);
      SetCompareFunc := GetProcAddress(LibQt, QtNamePrefix + 'setListViewCompare'); //do not localize
      if Assigned(SetCompareFunc) then
        TSetQtItemCompareFunc(SetCompareFunc)(@InternalQItemCompare);
    end;
{$ENDIF}
    CompareAssigned := True;
  end;
end;


procedure CopyQStringListToTStrings(Handle: QStringListH; Strings: TStrings);
var
  I: Integer;
  S: WideString;
begin
  Strings.Clear;
  for I := 0 to QOpenStringList_count(QOpenStringListH(Handle)) - 1 do
  begin
    QOpenStringList_value(QOpenStringListH(handle), PWideString(@S), I);
    Strings.Add(S);
  end;
end;

function QStringListToTStringList(Handle: QStringListH): TStringList;
begin
  { It is the user's responsibility to free the result. }
  Result := TStringList.Create;
  CopyQStringListToTStrings(Handle, Result);
end;

function TStringsToQStringList(Strings: TStrings): QStringListH;
var
  I: Integer;
  S: WideString;
begin
  { It is the user's responsibility to free the result. }
  Result := QStringList_create;
  for I := 0 to Strings.Count - 1 do
  begin
    S := Strings.Strings[I];
    QOpenStringList_append(QOpenStringListH(Result), PWideString(@S));
  end;
end;

type
  PIODevice = ^TIODevice;
  TStreamReadProc = function (Rec: PIODevice; var Buffer; Size: Integer): Integer cdecl;
  TStreamWriteProc = function (Rec: PIODevice; var Buffer; Size: Integer): Integer cdecl;
  TStreamSeekProc = function (Rec: PIODevice; Location: Integer; Offset: Integer): Integer cdecl;
  TStreamFreeProc = procedure (Rec: PIODevice) cdecl;
  TIODevice = packed record
    Read: TStreamReadProc;
    Write: TStreamWriteProc;
    Seek: TStreamSeekProc;
    Free: TStreamFreeProc;
    Stream: TStream;
    Owned: Boolean;
  end;

function StreamRead(Rec: PIODevice; var Buffer; Size: Integer): Integer; cdecl;
begin
  try
    Result := Rec.Stream.Read(Buffer, Size);
  except
    Application.HandleException(Rec.Stream);
    Result := -1;
  end;
end;

function StreamWrite(Rec: PIODevice; var Buffer; Size: Integer): Integer; cdecl;
begin
  try
    Result := Rec.Stream.Write(Buffer,Size);
  except
    Application.HandleException(Rec.Stream);
    Result := 1;
  end;
end;

function StreamSeek(Rec: PIODevice; Location: Integer; Offset: Integer): Integer; cdecl;
begin
  try
    Result := Rec.Stream.Seek(Location, Offset);
  except
    Application.HandleException(Rec.Stream);
    Result := -1;
  end;
end;

procedure StreamFree(Rec: PIODevice); cdecl;
begin
  try
    if Rec.Owned then
      Rec.Stream.Free;
    Dispose(Rec);
  except
    Application.HandleException(nil);
  end;
end;

const
  InitDevice: TIODevice = (
    Read: StreamRead;
    Write: StreamWrite;
    Seek: StreamSeek;
    Free: StreamFree;
  );

function IODeviceFromStream(Stream: TStream; Owned: Boolean): QIODeviceH;
var
  Rec: PIODevice;
begin
  New(Rec);
  Rec^ := InitDevice;
  Rec.Stream := Stream;
  Rec.Owned := Owned;
  Result := QClxIODevice_create(Rec);
end;

{ THandleComponent }

procedure THandleComponent.CreateHandle;
begin
  if FHandle = nil then
  begin
    CreateWidget;
    InitWidget;
    HookEvents;
    if (FHandle = nil) then
      raise EHandleComponentException.CreateResFmt(@SInvalidCreateWidget, [ClassName]);
    QClxObjectMap_add(FHandle, Integer(Self));
  end;
end;

destructor THandleComponent.Destroy;
begin
  if FHandle <> nil then
  begin
    DestroyWidget;
    FHandle := nil;
  end;
  inherited Destroy;
end;

procedure THandleComponent.DestroyedHook;
begin
  try
    WidgetDestroyed;
  except
    Application.HandleException(Self);
  end;
end;

procedure THandleComponent.DestroyWidget;
var
  TmpHandle: QObjectH;
begin
  if FHandle <> nil then
  begin
    TmpHandle := FHandle;
    WidgetDestroyed;
    QObject_destroy(TmpHandle);
  end;
end;

function THandleComponent.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin
  Result := False;
  if (QEvent_type(Event) = QEventType_KeyPress) and
  (QKeyEvent_key(QKeyEventH(Event)) = Application.HelpKey) and (Sender = FHandle) then
  begin
    Result := True;
    InvokeHelp;
  end;
end;

function THandleComponent.GetHandle: QObjectH;
begin
  HandleNeeded;
  Result := FHandle;
end;

function THandleComponent.GetHooks: QObject_hookH;
begin
  HandleNeeded;
  Result := FHooks;
end;

type TOpenApplication = class(TApplication);

function THandleComponent.GetParentWidget: QWidgetH;
begin
  if FParentWidget <> nil then
    Result := FParentWidget
  else if not assigned(Application.MainForm) then
    Result := QApplication_desktop
  else
    Result := TOpenApplication(Application).AppWidget;
end;

function THandleComponent.HandleAllocated: Boolean;
begin
  Result := FHandle <> nil;
end;

procedure THandleComponent.HandleNeeded;
begin
  if FHandle = nil then CreateHandle;
end;

procedure THandleComponent.HookEvents;
var
  Method: TMethod;
begin
  if FHooks = nil then
  begin
    Assert(FHandle <> nil);
    FHooks := QObject_hook_create(Handle);
  end;

  TEventFilterMethod(Method) := MainEventFilter;
  Qt_hook_hook_events(FHooks, Method);

  QObject_destroyed_event(Method) := Self.DestroyedHook;
  QObject_hook_hook_destroyed(FHooks, Method);
end;

procedure THandleComponent.InitWidget;
begin
  { Notification }
end;

procedure THandleComponent.InvokeHelp;
begin
  case HelpType of
    htKeyword:
      Application.KeywordHelp(HelpKeyword);
    htContext:
      Application.ContextHelp(HelpContext);
  end;
end;

function THandleComponent.IsHelpContextStored: Boolean;
begin
  Result := True;
end;

procedure THandleComponent.SetParentWidget(const Value: QWidgetH);
begin
  FParentWidget := Value;
end;

procedure THandleComponent.SetHelpContext(const Value: THelpContext);
begin
  if not (csLoading in ComponentState) then FHelpType := htContext;
  FHelpContext := Value;
end;

procedure THandleComponent.SetHelpKeyword(const Value: String);
begin
  if not (csLoading in ComponentState) then FHelpType := htKeyword;
  FHelpKeyword := Value;
end;

procedure THandleComponent.WidgetDestroyed;
begin
  QClxObjectMap_remove(FHandle);
  FHandle := nil;
  QObject_hook_destroy(FHooks);
  FHooks := nil;
end;

function THandleComponent.MainEventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
begin
  Result := False;
  try
    Result := EventFilter(Sender, Event);
  except
    Application.HandleException(Self);
  end;
end;

{ TClxMimeSource }

constructor TClxMimeSource.Create(const Format: string; Data: TStream);
begin
  inherited Create;
  LoadFromStream(Data, Format);
end;

constructor TClxMimeSource.Create(MimeSourceH: QClxMimeSourceH);
begin
  inherited Create;
  FHandle := MimeSourceH;
end;

function TClxMimeSource.GetHandle: QClxMimeSourceH;
begin
  HandleNeeded;
  Result := QClxMimeSourceH(FHandle);
end;

procedure TClxMimeSource.LoadFromStream(Stream: TStream; const Format: string);
var
  IO: QIODeviceH;
  ByteArray: QByteArrayH;
begin
  if not Assigned(Stream) then
    raise EInvalidParam.CreateRes(@SInvalidMimeSourceStream);
  IO := IODeviceFromStream(Stream);
  ByteArray := nil;
  try
    ByteArray := QByteArray_create(0);
    QIODevice_readAll(IO, ByteArray);
    QClxMimeSource_addFormat(Handle, PChar(Format), ByteArray);
  finally
    QIODevice_destroy(IO);
    if Assigned(ByteArray) then
      QByteArray_destroy(ByteArray);
  end;
end;

procedure TClxMimeSource.SetHandle(const Value: QClxMimeSourceH);
begin
  if FHandle <> Value then
    FHandle := Value;
end;

{ TMimeSource }

constructor TMimeSource.Create(AHandle: QMimeSourceH);
begin
  inherited Create;
  FHandle := AHandle;
end;

procedure TMimeSource.CreateHandle;
begin
  FHandle := QClxMimeSource_create;
end;

destructor TMimeSource.Destroy;
begin
  if HandleAllocated and FOwnHandle then
    QMimeSource_destroy(FHandle);
  inherited Destroy;
end;

function TMimeSource.GetHandle: QMimeSourceH;
begin
  HandleNeeded;
  Result := FHandle;
end;

function TMimeSource.HandleAllocated: Boolean;
begin
  Result := FHandle <> nil;
end;

procedure TMimeSource.HandleNeeded;
begin
  if not HandleAllocated then
    CreateHandle; 
end;

function TMimeSource.Provides(const Format: string): Boolean;
begin
  Result := QMimeSource_provides(Handle, PChar(Format));
end;

function TMimeSource.SaveToStream(const Format: string;
  Stream: TStream): Boolean;
var
  IO: QIODeviceH;
  ByteArray: QByteArrayH;
begin
  Result := False;
  if not Assigned(Stream) then
    raise EInvalidParam.CreateRes(@SInvalidMimeSourceStream);
  if Provides(Format) then
  begin
    IO := IODeviceFromStream(Stream);
    try
      ByteArray := QByteArray_create(0);
      try
        QMimeSource_encodedData(Handle, ByteArray, PChar(Format));
        if not Boolean(QIODevice_writeBlock(IO, ByteArray)) then
          Stream.Size := 0;
        Result := True;
      finally
        QByteArray_destroy(ByteArray);
      end;
    finally
      QIODevice_destroy(IO);
    end;
  end;
end;

procedure TMimeSource.SetHandle(const Value: QMimeSourceH);
begin
  if FHandle <> Value then
  begin
    FHandle := Value;
    OwnHandle;
  end;
end;

procedure TMimeSource.SupportedFormats(List: TStrings);
var
  I: Integer;
  Str: PChar;
begin
  if Assigned(List) then
  begin
    List.Clear;
    I := 0;
    while True do
    begin
      Str := QMimeSource_format(Handle, i);
      if not Assigned(Str) then
        Exit;
      List.Add(Str);
      Inc(I);
    end;
  end;
end;

procedure TMimeSource.ReleaseHandle;
begin
  FHandle := nil;
  FOwnHandle := False;
end;

procedure TMimeSource.OwnHandle;
begin
  FOwnHandle := True;
end;

end.
