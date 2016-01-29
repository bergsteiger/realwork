{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit adxRTDServ;

{$I adxDefs.inc}

interface

uses Windows, SysUtils, ComObj, ActiveX, Forms, Classes, Dialogs, ExtCtrls;

type
  IRTDUpdateEvent = interface(IDispatch)
    ['{A43788C1-D91B-11D3-8F39-00C04F3651B8}']
    procedure UpdateNotify; safecall;
    function Get_HeartbeatInterval: Integer; safecall;
    procedure Set_HeartbeatInterval(plRetVal: Integer); safecall;
    procedure Disconnect; safecall;
    property HeartbeatInterval: Integer read Get_HeartbeatInterval write Set_HeartbeatInterval;
  end;

  IRtdServer = interface(IDispatch)
    ['{EC0E6191-DB51-11D3-8F3E-00C04F3651B8}']
    function ServerStart(const CallbackObject: IRTDUpdateEvent): Integer; safecall;
    function ConnectData(TopicID: Integer; var Strings: PSafeArray; var GetNewValues: WordBool): OleVariant; safecall;
    function RefreshData(var TopicCount: Integer): PSafeArray; safecall;
    procedure DisconnectData(TopicID: Integer); safecall;
    function Heartbeat: Integer; safecall;
    procedure ServerTerminate; safecall;
  end;

  TadxOnRefreshData = function(Sender: TObject): OleVariant of object;

  TadxRTDTopic = class(TComponent)
  private
    FTopicID: Integer;
    FEnabled: boolean;
    FUseStoredValue: boolean;
    FDefaultValue: OleVariant;
    FStrings: array [0..27] of WideString;
    FNestedTopics: TList;
    FOnRefreshData: TadxOnRefreshData;
    FOnConnect: TNotifyEvent;
    FOnDisconnect: TNotifyEvent;
    function GetText: string;
    function GetString(Index: Integer): WideString;
    procedure SetString(Index: Integer; const Value: WideString);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property TopicID: Integer read FTopicID;
    property Strings[Index: Integer]: WideString read GetString write SetString; default;
    property Text: string read GetText;
  published
    property Enabled: boolean read FEnabled write FEnabled default True;
    property DefaultValue: OleVariant read FDefaultValue write FDefaultValue;
    property String01: WideString Index 0 read GetString write SetString;
    property String02: WideString Index 1 read GetString write SetString;
    property String03: WideString Index 2 read GetString write SetString;
    property String04: WideString Index 3 read GetString write SetString;
    property String05: WideString Index 4 read GetString write SetString;
    property String06: WideString Index 5 read GetString write SetString;
    property String07: WideString Index 6 read GetString write SetString;
    property String08: WideString Index 7 read GetString write SetString;
    property String09: WideString Index 8 read GetString write SetString;
    property String10: WideString Index 9 read GetString write SetString;
    property String11: WideString Index 10 read GetString write SetString;
    property String12: WideString Index 11 read GetString write SetString;
    property String13: WideString Index 12 read GetString write SetString;
    property String14: WideString Index 13 read GetString write SetString;
    property String15: WideString Index 14 read GetString write SetString;
    property String16: WideString Index 15 read GetString write SetString;
    property String17: WideString Index 16 read GetString write SetString;
    property String18: WideString Index 17 read GetString write SetString;
    property String19: WideString Index 18 read GetString write SetString;
    property String20: WideString Index 19 read GetString write SetString;
    property String21: WideString Index 20 read GetString write SetString;
    property String22: WideString Index 21 read GetString write SetString;
    property String23: WideString Index 22 read GetString write SetString;
    property String24: WideString Index 23 read GetString write SetString;
    property String25: WideString Index 24 read GetString write SetString;
    property String26: WideString Index 25 read GetString write SetString;
    property String27: WideString Index 26 read GetString write SetString;
    property String28: WideString Index 27 read GetString write SetString;
    property UseStoredValue: boolean read FUseStoredValue write FUseStoredValue default False;
    property OnRefreshData: TadxOnRefreshData read FOnRefreshData write FOnRefreshData;
    property OnConnect: TNotifyEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TNotifyEvent read FOnDisconnect write FOnDisconnect;
  end;

  TadxXlRTDServerModule = class;
  TadxXlRTDServerModuleClass = class of TadxXlRTDServerModule;

  TadxRTDFactory = class(TAutoObjectFactory)
  private
    FModuleClass: TadxXlRTDServerModuleClass;
    FFilePath: string;
  public
    constructor Create(ComServer: TComServerObject; AutoClass: TAutoClass;
      const ClassID: TGUID; AModuleClass: TadxXlRTDServerModuleClass);
    property FilePath: string read FFilePath;
  end;

  TadxRTDServer = class(TAutoObject, IRtdServer)
  private
    FTimer: TTimer;
    FRTDUpdateEvent: IRTDUpdateEvent;
    FModule: TadxXlRTDServerModule;
    FUpdating: boolean;
    FTargetTopicID: Integer;
    function GetFactory: TadxRTDFactory;
    procedure DoOnTimer(Sender: TObject);
    procedure UpdateTopics;
    { IRtdServer }
    //
    // * The ServerStart method is called immediately after a real-time data
    //   server is instantiated.
    // * CallbackObject - the callback IRTDUpdateEvent object.
    // * Result - negative value or zero indicates failure to start the server;
    //   positive value indicates success.
    function ServerStart(const CallbackObject: IRTDUpdateEvent): Integer; safecall;
    //
    // * Adds new topics from a real-time data server. The ConnectData method is
    //   called when a file is opened that contains real-time data functions or
    //   when a user types in a new formula which contains the RTD function.
    // * TopicID - a unique value, assigned by Microsoft Excel, which
    //   identifies the topic.
    // * Strings - a single-dimensional array of strings identifying the topic.
    // * GetNewValues - True to determine if new values are to be acquired.
    // * Result - the initial value for a new topic
    function ConnectData(TopicID: Integer; var Strings: PSafeArray;
      var GetNewValues: WordBool): OleVariant; safecall;
    //
    // * This method is called by Microsoft Excel to get new data. This method
    //   call only takes place after being notified by the real-time data server
    //   that there is new data.
    // * TopicCount - the RTD server must change the value of the TopicCount to
    //   the number of elements in the array returned.
    // * Result - the data returned to Microsoft Excel is a Variant containing a
    //   two-dimensional array. The first dimension represents the list of topic
    //   IDs. The second dimension represents the values associated with the
    //   topic IDs.
    function RefreshData(var TopicCount: Integer): PSafeArray; safecall;
    //
    // * Notifies the RTD server application that a topic is no longer in use.
    // * TopicID - a unique value of the topic assigned by Microsoft Excel.
    procedure DisconnectData(TopicID: Integer); safecall;
    //
    // * Determines if the real-time data server is still active. The Heartbeat
    //   method is called by Microsoft Excel if the HeartbeatInterval property
    //   has elapsed since the last time Excel was called with the UpdateNotify
    //   method.
    // * Result - zero or negative number indicates failure; positive
    //   number indicates success.
    function Heartbeat: Integer; safecall;
    //
    // * Terminates the connection to the real-time data server.
    procedure ServerTerminate; safecall;
  protected
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; override; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; override; stdcall;
  public
    property Factory: TadxRTDFactory read GetFactory;
    property RTDServerModule: TadxXlRTDServerModule read FModule;
  end;

  TadxRTDOnError = procedure (const E: SysUtils.Exception; var Handled: boolean) of object;
  TadxRTDOnConnectData = procedure (const Topics: array of string) of object;

  TadxXlRTDServerModule = class(TDataModule)
  private
    FInterval: Longword;
    FOnRTDInitialize: TNotifyEvent;
    FOnRTDFinalize: TNotifyEvent;
    FServerClassFactory: TadxRTDFactory;
    FServerClassInstance: TadxRTDServer;
    FOnError: TadxRTDOnError;
    FOnConnectData: TadxRTDOnConnectData;
    procedure SetInterval(const Value: Longword);
    procedure DoError(const E: Exception);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateTopics;
    procedure UpdateTopic(TopicID: Integer); overload;
    procedure UpdateTopic(RTDTopic: TadxRTDTopic); overload;
    property RTDServerClassInstance: TadxRTDServer read FServerClassInstance;
    property RTDServerClassFactory: TadxRTDFactory read FServerClassFactory;
  published
    property Interval: Longword read FInterval write SetInterval default 5000;
    property OnRTDInitialize: TNotifyEvent read FOnRTDInitialize write FOnRTDInitialize;
    property OnRTDFinalize: TNotifyEvent read FOnRTDFinalize write FOnRTDFinalize;
    property OnError: TadxRTDOnError read FOnError write FOnError;
    property OnConnectData: TadxRTDOnConnectData read FOnConnectData write FOnConnectData;
  end;

implementation

var
  TopicList: TList;

{$IFDEF ADX_TRIAL}
{$I Trial_rtd_1.inc}
{$ENDIF}

{ TadxRTDTopic }

constructor TadxRTDTopic.Create(AOwner: TComponent);
var
  i: Integer;
begin
  if AOwner = nil then
    raise Exception.Create(Format('The %s class cannot be contained in the %s class.', [ClassName, 'nil']));
  if not (AOwner is TadxXlRTDServerModule) then
    raise Exception.Create(Format('The %s class cannot be contained in the %s class.', [ClassName, AOwner.ClassName]));
  inherited Create(AOwner);
  FNestedTopics := TList.Create;
  for i := 0 to 27 do FStrings[i] := '';
  FUseStoredValue := False;
  FEnabled := True;
  FTopicID := -1;
  TopicList.Add(Self);
end;

destructor TadxRTDTopic.Destroy;
var
  Index: Integer;
begin
  Index := TopicList.IndexOf(Self);
  if Index >= 0 then TopicList.Delete(Index);
  FNestedTopics.Free;
  inherited Destroy;
end;

function TadxRTDTopic.GetString(Index: Integer): WideString;
begin
  if (Index < 0) or (Index > 27) then
    raise Exception.Create(Format('List index out of bounds (%d)', [Index]));
  Result := FStrings[Index];
end;

procedure TadxRTDTopic.SetString(Index: Integer; const Value: WideString);
begin
  if (Index < 0) or (Index > 27) then
    raise Exception.Create(Format('List index out of bounds (%d)', [Index]));
  FStrings[Index] := Value;
end;

procedure TadxRTDTopic.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if Source is TadxRTDTopic then begin
    Tag := TadxRTDTopic(Source).Tag;
    FTopicID := TadxRTDTopic(Source).TopicID;
    Enabled := TadxRTDTopic(Source).Enabled;
    UseStoredValue := TadxRTDTopic(Source).UseStoredValue;
    DefaultValue := TadxRTDTopic(Source).DefaultValue;
    for i := 0 to 27 do
      FStrings[i] := TadxRTDTopic(Source)[i];
  end
  else
    inherited Assign(Source);
end;

function TadxRTDTopic.GetText: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to 27 do Result := Result + FStrings[i];
end;

{ TadxRTDFactory }

constructor TadxRTDFactory.Create(ComServer: TComServerObject;
  AutoClass: TAutoClass; const ClassID: TGUID;
  AModuleClass: TadxXlRTDServerModuleClass);
var
  Buffer: array [0..MAX_PATH + 1] of Char;
begin
  inherited Create(ComServer, AutoClass, ClassID, ciSingleInstance, tmApartment);
  FModuleClass := AModuleClass;
  {$IFDEF UNICODE}
  SetString(FFilePath, Buffer, Windows.GetModuleFileName(HInstance, Buffer, Length(Buffer)));
  {$ELSE}
  SetString(FFilePath, Buffer, Windows.GetModuleFileName(HInstance, Buffer, SizeOf(Buffer)));
  {$ENDIF}
  FFilePath := ExtractFilePath(FFilePath);
end;

{ TadxRTDServer }

function TadxRTDServer.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;

  procedure WideCharToShortString(P: PWideChar; var S: ShortString);
  var
    I: Integer;
    W: WideChar;
  begin
    I := 0;
    repeat
      W := P[I];
      if W = #0 then Break;
      if W >= #256 then W := #0;
      Inc(I);
      {$IFDEF UNICODE}
      S[I] := AnsiChar(W);
      {$ELSE}
      S[I] := Char(W);
      {$ENDIF}
    until I = 255;
    {$IFDEF UNICODE}
    S[0] := AnsiChar(I);
    {$ELSE}
    S[0] := Char(I);
    {$ENDIF}
  end;

type
  PNames = ^TNames;
  TNames = array[0..100] of POleStr;
  PDispIDs = ^TDispIDs;
  TDispIDs = array[0..100] of Cardinal;
var
  Name: ShortString;
begin
  Result := inherited GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs);
  if Result <> S_OK then begin
    WideCharToShortString(PNames(Names)^[0], Name);
    FillChar(DispIDs^, SizeOf(PDispIds(DispIDs^)[0]) * NameCount, $FF);
    if Name = 'ServerStart' then PDispIds(DispIds)^[0] := 10
    else
      if Name = 'ConnectData' then PDispIds(DispIds)^[0] := 11
      else
        if Name = 'RefreshData' then PDispIds(DispIds)^[0] := 12
        else
          if Name = 'DisconnectData' then PDispIds(DispIds)^[0] := 13
          else
            if Name = 'Heartbeat' then PDispIds(DispIds)^[0] := 14
            else
              if Name = 'ServerTerminate' then PDispIds(DispIds)^[0] := 15;
    Result := S_OK;
  end;
end;

function TadxRTDServer.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  Parms: PDispParams;
  TempRet: OleVariant;
begin
  Result := S_OK;
  Parms := @Params;
  try
    if VarResult = nil then VarResult := @TempRet;
    case DispID of
      10: POleVariant(VarResult)^ :=
            ServerStart(IDispatch(Parms^.rgvarg^[0].dispVal) as IRTDUpdateEvent);
      11: POleVariant(VarResult)^ := ConnectData(Parms^.rgvarg^[2].lVal,
            Parms^.rgvarg^[1].parray, Parms^.rgvarg^[0].pbool^);
      12: begin
            VarClear(POleVariant(VarResult)^);
            TVarData(POleVariant(VarResult)^).VType := varVariant or varArray;
            TVarData(POleVariant(VarResult)^).VArray :=
              PVarArray(RefreshData(Parms^.rgvarg^[0].plVal^));
          end;
      13: DisconnectData(Parms^.rgvarg^[0].lVal);
      14: POleVariant(VarResult)^ := Heartbeat;
      15: ServerTerminate;
    end;
  except
    Result := DISP_E_EXCEPTION;
  end;
end;

function TadxRTDServer.ServerStart(const CallbackObject: IRTDUpdateEvent): Integer;
begin
  FUpdating := False;
  FTargetTopicID := -1;
  Result := 0;
  FRTDUpdateEvent := CallbackObject;
  FModule := TadxRTDFactory(Factory).FModuleClass.Create(nil);
  FModule.FServerClassInstance := Self;
  FModule.FServerClassFactory := Factory;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := FModule.Interval;
  FTimer.OnTimer := DoOnTimer;
  try
    {$IFDEF ADX_TRIAL}
    {$I Trial_rtd_2.inc}
    {$ENDIF}
    if Assigned(FModule.FOnRTDInitialize) then
      FModule.FOnRTDInitialize(FModule);
    Result := 1;
  except
    on E: Exception do
      if Assigned(FModule) then FModule.DoError(E);
  end;
end;

function TadxRTDServer.ConnectData(TopicID: Integer; var Strings: PSafeArray;
  var GetNewValues: WordBool): OleVariant;

  function GetTopics(var Topics: array of string): string;
  var
    i: Integer;
    V: Variant;
  begin
    Result := '';
    for i := 0 to Strings^.rgsabound[0].cElements - 1 do begin
      SafeArrayGetElement(Strings, i, V);
      Result := Result + V;
      Topics[i] := V;
    end;
  end;

  function IndexOfTopicStrings(const S: string): Integer;
  begin
    {$IFDEF ADX_TRIAL}
    Result := -1;
    if TopicList.Count > 0 then
      if TadxRTDTopic(TopicList[0]).Text = S then Result := 0;
    {$ELSE}
    for Result := 0 to TopicList.Count - 1 do
      if TadxRTDTopic(TopicList[Result]).Text = S then Exit;
    Result := -1;
    {$ENDIF}
  end;

  function FindNestedTopic(const TopicStrings: array of string): TadxRTDTopic;
  var
    i, j, ParamCount: Integer;
    Condition: boolean;
    SourceTopic, CurrentTopic: TadxRTDTopic;
  begin
    Result := nil;
    SourceTopic := nil;
    for i := 0 to TopicList.Count - 1 do begin
      CurrentTopic := TadxRTDTopic(TopicList[i]);
      ParamCount := 0;
      while (ParamCount <= 27) and (CurrentTopic.FStrings[ParamCount] <> '') do
        Inc(ParamCount);
      if High(TopicStrings) = (ParamCount - 1) then begin
        Condition := True;
        for j := 0 to ParamCount - 1 do
          if (CurrentTopic[j] <> TopicStrings[j]) and (CurrentTopic[j] <> '*') then begin
            Condition := False;
            Break;
          end;
        if Condition then begin
          SourceTopic := CurrentTopic;
          Break;
        end;
      end;
    end;
    if Assigned(SourceTopic) then begin
      CurrentTopic := TadxRTDTopic.Create(FModule);
      CurrentTopic.Assign(SourceTopic);
      CurrentTopic.FOnRefreshData := SourceTopic.FOnRefreshData;
      CurrentTopic.FOnConnect := SourceTopic.FOnConnect;
      CurrentTopic.FOnDisconnect := SourceTopic.FOnDisconnect;
      for i := Low(TopicStrings) to High(TopicStrings) do
        CurrentTopic[i] := TopicStrings[i];
      SourceTopic.FNestedTopics.Add(CurrentTopic);
      Result := CurrentTopic;
    end;
  end;

var
  S: string;
  Index: Integer;
  Topic: TadxRTDTopic;
  TopicStrings: array of string;
begin
  if Assigned(Strings) then begin
    SetLength(TopicStrings, Strings^.rgsabound[0].cElements);
    try
      S := GetTopics(TopicStrings);
      Index := IndexOfTopicStrings(S);
      if Index > -1 then
        Topic := TadxRTDTopic(TopicList[Index])
      else begin
        {$IFDEF ADX_TRIAL}
        Topic := nil;
        {$ELSE}
        Topic := FindNestedTopic(TopicStrings);
        if (Topic = nil) and Assigned(FModule.FOnConnectData) then begin
          FModule.FOnConnectData(TopicStrings);
          Index := IndexOfTopicStrings(S);
          if Index > -1 then
            Topic := TadxRTDTopic(TopicList[Index]);
        end;
        {$ENDIF}
      end;
      if Assigned(Topic) then begin
        Topic.FTopicID := TopicID;
        GetNewValues := not Topic.UseStoredValue;
        if GetNewValues then begin
          Result := Topic.DefaultValue;
          if TVarData(Result).VType = varString then begin
            TVarData(Result).VType := varOleStr;
            TVarData(Result).VOleStr := StringToOleStr(Topic.DefaultValue);
          end;
        end;
        if Assigned(Topic.FOnConnect) then
          try
            Topic.FOnConnect(Topic); 
          except
            on E: Exception do FModule.DoError(E);
          end;
      end
      else
        Result := 'Unrecognized';
    finally
      SetLength(TopicStrings, 0);
    end;
  end;
end;

function TadxRTDServer.RefreshData(var TopicCount: Integer): PSafeArray;
var
  V: OleVariant;
  Index, i: Integer;
  Indexes: array [0..1] of Integer;
  Bounds: array [0..1] of SAFEARRAYBOUND;
begin
  FUpdating := True;
  try
    TopicCount := 0;
    {$IFDEF ADX_TRIAL}
    if TopicList.Count > 0 then
      if TadxRTDTopic(TopicList[0]).Enabled and
        (TadxRTDTopic(TopicList[0]).FTopicID >= 0) then Inc(TopicCount);
    {$ELSE}
    // Case #1203
    if Self.FTargetTopicID <> -1 then begin
      for i := 0 to TopicList.Count - 1 do
        if TadxRTDTopic(TopicList[i]).Enabled and
         (TadxRTDTopic(TopicList[i]).FTopicID >= 0) and
         (TadxRTDTopic(TopicList[i]).FTopicID = Self.FTargetTopicID) then
        begin
          TopicCount := 1;
          Break;
        end;
    end
    else
      for i := 0 to TopicList.Count - 1 do
        if TadxRTDTopic(TopicList[i]).Enabled and
         (TadxRTDTopic(TopicList[i]).FTopicID >= 0) then Inc(TopicCount);
    {$ENDIF}
    if TopicCount > 0 then begin
      Bounds[0].cElements := 2;
      Bounds[0].lLbound := 0;
      Bounds[1].cElements := TopicCount;
      Bounds[1].lLbound := 0;
      Result := SafeArrayCreate(VT_VARIANT, 2, bounds);
      Index := 0;
      // Case #1203
      if Self.FTargetTopicID <> -1 then begin
        for i := 0 to TopicList.Count - 1 do
          if TadxRTDTopic(TopicList[i]).Enabled and
            (TadxRTDTopic(TopicList[i]).FTopicID >= 0) and
            (TadxRTDTopic(TopicList[i]).FTopicID = Self.FTargetTopicID) then
          begin
            Indexes[0] := 0;
            Indexes[1] := Index;
            V := TadxRTDTopic(TopicList[i]).FTopicID;
            SafeArrayPutElement(Result, Indexes, V);
            Indexes[0] := 1;
            Indexes[1] := Index;
            try
              if Assigned(TadxRTDTopic(TopicList[i]).FOnRefreshData) then
                V := TadxRTDTopic(TopicList[i]).FOnRefreshData(TadxRTDTopic(TopicList[i]))
              else
                V := 'Unrecognized';
            except
              on E: Exception do FModule.DoError(E);
            end;
            SafeArrayPutElement(Result, Indexes, V);
            Break;
          end;
        Self.FTargetTopicID := -1;
      end
      else
        for i := 0 to TopicList.Count - 1 do
          if TadxRTDTopic(TopicList[i]).Enabled and
            (TadxRTDTopic(TopicList[i]).FTopicID >= 0) then
          begin
            Indexes[0] := 0;
            Indexes[1] := Index;
            V := TadxRTDTopic(TopicList[i]).FTopicID;
            SafeArrayPutElement(Result, Indexes, V);
            Indexes[0] := 1;
            Indexes[1] := Index;
            try
              if Assigned(TadxRTDTopic(TopicList[i]).FOnRefreshData) then
                V := TadxRTDTopic(TopicList[i]).FOnRefreshData(TadxRTDTopic(TopicList[i]))
              else
                V := 'Unrecognized';
            except
              on E: Exception do FModule.DoError(E);
            end;
            SafeArrayPutElement(Result, Indexes, V);
            Inc(Index);
            {$IFDEF ADX_TRIAL}
            Break;
            {$ENDIF}
          end;
    end;
  finally
    FUpdating := False;
  end;
end;

procedure TadxRTDServer.DisconnectData(TopicID: Integer);

  function IndexOfTopicID(const ATopicID: Integer): Integer;
  begin
    for Result := 0 to TopicList.Count - 1 do
      if TadxRTDTopic(TopicList[Result]).FTopicID = ATopicID then Exit;
    Result := -1;
  end;

var
  Index: Integer;
begin
  Index := IndexOfTopicID(TopicID);
  if Index > -1 then begin
    try
      if Assigned(TadxRTDTopic(TopicList[Index]).FOnDisconnect) then
        TadxRTDTopic(TopicList[Index]).FOnDisconnect(TadxRTDTopic(TopicList[Index]));
    except
      on E: Exception do FModule.DoError(E);
    end;
    TadxRTDTopic(TopicList[Index]).FTopicID := -1;
  end;
end;

function TadxRTDServer.Heartbeat: Integer;
begin
  Result := 1;
end;

procedure TadxRTDServer.ServerTerminate;
begin
  FTimer.Enabled := False;
  FTimer.Free;
  try
    if Assigned(FModule.FOnRTDFinalize) then
      FModule.FOnRTDFinalize(FModule);
  except
    on E: Exception do FModule.DoError(E);
  end;
  FRTDUpdateEvent := nil;
  FreeAndNil(FModule);
end;

procedure TadxRTDServer.UpdateTopics;
begin
  if Assigned(FRTDUpdateEvent) then FRTDUpdateEvent.UpdateNotify;
end;

procedure TadxRTDServer.DoOnTimer(Sender: TObject);
begin
  UpdateTopics;
end;

function TadxRTDServer.GetFactory: TadxRTDFactory;
begin
  Result := TadxRTDFactory(inherited Factory);
end;                                                   

{ TadxXlRTDServerModule }

constructor TadxXlRTDServerModule.Create(AOwner: TComponent);
begin
  FInterval := 5000;
  inherited Create(AOwner);
  FServerClassInstance := nil;
  FServerClassFactory := nil;
end;

destructor TadxXlRTDServerModule.Destroy;
begin
  FServerClassInstance := nil;
  FServerClassFactory := nil;
  inherited Destroy;
end;

procedure TadxXlRTDServerModule.UpdateTopics;
begin
  if Assigned(FServerClassInstance) then
    if (not FServerClassInstance.FUpdating) then begin
      FServerClassInstance.FTargetTopicID := -1;
      FServerClassInstance.UpdateTopics;
    end;
end;

// Case #1203
procedure TadxXlRTDServerModule.UpdateTopic(TopicID: Integer);
begin
  if Assigned(FServerClassInstance) then
    if (not FServerClassInstance.FUpdating) then begin
      FServerClassInstance.FTargetTopicID := TopicID;
      FServerClassInstance.UpdateTopics;
    end;
end;

procedure TadxXlRTDServerModule.UpdateTopic(RTDTopic: TadxRTDTopic);
begin
  if Assigned(FServerClassInstance) then
    if (not FServerClassInstance.FUpdating) then begin
      FServerClassInstance.FTargetTopicID := RTDTopic.TopicID;
      FServerClassInstance.UpdateTopics;
    end;
end;

procedure TadxXlRTDServerModule.DoError(const E: Exception);
var
  Handled: boolean;
begin
  Handled := False;
  if Assigned(FOnError) then FOnError(E, Handled);
  if not Handled then
    MessageDlg(Format('RTD Server error: the server has fired an exception.'#13#10 +
     '%s', [E.Message]), mtError, [mbOK], 0);
end;

procedure TadxXlRTDServerModule.SetInterval(const Value: Longword);
begin
  FInterval := Value;
  if Assigned(FServerClassInstance) then
    if FServerClassInstance.FTimer.Interval <> Value then
      FServerClassInstance.FTimer.Interval := Value;
end;

initialization
  TopicList := TList.Create;

finalization
  TopicList.Free;

end.
