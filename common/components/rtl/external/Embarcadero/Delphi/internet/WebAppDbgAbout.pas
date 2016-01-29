{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit WebAppDbgAbout;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TAboutBox = class(TForm)
    OKButton: TButton;
    Bevel1: TBevel;
    DetailsPanel: TPanel;
    Copyright: TLabel;
    Version: TLabel;
    SKUName: TLabel;
    CompanyName: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowAboutBox;

implementation

uses SvrConst;

const
  BltSize = 12;

{$R *.dfm}

procedure ShowAboutBox;
var
  AboutBox: TAboutBox;
begin
  AboutBox := TAboutBox.Create(Application);
  try
    AboutBox.ShowModal;
  finally
    AboutBox.Free;
  end;
end;


end.

