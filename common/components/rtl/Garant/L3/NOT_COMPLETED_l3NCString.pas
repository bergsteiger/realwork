unit NOT_COMPLETED_l3NCString;
 {* Гарантированно некешируемая строка. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_COMPLETED_l3NCString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3NCString" MUID: (47BC50F5038E)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3_String
;

type
 Tl3NCString = class(Tl3_String)
  {* Гарантированно некешируемая строка. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3NCString

implementation

uses
 l3ImplUses
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3NCString.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_47BC50F5038E_var*
//#UC END# *47A6FEE600FC_47BC50F5038E_var*
begin
//#UC START# *47A6FEE600FC_47BC50F5038E_impl*
 Result := false;
//#UC END# *47A6FEE600FC_47BC50F5038E_impl*
end;//Tl3NCString.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
