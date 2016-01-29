unit dsAttributeSelect;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/dsAttributeSelect.pas"
// Начат: 29.07.2005 17.07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TdsAttributeSelect
//
// бизнес объект формы выбранные атрибуты дерева
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
  SearchInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _FormDataSourceType_ = IdsAttributeSelect;
 _InitDataType_ = IdeSearch;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 TdsAttributeSelect = {vac} class(_vcmFormDataSource_, IdsAttributeSelect)
  {* бизнес объект формы выбранные атрибуты дерева }
 protected
 // realized methods
   function pm_GetSearch: IdeSearch;
 end;//TdsAttributeSelect
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

type _Instance_R_ = TdsAttributeSelect;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

// start class TdsAttributeSelect

function TdsAttributeSelect.pm_GetSearch: IdeSearch;
//#UC START# *4922D0440266_4922D2780153get_var*
//#UC END# *4922D0440266_4922D2780153get_var*
begin
//#UC START# *4922D0440266_4922D2780153get_impl*
 Result := PartData;
//#UC END# *4922D0440266_4922D2780153get_impl*
end;//TdsAttributeSelect.pm_GetSearch

{$IfEnd} //not Admin

end.