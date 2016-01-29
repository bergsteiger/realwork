{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit AboUnit;
{$I dc.inc}
interface

uses
  dcsystem,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,dcGen,dcconsts,dcdreamlib, dccommon;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    VersionLabel: TLabel;
    CopyrightLabel: TLabel;
    URLLabel: TLabel;
    Image1: TImage;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Image1Click(Sender: TObject);
    procedure URLLabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

procedure ShowAboutForm;
procedure ShowSplashScreen;
procedure HideSplashScreen;

implementation
{$I dc.inc}
{$R *.DFM}

{------------------------------------------------------------------}

procedure ShowSplashScreen;
begin
  AboutForm:=TAboutForm.Create(Application);
  AboutForm.Show;
  AboutForm.Update;
end;

{------------------------------------------------------------------}

procedure HideSplashScreen;
begin
  AboutForm.Hide;
  FreeObject(AboutForm,AboutForm);
end;

{------------------------------------------------------------------}

procedure ShowAboutForm;
begin
  with TAboutForm.Create(Application) do
  begin
    ShowModal;
    Free;
  end;
end;

{------------------------------------------------------------------}

procedure TAboutForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Close;
end;

{------------------------------------------------------------------}

procedure TAboutForm.Image1Click(Sender: TObject);
begin
  Close;
end;

{------------------------------------------------------------------}

procedure TAboutForm.URLLabelClick(Sender: TObject);
begin
  JumpToUrl(CompanyURL);
end;

{------------------------------------------------------------------}
procedure TAboutForm.FormCreate(Sender: TObject);
begin
  {$IFDEF D3}
  URLLabel.Cursor:=crHandPoint;
  {$ENDIF}
  URLLabel.Caption:=CompanyURL;
  VersionLabel.Caption:=Format(VersionLabel.Caption,[SDreamControlsVersion]);
  CopyrightLabel.Caption:=SCopyrightDream;
end;


end.
