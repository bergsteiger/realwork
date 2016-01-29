unit D_DocumentProperties;

{ Автор: Люлин А.В. ©                   }
{ Модуль: D_DocumentProperties -        }
{ Начат: 21.02.2001 12:02               }
{ $Id: D_DocumentProperties.pas,v 1.13 2008/04/15 17:36:14 lulin Exp $ }

// $Log: D_DocumentProperties.pas,v $
// Revision 1.13  2008/04/15 17:36:14  lulin
// - автоматизируем переключение между версиями редактора.
//
// Revision 1.12  2007/12/05 13:51:28  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.9.2.3  2007/03/27 07:59:35  dinishev
// Bug fix: не собирался Everest в ветке
//
// Revision 1.9.2.2  2006/12/21 16:23:04  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.9.2.1  2006/02/07 15:15:59  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.9  2005/05/27 14:44:27  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.8  2004/04/23 16:11:30  law
// - new unit: evEdit.
//
// Revision 1.7  2003/10/13 15:06:41  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.6  2001/05/24 14:29:51  law
// - new behavior: подстраиваемся под изменения Вована, относительно PopupWindow.
//
// Revision 1.5  2001/05/07 08:54:36  law
// - new behavior: Tl3Tree ->Il3RootNode.
// - cleanup: убраны ненужные ссылки на RXSpin.
//
// Revision 1.4  2001/02/21 12:34:39  law
// - nothing special.
//
// Revision 1.3  2001/02/21 12:32:20  law
// - поправлена кодировка.
//
// Revision 1.2  2001/02/21 12:31:35  law
// - вставлен заголовок модуля.
//

interface

uses
  Windows, 
  Messages, 
  SysUtils, 
  Classes, 
  Graphics, 
  Controls, 
  Forms, 
  Dialogs,
  StdCtrls, 
  Buttons,
  ExtCtrls,  

  D_Base, 

  l3Types, 

  evInternalInterfaces,
  evEditorWindow, 
  evEditor, 
  evMemo, 
  evEdit, 
  evMultiSelectEditorWindow, 
  evEditorWithOperations, 
  evCustomEditor,
  
  nevTools,

  OvcBase,  
  
  vtSpin, 
  
  afwControl;

type
  TDocumentPropertiesDlg = class(TBaseDlg)
    lbShortName: TLabel;
    edShortName: TevEdit;
    lbName: TLabel;
    memName: TevMemo;
    lbComment: TLabel;
    memComment: TevMemo;
    lbNumber: TLabel;
    edExternalNumber: TvtSpinEdit;
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
    f_Document : IevDocument;
  public
    { Public declarations }
    function Execute(const aDocument: IevDocument): Long;
      {-}
  end;//TDocumentPropertiesDlg

implementation

{$R *.DFM}

function TDocumentPropertiesDlg.Execute(const aDocument: IevDocument): Long;
  {-}
begin
 if (aDocument = nil) then
  Result := mrCancel
 else begin
  f_Document := aDocument;
  with f_Document do begin
   edShortName.Buffer := ShortName;
   memName.Buffer := Name;
   memComment.Buffer := Comment;
   edExternalNumber.Value := ExternalHandle;
  end;//with f_Document
  Result := ShowModal;
 end;//aDocument = nil
end;

procedure TDocumentPropertiesDlg.FormDestroy(Sender: TObject);
begin
 inherited;
 f_Document := nil;
end;

procedure TDocumentPropertiesDlg.OKBtnClick(Sender: TObject);
begin
 inherited;
 with f_Document do begin
  if edShortName.Modified then
   ShortName := Tl3PCharLen(edShortName.Buffer);
  if memName.Modified then
   Name := Tl3PCharLen(memName.Buffer);
  if memComment.Modified then
   Comment := Tl3PCharLen(memComment.Buffer);
  if edExternalNumber.Modified then
   ExternalHandle := edExternalNumber.AsInteger;
 end;//with f_Document
end;

end.
