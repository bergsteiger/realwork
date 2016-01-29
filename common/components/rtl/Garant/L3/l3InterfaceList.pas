unit l3InterfaceList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3InterfaceList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3InterfaceList
//
// Список интерфейсов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IUnknown;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3InterfaceRefList.imp.pas}
 Tl3InterfaceList = class(_l3InterfaceRefList_)
  {* Список интерфейсов. }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3InterfaceList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3InterfaceList;

{$Include ..\L3\l3InterfaceRefList.imp.pas}

// start class Tl3InterfaceList

{$If not defined(DesignTimeLibrary)}
class function Tl3InterfaceList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4773DC580043_var*
//#UC END# *47A6FEE600FC_4773DC580043_var*
begin
//#UC START# *47A6FEE600FC_4773DC580043_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DC580043_impl*
end;//Tl3InterfaceList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.