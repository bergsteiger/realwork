{*********************************************************}
{*                  STNETMSG.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}
{$H+} {Huge strings}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{$IFNDEF VERSION2}
  !! Error: This unit cannot be compiled with Delphi 1 or CBuilder 1
{$ENDIF}

unit StNetMsg;

interface

uses
  Windows, Classes, StBase;

type
  TStNetMessage = class(TStComponent)
   private   { Private Methods/Properties   }
    FAliasNames    : TStringList;
    FMsgFrom       : string;
    FMsgText       : string;
    FMsgTo         : string;
    FServerName    : string;
    FOnMessageSent : TNotifyEvent;
   protected { Protected Methods/Properties }
    function GetServer: string;
    procedure SetServer(Value: string);

   public    { Public Methods/Properties    }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure AddAlias(AName: string);
    function AliasNames: TStringList;
    procedure RemoveAlias(AName: string);
    procedure Send;
   published { Published Methods/Properties }
    property MsgFrom: string
      read FMsgFrom  write FMsgFrom;
    property MsgText: string
      read FMsgText  write FMsgText;
    property MsgTo  : string
      read FMsgTo    write FMsgTo;
    property Server : string
      read GetServer write SetServer;
    property OnMessageSent: TNotifyEvent
      read FOnMessageSent write FOnMessageSent;
  end;

implementation

uses SysUtils, StStrS, StNetApi, Dialogs
{$IFDEF TRIALRUN}
  , Registry,
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
{$ELSE}
  ;
{$ENDIF}

constructor TStNetMessage.Create(AOwner: TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);
  FAliasNames := TStringList.Create;
end;

destructor TStNetMessage.Destroy;
begin
  FAliasNames.Free;

  inherited Destroy;
end;

procedure TStNetMessage.AddAlias(AName: string);
var
  ErrorD : DWord;
begin
  ErrorD := StNetMessageNameAdd(FServerName, AName);
  if ErrorD <> NERR_SUCCESS then
    RaiseStWin32Error(EStNetException, ErrorD);
end;

function TStNetMessage.AliasNames: TStringList;
var
  ErrorD : DWord;
  Buffer : Pointer;
  TotalEntries : DWord;
  EntriesRead : DWord;
  I : Integer;
begin
  ErrorD := StNetMessageNameEnum(FServerName, 0, Buffer, DWord(-1),
                                 EntriesRead, TotalEntries, nil);
  if ErrorD = NERR_SUCCESS then begin
    FAliasNames.Clear;
    for I := 0 to EntriesRead-1 do begin
      FAliasNames.Add(TMsgInfo0Array(Buffer^)[I].msgi0_name);
    end;
    StNetApiBufferFree(Buffer);
  end else begin
    RaiseStWin32Error(EStNetException, ErrorD);
  end;
  Result := FAliasNames;
end;

procedure TStNetMessage.RemoveAlias(AName: string);
var
  ErrorD : DWord;
begin
  ErrorD := StNetMessageNameDel(FServerName, AName);
  if ErrorD <> NERR_SUCCESS then
    RaiseStWin32Error(EStNetException, ErrorD);
end;

procedure TStNetMessage.Send;
var
  ErrorD : DWord;
  Buffer : TLMWideChar;
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  Buffer.Value := nil;
  try
    CvtToWideChar(FMsgText, Buffer);

    ErrorD := StNetMessageBufferSend(FServerName, FMsgTo, FMsgFrom,
                                     Buffer.Value, Buffer.Length);
    if ErrorD <> NERR_SUCCESS then
      RaiseStWin32Error(EStNetException, ErrorD)
    else
      if Assigned(FOnMessageSent) then FOnMessageSent(Self);
  finally
    FreeMem(Buffer.Value, Buffer.Length);
  end;
end;

function TStNetMessage.GetServer: string;
begin
  { don't return any UNC notation }
  Result := FilterS(FServerName, '\');
end;

procedure TStNetMessage.SetServer(Value: string);
begin
  { get rid of any UNC notation or trailing marks }
  Value := FilterS(Value, '\');

  { do we have a valid server name? }
  if (Length(Value) > 0) then

    if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 5) then
      FServerName := Value
    else
      FServerName := '\\' + Value
  else
    FServerName := Value;
end;


end.
