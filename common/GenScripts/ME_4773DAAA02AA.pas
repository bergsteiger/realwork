unit l3ObjectRefList1;
 {* Список ссылок на объекты. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectRefList1.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ObjectRefList1" MUID: (4773DAAA02AA)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3_Base
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3_Base;
 _l3ObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectRefList.imp.pas}
 Tl3ObjectRefList1 = class(_l3ObjectRefList_)
  {* Список ссылок на объекты. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3ObjectRefList1

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = Tl3ObjectRefList1;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectRefList.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3ObjectRefList1.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4773DAAA02AA_var*
//#UC END# *47A6FEE600FC_4773DAAA02AA_var*
begin
//#UC START# *47A6FEE600FC_4773DAAA02AA_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DAAA02AA_impl*
end;//Tl3ObjectRefList1.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
