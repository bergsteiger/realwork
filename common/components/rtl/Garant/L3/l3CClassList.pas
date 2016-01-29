unit l3CClassList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3CClassList.pas"
// Начат: 06.02.2008 16:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CClassList
//
// Кешируемый список классов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ClassList
  ;

type
 Tl3CClassList = class(Tl3ClassList)
  {* Кешируемый список классов. }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3CClassList

implementation

// start class Tl3CClassList

{$If not defined(DesignTimeLibrary)}
class function Tl3CClassList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4773DC3502A7_var*
//#UC END# *47A6FEE600FC_4773DC3502A7_var*
begin
//#UC START# *47A6FEE600FC_4773DC3502A7_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DC3502A7_impl*
end;//Tl3CClassList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.