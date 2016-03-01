unit nevRangeList;
 {* Список выделенных элементов документа. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevRangeList.pas"
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
 _ItemType_ = InevRange;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevRangeList = class(_l3InterfaceRefList_)
  {* Список выделенных элементов документа. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   function Clone: TnevRangeList;
 end;//TnevRangeList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnevRangeList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

function TnevRangeList.Clone: TnevRangeList;
//#UC START# *4DD2681E03BF_47E26A16008E_var*
type
 RnevRangeList = class of TnevRangeList;
//#UC END# *4DD2681E03BF_47E26A16008E_var*
begin
//#UC START# *4DD2681E03BF_47E26A16008E_impl*
 Result := RnevRangeList(ClassType).Create;
 Result.JoinWith(Self);
//#UC END# *4DD2681E03BF_47E26A16008E_impl*
end;//TnevRangeList.Clone

{$If NOT Defined(DesignTimeLibrary)}
class function TnevRangeList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_47E26A16008E_var*
//#UC END# *47A6FEE600FC_47E26A16008E_var*
begin
//#UC START# *47A6FEE600FC_47E26A16008E_impl*
 Result := true;
//#UC END# *47A6FEE600FC_47E26A16008E_impl*
end;//TnevRangeList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
