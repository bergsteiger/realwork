unit PrimSaveLoadOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptions_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimSaveLoadOptions" MUID: (4C88C4630176)
// Имя типа: "TPrimSaveLoadOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoad_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimSaveLoadOptionsForm = class(TPrimSaveLoadForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimSaveLoadOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , Search_Strange_Controls
 , SearchLite_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , afwFacade
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3String
 //#UC START# *4C88C4630176impl_uses*
 //#UC END# *4C88C4630176impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_File, op_SaveToFolder, True);
  ShowInToolbar(en_File, op_SaveToFolder, True);
  ShowInContextMenu(en_File, op_LoadFromFolder, True);
  ShowInToolbar(en_File, op_LoadFromFolder, True);
  ShowInContextMenu(en_Result, op_ClearAll, True);
  ShowInToolbar(en_Result, op_ClearAll, True);
  ShowInContextMenu(en_Query, op_GetOldQuery, True);
  ShowInToolbar(en_Query, op_GetOldQuery, True);
  ShowInContextMenu(en_Query, op_SearchType, False);
  ShowInToolbar(en_Query, op_SearchType, True);
  ShowInContextMenu(en_LogicOperation, op_LogicOr, True);
  ShowInToolbar(en_LogicOperation, op_LogicOr, True);
  ShowInContextMenu(en_Result, op_Cancel, True);
  ShowInToolbar(en_Result, op_Cancel, True);
  ShowInContextMenu(en_Result, op_OkExt, True);
  ShowInToolbar(en_Result, op_OkExt, True);
  ShowInContextMenu(en_Filters, op_FiltersListOpen, False);
  ShowInToolbar(en_Filters, op_FiltersListOpen, True);
 end;//with Entities.Entities
end;//TPrimSaveLoadOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadOptionsForm);
 {* Регистрация PrimSaveLoadOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
