{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSPortsWizardPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, WizardAPI, StdCtrls, DSPortFrame, Generics.Collections, AppEvnts,
  ExpertsUIWizard;

type
  TDSAvailablePort = (portNone, portHTTP, portHTTPS, portTCPIP);
  TDSAvailablePorts = set of TDSAvailablePort;

  TDSPortDescription = record
    Port: TDSAvailablePort;
    PortLabel: string;
    DefaultValue: Integer;
  end;

  TDSPortDescriptions = array of TDSPortDescription;

  TDSPortsWizardFrame = class(TFrame, IExpertsWizardPageFrame)
    ApplicationEvents1: TApplicationEvents;
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
  private
    FFocusedPort: TDSAvailablePort;
    FPortFrames: TDictionary<TDSAvailablePort, TDSPortFram>;
    FPortDescriptionsDictionary: TDictionary<TDSAvailablePort, TDSPortDescription>;
    FOnFocusedPortChange: TNotifyEvent;
    FLeftMargin: Integer;
    FPage: TCustomExpertsFrameWizardPage;
    function GetPort(I: TDSAvailablePort): Integer;
    procedure SetPortDescriptions(const Value: TDSPortDescriptions);
    procedure ShowPortPages;
    procedure SetPort(I: TDSAvailablePort; const Value: Integer);
    procedure SetFocusedPort(const Value: TDSAvailablePort);
    procedure SetLeftMargin(const Value: Integer);
  protected
    { IExpertsWizardPageFrame }
    function ExpertsFrameValidatePage(ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
    procedure ExpertsFrameUpdateInfo(ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
    procedure ExpertsFrameCreated(APage: TCustomExpertsFrameWizardPage);
    procedure ExpertsFrameEnterPage(APage: TCustomExpertsFrameWizardPage);
    function GetWizardInfo: string;
    function ValidateFields: Boolean;
    property LeftMargin: Integer read FLeftMargin write SetLeftMargin;
  public
    { Public declarations }
//    class function CreateFrame(AOwner: TComponent): TDSPortsWizardFrame; static;
    property PortDescriptions: TDSPortDescriptions write SetPortDescriptions;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Ports[I: TDSAvailablePort]: Integer read GetPort write SetPort;
    property FocusedPort: TDSAvailablePort read FFocusedPort write SetFocusedPort;
    property OnFocusedPortChange: TNotifyEvent read FOnFocusedPortChange write FOnFocusedPortChange;
  end;

  IDSPortsWizardPage = interface(IWizardPage)
  ['{2149E34E-3931-4EBF-9A09-B7E7D59D0E96}']
    function GetFrame: TDSPortsWizardFrame;
    procedure SetPortDescriptions(const Value: TDSPortDescriptions);
    property Frame: TDSPortsWizardFrame read GetFrame;
    property PortDescriptions: TDSPortDescriptions write SetPortDescriptions;

  end;


//const
//  sDSPortsWizardPage = 'DSPortsWizardPage';
//  sDSWebServerPortPage = 'WebServerPortPage';

implementation

{$R *.dfm}

uses StrUtils, DSCommonDsnResStrs, DsServerDsnResStrs, System.UITypes;

{ TDSPortsWizardFrame }

procedure TDSPortsWizardFrame.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
var
  LFrame: TPair<TDSAvailablePort, TDSPortFram>;
begin
  if not Self.Visible then
    Exit;
  for LFrame in FPortFrames do
    if LFrame.Value.EditPort.Focused or LFrame.Value.ButtonTest.Focused
      or LFrame.Value.ButtonNextAvailable.Focused then
    begin
      FocusedPort := LFrame.Key;
      Exit;
    end;
  FocusedPort := portNone;
end;

function TDSPortsWizardFrame.ValidateFields: Boolean;
var
  LFrame: TPair<TDSAvailablePort, TDSPortFram>;
begin
  for LFrame in FPortFrames do
    try
      StrToInt(LFrame.Value.EditPort.Text);
    except
      LFrame.Value.EditPort.SetFocus;
      MessageDlg(Format(sInvalidInt, [sPort]), mtError, [mbOk], 0);
      Exit(False);
    end;
  Result := True;
end;

constructor TDSPortsWizardFrame.Create(AOwner: TComponent);
begin
  inherited;
  FPortDescriptionsDictionary := TDictionary<TDSAvailablePort, TDSPortDescription>.Create;
  FPortFrames := TDictionary<TDSAvailablePort, TDSPortFram>.Create;
end;

destructor TDSPortsWizardFrame.Destroy;
begin
  FPortFrames.Free;
  FPortDescriptionsDictionary.Free;
  inherited;
end;

procedure TDSPortsWizardFrame.ExpertsFrameCreated(
  APage: TCustomExpertsFrameWizardPage);
begin
  LeftMargin := ExpertsUIWizard.cExpertsLeftMargin;
  FPage := APage;
  FPage.Description := sPortsPageDescription;
  FPage.Title := sPortsPageTitle;
  FPage.UpdateInfo;
end;

procedure TDSPortsWizardFrame.ExpertsFrameEnterPage(
  APage: TCustomExpertsFrameWizardPage);
begin
 // APage.UpdateInfo;
end;

procedure TDSPortsWizardFrame.ExpertsFrameUpdateInfo(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
begin
  AHandled := True;
  ASender.WizardInfo := GetWizardInfo;
end;

function TDSPortsWizardFrame.ExpertsFrameValidatePage(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
begin
  AHandled := True;
  Result := ValidateFields;
end;

function TDSPortsWizardFrame.GetPort(I: TDSAvailablePort): Integer;
var
  LFrame: TDSPortFram;
begin
  Result := 0;
  if FPortFrames.TryGetValue(I, LFrame) then
    Result := LFrame.Port;
end;

function TDSPortsWizardFrame.GetWizardInfo: string;
begin
  case FocusedPort of
    portNone: Result := sPortsPageInfo;
    portHTTP: Result := sHTTPPortInfo;
    portHTTPS: Result := sHTTPSPortInfo;
    portTCPIP: Result := sTCPIPPortInfo;
  else
    Result := sPortsPageInfo;
  end;
end;

procedure TDSPortsWizardFrame.ShowPortPages;
var
  LTop: Integer;
  LTabOrder: TTabOrder;

  procedure AddFrame(APort: TDSPortDescription);
  var
    LFrame: TDSPortFram;
  begin
    if not FPortFrames.TryGetValue(APort.Port, LFrame) then
    begin
      LFrame := TDSPortFram.Create(Self);
      LFrame.Name := LFrame.Name + IntToStr(Integer(APort.Port));
      FPortFrames.Add(APort.Port, LFrame);
      LFrame.Parent := Self;
      LFrame.LabelPort.Caption := APort.PortLabel;
      LFrame.Port := APort.DefaultValue;
    end;
    LFrame.Left := FLeftMargin;
    LFrame.Top := LTop;
    LFrame.TabOrder := LTabOrder;
    LTabOrder := LTabOrder + 1;
    LTop := LTop + LFrame.Height;
  end;

  procedure RemoveFrame(APort: TDSAvailablePort);
  var
    LFrame: TDSPortFram;
  begin
    if FPortFrames.TryGetValue(APort, LFrame) then
    begin
      LFrame.Free;
      FPortFrames.Remove(APort);
    end;
  end;

  procedure AddOrRemove(APort: TDSAvailablePort);
  begin
    if FPortDescriptionsDictionary.ContainsKey(APort) then
      AddFrame(FPortDescriptionsDictionary[APort])
    else
      RemoveFrame(APort);
  end;
begin
  LTop := 0;
  LTabOrder := 1;
  AddOrRemove(portTCPIP);
  AddOrRemove(portHTTP);
  AddOrRemove(portHTTPS);
end;

procedure TDSPortsWizardFrame.SetPortDescriptions(const Value: TDSPortDescriptions);
var
  LPortDescription: TDSPortDescription;
begin
  FPortDescriptionsDictionary.Clear;
  for LPortDescription in Value do
    FPortDescriptionsDictionary.Add(LPortDescription.Port, LPortDescription);
  ShowPortPages;
end;

procedure TDSPortsWizardFrame.SetFocusedPort(const Value: TDSAvailablePort);
begin
  if FFocusedPort <> Value then
  begin
    FFocusedPort := Value;
    if Assigned(OnFocusedPortChange) then
      OnFocusedPortChange(Self);
    if FPage <> nil then
      FPage.UpdateInfo;
  end;
end;

procedure TDSPortsWizardFrame.SetLeftMargin(const Value: Integer);
var
  LFrame: TFrame;
begin
  FLeftMargin := Value;
  for LFrame in FPortFrames.Values do
    LFrame.Left := FLeftMargin;
end;

procedure TDSPortsWizardFrame.SetPort(I: TDSAvailablePort;
  const Value: Integer);
begin
  FPortFrames[I].Port := Value;
end;

end.

