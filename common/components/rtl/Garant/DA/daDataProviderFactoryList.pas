unit daDataProviderFactoryList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daDataProviderFactoryList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaDataProviderFactoryList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3ProtoDataContainer,
  daDataProviderFactory,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TdaDataProviderFactory;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TdaDataProviderFactoryList = class(_l3UncomparabeObjectRefList_)
 end;//TdaDataProviderFactoryList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TdaDataProviderFactoryList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_54F98A56030A_var*
//#UC END# *47B2C42A0163_54F98A56030A_var*
begin
//#UC START# *47B2C42A0163_54F98A56030A_impl*
 Assert(False);
//#UC END# *47B2C42A0163_54F98A56030A_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_54F98A56030A_var*
//#UC END# *47B99D4503A2_54F98A56030A_var*
begin
//#UC START# *47B99D4503A2_54F98A56030A_impl*
 Result := AnsiCompareText(CI.rA.Key, CI.rB.Key);
//#UC END# *47B99D4503A2_54F98A56030A_impl*
end;//CompareExistingItems

type _Instance_R_ = TdaDataProviderFactoryList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.