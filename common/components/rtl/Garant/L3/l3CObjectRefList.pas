unit l3CObjectRefList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3CObjectRefList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CObjectRefList
//
// Кешируемый список ссылок на объекты.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ObjectRefList1
  ;

type
 Tl3CObjectRefList = class(Tl3ObjectRefList1)
  {* Кешируемый список ссылок на объекты. }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3CObjectRefList

implementation

// start class Tl3CObjectRefList

{$If not defined(DesignTimeLibrary)}
class function Tl3CObjectRefList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4773DAF300E4_var*
//#UC END# *47A6FEE600FC_4773DAF300E4_var*
begin
//#UC START# *47A6FEE600FC_4773DAF300E4_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DAF300E4_impl*
end;//Tl3CObjectRefList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.