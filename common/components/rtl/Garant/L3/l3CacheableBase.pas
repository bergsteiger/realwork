unit l3CacheableBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3CacheableBase.pas"
// Начат: 12.04.1998 16:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CacheableBase
//
// Базовый класс для кешируемых объектов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleObject
  ;

type
 Tl3CacheableBase = class(Tl3SimpleObject)
  {* Базовый класс для кешируемых объектов }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3CacheableBase

implementation

// start class Tl3CacheableBase

{$If not defined(DesignTimeLibrary)}
class function Tl3CacheableBase.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_46780E690001_var*
//#UC END# *47A6FEE600FC_46780E690001_var*
begin
//#UC START# *47A6FEE600FC_46780E690001_impl*
 Result := true;
//#UC END# *47A6FEE600FC_46780E690001_impl*
end;//Tl3CacheableBase.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.