unit About;

interface 

uses Windows, Classes, Forms, Controls, StdCtrls, Buttons, ExtCtrls, ElURLLabel,
  Graphics, ElCLabel, ElXPThemedControl, ElBtnCtl, ElPopBtn;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Copyright: TLabel;
    OKButton: TElPopupButton;
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}

end.

