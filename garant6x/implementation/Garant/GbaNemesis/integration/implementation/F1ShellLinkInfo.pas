unit F1ShellLinkInfo;

interface

uses
  Buttons,
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  StdCtrls, Graphics;

type
 TF1ShellLinkInfoForm = class(TForm)
  f_MainPanel: TPanel;
  f_BottomPanel: TPanel;
  f_ClientPanel: TPanel;
  f_TopPanel: TPanel;
  f_LogoImage: TImage;
  f_InfoLabel: TLabel;
  f_GotoGARANT: TBitBtn;
  f_Close: TBitBtn;
 end;

var
 F1ShellLinkInfoForm: TF1ShellLinkInfoForm;

implementation

{$R *.dfm}

end.
