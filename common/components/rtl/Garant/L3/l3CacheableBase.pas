unit l3CacheableBase;
 {* Базовый класс для кешируемых объектов }

// Модуль: "w:\common\components\rtl\Garant\L3\l3CacheableBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3CacheableBase" MUID: (46780E690001)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
;

type
 Tl3CacheableBase = class(Tl3SimpleObject)
  {* Базовый класс для кешируемых объектов }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3CacheableBase

implementation

uses
 l3ImplUses
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3CacheableBase.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_46780E690001_var*
//#UC END# *47A6FEE600FC_46780E690001_var*
begin
//#UC START# *47A6FEE600FC_46780E690001_impl*
 Result := true;
//#UC END# *47A6FEE600FC_46780E690001_impl*
end;//Tl3CacheableBase.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
