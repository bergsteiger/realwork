unit WebAppDbgAbout;

interface

uses
  SysUtils, Classes, QGraphics, QControls,
  QForms, QDialogs, QStdCtrls, QButtons, QExtCtrls;

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

{$R *.xfm}

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

