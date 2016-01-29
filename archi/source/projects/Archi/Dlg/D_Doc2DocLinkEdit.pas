unit D_Doc2DocLinkEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, D_GetNum, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls, ActnList,
  k2Interfaces, k2Tags,
  DT_Link,
  
  l3Variant
  ;

type
  TDoc2DocLinkEditDlg = class(TGetNumberDlg)
    cbLinkType: TComboBox;
    Label2: TLabel;
  private
    { Private declarations }
  public
   { Public declarations }
   function Execute(aRec : Tl3Tag; aRecEmpty : Boolean): Boolean;
  end;

var
  Doc2DocLinkEditDlg: TDoc2DocLinkEditDlg;

function Doc2DocLinkEdit(aRec : Tl3Tag; aRecEmpty : Boolean): Boolean;

implementation
{$R *.dfm}

uses
 l3Base,
 DT_Types,
 DT_Const,
 DT_Serv,
 dt_LinkServ,
 DT_Renum;

function Doc2DocLinkEdit(aRec : Tl3Tag; aRecEmpty : Boolean): Boolean;
var
 l_Dialog: TDoc2DocLinkEditDlg;
begin
 l_Dialog := TDoc2DocLinkEditDlg.Create(nil);
 try
  Result := l_Dialog.Execute(aRec, aRecEmpty);
 finally
  l3Free(l_Dialog);
 end;
end;

function TDoc2DocLinkEditDlg.Execute(aRec : Tl3Tag; aRecEmpty : Boolean): Boolean;
begin
 if aRecEmpty then
 begin
  cbLinkType.ItemIndex := 0;
  edNumber.Text := '';
 end
 else
 with aRec do
 begin
  cbLinkType.ItemIndex := IntA[k2_tiType];
  edNumber.Text := IntToStr(IntA[k2_tiDocID]);
  chkRenum.Checked := True;
 end;

 Result := ShowModal = mrOK;

 if Result then
 begin
  with aRec do
  begin
   AttrW[k2_tiName, nil] := nil;
   IntA[k2_tiType] := cbLinkType.ItemIndex;
   IntA[k2_tiDocID] := Number;
  end;
 end;
end;

end.
