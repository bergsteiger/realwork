unit dsFilters;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "List"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/List/dsFilters.pas"
// Начат: 29.07.2005 17.07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Базовые определения предметной области::LegalDomain::List::SimpleList::TdsFilters
//
// БОФ формы фильтры
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SimpleListInterfaces
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
  l3NotifyPtrList,
  l3TreeInterfaces
  ;

type
 _FormDataSourceType_ = IdsFilters;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsFilters = {final vac} class(_vcmFormDataSourcePrim_, IdsFilters)
  {* БОФ формы фильтры }
 protected
 // realized methods
   function OpenFilter(const aNode: Il3SimpleNode): IdeFilter;
     {* возвращает данные необходимые редактироания фильтра }
 end;//TdsFilters

implementation

uses
  deFilter,
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;

type _Instance_R_ = TdsFilters;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsFilters

function TdsFilters.OpenFilter(const aNode: Il3SimpleNode): IdeFilter;
//#UC START# *4922D96003C8_47F5BC100329_var*
//#UC END# *4922D96003C8_47F5BC100329_var*
begin
//#UC START# *4922D96003C8_47F5BC100329_impl*
 Result := TdeFilter.Make(aNode);
//#UC END# *4922D96003C8_47F5BC100329_impl*
end;//TdsFilters.OpenFilter

end.