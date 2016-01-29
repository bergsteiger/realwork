unit D_DictItemKind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, ExtCtrls, Buttons;

type
  TDictItemKindDlg = class(TBottomBtnDlg)
    RadioGroup1: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
 TItemKind = (ikBase, ikExt, ikCancel);

function GetDictItemKind : TItemKind;

implementation

uses
 Main;

{$R *.dfm}
 function GetDictItemKind : TItemKind;
 begin
  with TDictItemKindDlg.Create(MainForm) do
  begin
   if ShowModal = mrOk then
    Result := TItemKind(RadioGroup1.ItemIndex)
   else
    Result := ikCancel;

   Free;
  end;

 end;

end.
