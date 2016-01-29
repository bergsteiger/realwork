unit Il3ContextFilterParamsNotifierPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/Il3ContextFilterParamsNotifierPtrList.pas"
// Начат: 29.10.2008 20:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::TIl3ContextFilterParamsNotifierPtrList
//
// Список УКАЗАТЕЛЕЙ на Il3ContextFilterParamsNotifier
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3TreeInterfaces,
  l3SimpleDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Il3ContextFilterParamsNotifier;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIl3ContextFilterParamsNotifierPtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на Il3ContextFilterParamsNotifier }
 end;//TIl3ContextFilterParamsNotifierPtrList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TIl3ContextFilterParamsNotifierPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.