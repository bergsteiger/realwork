unit D_MacroSubNameProp;

interface

uses
  Windows, 
  Messages, 
  SysUtils, 
  Variants, 
  Classes, 
  Graphics, 
  Controls, 
  Forms,
  Dialogs, 
  BottomBtnDlg, 
  StdCtrls, 
  Buttons, 
  ExtCtrls, 

  l3Interfaces,

  vtGroupBox,
  vtGroupBoxEx;

type
  TGetSubNamePropDlg = class(TBottomBtnDlg)
    cbxNeedHeader: TCheckBox;
    vtGroupBoxEx1: TvtGroupBoxEx;
    rb1_1: TRadioButton;
    rb1_2: TRadioButton;
    rb1_3: TRadioButton;
    vtGroupBoxEx2: TvtGroupBoxEx;
    rb2_1: TRadioButton;
    rb2_2: TRadioButton;
    vtGroupBoxEx3: TvtGroupBoxEx;
    rb3_1: TRadioButton;
    rb3_2: TRadioButton;
    vtGroupBoxEx4: TvtGroupBoxEx;
    rb4_1: TRadioButton;                                      
    rb4_2: TRadioButton;
    rb4_3: TRadioButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure GetSubNamePropDlg(var aSubNamePrefix1 : Il3CString; var aSubNamePrefix2 : Il3CString;
                            var aSubNamePrefix3 : Il3CString; var aSubNamePrefix4 : Il3CString;
                            var aNeedHeader : Boolean);
implementation

uses
 l3Base;

{$R *.dfm}

procedure GetSubNamePropDlg(var aSubNamePrefix1 : Il3CString; var aSubNamePrefix2 : Il3CString;
                            var aSubNamePrefix3 : Il3CString; var aSubNamePrefix4 : Il3CString;
                            var aNeedHeader : Boolean);
begin
 with TGetSubNamePropDlg.Create(nil) do
 try
  ShowModal;

  aNeedHeader := cbxNeedHeader.Checked;

  if rb1_1.Checked then
   aSubNamePrefix1 := l3CStr(rb1_1.Caption)
  else
  if rb1_2.Checked then
   aSubNamePrefix1 := l3CStr(rb1_2.Caption)
  else
   aSubNamePrefix1 := l3CStr(rb1_3.Caption);

  if rb2_1.Checked then
   aSubNamePrefix2 := l3CStr(rb2_1.Caption)
  else
   aSubNamePrefix2 := l3CStr(rb2_2.Caption);

  if rb3_1.Checked then
   aSubNamePrefix3 := l3CStr(rb3_1.Caption)
  else
   aSubNamePrefix3 := l3CStr(rb3_2.Caption);

  if rb4_1.Checked then
   aSubNamePrefix4 := l3CStr(rb4_1.Caption)
  else
  if rb4_2.Checked then
   aSubNamePrefix4 := l3CStr(rb4_2.Caption)
  else
   aSubNamePrefix4 := l3CStr(rb4_3.Caption);
 finally
  Free;
 end;
end;
end.
