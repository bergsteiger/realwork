unit PrimDocumentWithFlashOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimDocumentWithFlashOptions_Form.pas"
// Начат: 08.09.2010 16:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::DocumentWithFlash::PrimDocumentWithFlashOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  PrimDocumentWithFlash_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimDocumentWithFlashOptionsForm = {form} class(TPrimDocumentWithFlashForm)
 protected
  procedure InitEntities; override;
 end;//TPrimDocumentWithFlashOptionsForm

 TvcmEntityFormRef = TPrimDocumentWithFlashOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  Common_Strange_Controls
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimDocumentWithFlashOptionsForm

procedure TPrimDocumentWithFlashOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  
  ShowInContextMenu(en_Document, op_NextDocumentInList, false);
  ShowInToolbar(en_Document, op_NextDocumentInList, false);
  
  ShowInContextMenu(en_Document, op_ReturnToList, false);
  ShowInToolbar(en_Document, op_ReturnToList, false);
  
  ShowInContextMenu(en_Document, op_GetRelatedDocFrmAct, false);
  ShowInToolbar(en_Document, op_GetRelatedDocFrmAct, true);
  
  ShowInContextMenu(en_Document, op_AddBookmark, false);
  ShowInToolbar(en_Document, op_AddBookmark, false);
  
  ShowInContextMenu(en_Document, op_GetCorrespondentList, false);
  ShowInToolbar(en_Document, op_GetCorrespondentList, false);
  
  ShowInContextMenu(en_Document, op_GetRespondentList, false);
  ShowInToolbar(en_Document, op_GetRespondentList, false);
  
  ShowInContextMenu(en_Document, op_GetCorrespondentListExFrmAct, false);
  ShowInToolbar(en_Document, op_GetCorrespondentListExFrmAct, true);
  
  ShowInContextMenu(en_Document, op_GetRespondentListExFrmAct, false);
  ShowInToolbar(en_Document, op_GetRespondentListExFrmAct, true);
  
  ShowInContextMenu(en_Document, op_GetAttributesFrmAct, false);
  ShowInToolbar(en_Document, op_GetAttributesFrmAct, true);
  
  ShowInContextMenu(en_Document, op_AddToControl, false);
  ShowInToolbar(en_Document, op_AddToControl, true);
  
  ShowInContextMenu(en_Document, op_UserCR1, false);
  ShowInToolbar(en_Document, op_UserCR1, true);
  
  ShowInContextMenu(en_Document, op_UserCR2, false);
  ShowInToolbar(en_Document, op_UserCR2, true);
  
  ShowInContextMenu(en_Document, op_PrevDocumentInList, false);
  ShowInToolbar(en_Document, op_PrevDocumentInList, false);
  
  ShowInContextMenu(en_Document, op_DocumentIsUseful, false);
  ShowInToolbar(en_Document, op_DocumentIsUseful, false);
  
  ShowInContextMenu(en_Document, op_DocumentIsUseless, false);
  ShowInToolbar(en_Document, op_DocumentIsUseless, false);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimDocumentWithFlashOptions
 TtfwClassRef.Register(TPrimDocumentWithFlashOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.