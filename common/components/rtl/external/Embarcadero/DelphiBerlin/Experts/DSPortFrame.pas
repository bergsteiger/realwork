{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSPortFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IPPeerAPI;

type
  TDSPortFram = class(TFrame)
    LabelPort: TLabel;
    EditPort: TEdit;
    ButtonTest: TButton;
    ButtonNextAvailable: TButton;
    procedure ButtonTestClick(Sender: TObject);
    procedure ButtonNextAvailableClick(Sender: TObject);
  private
    function GetPort: Integer;
    procedure SetPort(const Value: Integer);
    procedure OnExecute(AContext: IIPContext);
    { Private declarations }
  public
    { Public declarations }
    property Port: Integer read GetPort write SetPort;
  end;

implementation

{$R *.dfm}

uses DSServerDsnResStrs, System.UITypes;

procedure TDSPortFram.ButtonNextAvailableClick(Sender: TObject);
var
  LPort: Integer;
  LTestServer: IIPTestServer;
begin
  LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
  LPort := LTestServer.GetOpenPort;
  Port := LPort;
end;

procedure TDSPortFram.ButtonTestClick(Sender: TObject);
var
  LTestServer: IIPTestServer;
begin
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(Port, OnExecute);
    MessageDlg(rsTestPortOK, mtInformation, [mbOK], 0);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TDSPortFram.OnExecute(AContext: IIPContext);
begin
//
end;

function TDSPortFram.GetPort: Integer;
begin
  Result := StrToInt(EditPort.Text);
end;

procedure TDSPortFram.SetPort(const Value: Integer);
begin
  EditPort.Text := IntToStr(Value);
end;

end.
