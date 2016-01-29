unit F1ShellInfo;

interface

uses
  Buttons,
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  StdCtrls, Graphics;

type
 TF1ShellInfoForm = class(TForm)
  f_MainPanel: TPanel;
  f_BottomPanel: TPanel;
  f_ClientPanel: TPanel;
  f_TopPanel: TPanel;
  f_LogoImage: TImage;
  f_InfoLabel: TLabel;
  f_Close: TBitBtn;
 end;

var
 F1ShellInfoForm: TF1ShellInfoForm;

implementation

{$R *.dfm}

end.
