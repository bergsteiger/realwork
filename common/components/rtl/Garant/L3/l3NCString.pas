unit l3NCString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3NCString.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3NCString
//
// Гарантированно некешируемая строка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3_String
  ;

type
 Tl3NCString = class(Tl3_String)
  {* Гарантированно некешируемая строка. }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3NCString

implementation

// start class Tl3NCString

{$If not defined(DesignTimeLibrary)}
class function Tl3NCString.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_47BC50F5038E_var*
//#UC END# *47A6FEE600FC_47BC50F5038E_var*
begin
//#UC START# *47A6FEE600FC_47BC50F5038E_impl*
 Result := false;
//#UC END# *47A6FEE600FC_47BC50F5038E_impl*
end;//Tl3NCString.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.