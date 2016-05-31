unit PrimSaveLoadOptionsForBaseSearch_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadOptionsForBaseSearch_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimSaveLoadOptionsForBaseSearch" MUID: (4F5DA09300C5)
// Имя типа: "TPrimSaveLoadOptionsForBaseSearchForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimSaveLoadOptionsForBaseSearchForm = class(TPrimSaveLoadOptionsForm)
  protected
   class function IsBaseSearchLike: Boolean; override;
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimSaveLoadOptionsForBaseSearchForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , PrimPrimListInterfaces
 , bsTypes
 , eeInterfaces
 , nsTypes
 , FiltersUnit
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4F5DA09300C5impl_uses*
 //#UC END# *4F5DA09300C5impl_uses*
;

class function TPrimSaveLoadOptionsForBaseSearchForm.IsBaseSearchLike: Boolean;
//#UC START# *502289FB008D_4F5DA09300C5_var*
//#UC END# *502289FB008D_4F5DA09300C5_var*
begin
//#UC START# *502289FB008D_4F5DA09300C5_impl*
 Result := true;
//#UC END# *502289FB008D_4F5DA09300C5_impl*
end;//TPrimSaveLoadOptionsForBaseSearchForm.IsBaseSearchLike

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadOptionsForBaseSearchForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 AddUserTypeExclude(slqtBaseSearchName, en_File, op_SaveToFolder, False);
 AddUserTypeExclude(slqtBaseSearchName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Loadable, op_Load, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Result, op_OkExt, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Result, op_Cancel, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_ClearAll, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_SetList, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_Add, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_Delete, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_GetList, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_ClearAll, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_Refresh, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Result, op_ClearAll, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_GetOldQuery, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_SearchType, False);
 AddUserTypeExclude(slqtBaseSearchName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtBaseSearchName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtBaseSearchName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_GetListType, False);
end;//TPrimSaveLoadOptionsForBaseSearchForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadOptionsForBaseSearchForm.MakeControls;
begin
 inherited;
 with AddUsertype(slqtBaseSearchName,
  str_slqtBaseSearchCaption,
  str_slqtBaseSearchCaption,
  True,
  102,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtBaseSearchName
end;//TPrimSaveLoadOptionsForBaseSearchForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadOptionsForBaseSearchForm);
 {* Регистрация PrimSaveLoadOptionsForBaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
