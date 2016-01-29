unit PrimSaveLoadOptionsForBaseSearch_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadOptionsForBaseSearch_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadOptionsForBaseSearch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  SearchLite_Strange_Controls,
  Search_Strange_Controls,
  l3StringIDEx,
  PrimSaveLoadOptions_Form,
  PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TPrimSaveLoadOptionsForBaseSearchForm = {form} class(TPrimSaveLoadOptionsForm)
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // overridden protected methods
   class function IsBaseSearchLike: Boolean; override;
 end;//TPrimSaveLoadOptionsForBaseSearchForm

 TvcmContainerFormRef = TPrimSaveLoadOptionsForBaseSearchForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a},
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

var
   { Локализуемые строки slqtBaseSearchLocalConstants }
  str_slqtBaseSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtBaseSearchCaption'; rValue : 'Базовый поиск');
   { Заголовок пользовательского типа "Базовый поиск" }

// start class TPrimSaveLoadOptionsForBaseSearchForm

class function TPrimSaveLoadOptionsForBaseSearchForm.IsBaseSearchLike: Boolean;
//#UC START# *502289FB008D_4F5DA09300C5_var*
//#UC END# *502289FB008D_4F5DA09300C5_var*
begin
//#UC START# *502289FB008D_4F5DA09300C5_impl*
 Result := true;
//#UC END# *502289FB008D_4F5DA09300C5_impl*
end;//TPrimSaveLoadOptionsForBaseSearchForm.IsBaseSearchLike

procedure TPrimSaveLoadOptionsForBaseSearchForm.InitEntities;
begin
 inherited;
 AddUserTypeExclude(slqtBaseSearchName, en_File, op_SaveToFolder, false);
 AddUserTypeExclude(slqtBaseSearchName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Loadable, op_Load, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(slqtBaseSearchName, en_Result, op_OkExt, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(slqtBaseSearchName, en_Result, op_Cancel, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_ClearAll, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_SetList, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_Add, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_Delete, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_GetList, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_ClearAll, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_Refresh, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Result, op_ClearAll, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_GetOldQuery, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Query, op_SearchType, false);
 AddUserTypeExclude(slqtBaseSearchName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtBaseSearchName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtBaseSearchName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(slqtBaseSearchName, en_Filterable, op_GetListType, false);
end;

procedure TPrimSaveLoadOptionsForBaseSearchForm.MakeControls;
begin
 inherited;
 with AddUsertype(slqtBaseSearchName,
  str_slqtBaseSearchCaption,
  str_slqtBaseSearchCaption,
  true,
  102,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtBaseSearchName
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin)}
// Инициализация str_slqtBaseSearchCaption
 str_slqtBaseSearchCaption.Init;
{$IfEnd} //not Admin
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimSaveLoadOptionsForBaseSearch
 TtfwClassRef.Register(TPrimSaveLoadOptionsForBaseSearchForm);
{$IfEnd} //not Admin AND not NoScripts

end.