unit nevBasePointList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevBasePointList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InevBasePoint;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevBasePointList = class(_l3InterfaceRefList_)
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//TnevBasePointList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnevBasePointList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function TnevBasePointList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_47E271DA01B1_var*
//#UC END# *47A6FEE600FC_47E271DA01B1_var*
begin
//#UC START# *47A6FEE600FC_47E271DA01B1_impl*
 Result := true;
//#UC END# *47A6FEE600FC_47E271DA01B1_impl*
end;//TnevBasePointList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
