unit PrimDocumentWithFlashOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocumentWithFlashOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimDocumentWithFlashOptions" MUID: (4C87849303A6)
// Имя типа: "TPrimDocumentWithFlashOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocumentWithFlash_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimDocumentWithFlashOptionsForm = class(TPrimDocumentWithFlashForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimDocumentWithFlashOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Base_Operations_Strange_Controls
 , Common_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C87849303A6impl_uses*
 //#UC END# *4C87849303A6impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimDocumentWithFlashOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_Document, op_NextDocumentInList, False);
  ShowInToolbar(en_Document, op_NextDocumentInList, False);
  ShowInContextMenu(en_Document, op_ReturnToList, False);
  ShowInToolbar(en_Document, op_ReturnToList, False);
  ShowInContextMenu(en_Document, op_GetRelatedDocFrmAct, False);
  ShowInToolbar(en_Document, op_GetRelatedDocFrmAct, True);
  ShowInContextMenu(en_Document, op_AddBookmark, False);
  ShowInToolbar(en_Document, op_AddBookmark, False);
  ShowInContextMenu(en_Document, op_GetCorrespondentList, False);
  ShowInToolbar(en_Document, op_GetCorrespondentList, False);
  ShowInContextMenu(en_Document, op_GetRespondentList, False);
  ShowInToolbar(en_Document, op_GetRespondentList, False);
  ShowInContextMenu(en_Document, op_GetCorrespondentListExFrmAct, False);
  ShowInToolbar(en_Document, op_GetCorrespondentListExFrmAct, True);
  ShowInContextMenu(en_Document, op_GetRespondentListExFrmAct, False);
  ShowInToolbar(en_Document, op_GetRespondentListExFrmAct, True);
  ShowInContextMenu(en_Document, op_GetAttributesFrmAct, False);
  ShowInToolbar(en_Document, op_GetAttributesFrmAct, True);
  ShowInContextMenu(en_Document, op_AddToControl, False);
  ShowInToolbar(en_Document, op_AddToControl, True);
  ShowInContextMenu(en_Document, op_UserCR1, False);
  ShowInToolbar(en_Document, op_UserCR1, True);
  ShowInContextMenu(en_Document, op_UserCR2, False);
  ShowInToolbar(en_Document, op_UserCR2, True);
  ShowInContextMenu(en_Document, op_PrevDocumentInList, False);
  ShowInToolbar(en_Document, op_PrevDocumentInList, False);
  ShowInContextMenu(en_Document, op_DocumentIsUseful, False);
  ShowInToolbar(en_Document, op_DocumentIsUseful, False);
  ShowInContextMenu(en_Document, op_DocumentIsUseless, False);
  ShowInToolbar(en_Document, op_DocumentIsUseless, False);
 end;//with Entities.Entities
end;//TPrimDocumentWithFlashOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDocumentWithFlashOptionsForm);
 {* Регистрация PrimDocumentWithFlashOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
