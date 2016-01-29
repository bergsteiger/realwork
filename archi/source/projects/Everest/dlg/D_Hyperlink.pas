unit D_Hyperlink;

{ Автор: Люлин А.В. ©     }
{ Модуль: D_Hyperlink -   }
{ Начат: 24.10.2000 17:55 }
{ $Id: D_Hyperlink.pas,v 1.22 2013/05/31 06:24:58 lulin Exp $ }

// $Log: D_Hyperlink.pas,v $
// Revision 1.22  2013/05/31 06:24:58  lulin
// - портируем под XE4.
//
// Revision 1.21  2009/06/02 13:47:44  lulin
// [$148574526].
//
// Revision 1.20  2009/06/01 16:07:46  lulin
// [$148574348].
//
// Revision 1.19  2009/05/14 08:55:05  dinishev
// Bug fix: не собирался Everest
//
// Revision 1.18  2007/12/05 13:51:29  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.15.2.1  2007/03/27 07:59:49  dinishev
// Bug fix: не собирался Everest в ветке
//
// Revision 1.15  2005/05/27 14:44:27  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.14  2004/12/23 11:16:14  lulin
// - rename prop: TvtCustomOutliner.TreeSource -> TreeStruct.
//
// Revision 1.13  2004/05/26 17:01:53  law
// - new behavior: TvtCustomOutliner теперь знает только про интерфейсы Il3SimpleTree и Il3Tree, а не про объект Tl3Tree.
//
// Revision 1.12  2004/04/23 16:11:30  law
// - new unit: evEdit.
//
// Revision 1.11  2003/10/13 15:06:41  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.10  2002/10/28 12:41:46  law
// - new behavior: возможность редактирования ссылок на тот же документ, где эта ссылка стоит.
//
// Revision 1.9  2001/05/24 14:29:52  law
// - new behavior: подстраиваемся под изменения Вована, относительно PopupWindow.
//
// Revision 1.8  2001/05/07 08:54:36  law
// - new behavior: Tl3Tree ->Il3RootNode.
// - cleanup: убраны ненужные ссылки на RXSpin.
//
// Revision 1.7  2001/02/21 14:26:41  law
// - убраны ненужные ссылки на модуль vbSpin.
//
// Revision 1.6  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

{$Include l3Define.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  D_ID, StdCtrls, Buttons, ExtCtrls, OvcBase, l3Types, l3Base,
   evEditorWindow, evEditor, evMemo, evEdit, evInternalInterfaces, fr_SubCombo,
  vtSpin, evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations,
  afwControl, afwControlPrim, afwBaseControl, nevControl, evCustomMemo,
  evCustomEdit, nevTools,
  nevNavigation,

  afwNavigation
  ;

type
  TdHyperLink = class(TIDDlg)
    lbURL: TLabel;
    edtURL: TevEdit;
    cbSub: TCheckBox;
    frSubCombo: TfrSubCombo;
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbSubClick(Sender: TObject);
  private
    { Private declarations }
    f_Hyperlink : IevHyperlink;
    f_Address   : TevAddress;
    f_DocID     : Long;
  public
    { Public declarations }
    function Execute(const aHyperlink: IevHyperlink; aDocID: Long) : Byte;
      {-}
  end;

implementation

uses
  l3TreeInterfaces,
  l3Tree_TLB
  ;

{$R *.DFM}

function TdHyperLink.Execute(const aHyperlink: IevHyperlink; aDocID: Long) : Byte;
  {-}
var
 l_RootNode : Il3RootNode;
begin
 if (aHyperlink = nil) then
  Result := mrCancel
 else begin
  f_DocID := aDocID;
  f_Hyperlink := aHyperlink;
  with f_Hyperlink do begin
   if Exists then begin
    Caption := 'Свойства ссылки';
    edtNum.AsInteger := ID;
   end else
    edtNum.AsInteger := Random(High(Long)-2) + 1;
   edtURL.Buffer := URL;
   f_Address := Address;
   frSubCombo.seSubID.AsInteger := f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.SubID;
  end;//with f_Hyperlink
  if l3IOk(aHyperlink.QueryInterface(Il3RootNode, l_RootNode)) then
   try
    frSubCombo.otlSub.TreeStruct.RootNode := l_RootNode As Il3SimpleRootNode;
   finally
    l_RootNode := nil;
   end;//try..finally
  with cbSub do begin
   Visible := (f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID <= 0) OR
              (f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID = f_DocID);
   Checked := (edtURL.Text = '') AND Visible;
  end;//with cbSub
  Result := ShowModal;
 end;
end;

procedure TdHyperLink.FormDestroy(Sender: TObject);
begin
 inherited;
 f_Hyperlink := nil;
end;

procedure TdHyperLink.OKBtnClick(Sender: TObject);
var
 l_HyperlinkID : Long;
begin
 inherited;
 l_HyperlinkID := edtNum.AsInteger;
 f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.SubID := frSubCombo.seSubID.AsInteger;
 if (l_HyperlinkID <= 0) then begin
  MessageDlg('Номер ссылки должен быть больше нуля.', mtError, [mbOK], 0);
  ActiveControl := edtNum;
  ModalResult := mrNone;
  Exit;
 end;//l_Hyperlink <= 0
 if (f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.SubID < 0) AND
    ((f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID <= 0) OR
     (f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID = f_DocID)) AND
    frSubCombo.seSubID.Modified then begin
  MessageDlg('Номер метки должен быть больше или равен нулю.', mtError, [mbOK], 0);
  if frSubCombo.Visible then
   ActiveControl := frSubCombo.seSubID;
  ModalResult := mrNone;
  Exit;
 end;//l_SubID < 0..
 with f_Hyperlink do begin
  if (l_HyperlinkID = ID) then
   edtNum.Modified := false;
  if Exists then begin
   if edtNum.Modified then
    ID := l_HyperlinkID;
  end else
   ID := l_HyperlinkID;
  if edtURL.Modified then
   URL := Tl3PCharLen(edtURL.Buffer);
  if ((f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID <= 0) OR
      (f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID = f_DocID)) AND
     frSubCombo.seSubID.Modified then begin
   if (f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID < 0) then
    f_Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID := 0;
   Address := f_Address;
  end;//f_DocID <= 0..
 end;//with f_Hyperlink
end;

procedure TdHyperLink.FormCreate(Sender: TObject);
begin
 inherited;
 frSubCombo.BoundsRect := edtURL.BoundsRect;
end;

procedure TdHyperLink.cbSubClick(Sender: TObject);
begin
 inherited;
 if cbSub.Checked then begin
  edtURL.Visible := false;
  frSubCombo.Visible := true;
 end else begin
  frSubCombo.Visible := false;
  edtURL.Visible := true;
 end;
end;

end.
