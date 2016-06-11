{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{               FireDAC VCL About dialog                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.About;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
    Vcl.StdCtrls, Vcl.ExtCtrls;

type
  { ------------------------------------------------------------------------- }
  { TfrmFDGUIxFormsAbout                                                      }
  { ------------------------------------------------------------------------- }
  TfrmFDGUIxFormsAbout = class(TForm)
    lblVersion: TLabel;
    lblCopyright: TLabel;
    lblInternetLink: TLabel;
    Image1: TImage;
    procedure lblInternetLinkClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    procedure Setup(AModHInst: THandle; const ACaption: String);
    class procedure Execute(AModHInst: THandle = 0; const ACaption: String = '');
  end;

var
  frmFDGUIxFormsAbout: TfrmFDGUIxFormsAbout;

implementation

uses
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.ResStrs;

{$R *.dfm}

{ ------------------------------------------------------------------------- }
{ TfrmFDGUIxFormsAbout                                                      }
{ ------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsAbout.Setup(AModHInst: THandle; const ACaption: String);
var
{$IFDEF MSWINDOWS}
  sMod, sVersion,
{$ENDIF}
  sProduct, sVersionName, sCopyright, sInfo: String;
begin
{$IFDEF MSWINDOWS}
  if AModHInst = 0 then
    AModHInst := HInstance;
  sMod := GetModuleName(AModHInst);
  FDGetVersionInfo(sMod, sProduct, sVersion, sVersionName, sCopyright, sInfo);
{$ENDIF}
{$IFDEF POSIX}
  sProduct := '';
{$ENDIF}
  if sProduct = '' then begin
    sProduct := C_FD_Product + ' ' + ExtractFileName(ParamStr(0));
    sVersionName := C_FD_Version;
    sCopyright := C_FD_Copyright;
    sInfo := S_FD_Prod_Link;
  end;
  if ACaption = '' then
    Caption := Format(S_FD_ProductAbout, [sProduct])
  else
    Caption := ACaption;
  lblVersion.Caption := sVersionName;
  lblCopyright.Caption := sCopyright;
  lblInternetLink.Caption := sInfo;
end;

{ ------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsAbout.Image1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

{ ------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

{ ------------------------------------------------------------------------- }
procedure TfrmFDGUIxFormsAbout.lblInternetLinkClick(Sender: TObject);
begin
  if TLabel(Sender).Caption <> '' then
    FDShell(TLabel(Sender).Caption, S_FD_LComp_Design);
end;

{ ------------------------------------------------------------------------- }
class procedure TfrmFDGUIxFormsAbout.Execute(AModHInst: THandle = 0;
  const ACaption: String = '');
var
  oFrm: TfrmFDGUIxFormsAbout;
begin
  oFrm := TfrmFDGUIxFormsAbout.Create(nil);
  oFrm.Position := poMainFormCenter;
  oFrm.Setup(AModHInst, ACaption);
  try
    oFrm.ShowModal;
  finally
    FDFree(oFrm);
  end;
end;

end.
