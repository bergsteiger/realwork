{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.DdeMan;

{$R-,T-,H+,X+}

interface

uses
{$IF DEFINED(CLR)}
  System.Collections, System.ComponentModel.Design.Serialization,
  System.Security.Permissions,
{$ENDIF}
  Winapi.Windows, System.Classes, Vcl.Forms, Winapi.DDEml;

type
  TDataMode = (ddeAutomatic, ddeManual);
  TDdeServerConv = class;

  TMacroEvent = procedure(Sender: TObject; Msg: TStrings) of object;

  TDdeClientItem = class;

{$IF DEFINED(CLR)}
  TFinalizeHConvNotify = procedure(Handle: HConv) of object;
  TFinalizeDDENotify = procedure(InstID: Longint) of object;
{$ENDIF}

{ TDdeClientConv }

  [RootDesignerSerializerAttribute('', '', False)]
  [SecurityPermission(SecurityAction.LinkDemand, UnmanagedCode=True)]
  TDdeClientConv = class(TComponent)
  private
    FDdeService: string;
    FDdeTopic: string;
    FCnvInfo: TConvInfo;
    FItems: TList;
    FDdeFmt: Integer;
    FOnClose: TNotifyEvent;
    FOnOpen: TNotifyEvent;
    FAppName: string;
    FDataMode: TDataMode;
    FConnectMode: TDataMode;
    FWaitStat: Boolean;
    FFormatChars: Boolean;
{$IF DEFINED(CLR)}
    FConvObj: TObject;
    FHszAppObj: TObject;
    FHszTopicObj: TObject;
{$ELSE}
    FConv: HConv;
    FHszApp: HSZ;
    FHszTopic: HSZ;
{$ENDIF}
    procedure SetDdeService(const Value: string);
    procedure SetDdeTopic(const Value: string);
    procedure SetService(const Value: string);
    procedure SetTopic(const Value: string);
    procedure SetConnectMode(NewMode: TDataMode);
    procedure SetFormatChars(NewFmt: Boolean);
    procedure XactComplete;
    procedure SrvrDisconnect;
    procedure DataChange(DdeDat: HDDEData; hszIt: HSZ);
{$IF DEFINED(CLR)}
    function get_FConv: HConv;
    function get_FHszApp: Hsz;
    function get_FHszTopic: Hsz;
    procedure set_FConv(const Value: HConv);
    procedure set_FHszApp(const Value: Hsz);
    procedure set_FHszTopic(const Value: Hsz);
    property FConv: HConv read get_FConv write set_FConv;
    property FHszApp: Hsz read get_FHszApp write set_FHszApp;
    property FHszTopic: Hsz read get_FHszTopic write set_FHszTopic;
{$ENDIF}
  protected
    function CreateDdeConv(FHszApp: HSZ; FHszTopic: HSZ): Boolean;
    function GetCliItemByName(const ItemName: string): TPersistent;
    function GetCliItemByCtrl(ACtrl: TDdeClientItem): TPersistent;
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadLinkInfo(Reader: TReader);
    procedure WriteLinkInfo(Writer: TWriter);
    function OnSetItem(aCtrl: TDdeClientItem; const S: string): Boolean;
    procedure OnAttach(aCtrl: TDdeClientItem);
    procedure OnDetach(aCtrl: TDdeClientItem);
    procedure Close; dynamic;
    procedure Open; dynamic;
    function ChangeLink(const App, Topic, Item: string): Boolean;
    procedure ClearItems;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PasteLink: Boolean;
    function OpenLink: Boolean;
    function SetLink(const Service, Topic: string): Boolean;
    procedure CloseLink;
    function StartAdvise: Boolean;
    function PokeDataLines(const Item: string; Data: TStrings): Boolean;
    function ExecuteMacroLines(Cmd: TStrings; waitFlg: Boolean): Boolean;
{$IF DEFINED(CLR)}
    function PokeData(const Item: string; Data: string): Boolean; overload;
    function PokeData(const Item: string; Data: IntPtr; Len: Integer): Boolean; overload;
    function ExecuteMacro(Cmd: string; waitFlg: Boolean): Boolean; overload;
    function ExecuteMacro(Cmd: IntPtr; Len: Integer; waitFlg: Boolean): Boolean; overload;
    function RequestData(const Item: string): TBytes;
    property Conv: HConv read get_FConv;
{$ELSE}
    function PokeData(const Item: string; Data: PAnsiChar): Boolean;
    function ExecuteMacro(Cmd: PAnsiChar; waitFlg: Boolean): Boolean;
    function RequestData(const Item: string): PAnsiChar;
    property Conv: HConv read FConv;
{$ENDIF}
    property DdeFmt: Integer read FDdeFmt;
    property WaitStat: Boolean read FWaitStat;
    property DataMode: TDataMode read FDataMode write FDataMode;
  published
    property ServiceApplication: string read FAppName write FAppName;
    property DdeService: string read FDdeService write SetDdeService;
    property DdeTopic: string read FDdeTopic write SetDdeTopic;
    property ConnectMode: TDataMode read FConnectMode write SetConnectMode default ddeAutomatic;
    property FormatChars: Boolean read FFormatChars write SetFormatChars default False;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
  end;

{ TDdeClientItem }

  [RootDesignerSerializerAttribute('', '', False)]
  [SecurityPermission(SecurityAction.LinkDemand, UnmanagedCode=True)]
  TDdeClientItem = class(TComponent)
  private
    FLines: TStrings;
    FDdeClientConv: TDdeClientConv;
    FDdeClientItem: string;
    FOnChange: TNotifyEvent;
    function GetText: string;
    procedure SetDdeClientItem(const Val: string);
    procedure SetDdeClientConv(Val: TDdeClientConv);
    procedure SetText(const S: string);
    procedure SetLines(L: TStrings);
    procedure OnAdvise;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Text: string read GetText write SetText;
    property Lines: TStrings read FLines write SetLines;
    property DdeConv: TDdeClientConv read FDdeClientConv write SetDdeClientConv;
    property DdeItem: string read FDdeClientItem write SetDdeClientItem;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

{ TDdeServerConv }

  [RootDesignerSerializerAttribute('', '', False)]
  TDdeServerConv = class(TComponent)
  private
    FOnOpen: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FOnExecuteMacro: TMacroEvent;
  protected
    procedure Connect; dynamic;
    procedure Disconnect; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteMacro(Data: HDdeData): LongInt;
  published
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnExecuteMacro: TMacroEvent read FOnExecuteMacro write FOnExecuteMacro;
  end;

{ TDdeServerItem }

  [RootDesignerSerializerAttribute('', '', False)]
  [SecurityPermission(SecurityAction.LinkDemand, UnmanagedCode=True)]
  TDdeServerItem = class(TComponent)
  private
    FLines: TStrings;
    FServerConv: TDdeServerConv;
    FOnChange: TNotifyEvent;
    FOnPokeData: TNotifyEvent;
    FFmt: Integer;
    procedure ValueChanged;
  protected
    function GetText: string;
    procedure SetText(const Item: string);
    procedure SetLines(Value: TStrings);
    procedure SetServerConv(SConv: TDdeServerConv);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PokeData(Data: HDdeData): LongInt;
    procedure CopyToClipboard;
    procedure Change; dynamic;
    property Fmt: Integer read FFmt;
  published
    property ServerConv: TDdeServerConv read FServerConv write SetServerConv;
    property Text: string read GetText write SetText;
    property Lines: TStrings read FLines write SetLines;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnPokeData: TNotifyEvent read FOnPokeData write FOnPokeData;
  end;

  { TDdeResources }

{$IF DEFINED(CLR)}
  [SecurityPermission(SecurityAction.LinkDemand, UnmanagedCode=True)]
  TDdeResources = class
  private
    FInstance: Longint; // DDE Instance handle
    FAppName: HSZ; // DDE application name
    FStrings: TList; // string handles for topic names and server items
    FConvHandles: TList; // conversation handles
    FCliItems: TList; // string handles for client items
  strict protected
    procedure Finalize; override;
    procedure FreeResources;
  public
    constructor Create;
    destructor Destroy; override;
  end;
{$ENDIF}

{ TDdeMgr }

  [RootDesignerSerializerAttribute('', '', False)]
  [SecurityPermission(SecurityAction.LinkDemand, UnmanagedCode=True)]
  TDdeMgr = class(TComponent)
  private
    FAppName: string;
    FConvs: TList;
    FCliConvs: TList;
    FConvCtrls: TList;
    FLinkClipFmt: Word;
{$IF NOT DEFINED(CLR)}
    FHszApp: HSZ;
    FDdeInstId: Longint;
{$ELSE}
    FResources: TDdeResources;
    FConvHashTable: System.Collections.HashTable;
    FCliConvHashTable: System.Collections.HashTable;
    FCallback: DDEml.TFNCallback;
    function DdeMgrCallBack(CallType, Fmt : UINT; Conv: HConv; hsz1, hsz2: HSZ;
      Data: HDDEData; Data1, Data2: ULONG_PTR): HDDEData;
{$ENDIF}
    procedure Disconnect(DdeSrvrConv: TComponent);
    function GetDdeInstId: LongInt;
    function GetSrvrConv(const Topic: string ): TComponent;
    function AllowConnect(hszApp: HSZ; hszTopic: HSZ): Boolean;
    function AllowWildConnect(hszApp: HSZ; hszTopic: HSZ): HDdeData;
    function Connect(Conv: HConv; hszTopic: HSZ; SameInst: Boolean): Boolean;
    procedure PostDataChange(const Topic: string; Item: string);
    procedure SetAppName(const Name: string);
    procedure SetDdeInstId(const ID: LongInt);
    procedure ResetAppName;
    function  GetServerConv(const Topic: string): TDdeServerConv;
    procedure InsertServerConv(SConv: TDdeServerConv);
    procedure RemoveServerConv(SConv: TDdeServerConv);
//    procedure DoError;
    function  GetForm(const Topic: string): TForm;
{$IF DEFINED(CLR)}
    function get_FHszApp: Hsz;
    procedure set_FHszApp(const Value: Hsz);
    property FHszApp: Hsz read get_FHszApp write set_FHszApp;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetExeName: string; deprecated;
    property DdeInstId: LongInt read GetDdeInstId write SetDdeInstId;
    property AppName: string read FAppName write SetAppName;
    property LinkClipFmt: Word read FLinkClipFmt;
  end;

  function GetPasteLinkInfo(var Service: string; var Topic: string;
    var Item: string): Boolean;
var
  ddeMgr: TDdeMgr;

implementation

uses 
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices, System.Text, System.IO,
{$ENDIF}
  System.Types, System.SysUtils, Vcl.Dialogs, Vcl.Controls, Vcl.Consts, Vcl.Clipbrd;

type
  EDdeError = class(Exception);
  TDdeSrvrConv = class;

{ TDdeSrvrItem }

  [RootDesignerSerializerAttribute('', '', False)]
  TDdeSrvrItem = class(TComponent)
  private
    FConv: TDdeSrvrConv;
    FItem: string;
    FSrvr: TDdeServerItem;
{$IF NOT DEFINED(CLR)}
    FHszItem: HSZ;
{$ELSE}
    FHszItem: TObject;
{$ENDIF}
    function GetHszItem: HSZ;
    procedure SetHszItem(const Value: HSZ);
  protected
    procedure SetItem(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RequestData(Fmt: Word): HDdeData;
    procedure PostDataChange;
    property Conv: TDdeSrvrConv read FConv write FConv;
    property Item: string read FItem write SetItem;
    property Srvr: TDdeServerItem read FSrvr write FSrvr;
    property HszItem: HSZ read GetHszItem;
  end;

{ TDdeSrvrConv }

  [RootDesignerSerializerAttribute('', '', False)]
  TDdeSrvrConv = class(TComponent)
  private
    FTopic: string;
    FForm: TForm;
    FSConv: TDdeServerConv;
    FItems: TList;
{$IF DEFINED(CLR)}
    FHszTopic: TObject;
    FConvObj: TObject;
{$ELSE}
    FHszTopic: HSZ;
    FConv: HConv;
{$ENDIF}
    function get_FConv: HConv;
    function GetHszTopic: HSZ;
    procedure SetHszTopic(const Value: HSZ);
{$IF DEFINED(CLR)}
    procedure set_FConv(const Value: HConv);
    property FConv: HConv read get_FConv write set_FConv;
{$ENDIF}
  protected
    function GetControl(WinCtrl: TWinControl; DdeConv: TDdeServerConv; const ItemName: string): TDdeServerItem;
    function GetSrvrItem(hszItem: HSZ): TDdeSrvrItem;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RequestData(Conv: HConv; hszTopic: HSZ; hszItem: HSZ;
      Fmt: Word): HDdeData;
    function AdvStart(Conv: HConv; hszTopic: HSZ; hszItem: HSZ;
      Fmt: Word): Boolean;
    procedure AdvStop(Conv: HConv; hszTopic: HSZ; hszItem: HSZ);
    function PokeData(Conv: HConv; hszTopic: HSZ; hszItem: HSZ; Data: HDdeData;
      Fmt: Integer): LongInt;
    function ExecuteMacro(Conv: HConv; hszTopic: HSZ; Data: HDdeData): Integer;
    function GetItem(const ItemName: string): TDdeSrvrItem;
    property Conv: HConv read get_FConv;
    property Form: TForm read FForm;
    property SConv: TDdeServerConv read FSConv;
    property Topic: string read FTopic write FTopic;
    property HszTopic: HSZ read GetHszTopic;
  end;

{ TDdeCliItem }

type
{$IF DEFINED(CLR)}
  TCliItemInfo = class
    FConv: HConv;
    FFormat: UINT;
    FName: HSZ;
  end;
{$ENDIF}

  [RootDesignerSerializerAttribute('', '', False)]
  TDdeCliItem = class(TPersistent)
  private
    function GetHszItem: Hsz;
    procedure SetHszItem(const Value: Hsz);
  protected
    FItem: string;
    FCliConv: TDdeClientConv;
    FCtrl: TDdeClientItem;
{$IF DEFINED(CLR)}
    FHszItem: TCliItemInfo;
{$ELSE}
    FHszItem: HSZ;
{$ENDIF}
    function StartAdvise: Boolean;
    function StopAdvise: Boolean;
    procedure StoreData(DdeDat: HDDEData);
    procedure DataChange;
    procedure ReleaseData(DdeDat: HDDEData);
{$IF DEFINED(CLR)}
    function AccessData(DdeDat: HDDEData; var DataLen: DWORD): IntPtr;
{$ELSE}
    function AccessData(DdeDat: HDDEData; pDataLen: PDWORD): Pointer;
{$ENDIF}
  public
    constructor Create(ADS: TDdeClientConv);
    destructor Destroy; override;
    function RefreshData: Boolean;
    function SetItem(const S: string): Boolean;
    procedure SrvrDisconnect;
    property HszItem: HSZ read GetHszItem;
    property Control: TDdeClientItem read FCtrl write FCtrl;
  published
    property Item: string read FItem;
  end;

    { Utility functions }

procedure DDECheck(Success: Boolean);
var
  err: Integer;
  ErrStr: string;
begin
  if Success then Exit;
  err := DdeGetLastError(DDEMgr.DdeInstId);
  case err of
    DMLERR_LOW_MEMORY, DMLERR_MEMORY_ERROR:
      ErrStr := Format(SDdeMemErr, [err]);
    DMLERR_NO_CONV_ESTABLISHED:
      ErrStr := Format(SDdeConvErr, [err]);
  else
    ErrStr := Format(SDdeErr, [err]);
  end;
  raise EDdeError.Create(ErrStr);
end;

{$IF NOT DEFINED(CLR)}
function DdeMgrCallBack(CallType, Fmt : UINT; Conv: HConv; hsz1, hsz2: HSZ;
  Data: HDDEData; Data1, Data2: ULONG_PTR): HDDEData; stdcall;
var
  ci: TConvInfo;
  ddeCli: TComponent;
  ddeSrv: TDdeSrvrConv;
  ddeObj: TComponent;
  xID: DWORD;
begin
  Result := 0;
  case CallType of
    XTYP_CONNECT:
      Result := HDdeData(ddeMgr.AllowConnect(hsz2, hsz1));
    XTYP_WILDCONNECT:
      Result := ddeMgr.AllowWildConnect(hsz2, hsz1);
    XTYP_CONNECT_CONFIRM:
      ddeMgr.Connect(Conv, hsz1, Boolean(Data2));
  end;
  if Conv <> 0 then
  begin
    ci.cb := sizeof(TConvInfo);
    if CallType = XTYP_XACT_COMPLETE then
      xID := Data1
    else
      xID := QID_SYNC;
    if DdeQueryConvInfo(Conv, xID, @ci) = 0 then Exit;
    case CallType of
      XTYP_ADVREQ:
        begin
          ddeSrv := TDdeSrvrConv(ci.hUser);
          Result := ddeSrv.RequestData(Conv, hsz1, hsz2, Fmt);
        end;
      XTYP_REQUEST:
        begin
          ddeSrv := TDdeSrvrConv(ci.hUser);
          Result := ddeSrv.RequestData(Conv, hsz1, hsz2, Fmt);
        end;
      XTYP_ADVSTOP:
        begin
          ddeSrv := TDdeSrvrConv(ci.hUser);
          ddeSrv.AdvStop(Conv, hsz1, hsz2);
        end;
      XTYP_ADVSTART:
        begin
          ddeSrv := TDdeSrvrConv(ci.hUser);
          Result := HDdeData(ddeSrv.AdvStart(Conv, hsz1, hsz2, Fmt));
        end;
      XTYP_POKE:
        begin
          ddeSrv := TDdeSrvrConv(ci.hUser);
          Result := HDdeData(ddeSrv.PokeData(Conv, hsz1, hsz2, Data, Fmt));
        end;
      XTYP_EXECUTE:
        begin
          ddeSrv := TDdeSrvrConv(ci.hUser);
          Result := HDdeData(ddeSrv.ExecuteMacro(Conv, hsz1, Data));
        end;
      XTYP_XACT_COMPLETE:
        begin
          ddeCli := TComponent(ci.hUser);
          if ddeCli <> nil then TDdeClientConv(ddeCli).XactComplete
        end;
      XTYP_ADVDATA:
        begin
          ddeCli := TComponent(ci.hUser);
          TDdeClientConv(ddeCli).DataChange(Data, hsz2);
        end;
      XTYP_DISCONNECT:
        begin
          ddeObj := TComponent(ci.hUser);
          if ddeObj <> nil then
          begin
            if ddeObj is TDdeClientConv then
              TDdeClientConv(ddeObj).SrvrDisconnect
            else
              ddeMgr.Disconnect(ddeObj);
          end;
        end;
    end;
  end;
end;
{$ENDIF}

// .NET note, GetPasteLinkInfo assumes that the paste link info uses a narrow (ansi)
// encoding rather than a wide (unicode) encoding 

[SecurityPermission(SecurityAction.LinkDemand, UnmanagedCode=True)]
[UIPermission(SecurityAction.LinkDemand, Clipboard=UIPermissionClipboard.AllClipboard)]
function GetPasteLinkInfo(var Service, Topic, Item: string): Boolean;
{$IF DEFINED(CLR)}
var
  hData: THandle;
  pData: IntPtr;
  B: Byte;
  SB: StringBuilder;
  I: Integer;
begin
  Result := False;
  OpenClipboard(0);
  try
    hData := GetClipboardData(ddeMgr.LinkClipFmt);
    if hData <> 0 then
    begin
      SB := StringBuilder.Create;
      pData := GlobalLock(hData);
      try
        I := 0;
        repeat
          B := Marshal.ReadByte(pData, I);
          if B <> 0 then
            SB.Append(Char(AnsiChar(B)));
          Inc(I);
        until B = 0;
        Service := SB.ToString;
        SB.Remove(0, SB.Length); // clear the stringbuilder
        repeat
          B := Marshal.ReadByte(pData, I);
          if B <> 0 then
            SB.Append(Char(AnsiChar(B)));
          Inc(I);
        until B = 0;
        Topic := SB.ToString;
        SB.Remove(0, SB.Length); // clear the stringbuilder
        repeat
          B := Marshal.ReadByte(pData, I);
          if B <> 0 then
            SB.Append(Char(AnsiChar(B)));
          Inc(I);
        until B = 0;
        Item := SB.ToString;
      finally
        GlobalUnlock(hData);
      end;
      Result := True;
    end;
  finally
    CloseClipboard;
  end;
end;
{$ELSE}
var
  hData: THandle;
  pData: Pointer;
  P: PAnsiChar;
  LService: AnsiString;
  LTopic: AnsiString;
  LItem: AnsiString;
begin
  Result := False;
  Clipboard.Open;
  hData := Clipboard.GetAsHandle(ddeMgr.LinkClipFmt);
  if hData <> 0 then
  begin
    pData := GlobalLock(hData);
    try
      P := PAnsiChar(pData);
      LService := PAnsiChar(pData);
      P := P + Length(LService) + 1;
      LTopic := P;
      P := P + Length(LTopic) + 1;
      LItem := P;
    finally
      GlobalUnlock(hData);
    end;
    Service := string(LService);
    Topic := string(LTopic);
    Item := string(LItem);
    Result := True;
  end;
  Clipboard.Close;
end;
{$ENDIF}

  { TDdeResources }

{$IF DEFINED(CLR)}
procedure TDdeResources.Finalize;
begin
  FreeResources;
end;

{ This frees any remaining Dde resources in the required order }
procedure TDdeResources.FreeResources;
var
  ddeRslt: DWORD;
  I : Integer;
  CII: TCliItemInfo;
begin
  if Assigned(FCliItems) then
  begin
    for I := 0 to FCliItems.Count - 1 do
    begin
      CII := TCliItemInfo(FCliItems[I]);
      if CII.FName <> 0 then
      begin
       if CII.FConv <> 0 then
         DdeClientTransaction(nil, DWORD(-1), CII.FConv, CII.FName, CII.FFormat,
           XTYP_ADVSTOP, 1000, ddeRslt);
       DdeFreeStringHandle(FInstance, CII.FName);
      end;
    end;
    FreeAndNil(FCliItems);
  end;
  if Assigned(FConvHandles) then
  begin
    for I := 0 to FConvHandles.Count - 1 do
      if HConv(FConvHandles[I]) <> 0 then
        DdeDisconnect(HConv(FConvHandles[I]));
    FreeAndNil(FConvHandles);
  end;
  if Assigned(FStrings) then
  begin
    for I := 0 to FStrings.Count - 1 do
      if HSz(FStrings[I]) <> 0 then
        DdeFreeStringHandle(FInstance, HSz(FStrings[I]));
    FreeAndNil(FStrings);
  end;
  if FAppName <> 0 then
  begin
    DdeNameService(FInstance, FAppName, 0, DNS_UNREGISTER);
    DdeFreeStringHandle(FInstance, FAppName);
    FAppName := 0;
  end;
  if FInstance <> 0 then
  begin
    DdeUnInitialize(FInstance);
    FInstance := 0;
  end;
end;

constructor TDdeResources.Create;
begin
  inherited;
  FStrings := TList.Create;
  FConvHandles := TList.Create;
  FCliItems := TList.Create;
end;

destructor TDdeResources.Destroy;
begin
  FreeResources;
  System.GC.SuppressFinalize(self);
end;
{$ENDIF}

  { TDdeMgr }

constructor TDdeMgr.Create(AOwner: TComponent);
{$IF DEFINED(CLR)}
var
  DDEInst: Longint;
{$ENDIF}
begin
  inherited Create(AOwner);
  FLinkClipFmt := RegisterClipboardFormat('Link');
{$IF DEFINED(CLR)}
  FCallback := @DdeMgrCallback; // save a reference to the delegate
  FResources := TDdeResources.Create;
  DDECheck(DdeInitialize(DDEInst, FCallback, APPCLASS_STANDARD, 0) = 0);
  DdeInstID := DDEInst;
  FConvHashTable := System.Collections.HashTable.Create;
  FCliConvHashTable := System.Collections.HashTable.Create;
{$ELSE}
  FDdeInstId := 0;
{$IFDEF MSWINDOWS}
  DDECheck(DdeInitializeA(FDdeInstId, DdeMgrCallBack, APPCLASS_STANDARD, 0) = 0);
{$ENDIF}
{$ENDIF}
  FConvs := TList.Create;
  FCliConvs := TList.Create;
  FConvCtrls := TList.Create;
  AppName := ParamStr(0);
end;

destructor TDdeMgr.Destroy;
var
  I: Integer;
begin
  if FConvs <> nil then
  begin
    for I := 0 to FConvs.Count - 1 do
      TDdeSrvrConv(FConvs[I]).Free;
    FreeAndNil(FConvs);
  end;
  if FCliConvs <> nil then
  begin
    for I := 0 to FCliConvs.Count - 1 do
      TDdeSrvrConv(FCliConvs[I]).Free;
    FCliConvs.Free;
    FCliConvs := nil;
  end;
  if FConvCtrls <> nil then
  begin
    FConvCtrls.Free;
    FConvCtrls := nil;
  end;
{$IF DEFINED(CLR)}
  FreeAndNil(FResources);
{$ELSE}
  ResetAppName;
{$IFDEF MSWINDOWS}   
  DdeUnInitialize(FDdeInstId);
{$ENDIF}   
{$ENDIF}
  DdeMgr := nil;
  inherited Destroy;
end;

{$IF DEFINED(CLR)}
function TDdeMgr.DdeMgrCallBack(CallType, Fmt : UINT; Conv: HConv; hsz1, hsz2: HSZ;
  Data: HDDEData; Data1, Data2: ULONG_PTR): HDDEData;
var
  ddeCli: TComponent;
  ddeSrv: TDdeSrvrConv;
begin
  Result := 0;
  case CallType of
    XTYP_CONNECT:
      Result := HDdeData(ddeMgr.AllowConnect(hsz2, hsz1));
    XTYP_WILDCONNECT:
      Result := ddeMgr.AllowWildConnect(hsz2, hsz1);
    XTYP_CONNECT_CONFIRM:
      ddeMgr.Connect(Conv, hsz1, Data2 <> 0);
  end;
  if Conv <> 0 then
  begin
    case CallType of
      XTYP_ADVREQ:
        begin
          ddeSrv := TDdeSrvrConv(FConvHashTable[TObject(Conv)]);
          if ddeSrv <> nil then
            Result := ddeSrv.RequestData(Conv, hsz1, hsz2, Fmt);
        end;
      XTYP_REQUEST:
        begin
          ddeSrv := TDdeSrvrConv(FConvHashTable[TObject(Conv)]);
          if ddeSrv <> nil then
            Result := ddeSrv.RequestData(Conv, hsz1, hsz2, Fmt);
        end;
      XTYP_ADVSTOP:
        begin
          ddeSrv := TDdeSrvrConv(FConvHashTable[TObject(Conv)]);
          if ddeSrv <> nil then
            ddeSrv.AdvStop(Conv, hsz1, hsz2);
        end;
      XTYP_ADVSTART:
        begin
          ddeSrv := TDdeSrvrConv(FConvHashTable[TObject(Conv)]);
          if ddeSrv <> nil then
            Result := HDdeData(ddeSrv.AdvStart(Conv, hsz1, hsz2, Fmt));
        end;
      XTYP_POKE:
        begin
          ddeSrv := TDdeSrvrConv(FConvHashTable[TObject(Conv)]);
          if ddeSrv <> nil then
            Result := HDdeData(ddeSrv.PokeData(Conv, hsz1, hsz2, Data, Fmt));
        end;
      XTYP_EXECUTE:
        begin
          ddeSrv := TDdeSrvrConv(FConvHashTable[TObject(Conv)]);
          if ddeSrv <> nil then
            Result := HDdeData(ddeSrv.ExecuteMacro(Conv, hsz1, Data));
        end;
      XTYP_XACT_COMPLETE:
        begin
          ddeCli := TComponent(FCliConvHashTable[TObject(Conv)]);
          if ddeCli <> nil then TDdeClientConv(ddeCli).XactComplete
        end;
      XTYP_ADVDATA:
        begin
          ddeCli := TComponent(FCliConvHashTable[TObject(Conv)]);
          if ddeCli <> nil then
            TDdeClientConv(ddeCli).DataChange(Data, hsz2);
        end;
      XTYP_DISCONNECT:
        begin
          ddeCli := TComponent(FCliConvHashTable[TObject(Conv)]);
          if ddeCli <> nil then
            TDdeClientConv(ddeCli).SrvrDisconnect
          else
          begin
            ddeSrv := TDdeSrvrConv(FConvHashTable[TObject(Conv)]);
            if ddeSrv <> nil then
              ddeMgr.Disconnect(ddeSrv);
          end;
        end;
    end;
  end;
end;
{$ENDIF}

function TDdeMgr.AllowConnect(hszApp: HSZ; hszTopic: HSZ): Boolean;
var
  Topic: string;
  Form: TForm;
  SConv: TDdeServerConv;
{$IF DEFINED(CLR)}
  SB: StringBuilder;
{$ELSE}
  Buffer: array[0..4095] of AnsiChar;
{$ENDIF}
begin
  Result := False;
  if (hszApp = 0) or (DdeCmpStringHandles(hszApp, FHszApp) = 0)  then
  begin
{$IF DEFINED(CLR)}
    SB := StringBuilder.Create(4096);
    DdeQueryStringA(DdeInstId, hszTopic, SB, SB.Capacity, CP_WINANSI);
    Topic := SB.ToString;
{$ELSE}
    SetString(Topic, Buffer, DdeQueryStringA(FDdeInstId, hszTopic, Buffer,
      Length(Buffer), CP_WINANSI));
{$ENDIF}
    SConv := GetServerConv(Topic);
    if SConv <> nil then
      Result := True
    else begin
      Form := GetForm(Topic);
      if Form <> nil then Result := True;
    end;
  end;
end;

function TDdeMgr.AllowWildConnect(hszApp: HSZ; hszTopic: HSZ): HDdeData;
{$IF DEFINED(CLR)}
var
  Mem: IntPtr;
begin
  Result := 0;
  if hszTopic = 0 then Exit;
  if AllowConnect(hszApp, hszTopic) = True then
  begin
    Mem := Marshal.AllocHGlobal(2 * Marshal.SizeOf(TypeOf(THSZPair)));
    try
      Marshal.WriteInt32(Mem, HszApp);                 // conns[0].hszSvc := FHszApp;
      Marshal.WriteInt32(Mem, SizeOf(Hsz), hszTopic);  // conns[0].hszTopic := hszTopic;
      Marshal.WriteInt32(Mem, 2 * SizeOf(Hsz), 0);     // conns[1].hszSvc := 0;
      Marshal.WriteInt32(Mem, 3 * sizeOf(Hsz), 0);     // conns[1].hszTopic := 0;
      Result := DdeCreateDataHandle(DdeInstId, Mem,
        2 * Marshal.sizeof(TypeOf(THSZPair)), 0, 0, CF_TEXT, 0);
    finally
      Marshal.FreeHGlobal(Mem);
    end;
  end;
{$ELSE}
var
  conns: packed array[0..1] of THSZPair;
begin
  Result := 0;
  if hszTopic = 0 then Exit;
  if AllowConnect(hszApp, hszTopic) = True then
  begin
    conns[0].hszSvc := FHszApp;
    conns[0].hszTopic := hszTopic;
    conns[1].hszSvc := 0;
    conns[1].hszTopic := 0;
    Result := DdeCreateDataHandle(ddeMgr.DdeInstId, @conns,
      2 * sizeof(THSZPair), 0, 0, CF_TEXT, 0);
  end;
{$ENDIF}
end;

function TDdeMgr.Connect(Conv: HConv; hszTopic: HSZ; SameInst: Boolean): Boolean;
var
  Topic: string;
  DdeConv: TDdeSrvrConv;
{$IF DEFINED(CLR)}
  Buffer: StringBuilder;
{$ELSE}
  Buffer: array[0..4095] of AnsiChar;
{$ENDIF}
begin
  DdeConv := TDdeSrvrConv.Create(Self);
{$IF DEFINED(CLR)}
  Buffer := StringBuilder.Create(4096);
  DdeQueryStringA(DdeInstId, hszTopic, Buffer, Buffer.Capacity, CP_WINANSI);
  Topic := Buffer.ToString;
{$ELSE}
  SetString(Topic, Buffer, DdeQueryStringA(FDdeInstId, hszTopic, Buffer,
    Length(Buffer), CP_WINANSI));
{$ENDIF}
  DdeConv.Topic := Topic;
  DdeConv.FSConv := GetServerConv(Topic);
  if DdeConv.FSConv = nil then
    DdeConv.FForm := GetForm(Topic);
  DdeConv.FConv := Conv;
{$IF NOT DEFINED(CLR)}
  DdeSetUserHandle(Conv, QID_SYNC, DWORD_PTR(DdeConv));
{$ELSE}
  FConvHashTable.Add(TObject(Conv), DdeConv);
{$ENDIF}
  FConvs.Add(DdeConv);
  if DdeConv.FSConv <> nil then DdeConv.FSConv.Connect;
  Result := True;
end;

procedure TDdeMgr.Disconnect(DdeSrvrConv: TComponent);
var
  DdeConv: TDdeSrvrConv;
begin
  DdeConv := TDdeSrvrConv(DdeSrvrConv);
  if DdeConv.FSConv <> nil then DdeConv.FSConv.Disconnect;
{$IF DEFINED(CLR)}
  FConvHashTable.Remove(TObject(DdeConv.Conv));
{$ELSE}
  if DdeConv.FConv <> 0 then DdeSetUserHandle(DdeConv.FConv, QID_SYNC, 0);
{$ENDIF}
  DdeConv.FConv := 0;
  if FConvs <> nil then
  begin
    FConvs.Remove(DdeConv);
    DdeConv.Free;
  end;
end;

function TDdeMgr.GetExeName: string;
begin
  Result := ParamStr(0);
end;

{$IF DEFINED(CLR)}
procedure TDdeMgr.set_FHszApp(const Value: Hsz);
begin
  FResources.FAppName := Value;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TDdeMgr.get_FHszApp: Hsz;
begin
  Result := FResources.FAppName;
end;
{$ENDIF}

procedure TDdeMgr.SetAppName(const Name: string);
var
  Dot: Integer;
begin
  ResetAppName;
  FAppName := ExtractFileName(Name);
  Dot := Pos('.', FAppName);
  if Dot <> 0 then
    Delete(FAppName, Dot, Length(FAppName));
{$IF DEFINED(CLR)}
  FHszApp := DdeCreateStringHandleA(DdeInstId, FAppName, CP_WINANSI);
{$ELSE}
  FHszApp := DdeCreateStringHandleA(FDdeInstId, PAnsiChar(AnsiString(FAppName)), CP_WINANSI);
{$ENDIF}
  DdeNameService(DdeInstId, FHszApp, 0, DNS_REGISTER);
end;

procedure TDdeMgr.ResetAppName;
begin
  if FHszApp <> 0 then
  begin
    DdeNameService(DdeInstId, FHszApp, 0, DNS_UNREGISTER);
    DdeFreeStringHandle(DdeInstId, FHszApp);
  end;
  FHszApp := 0;
end;

function TDdeMgr.GetServerConv(const Topic: string): TDdeServerConv;
var
  I: Integer;
  SConv: TDdeServerConv;
begin
  Result := nil;
  for I := 0 to FConvCtrls.Count - 1 do
  begin
    SConv := TDdeServerConv(FConvCtrls[I]);
    if AnsiCompareText(SConv.Name, Topic) = 0 then
    begin
      Result := SConv;
      Exit;
    end;
  end;
end;

function TDdeMgr.GetForm(const Topic: string): TForm;
var
  I: Integer;
  Form: TForm;
begin
  Result := nil;
  for I := 0 to Screen.FormCount - 1 do
  begin
    Form := TForm(Screen.Forms[I]);
    if AnsiCompareText(Form.Caption, Topic) = 0 then
    begin
      Result := Form;
      Exit;
    end;
  end;
end;

function TDdeMgr.GetSrvrConv(const Topic: string ): TComponent;
var
  I: Integer;
  Conv: TDdeSrvrConv;
begin
  Result := nil;
  for I := 0 to FConvs.Count - 1 do
  begin
    Conv := TDdeSrvrConv(FConvs[I]);
    if AnsiCompareText(Conv.Topic, Topic) = 0 then
    begin
      Result := Conv;
      Exit;
    end;
  end;
end;

procedure TDdeMgr.PostDataChange(const Topic: string; Item: string);
var
  Conv: TDdeSrvrConv;
  Itm: TDdeSrvrItem;
begin
  Conv := TDdeSrvrConv(GetSrvrConv (Topic));
  If Conv <> nil then
  begin
    Itm := Conv.GetItem(Item);
    if Itm <> nil then Itm.PostDataChange;
  end;
end;

procedure TDdeMgr.InsertServerConv(SConv: TDdeServerConv);
begin
  FConvCtrls.Insert(FConvCtrls.Count, SConv);
end;

procedure TDdeMgr.RemoveServerConv(SConv: TDdeServerConv);
begin
  FConvCtrls.Remove(SConv);
end;

function TDdeMgr.GetDdeInstId: LongInt;
begin
{$IF DEFINED(CLR)}
  Result := FResources.FInstance;
{$ELSE}
  Result := FDdeInstId;
{$ENDIF}
end;

procedure TDdeMgr.SetDdeInstId(const ID: LongInt);
begin
{$IF DEFINED(CLR)}
  FResources.FInstance := ID;
{$ELSE}
  FDdeInstId := ID;
{$ENDIF}
end;

{procedure TDdeMgr.DoError;
begin
  DDECheck(False);
end;}

constructor TDdeClientConv.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList.Create;
end;

destructor TDdeClientConv.Destroy;
begin
  CloseLink;
  inherited Destroy;
  FItems.Free;
  FItems := nil;
end;

procedure TDdeClientConv.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('LinkInfo', ReadLinkInfo, WriteLinkInfo,
    not ((DdeService = '') and (DdeTopic = '')));
end;

{$IF DEFINED(CLR)}
procedure TDdeClientConv.set_FHszApp(const Value: Hsz);
begin
  if FHszAppObj <> nil then
    DdeMgr.FResources.FStrings.Remove(FHszAppObj);
  if Value = 0 then
    FHszAppObj := nil
  else
  begin
    FHszAppObj := TObject(Value); // box the value
    DdeMgr.FResources.FStrings.Add(FHszAppObj);
  end;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TDdeClientConv.get_FHszApp: Hsz;
begin
  if Assigned(FHszAppObj) then
    Result := Hsz(FHszAppObj)
  else
    Result := 0;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
procedure TDdeClientConv.set_FHszTopic(const Value: Hsz);
begin
  if FHszTopicObj <> nil then
    DdeMgr.FResources.FStrings.Remove(FHszTopicObj);
  if Value = 0 then
    FHszTopicObj := nil
  else
  begin
    FHszTopicObj := TObject(Value); // box the value
    DdeMgr.FResources.FStrings.Add(FHszTopicObj);
  end;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TDdeClientConv.get_FHszTopic: Hsz;
begin
  if Assigned(FHszTopicObj) then
    Result := Hsz(FHszTopicObj)
  else
    Result := 0;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
procedure TDdeClientConv.set_FConv(const Value: HConv);
begin
  if FConvObj <> nil then
    ddeMgr.FResources.FConvHandles.Remove(FConvObj);
  if Value = 0 then
    FConvObj := nil
  else
  begin
    FConvObj := TObject(Value); // box the value
    ddeMgr.FResources.FConvHandles.Add(FConvObj);
  end;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TDdeClientConv.get_FConv: HConv;
begin
  if FConvObj <> nil then
    Result := HConv(FConvObj)
  else
    Result := 0;
end;
{$ENDIF}

procedure TDdeClientConv.Loaded;
var
  Service, Topic: string;
begin
  inherited Loaded;
  Service := DdeService;
  Topic := DdeTopic;
  if (Length(Service) <> 0) and (ConnectMode <> ddeManual) then
    ChangeLink(Service, Topic, '');
end;

procedure TDdeClientConv.ReadLinkInfo (Reader: TReader);
var
  Value: string;
  Text: string;
  Temp: Integer;
begin
  Reader.ReadListBegin;
  while not Reader.EndOfList do
  begin
    Value := Reader.ReadString;
    Temp := Pos(' ', Value);
    Text := Copy(Value, Temp + 1, Length (Value) - Temp);
    case Value[1] of
      'S': SetService(Text);
      'T': SetTopic(Text);
    end;
  end;
  Reader.ReadListEnd;
end;

procedure TDdeClientConv.WriteLinkInfo (Writer: TWriter);
var
  Value: string;
begin
  Writer.WriteListBegin;
  Value := DdeService;
  Writer.WriteString(Format('Service %s', [Value]));
  Value := DdeTopic;
  Writer.WriteString(Format('Topic %s', [Value]));
  Writer.WriteListEnd;
end;

procedure TDdeClientConv.OnAttach(aCtrl: TDdeClientItem);
var
  ItemLnk: TDdeCliItem;
begin
  ItemLnk := TDdeCliItem.Create(Self);
  FItems.Insert(FItems.Count, ItemLnk);
  ItemLnk.Control := aCtrl;
  ItemLnk.SetItem('');
end;

procedure TDdeClientConv.OnDetach(aCtrl: TDdeClientItem);
var
  ItemLnk: TDdeCliItem;
begin
  ItemLnk := TDdeCliItem(GetCliItemByCtrl(aCtrl));
  if ItemLnk <> nil then
  begin
    ItemLnk.SetItem('');
    FItems.Remove(ItemLnk);
    ItemLnk.Free;
  end;
end;

function TDdeClientConv.OnSetItem(aCtrl: TDdeClientItem; const S: string): Boolean;
var
  ItemLnk: TDdeCliItem;
begin
  Result := True;
  ItemLnk := TDdeCliItem(GetCliItemByCtrl(aCtrl));

  if (ItemLnk = nil) and (Length(S) > 0) then
  begin
    OnAttach (aCtrl);
    ItemLnk := TDdeCliItem(GetCliItemByCtrl(aCtrl));
  end;

  if (ItemLnk <> nil) and (Length(S) = 0) then
  begin
    OnDetach (aCtrl);
  end
  else if ItemLnk <> nil then
  begin
    Result := ItemLnk.SetItem(S);
    if not (Result) and not (csLoading in ComponentState) then
      OnDetach (aCtrl);  {error occurred, do cleanup}
  end;
end;

function TDdeClientConv.GetCliItemByCtrl(ACtrl: TDdeClientItem): TPersistent;
var
  ItemLnk: TDdeCliItem;
  I: word;
begin
  Result := nil;
  I := 0;
  while I < FItems.Count do
  begin
    ItemLnk := TDdeCliItem(FItems[I]);
    if ItemLnk.Control = aCtrl then
    begin
      Result := ItemLnk;
      Exit;
    end;
    Inc(I);
  end;
end;

function TDdeClientConv.PasteLink: Boolean;
var
  Service, Topic, Item: string;
begin
  if GetPasteLinkInfo(Service, Topic, Item) = True then
    Result := ChangeLink(Service, Topic, Item) else
    Result := False;
end;

function TDdeClientConv.ChangeLink(const App, Topic, Item: string): Boolean;
begin
  CloseLink;
  SetService(App);
  SetTopic(Topic);
  Result := OpenLink;
  if not Result then
  begin
    SetService('');
    SetTopic('');
  end;
end;

function TDdeClientConv.OpenLink: Boolean;
var
  Res: Boolean;
{$IF DEFINED(CLR)}
  Temp: string;
{$ELSE}
  CharVal: array[0..255] of AnsiChar;
{$ENDIF}
begin
  Result := False;
  if FConv <> 0 then Exit;

  if (Length(DdeService) = 0) and (Length(DdeTopic) = 0) then
  begin
    ClearItems;
    Exit;
  end;

{$IF DEFINED(CLR)}
  if FHszApp = 0 then
    FHszApp := DdeCreateStringHandleA(ddeMgr.DdeInstId, DdeService, CP_WINANSI);
  if FHszTopic = 0 then
    FHszTopic := DdeCreateStringHandleA(ddeMgr.DdeInstId, DdeTopic, CP_WINANSI);
{$ELSE}
  if FHszApp = 0 then
  begin
    StrPCopy(CharVal, AnsiString(DdeService));
    FHszApp := DdeCreateStringHandleA(ddeMgr.DdeInstId, CharVal, CP_WINANSI);
  end;
  if FHszTopic = 0 then
  begin
    StrPCopy(CharVal, AnsiString(DdeTopic));
    FHszTopic := DdeCreateStringHandleA(ddeMgr.DdeInstId, CharVal, CP_WINANSI);
  end;
{$ENDIF}
  Res := CreateDdeConv(FHszApp, FHszTopic);
  if not Res then
  begin
    if not((Length(DdeService) = 0) and
      (Length(ServiceApplication) = 0)) then
    begin
      if Length(ServiceApplication) <> 0 then
{$IF DEFINED(CLR)}
        Temp := ServiceApplication
      else
        Temp := DdeService + ' ' + DdeTopic;
      if WinExec(Temp, SW_SHOWMINNOACTIVE) >= 32 then
{$ELSE}
        StrPCopy(CharVal, AnsiString(ServiceApplication))
      else
        StrPCopy(CharVal, AnsiString(DdeService + ' ' + DdeTopic));
      if WinExec(PAnsiChar(@CharVal[0]), SW_SHOWMINNOACTIVE) >= 32 then
{$ENDIF}
        Res := CreateDdeConv(FHszApp, FHszTopic);
    end;
  end;
  if not Res then
  begin
    ClearItems;
    Exit;
  end;
  if FCnvInfo.wFmt <> 0 then
    FDdeFmt := FCnvInfo.wFmt
  else
    FDdeFmt := CF_TEXT;
  if StartAdvise = False then Exit;
  Open;
  DataChange(0, 0);
  Result := True;
end;

procedure TDdeClientConv.CloseLink;
var
  OldConv: HConv;
begin
  if FConv <> 0 then
  begin
    OldConv := FConv;
    SrvrDisconnect;
{$IF DEFINED(CLR)}
    if Assigned(ddeMgr) then
      ddeMgr.FCliConvHashTable.Remove(TObject(OldConv));
{$ELSE}
    DdeSetUserHandle(OldConv, QID_SYNC, 0);
{$ENDIF}
    FConv := 0;
    DdeDisconnect(OldConv);
  end;

  if FHszApp <> 0 then
  begin
    DdeFreeStringHandle(ddeMgr.DdeInstId, FHszApp);
    FHszApp := 0;
  end;

  if FHszTopic <> 0 then
  begin
    DdeFreeStringHandle(ddeMgr.DdeInstId, FHszTopic);
    FHszTopic := 0;
  end;
  SetService('');
  SetTopic('');
end;

procedure TDdeClientConv.ClearItems;
var
  ItemLnk: TDdeCliItem;
  i: word;
begin
  if FItems.Count = 0 then Exit;

  for I := 0 to FItems.Count - 1 do
  begin
    ItemLnk := TDdeCliItem(FItems [0]);
    ItemLnk.Control.DdeItem := EmptyStr;
  end;
end;

function TDdeClientConv.CreateDdeConv(FHszApp: HSZ; FHszTopic: HSZ): Boolean;
{$IF NOT DEFINED(CLR)}
var
  Context: TConvContext;
{$ENDIF}
begin
{$IF NOT DEFINED(CLR)}
  FillChar(Context, SizeOf(Context), 0);
  with Context do
  begin
    cb := SizeOf(TConvConText);
    iCodePage := CP_WINANSI;
  end;
{$ENDIF}
  FConv := DdeConnect(ddeMgr.DdeInstId, FHszApp, FHszTopic, nil);
  Result := FConv <> 0;
  if Result then
  begin
{$IF DEFINED(CLR)}
    FCnvInfo.cb := Marshal.SizeOf(TypeOf(TConvInfo));
    DdeQueryConvInfo(Conv, QID_SYNC, FCnvInfo);
    ddeMgr.FCliConvHashTable.Add(TObject(Conv), self);
{$ELSE}
    FCnvInfo.cb := sizeof(TConvInfo);
    DdeQueryConvInfo(FConv, QID_SYNC, @FCnvInfo);
    DdeSetUserHandle(FConv, QID_SYNC, UIntPtr(Self));
{$ENDIF}
  end;
end;

function TDdeClientConv.StartAdvise: Boolean;
var
  ItemLnk: TDdeCliItem;
  i: word;
begin
  Result := False;
  if FConv = 0 then Exit;

  i := 0;
  while i < FItems.Count do
  begin
    ItemLnk := TDdeCliItem(FItems [i]);
    if not ItemLnk.StartAdvise then
    begin
      ItemLnk.Control.DdeItem := EmptyStr;
    end else
      Inc(i);
    if i >= FItems.Count then
      break;
  end;
  Result := True;
end;

function TDdeClientConv.ExecuteMacroLines(Cmd: TStrings; waitFlg: Boolean): Boolean;
begin
  Result := False;
  if (FConv = 0) or FWaitStat then Exit;
{$IF DEFINED(CLR)}
  Result := ExecuteMacro(Cmd.Text, waitFlg);
{$ELSE}
  Result := ExecuteMacro(PAnsiChar(AnsiString(Cmd.Text)), waitFlg);
{$ENDIF}
end;

{$IF DEFINED(CLR)}
function TDdeClientConv.ExecuteMacro(Cmd: string; waitFlg: Boolean): Boolean;
var
  Mem: IntPtr;
begin
  Result := False;
  if (Conv = 0) or FWaitStat then Exit;
  Mem := Marshal.StringToHGlobalAnsi(Cmd);
  try
    Result := ExecuteMacro(Mem, Length(Cmd) + 1, waitFlg);
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
function TDdeClientConv.ExecuteMacro(Cmd: PAnsiChar; waitFlg: Boolean): Boolean;
var
  hszCmd: HDDEData;
  hdata: HDDEData;
  ddeRslt: LongInt;
begin
  Result := False;
  if (FConv = 0) or FWaitStat then Exit;
  hszCmd := DdeCreateDataHandle(ddeMgr.DdeInstId, Cmd, StrLen(Cmd) + 1,
    0, 0, FDdeFmt, 0);
  if hszCmd = 0 then Exit;
  if waitFlg = True then FWaitStat := True;
  hdata := DdeClientTransaction(Pointer(hszCmd), DWORD(-1), FConv, 0, FDdeFmt,
     XTYP_EXECUTE, TIMEOUT_ASYNC, @ddeRslt);
  if hdata = 0 then FWaitStat := False
  else Result := True;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TDdeClientConv.ExecuteMacro(Cmd: IntPtr; Len: Integer; waitFlg: Boolean): Boolean;
var
  hszCmd: HDDEData;
  hdata: HDDEData;
  ddeRslt: DWORD;
begin
  Result := False;
  if (Conv = 0) or FWaitStat then Exit;
  hszCmd := DdeCreateDataHandle(ddeMgr.DdeInstId, Cmd, Len, 0, 0, FDdeFmt, 0);
  if hszCmd = 0 then Exit;
  if waitFlg = True then FWaitStat := True;
  hdata := DdeClientTransaction(hszCmd, DWORD(-1), Conv, 0, UINT(FDdeFmt),
     XTYP_EXECUTE, TIMEOUT_ASYNC, ddeRslt);
  if hdata = 0 then FWaitStat := False
  else Result := True;
end;
{$ENDIF}

function TDdeClientConv.PokeDataLines(const Item: string; Data: TStrings): Boolean;
begin
  Result := False;
  if (FConv = 0) or FWaitStat then Exit;
{$IF DEFINED(CLR)}
  Result := PokeData(Item, Data.Text);
{$ELSE}
  Result := PokeData(Item, PAnsiChar(AnsiString(Data.Text)));
{$ENDIF}
end;

{$IF DEFINED(CLR)}
function TDdeClientConv.PokeData(const Item: string; Data: string): Boolean;
var
  Mem: IntPtr;
begin
  Result := False;
  if (Conv = 0) or FWaitStat then Exit;
  Mem := Marshal.StringToHGlobalAnsi(Data);
  try
    Result := PokeData(Item, Mem, Length(Data) + 1);
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
function TDdeClientConv.PokeData(const Item: string; Data: PAnsiChar): Boolean;
var
  hszDat: HDDEData;
  hdata: HDDEData;
  hszItem: HSZ;
begin
  Result := False;
  if (FConv = 0) or FWaitStat then Exit;
  hszItem := DdeCreateStringHandleA(ddeMgr.DdeInstId, PAnsiChar(AnsiString(Item)), CP_WINANSI);
  if hszItem = 0 then Exit;
  hszDat := DdeCreateDataHandle(ddeMgr.DdeInstId, Data, StrLen(Data) + 1,
    0, hszItem, FDdeFmt, 0);
  if hszDat <> 0 then
  begin
    hdata := DdeClientTransaction(Pointer(hszDat), DWORD(-1), FConv, hszItem,
      FDdeFmt, XTYP_POKE, TIMEOUT_ASYNC, nil);
    Result := hdata <> 0;
  end;
  DdeFreeStringHandle(ddeMgr.DdeInstId, hszItem);
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TDdeClientConv.PokeData(const Item: string; Data: IntPtr; Len: Integer): Boolean;
var
  hszDat: HDDEData;
  hdata: HDDEData;
  hszItem: HSZ;
  ddeResult: DWORD;
begin
  Result := False;
  if (Conv = 0) or FWaitStat then Exit;
  hszItem := DdeCreateStringHandleA(ddeMgr.DdeInstId, Item, CP_WINANSI);
  if hszItem = 0 then Exit;
  hszDat := DdeCreateDataHandle(ddeMgr.DdeInstId, Data, Len, 0, hszItem, FDdeFmt, 0);
  if hszDat <> 0 then
  begin
    hdata := DdeClientTransaction(hszDat, DWORD(-1), Conv, hszItem,
      UINT(FDdeFmt), XTYP_POKE, TIMEOUT_ASYNC, ddeResult);
    Result := hdata <> 0;
  end;
  DdeFreeStringHandle (ddeMgr.DdeInstId, hszItem);
end;
{$ENDIF}

{$IF DEFINED(CLR)}
function TDdeClientConv.RequestData(const Item: string): TBytes;
{$ELSE}
function TDdeClientConv.RequestData(const Item: string): PAnsiChar;
{$ENDIF}
var
  hData: HDDEData;
  ddeRslt: DWORD;
  hItem: HSZ;
  Len: DWORD;
{$IF DEFINED(CLR)}
  pData: IntPtr;
{$ELSE}
  pData: Pointer;
{$ENDIF}
begin
  Result := nil;
  if (FConv = 0) or FWaitStat then Exit;
{$IF DEFINED(CLR)}
  hItem := DdeCreateStringHandleA(ddeMgr.DdeInstId, Item, CP_WINANSI);
{$ELSE}
  hItem := DdeCreateStringHandleA(ddeMgr.DdeInstId, PAnsiChar(AnsiString(Item)), CP_WINANSI);
{$ENDIF}
  if hItem <> 0 then
  begin
{$IF DEFINED(CLR)}
    hData := DdeClientTransaction(nil, 0, FConv, hItem, UINT(FDdeFmt),
      XTYP_REQUEST, 10000, ddeRslt);
{$ELSE}
    hData := DdeClientTransaction(nil, 0, FConv, hItem, FDdeFmt,
      XTYP_REQUEST, 10000, @ddeRslt);
{$ENDIF}
    DdeFreeStringHandle(ddeMgr.DdeInstId, hItem);
    if hData <> 0 then
    try
{$IF DEFINED(CLR)}
      pData := DdeAccessData(hData, Len);
      if pData <> nil then
      try
        SetLength(Result, Len + 1);
        Marshal.Copy(pData, Result, 0, Len);  // data is binary, may contain nulls
        Result[len] := 0;
{$ELSE}
      pData := DdeAccessData(hData, @Len);
      if pData <> nil then
      try
        Result := PAnsiChar(StrAlloc(Len + 1));
        Move(pData^, Result^, len);    // data is binary, may contain nulls
        Result[len] := #0;
{$ENDIF}
      finally
        DdeUnaccessData(hData);
      end;
    finally
      DdeFreeDataHandle(hData);
    end;
  end;
end;

function TDdeClientConv.GetCliItemByName(const ItemName: string): TPersistent;
var
  ItemLnk: TDdeCliItem;
  i: word;
begin
  Result := nil;
  i := 0;
  while i < FItems.Count do
  begin
    ItemLnk := TDdeCliItem(FItems[i]);
    if ItemLnk.Item = ItemName then
    begin
      Result := ItemLnk;
      Exit;
    end;
    Inc(i);
  end;
end;

procedure TDdeClientConv.XactComplete;
begin
   FWaitStat := False;
end;

procedure TDdeClientConv.SrvrDisconnect;
var
  ItemLnk: TDdeCliItem;
  i: word;
begin
  if FConv <> 0 then Close;
  FConv := 0;
  i := 0;
  while i < FItems.Count do
  begin
    ItemLnk := TDdeCliItem(FItems [i]);
    ItemLnk.SrvrDisconnect;
    Inc(i);
  end;
end;

procedure TDdeClientConv.DataChange(DdeDat: HDDEData; hszIt: HSZ);
var
  ItemLnk: TDdeCliItem;
  i: word;
begin
  i := 0;
  while i < FItems.Count do
  begin
    ItemLnk := TDdeCliItem(FItems [i]);
    if (hszIt = 0) or (ItemLnk.HszItem = hszIt) then
    begin
        { data has changed and we found a link that might be interested }
      ItemLnk.StoreData(DdeDat);
    end;
    Inc(i);
  end;
end;

function TDdeClientConv.SetLink(const Service, Topic: string): Boolean;
begin
  CloseLink;
  if FConnectMode = ddeAutomatic then
    Result := ChangeLink(Service, Topic, '')
  else begin
    SetService(Service);
    SetTopic(Topic);
    DataChange(0,0);
    Result := True;
  end;
end;

procedure TDdeClientConv.SetConnectMode(NewMode: TDataMode);
begin
  if FConnectMode <> NewMode then
  begin
    if (NewMode = ddeAutomatic) and (Length(DdeService) <> 0) and
      (Length(DdeTopic) <> 0) and not OpenLink then
      raise Exception.CreateRes({$IFNDEF CLR}@{$ENDIF}SDdeNoConnect);
    FConnectMode := NewMode;
  end;
end;

procedure TDdeClientConv.SetFormatChars(NewFmt: Boolean);
begin
  if FFormatChars <> NewFmt then
  begin
    FFormatChars := NewFmt;
    if FConv <> 0 then DataChange(0, 0);
  end;
end;

procedure TDdeClientConv.SetDdeService(const Value: string);
begin
end;

procedure TDdeClientConv.SetDdeTopic(const Value: string);
begin
end;

procedure TDdeClientConv.SetService(const Value: string);
begin
  FDdeService := Value;
end;

procedure TDdeClientConv.SetTopic(const Value: string);
begin
  FDdeTopic := Value;
end;

procedure TDdeClientConv.Close;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TDdeClientConv.Open;
begin
  if Assigned(FOnOpen) then FOnOpen(Self);
end;

procedure TDdeClientConv.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  ItemLnk: TDdeCliItem;
  i: word;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FItems <> nil) then
  begin
    i := 0;
    while i < FItems.Count do
    begin
      ItemLnk := TDdeCliItem(FItems [i]);
      if (AComponent = ItemLnk.Control) then
        ItemLnk.Control.DdeItem := EmptyStr;
      if i >= FItems.Count then break;
      Inc(I);
    end;
  end;
end;

constructor TDdeClientItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLines := TStringList.Create;
end;

destructor TDdeClientItem.Destroy;
begin
  FLines.Free;
  inherited Destroy;
end;

procedure TDdeClientItem.SetDdeClientConv(Val: TDdeClientConv);
var
  OldItem: string;
begin
  if Val <> FDdeClientConv then
  begin
    OldItem := DdeItem;
    FDdeClientItem := '';
    if FDdeClientConv <> nil then
      FDdeClientConv.OnDetach (Self);

    FDdeClientConv := Val;
    if FDdeClientConv <> nil then
    begin
      FDdeClientConv.FreeNotification(Self);
      if Length(OldItem) <> 0 then SetDdeClientItem (OldItem);
    end;
  end;
end;

procedure TDdeClientItem.SetDdeClientItem(const Val: string);
begin
  if FDdeClientConv <> nil then
  begin
    FDdeClientItem := Val;
    if Not FDdeClientConv.OnSetItem (Self, Val) then
    begin
      if Not (csLoading in ComponentState) or
        not ((FDdeClientConv.Conv = 0) and
        (FDdeClientConv.ConnectMode = ddeManual)) then
        FDdeClientItem := '';
    end;
  end
  else if (csLoading in ComponentState) then
    FDdeClientItem := Val;
end;

procedure TDdeClientItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDdeClientConv) then
  begin
    FDdeClientConv.OnDetach (Self);
    FDdeClientConv := nil;
    FDdeClientItem := '';
  end;
end;

procedure TDdeClientItem.OnAdvise;
begin
  if csDesigning in ComponentState then
  begin
    if Owner.InheritsFrom (TForm) and (TForm(Owner).Designer <> nil) then
      TForm(Owner).Designer.Modified;
  end;
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TDdeClientItem.GetText: string;
begin
  if FLines.Count > 0 then
    Result := FLines.Strings[0]
  else Result := '';
end;

procedure TDdeClientItem.SetText(const S: string);
begin
end;

procedure TDdeClientItem.SetLines(L: TStrings);
begin
end;

constructor TDdeCliItem.Create(ADS: TDdeClientConv);
begin
  inherited Create;
{$IF NOT DEFINED(CLR)}
  FHszItem := 0;
{$ENDIF}
  FCliConv := ADS;
end;

destructor TDdeCliItem.Destroy;
begin
  StopAdvise;
{$IF DEFINED(CLR)}
  if FHszItem <> nil then
  begin
    DdeMgr.FResources.FCliItems.Remove(FHszItem);
    FreeAndNil(FHszItem);
  end;
{$ENDIF}
  inherited Destroy;
end;

procedure TDdeCliItem.SetHszItem(const Value: Hsz);
begin
{$IF DEFINED(CLR)}
  if FHszItem = nil then
  begin
    if Value = 0 then Exit;
    FHszItem := TCliItemInfo.Create;
    FHszItem.FConv := HConv(FCliConv.FConvObj);
    DdeMgr.FResources.FCliItems.Add(FHszItem);
  end;
  FHszItem.FFormat := FCliConv.FDdeFmt;
  FHszItem.FName := Value;
{$ELSE}
  FHszItem := Value;
{$ENDIF}
end;

function TDdeCliItem.GetHszItem: Hsz;
begin
{$IF DEFINED(CLR)}
  if FHszItem = nil then
    Result := 0
  else
    Result := FHszItem.FName;
{$ELSE}
  Result := FHszItem;
{$ENDIF}
end;

function TDdeCliItem.SetItem(const S: string): Boolean;
var
  OldItem: string;
begin
  Result := False;
  OldItem := Item;
  if HszItem <> 0 then StopAdvise;

  FItem := S;
  FCtrl.Lines.Clear;

  if (Length(Item) <> 0) then
  begin
    if (FCliConv.Conv <> 0) then
    begin
      Result := StartAdvise;
      if Not Result then
        FItem := '';
    end
    else if FCliConv.ConnectMode = ddeManual then Result := True;
  end;
  RefreshData;
end;

procedure TDdeCliItem.StoreData(DdeDat: HDDEData);
var
  Len: DWORD;
  I: Integer;
{$IF DEFINED(CLR)}
  DataBytes: TBytes;
  DataPtr: IntPtr;
{$ELSE}
  Data: AnsiString;
{$ENDIF}
begin
  if DdeDat = 0 then
  begin
    RefreshData;
    Exit;
  end;

{$IF DEFINED(CLR)}
  DataPtr := AccessData(DdeDat, Len);
  if DataPtr = nil then
    FCtrl.Lines.Text := ''
  else
  begin
    try
      SetLength(DataBytes, Len);
      if Len > 0 then
        Marshal.Copy(DataPtr, DataBytes, 0, Len);
    finally
      ReleaseData(DdeDat);
    end;
    if (Len > 0) and (DataBytes[0] <> 0) then
    begin
      if FCliConv.FormatChars = False then
        for I := 0 to Length(DataBytes) - 1 do
          if (DataBytes[I] > 0) and (DataBytes[I] < Ord(' ')) then
            DataBytes[I] := Ord(' ');
      FCtrl.Lines.Text := StringOf(DataBytes);
    end else
      FCtrl.Lines.Text := '';
  end;
{$ELSE}
  Data := PAnsiChar(AccessData(DdeDat, @Len));
  if Data <> '' then
  begin
    FCtrl.Lines.Text := string(Data);
    ReleaseData(DdeDat);
    if FCliConv.FormatChars = False then
    begin
      for I := 1 to Length(Data) do
        if (Data[I] > #0) and (Data[I] < ' ') then Data[I] := ' ';
      FCtrl.Lines.Text := string(Data);
    end;
  end;
{$ENDIF}
  DataChange;
end;

function TDdeCliItem.RefreshData: Boolean;
var
  ddeRslt: DWORD;
  DdeDat: HDDEData;
begin
  Result := False;
  if (FCliConv.Conv <> 0) and (HszItem <> 0) then
  begin
    if FCliConv.WaitStat = True then Exit;
{$IF DEFINED(CLR)}
    DdeDat := DdeClientTransaction(nil, DWORD(-1), FCliConv.Conv, HszItem,
      UINT(FCliConv.DdeFmt), XTYP_REQUEST, 1000, ddeRslt);
{$ELSE}
    DdeDat := DdeClientTransaction(nil, DWORD(-1), FCliConv.Conv, FHszItem,
      FCliConv.DdeFmt, XTYP_REQUEST, 1000, @ddeRslt);
{$ENDIF}
    if DdeDat = 0 then Exit
    else begin
      StoreData(DdeDat);
      DdeFreeDataHandle(DdeDat);
      Result := True;
      Exit;
    end;
  end;
  DataChange;
end;

{$IF DEFINED(CLR)}
function TDdeCliItem.AccessData(DdeDat: HDDEData; var DataLen: DWORD): IntPtr;
begin
  Result := DdeAccessData(DdeDat, DataLen);
end;
{$ELSE}
function TDdeCliItem.AccessData(DdeDat: HDDEData; pDataLen: PDWORD): Pointer;
begin
  Result := DdeAccessData(DdeDat, pDataLen);
end;
{$ENDIF}

procedure TDdeCliItem.ReleaseData(DdeDat: HDDEData);
begin
  DdeUnaccessData(DdeDat);
end;

function TDdeCliItem.StartAdvise: Boolean;
var
  ddeRslt: DWORD;
  hdata: HDDEData;
begin
  Result := False;
  if FCliConv.Conv = 0 then Exit;
  if Length(Item) = 0 then Exit;
{$IF DEFINED(CLR)}
  if HszItem = 0 then
    SetHszItem(DdeCreateStringHandleA(ddeMgr.DdeInstId, Item, CP_WINANSI));
  hdata := DdeClientTransaction(nil, DWORD(-1), FCliConv.Conv, HszItem,
    UINT(FCliConv.DdeFmt), XTYP_ADVSTART or XTYPF_NODATA, 1000, ddeRslt);
{$ELSE}
  if FHszItem = 0 then
    FHszItem := DdeCreateStringHandleA(ddeMgr.DdeInstId, PAnsiChar(AnsiString(Item)), CP_WINANSI);
  hdata := DdeClientTransaction(nil, DWORD(-1), FCliConv.Conv, FHszItem,
    FCliConv.DdeFmt, XTYP_ADVSTART or XTYPF_NODATA, 1000, @ddeRslt);
{$ENDIF}
  if hdata = 0 then
  begin
    DdeGetLastError(ddeMgr.DdeInstId);
{$IF DEFINED(CLR)}
    DdeFreeStringHandle(ddeMgr.DdeInstId, HszItem);
{$ELSE}
    DdeFreeStringHandle(ddeMgr.DdeInstId, FHszItem);
{$ENDIF}
    SetHszItem(0);
    FCtrl.Lines.Clear;
  end else
    Result := True;
end;

function TDdeCliItem.StopAdvise: Boolean;
var
  ddeRslt: DWORD;
begin
  if FCliConv.Conv <> 0 then
    if HszItem <> 0 then
{$IF DEFINED(CLR)}
      DdeClientTransaction(nil, DWORD(-1), FCliConv.Conv, HszItem,
        UINT(FCliConv.DdeFmt), XTYP_ADVSTOP, 1000, ddeRslt);
{$ELSE}
      DdeClientTransaction(nil, DWORD(-1), FCliConv.Conv, FHszItem,
        FCliConv.DdeFmt, XTYP_ADVSTOP, 1000, @ddeRslt);
{$ENDIF}
  SrvrDisconnect;
  Result := True;
end;

procedure TDdeCliItem.SrvrDisconnect;
begin
  if HszItem <> 0 then
  begin
    DdeFreeStringHandle(ddeMgr.DdeInstId, HszItem);
    SetHszItem(0);
  end;
end;

procedure TDdeCliItem.DataChange;
begin
  FCtrl.OnAdvise;
end;

constructor TDdeServerItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFmt := CF_TEXT;
  FLines := TStringList.Create;
end;

destructor TDdeServerItem.Destroy;
begin
  FLines.Free;
  inherited Destroy;
end;

procedure TDdeServerItem.SetServerConv(SConv: TDdeServerConv);
begin
  FServerConv := SConv;
  if SConv <> nil then SConv.FreeNotification(Self);
end;

function TDdeServerItem.GetText: string;
begin
  if FLines.Count > 0 then
    Result := FLines.Strings[0]
  else Result := '';
end;

procedure TDdeServerItem.SetText(const Item: string);
begin
  FFmt := CF_TEXT;
  FLines.Clear;
  FLines.Add(Item);
  ValueChanged;
end;

procedure TDdeServerItem.SetLines(Value: TStrings);
begin
  if AnsiCompareStr(Value.Text, FLines.Text) <> 0 then
  begin
    FFmt := CF_TEXT;
    FLines.Assign(Value);
    ValueChanged;
  end;
end;

procedure TDdeServerItem.ValueChanged;
begin
  if Assigned(FOnChange) then FOnChange(Self);
  if FServerConv <> nil then
    ddeMgr.PostDataChange(FServerConv.Name, Name)
  else if (Owner <> nil) and (Owner is TForm) then
    ddeMgr.PostDataChange(TForm(Owner).Caption, Name);
end;

function TDdeServerItem.PokeData(Data: HDdeData): LongInt;
var
  Len: DWORD;
{$IF DEFINED(CLR)}
  pData: IntPtr;
{$ELSE}
  pData: Pointer;
{$ENDIF}
begin
  Result := dde_FNotProcessed;
  pData := DdeAccessData(Data, {$IFNDEF CLR}@{$ENDIF}Len);
  if pData <> nil then
  begin
{$IF DEFINED(CLR)}
    Lines.Text := Marshal.PtrToStringAnsi(pData, Len);
{$ELSE}
    Lines.Text := string(PAnsiChar(pData));
{$ENDIF}
    DdeUnaccessData(Data);
    ValueChanged;
    if Assigned(FOnPokeData) then FOnPokeData(Self);
    Result := dde_FAck;
  end;
end;

{$IF DEFINED(CLR)}
procedure WriteTextToClipboard(AValue: string; Format: Word; AFlags: UINT);
var
  Data: THandle;
  DataPtr: IntPtr;
  B: TBytes;
begin
  Data := GlobalAlloc(AFlags, Length(AValue) + 1);
  try
    DataPtr := GlobalLock(Data);
    try
      B := BytesOf(AValue);
      SetLength(B, Length(B) + 1); // add null terminator
      Marshal.Copy(B, 0, DataPtr, Length(B));
      SetClipboardData(Format, Data);
    finally
     GlobalUnlock(Data);
    end;
  except
    GlobalFree(Data);
    raise;
  end;
end;
{$ENDIF}

procedure TDdeServerItem.CopyToClipboard;
var
  LinkData: string;
{$IF NOT DEFINED(CLR)}
  Data: THandle;
  DataPtr: Pointer;
{$ENDIF}
begin
  if FServerConv <> nil then
    LinkData := ddeMgr.AppName + #0 + FServerConv.Name + #0 + Name
  else if (Owner = nil) then Exit
  else if Owner is TForm then
    LinkData := ddeMgr.AppName + #0 + TForm(Owner).Caption + #0 + Name;
{$IF DEFINED(CLR)}
  OpenClipboard(0);
  try
    WriteTextToClipboard(Text, CF_TEXT, GMEM_MOVEABLE+GMEM_DDESHARE);
    WriteTextToClipboard(LinkData, DdeMgr.LinkClipFmt, GMEM_MOVEABLE);
  finally
    CloseClipboard;
  end;
{$ELSE}
  try
    Clipboard.Open;
    Clipboard.AsText := Text;
    Data := GlobalAlloc(GMEM_MOVEABLE, Length(LinkData) + SizeOf(Char));
    try
      DataPtr := GlobalLock(Data);
      try
        Move(PChar(LinkData)^, DataPtr^, Length(LinkData) + SizeOf(Char));
        Clipboard.SetAsHandle(DdeMgr.LinkClipFmt, Data);
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    Clipboard.Close;
  end;
{$ENDIF}
end;

procedure TDdeServerItem.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TDdeServerItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FServerConv) and (Operation = opRemove) then
    FServerConv := nil;
end;

constructor TDdeServerConv.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ddeMgr.InsertServerConv (Self);
end;

destructor TDdeServerConv.Destroy;
begin
  ddeMgr.RemoveServerConv(Self);
  inherited Destroy;
end;

function TDdeServerConv.ExecuteMacro(Data: HDdeData): LongInt;
var
  Len: DWORD;
  MacroLines: TStringList;
{$IF DEFINED(CLR)}
  pData: IntPtr;
{$ELSE}
  pData: Pointer;
{$ENDIF}
begin
  Result := dde_FNotProcessed;
  pData := DdeAccessData(Data, {$IFNDEF CLR}@{$ENDIF}Len);
  if pData <> nil then
  try
    if Assigned(FOnExecuteMacro) then
    begin
      MacroLines := TStringList.Create;
{$IF DEFINED(CLR)}
      MacroLines.Text := Marshal.PtrToStringAnsi(pData, Len);
{$ELSE}
      MacroLines.Text := string(PAnsiChar(pData));
{$ENDIF}
      FOnExecuteMacro(Self, MacroLines);
      MacroLines.Free;
    end;
    Result := dde_FAck;
  finally
{$IF DEFINED(CLR)}
    DdeUnaccessData(Data);
{$ENDIF}
  end;
end;

procedure TDdeServerConv.Connect;
begin
  if Assigned(FOnOpen) then FOnOpen(Self);
end;

procedure TDdeServerConv.Disconnect;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

constructor TDdeSrvrConv.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList.Create;
end;

destructor TDdeSrvrConv.Destroy;
var
  I: Integer;
begin
  if FItems <> nil then
  begin
    for I := 0 to FItems.Count - 1 do
      TDdeSrvrItem(FItems[I]).Free;
    FItems.Free;
    FItems := nil;
  end;
  if FConv <> 0 then
  begin
    DdeDisconnect(FConv);
    FConv := 0;
  end;
  if HszTopic <> 0 then
  begin
    DdeFreeStringHandle(ddeMgr.DdeInstId, HszTopic);
    SetHszTopic(0);
  end;
  inherited Destroy;
end;

{$IF DEFINED(CLR)}
procedure TDdeSrvrConv.set_FConv(const Value: HConv);
begin
  if FConvObj <> nil then
    ddeMgr.FResources.FConvHandles.Remove(FConvObj);
  if Value = 0 then
    FConvObj := nil
  else
  begin
    FConvObj := TObject(Value); // box the value
    ddeMgr.FResources.FConvHandles.Add(FConvObj);
  end;
end;
{$ENDIF}

function TDdeSrvrConv.get_FConv: HConv;
begin
{$IF DEFINED(CLR)}
  if FConvObj <> nil then
    Result := HConv(FConvObj)
  else
    Result := 0;
{$ELSE}
  Result := FConv;
{$ENDIF}
end;

function TDdeSrvrConv.GetHszTopic: HSZ;
begin
{$IF DEFINED(CLR)}
  if FHSzTopic <> nil then
    Result := Hsz(FHszTopic)
  else
    Result := 0;
{$ELSE}
  Result := FHSzTopic;
{$ENDIF}
end;

procedure TDdeSrvrConv.SetHszTopic(const Value: HSZ);
begin
{$IF DEFINED(CLR)}
  if FHszTopic <> nil then
    DdeMgr.FResources.FStrings.Remove(FHszTopic);
  if Value = 0 then
    FHszTopic := nil
  else
  begin
    FHszTopic := TObject(Value);
    DdeMgr.FResources.FStrings.Add(FHszTopic);
  end;
{$ELSE}
  FConv := Value;
{$ENDIF}
end;

function TDdeSrvrConv.AdvStart(Conv: HConv; hszTopic: HSZ; hszItem: HSZ;
  Fmt: Word): Boolean;
var
  Srvr: TDdeServerItem;
  SrvrItem: TDdeSrvrItem;
{$IF DEFINED(CLR)}
  Buffer: StringBuilder;
{$ELSE}
  Buffer: array[0..4095] of AnsiChar;
{$ENDIF}
begin
  Result := False;
  if Fmt <> CF_TEXT then Exit;
{$IF DEFINED(CLR)}
  Buffer := StringBuilder.Create(4096);
  DdeQueryStringA(ddeMgr.DdeInstId, hszItem, Buffer, Buffer.Capacity, CP_WINANSI);
  Srvr := GetControl(FForm, FSConv, Buffer.ToString);
{$ELSE}
  DdeQueryStringA(ddeMgr.DdeInstId, hszItem, Buffer, Length(Buffer), CP_WINANSI);
  Srvr := GetControl(FForm, FSConv, string(Buffer));
{$ENDIF}
  if Srvr = nil then Exit;
  SrvrItem := TDdeSrvrItem.Create(Self);
  SrvrItem.Srvr := Srvr;
{$IF DEFINED(CLR)}
  SrvrItem.Item := Buffer.ToString;
{$ELSE}
  SrvrItem.Item := string(Buffer);
{$ENDIF}
  FItems.Add(SrvrItem);
  SrvrItem.FreeNotification(Self);
{$IF DEFINED(CLR)}
  if HszTopic = 0 then
    SetHszTopic(DdeCreateStringHandleA(ddeMgr.DdeInstId, Topic, CP_WINANSI));
{$ELSE}
  if FHszTopic = 0 then
    FHszTopic := DdeCreateStringHandleA(ddeMgr.DdeInstId, PAnsiChar(AnsiString(Topic)), CP_WINANSI);
{$ENDIF}
  Result := True;
end;

procedure TDdeSrvrConv.AdvStop(Conv: HConv; hszTopic: HSZ; hszItem :HSZ);
var
  SrvrItem: TDdeSrvrItem;
begin
  SrvrItem := GetSrvrItem(hszItem);
  if SrvrItem <> nil then
  begin
    FItems.Remove(SrvrItem);
    SrvrItem.Free;
  end;
end;

function TDdeSrvrConv.PokeData(Conv: HConv; hszTopic: HSZ; hszItem: HSZ;
  Data: HDdeData; Fmt: Integer): LongInt;
var
  Srvr: TDdeServerItem;
{$IF DEFINED(CLR)}
  Buffer: StringBuilder;
{$ELSE}
  Buffer: array[0..4095] of AnsiChar;
{$ENDIF}
begin
  Result := dde_FNotProcessed;
  if Fmt <> CF_TEXT then Exit;
{$IF DEFINED(CLR)}
  Buffer := StringBuilder.Create(4096);
  DdeQueryStringA(ddeMgr.DdeInstId, hszItem, Buffer, Buffer.Capacity, CP_WINANSI);
  Srvr := GetControl(FForm, FSConv, Buffer.ToString);
{$ELSE}
  DdeQueryStringA(ddeMgr.DdeInstId, hszItem, Buffer, Length(Buffer), CP_WINANSI);
  Srvr := GetControl(FForm, FSConv, string(Buffer));
{$ENDIF}
  if Srvr <> nil then Result := Srvr.PokeData(Data);
end;

function TDdeSrvrConv.ExecuteMacro(Conv: HConv; hszTopic: HSZ;
  Data: HDdeData): Integer;
begin
  Result := dde_FNotProcessed;
  if (FSConv <> nil)  then
    Result := FSConv.ExecuteMacro(Data);
end;

function TDdeSrvrConv.RequestData(Conv: HConv; hszTopic: HSZ; hszItem :HSZ;
  Fmt: Word): HDdeData;
var
{$IF DEFINED(CLR)}
  Data: IntPtr;
  B: TBytes;
  Buffer: StringBuilder;
{$ELSE}
  Data: AnsiString;
  Buffer: array[0..4095] of AnsiChar;
{$ENDIF}
  SrvrIt: TDdeSrvrItem;
  Srvr: TDdeServerItem;
begin
  Result := 0;
  SrvrIt := GetSrvrItem(hszItem);
  if SrvrIt <> nil then
    Result := SrvrIt.RequestData(Fmt)
  else
  begin
{$IF DEFINED(CLR)}
    Buffer := StringBuilder.Create(4096);
    DdeQueryStringA(ddeMgr.DdeInstId, hszItem, Buffer, Buffer.Capacity, CP_WINANSI);
    Srvr := GetControl(FForm, FSConv, Buffer.ToString);
{$ELSE}
    DdeQueryStringA(ddeMgr.DdeInstId, hszItem, Buffer, Length(Buffer), CP_WINANSI);
    Srvr := GetControl(FForm, FSConv, string(Buffer));
{$ENDIF}
    if Srvr <> nil then
    begin
      if Fmt = CF_TEXT then
      begin
{$IF DEFINED(CLR)}
        B := BytesOf(Srvr.Lines.Text);
        SetLength(B, Length(B) + SizeOf(AnsiChar));
        Data := Marshal.AllocHGlobal(Length(B));
        try
          Marshal.Copy(B, 0, Data, Length(B));
          Result := DdeCreateDataHandle(ddeMgr.DdeInstId, Data,
            Length(B), 0, hszItem, Fmt, 0 );
        finally
          Marshal.FreeHGlobal(Data);
        end;
{$ELSE}
        Data := AnsiString(Srvr.Lines.Text);
        Result := DdeCreateDataHandle(ddeMgr.DdeInstId, PAnsiChar(Data),
          Length(Data) + 1, 0, hszItem, Fmt, 0 );
{$ENDIF}
      end;
    end;
  end;
end;

function TDdeSrvrConv.GetControl(WinCtrl: TWinControl; DdeConv: TDdeServerConv; const ItemName: string): TDdeServerItem;
var
  I: Integer;
  Ctrl: TComponent;
  MainCtrl: TWinControl;
  Srvr: TDdeServerItem;
begin
  Result := nil;
  MainCtrl := WinCtrl;
  if MainCtrl = nil then
  begin
    if (DdeConv <> nil) and (DdeConv.Owner <> nil) and
      (DdeConv.Owner is TForm) then
      MainCtrl := TWinControl(DdeConv.Owner);
  end;
  if MainCtrl = nil then Exit;
  for I := 0 to MainCtrl.ComponentCount - 1 do
  begin
    Ctrl := MainCtrl.Components[I];
    if Ctrl is TDdeServerItem then
    begin
      if (Ctrl.Name = ItemName) and
        (TDdeServerItem(Ctrl).ServerConv = DdeConv) then
      begin
        Result := TDdeServerItem(Ctrl);
        Exit;
      end;
    end;
    if Ctrl is TWinControl then
    begin
      Srvr := GetControl(TWinControl(Ctrl), DdeConv, ItemName);
      if Srvr <> nil then
      begin
        Result := Srvr;
        Exit;
      end;
    end;
  end;
end;

function TDdeSrvrConv.GetItem(const ItemName: string): TDdeSrvrItem;
var
  I: Integer;
  Item: TDdeSrvrItem;
begin
  Result := nil;
  for I := 0 to FItems.Count - 1 do
  begin
    Item := TDdeSrvrItem(FItems[I]);
    If Item.Item = ItemName then
    begin
      Result := Item;
      Exit;
    end;
  end;
end;

function TDdeSrvrConv.GetSrvrItem(hszItem: HSZ): TDdeSrvrItem;
var
  I: Integer;
  Item: TDdeSrvrItem;
begin
  Result := nil;
  for I := 0 to FItems.Count - 1 do
  begin
    Item := TDdeSrvrItem(FItems[I]);
    If DdeCmpStringHandles(Item.HszItem, hszItem) = 0 then
    begin
      Result := Item;
      Exit;
    end;
  end;
end;

constructor TDdeSrvrItem.Create(AOwner: TComponent);
begin
  FConv := TDdeSrvrConv(AOwner);
  inherited Create(AOwner);
end;

destructor TDdeSrvrItem.Destroy;
begin
  if HszItem <> 0 then
  begin
    DdeFreeStringHandle(ddeMgr.DdeInstId, HszItem);
    SetHszItem(0);
  end;
  inherited Destroy;
end;

function TDdeSrvrItem.GetHszItem: HSZ;
begin
{$IF DEFINED(CLR)}
  if Assigned(FHszItem) then
    Result := Hsz(FHszItem)
  else
    Result := 0;
{$ELSE}
  Result := FHszItem;
{$ENDIF}
end;

procedure TDdeSrvrItem.SetHszItem(const Value: HSZ);
begin
{$IF DEFINED(CLR)}
  if Assigned(FHszItem) then
    ddeMgr.FResources.FStrings.Remove(FHszItem);
  if Value = 0 then
    FHszItem := nil
  else
  begin
    FHszItem := TObject(Value);
    ddeMgr.FResources.FStrings.Add(FHszItem);
  end;
{$ELSE}
  FHszItem := Value;
{$ENDIF}
end;

function TDdeSrvrItem.RequestData(Fmt: Word): HDdeData;
{$IF DEFINED(CLR)}
var
  Data: IntPtr;
  B: TBytes;
  Buffer: StringBuilder;
begin
  Result := 0;
  Buffer := StringBuilder.Create(4096);
  DdeQueryStringA(ddeMgr.DdeInstId, HszItem, Buffer, Buffer.Capacity, CP_WINANSI);
  FItem := Buffer.ToString;
  if Fmt = CF_TEXT then
  begin
    B := BytesOf(Srvr.Lines.Text);
    SetLength(B, Length(B) + 1);
    Data := Marshal.AllocHGlobal(Length(B));
    try
      Marshal.Copy(B, 0, Data, Length(B));
      Result := DdeCreateDataHandle(ddeMgr.DdeInstId, Data, Length(B), 0,
        HszItem, Fmt, 0 );
    finally
     Marshal.FreeHGlobal(Data);
    end;
  end;
{$ELSE}
var
  Data: AnsiString;
  Buffer: array[0..4095] of AnsiChar;
begin
  Result := 0;
  SetString(FItem, Buffer, DdeQueryStringA(ddeMgr.DdeInstId, FHszItem, Buffer,
    Length(Buffer), CP_WINANSI));
  if Fmt = CF_TEXT then
  begin
    Data := AnsiString(FSrvr.Lines.Text);
    Result := DdeCreateDataHandle(ddeMgr.DdeInstId, PAnsiChar(Data),
      Length(Data) + 1, 0, FHszItem, Fmt, 0 );
  end;
{$ENDIF}
end;

procedure TDdeSrvrItem.PostDataChange;
begin
  DdePostAdvise(ddeMgr.DdeInstId, FConv.HszTopic, HszItem);
end;

procedure TDdeSrvrItem.SetItem(const Value: string);
begin
  FItem := Value;
  if HszItem <> 0 then
  begin
    DdeFreeStringHandle(ddeMgr.DdeInstId, HszItem);
    SetHszItem(0);
  end;
  if Length(FItem) > 0 then
{$IF DEFINED(CLR)}
    SetHszItem(DdeCreateStringHandleA(ddeMgr.DdeInstId, FItem, CP_WINANSI));
{$ELSE}
    FHszItem := DdeCreateStringHandleA(ddeMgr.DdeInstId, PAnsiChar(AnsiString(FItem)), CP_WINANSI);
{$ENDIF}
end;

initialization
  ddeMgr := TDdeMgr.Create(Application);
  GroupDescendentsWith(TDdeClientConv, TControl);
  GroupDescendentsWith(TDdeClientItem, TControl);
  GroupDescendentsWith(TDdeServerConv, TControl);
  GroupDescendentsWith(TDdeServerItem, TControl);
finalization
  FreeAndNil(ddeMgr);
end.


