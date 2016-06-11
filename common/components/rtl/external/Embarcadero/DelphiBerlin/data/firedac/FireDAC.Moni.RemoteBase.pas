{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{      FireDAC monitor TCP/IP based implementation      }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Moni.RemoteBase;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.Classes, System.SysUtils, System.SyncObjs,
  System.Win.ScktComp,
  FireDAC.Stan.Util, FireDAC.Stan.Intf;

type
  // common
  TFDMoniRemoteQueueItem = class;
  TFDMoniRemoteQueue = class;
  TFDMoniRemoteQueueWorker = class;
  TFDMoniRemoteStream = class;
  TFDMoniRemoteAdapterList = class;
  EFDMoniException = class(Exception);

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteQueueItem                                                     }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteQueueEventKind = (ptNone, ptConnectClient, ptDisConnectClient,
    ptRegisterAdapter, ptUnRegisterAdapter, ptUpdateAdapter, ptNotify);
  TFDMoniRemoteQueueEventKinds = set of TFDMoniRemoteQueueEventKind;
  TFDMoniRemoteQueueItem = class(TObject)
  private
    procedure SetArg(AArg: PVarRec);
  public
    FProcessID: LongWord;
    FMonitorID: LongWord;
    FEvent: TFDMoniRemoteQueueEventKind;
    FKind: TFDMoniEventKind;
    FStep: TFDMoniEventStep;
    FHandle: LongWord;
    FMessage: String;
    FPath: String;
    FArgs: TMemoryStream;
    FProc: Pointer;
    FTime: LongWord;
    constructor Create;
    destructor Destroy; override;
    procedure SetArgs(const AArgs: array of const); overload;
    procedure SetArgs(const AArgs: Variant); overload;
    function GetArgs: Variant;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteQueue                                                         }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteQueue = class(TObject)
  private
    FList: TFDObjList;
    FThread: TFDMoniRemoteQueueWorker;
    FOnPostItem: TNotifyEvent;
    FQueueCriticalSection: TCriticalSection;
    function GetCount: Integer;
  public
    constructor Create(AThread: TFDMoniRemoteQueueWorker);
    destructor Destroy; override;
    function GetItem: TFDMoniRemoteQueueItem;
    function GetNextEvent: TFDMoniRemoteQueueEventKind;
    procedure PostItem(AItem: TFDMoniRemoteQueueItem);
    procedure Clear;
    property Count: Integer read GetCount;
    property OnPostItem: TNotifyEvent read FOnPostItem write FOnPostItem;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteQueueWorker                                                   }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteQueueWorker = class(TThread)
  private
    FItemAvailableEvent: TEvent;
  protected
    procedure DoAction; virtual; abstract;
    function GetQueue: TFDMoniRemoteQueue; virtual; abstract;
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AbortProcessing;
    procedure Signal;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteStream                                                        }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteStreamOpenMode = (omRead, omWrite);
  TFDMoniRemoteStreamBlockID = LongWord;
  TFDMoniRemoteStream = class(TObject)
  private
    FConnection: TCustomWinSocket;
    FBuffer: TMemoryStream;
    FBlockLevel: Integer;
    FMode: TFDMoniRemoteStreamOpenMode;
    FEncoder: TFDEncoder;
    procedure WriteBytes(const ABuff; ALen: Integer);
    procedure WriteValueHeader(const AParamName: String; AType: TFDAnsiChar);
    procedure ReadBytes(var ABuff; ALen: Integer);
    procedure ReadValueHeader(const AParamName: String; AType: TFDAnsiChar);
    procedure ReceiveBuffer;
    procedure SendBuffer;
  public
    procedure Open(AConnection: TCustomWinSocket;
      AMode: TFDMoniRemoteStreamOpenMode);
    procedure Close;
    function IsOpen: Boolean;
    procedure WriteBeginBlock(AID: TFDMoniRemoteStreamBlockID);
    procedure WriteEndBlock;
    procedure WriteString(const AParamName: String; const AValue: String);
    procedure WriteBlob(const AParamName: String; AValue: TMemoryStream);
    procedure WriteBoolean(const AParamName: String; AValue: Boolean);
    procedure WriteInteger(const AParamName: String; AValue: Integer);
    procedure WriteLongWord(const AParamName: String; AValue: LongWord);
    procedure WriteFloat(const AParamName: String; AValue: Double);
    procedure WriteDate(const AParamName: String; AValue: TDateTime);

    procedure ReadBeginBlock(AID: TFDMoniRemoteStreamBlockID);
    procedure ReadEndBlock;
    function IsEndBlock: Boolean;
    function ReadString(const AParamName: String): String;
    procedure ReadBlob(const AParamName: String; AValue: TMemoryStream);
    function ReadBoolean(const AParamName: String): Boolean;
    function ReadInteger(const AParamName: String): Integer;
    function ReadLongWord(const AParamName: String): LongWord;
    function ReadFloat(const AParamName: String): Double;
    function ReadDate(const AParamName: String): TDateTime;
  end;

  {----------------------------------------------------------------------------}
  { TFDMoniRemoteAdapterList                                                   }
  {----------------------------------------------------------------------------}
  TFDMoniRemoteAdapterList = class(TObject)
  private
    FList: TFDStringList;
    function GetCount: Integer;
    function GetPath(AIndex: Integer): string;
    function GetHandle(AIndex: Integer): LongWord;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function IndexOf(AHandle: LongWord): Integer;
    function FindByHandle(AHandle: LongWord): string;
    function FindByPath(const APath: string): LongWord;
    procedure AddAdapter(const APath: string; AHandle: LongWord);
    procedure RemoveAdapter(AHandle: LongWord);
    property Count: Integer read GetCount;
    property Paths[AIndex: Integer]: string read GetPath;
    property Handles[AIndex: Integer]: LongWord read GetHandle;
  end;

const
  C_FD_Mon_PacketVersion: Integer = 1;
  C_FD_Mon_PacketBodyBlockID: Integer = 0;

  S_FD_MsgVersion: String = 'VER';
  S_FD_MsgEvent: String = 'EVT';
  S_FD_MsgProcessId: String = 'PID';
  S_FD_MsgMonitorId: String = 'MID';
  S_FD_MsgText: String = 'MSG';
  S_FD_MsgArgs: String = 'ARG';
  S_FD_MsgAdapterHandle: String = 'HND';
  S_FD_MsgNotifyKind: String = 'KND';
  S_FD_MsgNotifyStep: String = 'STP';
  S_FD_MsgTime: String = 'TIM';

  function FDMoniRemoteIsLocalHost(const AIP: String): Boolean;

implementation

uses
  System.Variants,
{$IFNDEF NEXTGEN}
  System.AnsiStrings,
{$ENDIF}
  FireDAC.Stan.ResStrs;

const
  C_FD_Mon_StringHeader:    TFDAnsiChar = TFDAnsiChar('S');
  C_FD_Mon_BooleanHeader:   TFDAnsiChar = TFDAnsiChar('B');
  C_FD_Mon_IntegerHeader:   TFDAnsiChar = TFDAnsiChar('I');
  C_FD_Mon_FloatHeader:     TFDAnsiChar = TFDAnsiChar('F');
  C_FD_Mon_DateHeader:      TFDAnsiChar = TFDAnsiChar('D');
  C_FD_Mon_BlobHeader:      TFDAnsiChar = TFDAnsiChar('L');
  C_FD_Mon_BeginBlockDelim: TFDAnsiChar = TFDAnsiChar('{');
  C_FD_Mon_EndBlockDelim:   TFDAnsiChar = TFDAnsiChar('}');

var
  GEmptyObj, GNullObj: TFDValWrapper;

{-------------------------------------------------------------------------------}
function FDMoniRemoteIsLocalHost(const AIP: String): Boolean;
begin
  Result := (AIP <> '127.0.0.1') and (LowerCase(AIP) <> 'localhost');
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteQueueItem                                                        }
{-------------------------------------------------------------------------------}
constructor TFDMoniRemoteQueueItem.Create;
begin
  inherited Create;
  FArgs := TMemoryStream.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteQueueItem.Destroy;
begin
  FDFreeAndNil(FArgs);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteQueueItem.SetArg(AArg: PVarRec);
var
  iLen: Integer;
  bByte: Byte;
  uiPtr: UInt64;
begin
  FArgs.WriteBuffer(AArg^.VType, SizeOf(AArg^.VType));
  case AArg^.VType of
    vtInteger:
      FArgs.WriteBuffer(AArg^.VInteger, SizeOf(AArg^.Vinteger));
    vtBoolean:
      FArgs.WriteBuffer(AArg^.VBoolean, SizeOf(AArg^.VBoolean));
    vtChar:
      FArgs.WriteBuffer(AArg^.VChar, SizeOf(AArg^.VChar));
    vtExtended:
      FArgs.WriteBuffer(AArg^.VExtended^, SizeOf(AArg^.VExtended^));
    vtString:
      begin
        iLen := Length(AArg^.VString^);
        FArgs.WriteBuffer(iLen, SizeOf(iLen));
        if iLen > 0 then
        {$IFDEF NEXTGEN}
          FArgs.WriteBuffer(String(AArg^.VString^)[1], iLen);
        {$ELSE}
          FArgs.WriteBuffer(AArg^.VString^[1], iLen);
        {$ENDIF}
      end;
    vtPointer:
      begin
        uiPtr := UInt64(AArg^.VPointer);
        FArgs.WriteBuffer(uiPtr, SizeOf(uiPtr));
      end;
    vtPChar:
      begin
        iLen := {$IFNDEF NEXTGEN} System.AnsiStrings. {$ENDIF}
          StrLen(AArg^.VPChar);
        FArgs.WriteBuffer(iLen, SizeOf(iLen));
        if iLen > 0 then
        {$IFDEF NEXTGEN}
          FArgs.WriteBuffer(PChar(AArg^.VPChar)^, iLen);
        {$ELSE}
          FArgs.WriteBuffer(AArg^.VPChar^, iLen);
        {$ENDIF}
      end;
    vtAnsiString:
      begin
        iLen := Length( {$IFDEF NEXTGEN} String {$ELSE} AnsiString {$ENDIF} (AArg^.VAnsiString));
        FArgs.WriteBuffer(iLen, SizeOf(iLen));
        if iLen > 0 then
        {$IFDEF NEXTGEN}
          FArgs.WriteBuffer(PChar(String(AArg^.VAnsiString))^, iLen);
        {$ELSE}
          FArgs.WriteBuffer(PAnsiChar(AnsiString(AArg^.VAnsiString))^, iLen);
        {$ENDIF}
      end;
    vtCurrency:
      FArgs.WriteBuffer(AArg^.VCurrency^, SizeOf(AArg^.VCurrency^));
    vtWideChar:
      FArgs.WriteBuffer(AArg^.VWideChar, SizeOf(AArg^.VWideChar));
    vtWideString:
      begin
        iLen := Length(WideString(AArg^.VWideString)) * SizeOf(WideChar);
        FArgs.WriteBuffer(iLen, SizeOf(iLen));
        if iLen > 0 then
          FArgs.WriteBuffer(PWideChar(WideString(AArg^.VWideString))^, iLen);
      end;
    vtPWideChar:
      begin
        iLen := StrLen(AArg^.VPWideChar) * SizeOf(WideChar);
        FArgs.WriteBuffer(iLen, SizeOf(iLen));
        if iLen > 0 then
          FArgs.WriteBuffer(AArg^.VPWideChar^, iLen);
      end;
    vtInt64:
      FArgs.WriteBuffer(AArg^.VInt64^, SizeOf(AArg^.VInt64^));
    vtObject:
      begin
        // special case - for NULL and Unassigned
        ASSERT((TObject(AArg^.VObject) is TFDValWrapper) and
               ((TFDValWrapper(AArg^.VObject).AsInt = 0) or
                (TFDValWrapper(AArg^.VObject).AsInt = 1)));
        bByte := Byte(TFDValWrapper(AArg^.VObject).AsInt);
        FArgs.WriteBuffer(bByte, SizeOf(bByte));
      end;
    vtUnicodeString:
      begin
        iLen := Length(UnicodeString(AArg^.VUnicodeString)) * SizeOf(WideChar);
        FArgs.WriteBuffer(iLen, SizeOf(iLen));
        if iLen > 0 then
          FArgs.WriteBuffer(PWideChar(UnicodeString(AArg^.VUnicodeString))^, iLen);
      end;
    else
      // vtObject, vtClass, vtVariant, vtInterface
      ASSERT(FALSE);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteQueueItem.SetArgs(const AArgs: array of const);
var
  i, iLen: Integer;
begin
  iLen := High(AArgs);
  if iLen = -1 then
    Exit;
  FArgs.WriteBuffer(iLen, SizeOf(iLen));
  for i := 0 to iLen do
    SetArg(@AArgs[i]);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteQueueItem.SetArgs(const AArgs: Variant);
var
  i, iLen: Integer;
  V: Variant;
  rVD: TVarData;

  procedure SetVarRec(const AArgs: array of const);
  begin
    SetArg(@AArgs[0]);
  end;

  procedure SetCustom;
  begin
    SetVarRec(['CT: ' + String(V)])
  end;

  procedure SetArray;
  var
    i, iLen: Integer;
    s: String;
  begin
    s := '';
    iLen := VarArrayHighBound(V, 1);
    for i := 0 to iLen - 1 do begin
      s := s + String(V[i]);
      if i < iLen - 1 then
        s := s + ',';
    end;
    SetVarRec(['ARR: <' + s + '>']);
  end;

begin
  if VarIsNull(AArgs) or VarIsEmpty(AArgs) then
    Exit;
  iLen := VarArrayHighBound(AArgs, 1);
  FArgs.WriteBuffer(iLen, SizeOf(iLen));
  for i := 0 to iLen do begin
    V := AArgs[i];
    rVD := TVarData(V);
    case rVD.VType of
      varSmallInt: SetVarRec([rVD.VSmallInt]);
      varInteger:  SetVarRec([rVD.VInteger]);
      varSingle:   SetVarRec([rVD.VSingle]);
      varDouble:   SetVarRec([rVD.VDouble]);
      varCurrency: SetVarRec([rVD.VCurrency]);
      varDate:     SetVarRec([rVD.VDate]);
      varOleStr:   SetVarRec([rVD.VOleStr]);
      varBoolean:  SetVarRec([rVD.VBoolean]);
      varByte:     SetVarRec([rVD.VByte]);
      varShortInt: SetVarRec([rVD.VShortInt]);
      varWord:     SetVarRec([rVD.VWord]);
      varLongWord: SetVarRec([rVD.VLongWord]);
      varInt64:    SetVarRec([rVD.VInt64]);
      varString:   SetVarRec([String(rVD.VString)]);
      varUInt64:   SetVarRec([rVD.VUInt64]);
      varUString:  SetVarRec([UnicodeString(rVD.VUString)]);
      // special case - for NULL and Unassigned
      varEmpty:    SetVarRec([GEmptyObj]);
      varNull:     SetVarRec([GNullObj]);
    else
      if VarIsCustom(V) then
        SetCustom
      else
      if VarIsArray(V) then
        SetArray
      else
        // varAny, varByRef, varDispatch, varError, varUnknown, varVariant
        ASSERT(FALSE);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteQueueItem.GetArgs: Variant;
var
  i, iLen: Integer;
  iType: Byte;
  iInteger: Integer;
  lBoolean: Boolean;
  cChar: TFDAnsiChar;
  fExtended: Extended;
  sString: {$IFDEF NEXTGEN} String {$ELSE} AnsiString {$ENDIF};
  uiPtr: UInt64;
  cCurrency: Currency;
  wsString: UnicodeString;
  wcChar: WideChar;
  lliInt64: Int64;
  bByte: Byte;
begin
  if FArgs.Read(iLen, SizeOf(iLen)) = 0 then begin
    Result := Unassigned;
    Exit;
  end;
  Result := VarArrayCreate([0, iLen], varVariant);
  for i := 0 to iLen do begin
    FArgs.ReadBuffer(iType, SizeOf(iType));
    case iType of
      vtInteger:
        begin
          FArgs.ReadBuffer(iInteger, SizeOf(integer));
          Result[i] := iInteger;
        end;
      vtBoolean:
        begin
          FArgs.ReadBuffer(lBoolean, SizeOf(lBoolean));
          Result[i] := lBoolean;
        end;
      vtChar:
        begin
          FArgs.ReadBuffer(cChar, SizeOf(cChar));
          Result[i] := cChar;
        end;
      vtExtended:
        begin
          FArgs.ReadBuffer(fExtended, SizeOf(fExtended));
          Result[i] := fExtended;
        end;
      vtString, vtPChar, vtAnsiString:
        begin
          FArgs.ReadBuffer(iLen, SizeOf(iLen));
          if iLen > 0 then begin
            SetLength(sString, iLen);
            FArgs.ReadBuffer(sString[1], iLen);
          end
          else
            sString := '';
          Result[i] := sString;
        end;
      vtPointer:
        begin
          FArgs.ReadBuffer(uiPtr, SizeOf(uiPtr));
          Result[i] := NativeUInt(uiPtr);
        end;
      vtCurrency:
        begin
          FArgs.ReadBuffer(cCurrency, SizeOf(cCurrency));
          Result[i] := cCurrency;
        end;
      vtWideString, vtPWideChar, vtUnicodeString:
        begin
          FArgs.ReadBuffer(iLen, SizeOf(iLen));
          if iLen > 0 then begin
            SetLength(wsString, iLen div SizeOf(WideChar));
            FArgs.ReadBuffer(wsString[1], iLen);
          end
          else
            wsString := '';
          Result[i] := wsString;
        end;
      vtWideChar:
        begin
          FArgs.ReadBuffer(wcChar, SizeOf(wcChar));
          Result[i] := wcChar;
        end;
      vtInt64:
        begin
          FArgs.ReadBuffer(lliInt64, SizeOf(lliInt64));
          Result[i] := lliInt64;
        end;
      vtObject:
        begin
          // special case - for NULL and Unassigned
          FArgs.ReadBuffer(bByte, SizeOf(bByte));
          if bByte = 0 then
            Result[i] := Unassigned
          else if bByte = 1 then
            Result[i] := Null;
        end;
      else
        // vtObject, ctClass, vtVariant, vtInterface
        ASSERT(FALSE);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteQueue                                                            }
{-------------------------------------------------------------------------------}
constructor TFDMoniRemoteQueue.Create(AThread: TFDMoniRemoteQueueWorker);
begin
  inherited Create;
  FThread := AThread;
  FList := TFDObjList.Create;
  FQueueCriticalSection := TCriticalSection.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteQueue.Destroy;
begin
  FThread := nil;
  FDFreeAndNil(FList);
  FDFreeAndNil(FQueueCriticalSection);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteQueue.GetCount: Integer;
begin
  Result := FList.Count;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteQueue.GetNextEvent: TFDMoniRemoteQueueEventKind;
begin
  FQueueCriticalSection.Enter;
  try
    if FList.Count > 0 then
      Result := TFDMoniRemoteQueueItem(FList[0]).FEvent
    else
      Result := ptNone;
  finally
    FQueueCriticalSection.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteQueue.GetItem: TFDMoniRemoteQueueItem;
begin
  FQueueCriticalSection.Enter;
  try
    if FList.Count > 0 then begin
      Result := TFDMoniRemoteQueueItem(FList[0]);
      FList.Delete(0);
    end
    else
      Result := nil;
  finally
    FQueueCriticalSection.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteQueue.PostItem(AItem: TFDMoniRemoteQueueItem);
var
  i: Integer;
  lSignal: Boolean;
begin
  i := 10;
  while (i > 0) and (FList.Count > 100) do begin
    Dec(i);
    Sleep(1);
  end;
  FQueueCriticalSection.Enter;
  try
    if FList.Count > 1000 then
      FList.Clear;
    lSignal := (FList.Count = 0);
    FList.Add(AItem);
  finally
    FQueueCriticalSection.Leave;
  end;
  if lSignal then
    FThread.Signal;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteQueue.Clear;
var
  i: Integer;
begin
  FQueueCriticalSection.Enter;
  try
    for i := 0 to FList.Count - 1 do
      FDFree(TFDMoniRemoteQueueItem(FList[i]));
    FList.Clear;
  finally
    FQueueCriticalSection.Leave;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteQueueWorker                                                      }
{-------------------------------------------------------------------------------}
constructor TFDMoniRemoteQueueWorker.Create;
begin
  inherited Create(True);
  FItemAvailableEvent := TEvent.Create(nil, False, False, '');
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteQueueWorker.Destroy;
begin
  AbortProcessing;
  FDFreeAndNil(FItemAvailableEvent);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteQueueWorker.Execute;
begin
  while not Terminated do begin
    if FItemAvailableEvent.WaitFor(INFINITE) = wrSignaled then
      while not Terminated and (GetQueue <> nil) and (GetQueue.Count > 0) do
        DoAction
    else
      Terminate;
  end;
  Sleep(10);
end;

{-------------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure TFDMoniRemoteQueueWorker.AbortProcessing;
begin
  if Suspended then
    Resume;
  if not Terminated then begin
    Terminate;
    Signal;
    WaitFor;
  end;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteQueueWorker.Signal;
begin
  FItemAvailableEvent.SetEvent;
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteStream                                                           }
{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteBytes(const ABuff; ALen: Integer);
begin
  FBuffer.WriteBuffer(ABuff, ALen);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteValueHeader(const AParamName: String;
  AType: TFDAnsiChar);
{$IFDEF FireDAC_DEBUG}
var
  iLen: Integer;
  sb: TFDByteString;
{$ENDIF}
begin
{$IFDEF FireDAC_DEBUG}
  WriteBytes(AType, SizeOf(AType));
  sb := FEncoder.Encode(AParamName);
  iLen := FEncoder.EncodedLength(sb);
  WriteBytes(iLen, SizeOf(iLen));
  if iLen > 0 then
    WriteBytes(PByte(sb)^, iLen);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.ReadBytes(var ABuff; ALen: Integer);
begin
  FBuffer.ReadBuffer(ABuff, ALen);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.ReadValueHeader(const AParamName: String; AType: TFDAnsiChar);
{$IFDEF FireDAC_DEBUG}
var
  ch: TFDAnsiChar;
  iLen: Integer;
  sPName: TFDByteString;
  s: String;
{$ENDIF}
begin
{$IFDEF FireDAC_DEBUG}
  ReadBytes(ch, SizeOf(ch));
  if ch <> AType then
    raise EFDMoniException.Create(S_FD_MonEncounterType);
  ReadBytes(iLen, SizeOf(iLen));
  if iLen > 0 then begin
    SetLength(sPName, iLen);
    ReadBytes(PByte(sPName)^, iLen);
    s := FEncoder.Decode(sPName);
    if CompareText(AParamName, s) <> 0 then
      raise EFDMoniException.Create(S_FD_MonEncounterParamName);
  end;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.ReceiveBuffer;
var
  iSize: Integer;
begin
  if FConnection.ReceiveBuf(iSize, SizeOf(iSize)) <> SizeOf(iSize) then
    raise EFDMoniException.Create(S_FD_MonEncounterEOF);
  FBuffer.Size := iSize;
  if FConnection.ReceiveBuf(FBuffer.Memory^, iSize) <> iSize then
    raise EFDMoniException.Create(S_FD_MonEncounterEOF);
  FBuffer.Position := 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.SendBuffer;
var
  iSize: Integer;
begin
  iSize := FBuffer.Size;
  FConnection.SendBuf(iSize, SizeOf(iSize));
  FConnection.SendBuf(FBuffer.Memory^, iSize);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.Open(AConnection: TCustomWinSocket;
  AMode: TFDMoniRemoteStreamOpenMode);
begin
  FEncoder := TFDEncoder.Create(nil);
  FBuffer := TMemoryStream.Create;
  FConnection := AConnection;
  FBlockLevel := 0;
  FMode := AMode;
  if FMode = omRead then
    try
      ReceiveBuffer;
    except
      Close;
      raise;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.Close;
begin
  try
    if FMode = omWrite then
      SendBuffer;
  finally
    FDFreeAndNil(FBuffer);
    FDFreeAndNil(FEncoder);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteStream.IsOpen: Boolean;
begin
  Result := FBuffer <> nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteBeginBlock(AID: TFDMoniRemoteStreamBlockID);
begin
  WriteBytes(C_FD_Mon_BeginBlockDelim, SizeOf(TFDAnsiChar));
  WriteBytes(AID, SizeOf(AID));
  Inc(FBlockLevel);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteEndBlock;
begin
  WriteBytes(C_FD_Mon_EndBlockDelim, SizeOf(TFDAnsiChar));
  Dec(FBlockLevel);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteString(const AParamName: String; const AValue: String);
var
  iLen: Integer;
  sb: TFDByteString;
begin
  WriteValueHeader(AParamName, C_FD_Mon_StringHeader);
  iLen := Length(AValue);
  WriteBytes(iLen, SizeOf(iLen));
  if iLen > 0 then begin
    sb := FEncoder.Encode(AValue);
    WriteBytes(PByte(sb)^, iLen);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteBlob(const AParamName: String; AValue: TMemoryStream);
var
  iLen: Integer;
begin
  WriteValueHeader(AParamName, C_FD_Mon_BlobHeader);
  iLen := AValue.Size;
  WriteBytes(iLen, SizeOf(iLen));
  if iLen > 0 then
    WriteBytes(PByte(AValue.Memory)^, iLen);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteBoolean(const AParamName: String; AValue: Boolean);
var
  b: Byte;
begin
  b := Byte(AValue);
  WriteValueHeader(AParamName, C_FD_Mon_BooleanHeader);
  WriteBytes(b, SizeOf(b));
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteInteger(const AParamName: String; AValue: Integer);
begin
  WriteValueHeader(AParamName, C_FD_Mon_IntegerHeader);
  WriteBytes(AValue, SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteLongWord(const AParamName: String; AValue: LongWord);
begin
  WriteInteger(AParamName, Integer(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteFloat(const AParamName: String; AValue: Double);
begin
  WriteValueHeader(AParamName, C_FD_Mon_FloatHeader);
  WriteBytes(AValue, SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.WriteDate(const AParamName: String; AValue: TDateTime);
begin
  WriteValueHeader(AParamName, C_FD_Mon_DateHeader);
  WriteBytes(AValue, SizeOf(AValue));
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.ReadBeginBlock(AID: TFDMoniRemoteStreamBlockID);
var
  iID: TFDMoniRemoteStreamBlockID;
  c: TFDAnsiChar;
begin
  ReadBytes(c, SizeOf(TFDAnsiChar));
  if c <> C_FD_Mon_BeginBlockDelim then
    raise EFDMoniException.Create(S_FD_MonEncounterBlock);
  ReadBytes(iID, SizeOf(iID));
  if AID <> iID then
    raise EFDMoniException.Create(S_FD_MonEncounterBlock);
  Inc(FBlockLevel);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.ReadEndBlock;
var
  c: TFDAnsiChar;
begin
  while not IsEndBlock do
    FBuffer.Position := FBuffer.Position + 1;
  ReadBytes(c, SizeOf(TFDAnsiChar));
  Dec(FBlockLevel);
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteStream.IsEndBlock: Boolean;
var
  iPos: Integer;
  c: TFDAnsiChar;
begin
  iPos := FBuffer.Position;
  try
    ReadBytes(c, SizeOf(TFDAnsiChar));
    Result := c = C_FD_Mon_EndBlockDelim;
  finally
    FBuffer.Position := iPos;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteStream.ReadString(const AParamName: String): String;
var
  iLen: Integer;
  sb: TFDByteString;
begin
  ReadValueHeader(AParamName, C_FD_Mon_StringHeader);
  ReadBytes(iLen, SizeOf(iLen));
  if iLen > 0 then begin
    SetLength(sb, iLen);
    ReadBytes(PByte(sb)^, iLen);
    Result := FEncoder.Decode(sb);
  end
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteStream.ReadBlob(const AParamName: String; AValue: TMemoryStream);
var
  iLen: Integer;
begin
  ReadValueHeader(AParamName, C_FD_Mon_BlobHeader);
  ReadBytes(iLen, SizeOf(iLen));
  AValue.Size := iLen;
  if iLen > 0 then
    ReadBytes(PByte(AValue.Memory)^, iLen);
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteStream.ReadBoolean(const AParamName: String): Boolean;
var
  b: Byte;
begin
  ReadValueHeader(AParamName, C_FD_Mon_BooleanHeader);
  ReadBytes(b, SizeOf(b));
  Result := Boolean(b);
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteStream.ReadInteger(const AParamName: String): Integer;
begin
  ReadValueHeader(AParamName, C_FD_Mon_IntegerHeader);
  ReadBytes(Result, SizeOf(Result));
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteStream.ReadLongWord(const AParamName: String): LongWord;
begin
  Result := LongWord(ReadInteger(AParamName));
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteStream.ReadFloat(const AParamName: String): Double;
begin
  ReadValueHeader(AParamName, C_FD_Mon_FloatHeader);
  ReadBytes(Result, SizeOf(Result));
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteStream.ReadDate(const AParamName: String): TDateTime;
begin
  ReadValueHeader(AParamName, C_FD_Mon_DateHeader);
  ReadBytes(Result, SizeOf(Result));
end;

{-------------------------------------------------------------------------------}
{ TFDMoniRemoteAdapterList                                                      }
{-------------------------------------------------------------------------------}
constructor TFDMoniRemoteAdapterList.Create;
begin
  inherited Create;
  FList := TFDStringList.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniRemoteAdapterList.Destroy;
begin
  Clear;
  FDFreeAndNil(FList);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteAdapterList.Clear;
begin
  FList.Clear;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteAdapterList.GetCount: Integer;
begin
  Result := FList.Count;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteAdapterList.GetPath(AIndex: Integer): string;
begin
  Result := FList[AIndex];
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteAdapterList.GetHandle(AIndex: Integer): LongWord;
begin
  Result := FList.Ints[AIndex];
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteAdapterList.IndexOf(AHandle: LongWord): Integer;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if FList.Ints[i] = AHandle then begin
      Result := i;
      Exit;
    end;
  Result := -1;
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteAdapterList.FindByHandle(AHandle: LongWord): string;
var
  i: Integer;
begin
  i := IndexOf(AHandle);
  if i <> -1 then
    Result := FList[i]
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
function TFDMoniRemoteAdapterList.FindByPath(const APath: string): LongWord;
var
  i: Integer;
begin
  if FList.Find(APath, i) then
    Result := FList.Ints[i]
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteAdapterList.AddAdapter(const APath: string; AHandle: LongWord);
begin
  FList.AddInt(APath, AHandle);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniRemoteAdapterList.RemoveAdapter(AHandle: LongWord);
var
  i: Integer;
begin
  i := IndexOf(AHandle);
  if i <> -1 then
    FList.Delete(i);
end;

{-------------------------------------------------------------------------------}
initialization
  GEmptyObj := TFDValWrapper.Create(0);
  GNullObj := TFDValWrapper.Create(1);

finalization
  FDFreeAndNil(GEmptyObj);
  FDFreeAndNil(GNullObj);

end.
