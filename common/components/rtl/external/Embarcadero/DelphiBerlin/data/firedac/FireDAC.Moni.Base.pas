{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC Moni base classes               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Moni.Base;

interface

{$IFDEF FireDAC_MONITOR}
uses
  System.Classes, 
  FireDAC.Stan.Intf, FireDAC.Stan.Factory;

type
  TFDMoniClientBase = class;
  TFDMoniClientLinkBase = class;

  TFDMoniClientBase = class(TFDObject, IFDMoniClient)
  private
    FName: TComponentName;
    FFailure: Boolean;
    FTracing: Boolean;
    FEventKinds: TFDMoniEventKinds;
    FOutputHandler: IFDMoniClientOutputHandler;
  protected
    // IFDMoniClient
    function GetTracing: Boolean;
    procedure SetTracing(const AValue: Boolean);
    function GetName: TComponentName;
    procedure SetName(const AValue: TComponentName);
    function GetEventKinds: TFDMoniEventKinds;
    procedure SetEventKinds(const AValue: TFDMoniEventKinds);
    function GetOutputHandler: IFDMoniClientOutputHandler;
    procedure SetOutputHandler(const AValue: IFDMoniClientOutputHandler);
    procedure ResetFailure;
    procedure Notify(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      ASender: TObject; const AMsg: String; const AArgs: array of const); virtual;
    function RegisterAdapter(const AAdapter: IFDMoniAdapter): LongWord; virtual;
    procedure UnregisterAdapter(const AAdapter: IFDMoniAdapter); virtual;
    procedure AdapterChanged(const AAdapter: IFDMoniAdapter); virtual;
    // other
    function DoTracingChanged: Boolean; virtual;
    function OperationAllowed: Boolean; virtual;
    procedure GetObjectNames(ASender: TObject; out AClassName, AName: String);
    // TFDObject
    procedure Finalize; override;
  public
    procedure Initialize; override;
  end;

  TFDMoniOutputEvent = procedure (ASender: TFDMoniClientLinkBase;
    const AClassName, AObjName, AMessage: String) of object;
  TFDMoniClientLinkBase = class(TComponent, IFDMoniClientOutputHandler)
  private
    FClient: IFDMoniClient;
    FOnOutput: TFDMoniOutputEvent;
    FDesignTracing: Boolean;
    function GetEventKinds: TFDMoniEventKinds;
    procedure SetEventKinds(const AValue: TFDMoniEventKinds);
    function GetTracing: Boolean;
    procedure SetTracing(const AValue: Boolean);
    procedure SetOnOutput(const AValue: TFDMoniOutputEvent);
  protected
    // IFDMoniClientOutputHandler
    procedure HandleOutput(const AClassName, AObjName, AMessage: String); virtual;
    // other
    function GetMoniClient: IFDMoniClient; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notify(AKind: TFDMoniEventKind; AStep: TFDMoniEventStep;
      ASender: TObject; const AMsg: String; const AArgs: array of const); virtual;
    property MoniClient: IFDMoniClient read FClient;
    property Tracing: Boolean read GetTracing write SetTracing default False;
  published
    property EventKinds: TFDMoniEventKinds read GetEventKinds write SetEventKinds
      default [ekLiveCycle .. ekComponent];
    property OnOutput: TFDMoniOutputEvent read FOnOutput write SetOnOutput;
  end;
{$ENDIF}

implementation

{$IFDEF FireDAC_MONITOR}
uses
  System.SysUtils,
  FireDAC.Stan.Consts, FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
{ TFDMoniClientBase                                                             }
{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.Initialize;
begin
  inherited Initialize;
  FEventKinds := [ekLiveCycle .. ekComponent];
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientBase.GetName: TComponentName;
begin
  Result := FName;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.SetName(const AValue: TComponentName);
begin
  FName := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientBase.GetEventKinds: TFDMoniEventKinds;
begin
  Result := FEventKinds;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.SetEventKinds(const AValue: TFDMoniEventKinds);
begin
  FEventKinds := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientBase.GetOutputHandler: IFDMoniClientOutputHandler;
begin
  Result := FOutputHandler;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.SetOutputHandler(const AValue: IFDMoniClientOutputHandler);
begin
  FOutputHandler := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientBase.GetTracing: Boolean;
begin
  Result := FTracing;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.SetTracing(const AValue: Boolean);
begin
  if (FTracing <> AValue) and not FFailure and OperationAllowed then begin
    FTracing := AValue;
    try
      if not DoTracingChanged then
        if AValue then begin
          FTracing := False;
          FFailure := True;
        end;
    except
      SetTracing(False);
      FFailure := True;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.ResetFailure;
begin
  FFailure := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.Notify(AKind: TFDMoniEventKind;
  AStep: TFDMoniEventStep; ASender: TObject; const AMsg: String;
  const AArgs: array of const);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientBase.RegisterAdapter(const AAdapter: IFDMoniAdapter): LongWord;
begin
  // nothing
  Result := 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.UnregisterAdapter(const AAdapter: IFDMoniAdapter);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.AdapterChanged(const AAdapter: IFDMoniAdapter);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientBase.OperationAllowed: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientBase.DoTracingChanged: Boolean;
begin
  // nothing
  Result := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientBase.Finalize;
begin
  SetTracing(False);
end;

{-------------------------------------------------------------------------------}
type
  __TInterfacedObject = class(TInterfacedObject)
  end;

procedure TFDMoniClientBase.GetObjectNames(ASender: TObject; out AClassName, AName: String);
var
  iRefCount: Integer;
  oObjIntf: IFDStanObject;
begin
  AName := '';
  if ASender <> nil then begin
    AClassName := ASender.ClassName;
    if (ASender <> nil) and (ASender is TInterfacedObject) then begin
      iRefCount := __TInterfacedObject(ASender).FRefCount;
      __TInterfacedObject(ASender).FRefCount := 2;
      try
        if Supports(ASender, IFDStanObject, oObjIntf) then begin
          AName := oObjIntf.GetName;
          oObjIntf := nil;
        end;
      finally
        __TInterfacedObject(ASender).FRefCount := iRefCount;
      end;
    end;
    if AName = '' then begin
      if ASender is TComponent then
        AName := TComponent(ASender).Name;
      if AName = '' then
        AName := '$' + IntToHex(Integer(ASender), 8);
    end;
  end
  else
    AClassName := '<nil>';
end;

{-------------------------------------------------------------------------------}
{ TFDMoniClientLinkBase                                                         }
{-------------------------------------------------------------------------------}
constructor TFDMoniClientLinkBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FClient := GetMoniClient;
end;

{-------------------------------------------------------------------------------}
destructor TFDMoniClientLinkBase.Destroy;
begin
  SetOnOutput(nil);
  FClient.Tracing := False;
  FClient := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientLinkBase.GetEventKinds: TFDMoniEventKinds;
begin
  Result := MoniClient.EventKinds;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientLinkBase.SetEventKinds(const AValue: TFDMoniEventKinds);
begin
  MoniClient.EventKinds := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDMoniClientLinkBase.GetTracing: Boolean;
begin
  if csDesigning in ComponentState then
    Result := FDesignTracing
  else
    Result := MoniClient.Tracing;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientLinkBase.SetTracing(const AValue: Boolean);
begin
  if csDesigning in ComponentState then
    FDesignTracing := AValue
  else
    MoniClient.Tracing := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientLinkBase.SetOnOutput(const AValue: TFDMoniOutputEvent);
begin
  if Assigned(AValue) then
    MoniClient.OutputHandler := Self as IFDMoniClientOutputHandler
  else
    MoniClient.OutputHandler := nil;
  FOnOutput := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientLinkBase.HandleOutput(
  const AClassName, AObjName, AMessage: String);
begin
  if Assigned(FOnOutput) and not (csDestroying in ComponentState) then
    FOnOutput(Self, AClassName, AObjName, AMessage);
end;

{-------------------------------------------------------------------------------}
procedure TFDMoniClientLinkBase.Notify(AKind: TFDMoniEventKind;
  AStep: TFDMoniEventStep; ASender: TObject; const AMsg: String;
  const AArgs: array of const);
begin
  MoniClient.Notify(AKind, AStep, ASender, AMsg, AArgs);
end;
{$ENDIF}

end.
