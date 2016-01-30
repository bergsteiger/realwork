unit NOT_FINISHED_l3RangeManager;

// ћодуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3RangeManager.pas"
// —тереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3RangeManager = class(Tl3CProtoObject, Il3RangeManager)
  protected
   function HasPage(anIndex: Integer): Boolean;
    {* содержит ли диапазон указанную страницу. }
   function Get_Count: Integer;
   function Get_Pages(anIndex: Integer): Integer;
   function Get_IndexOfPage(Page: Integer): Integer;
 end;//Tl3RangeManager

implementation

uses
 l3ImplUses
;

function Tl3RangeManager.HasPage(anIndex: Integer): Boolean;
 {* содержит ли диапазон указанную страницу. }
//#UC START# *46A45DA20336_4B9FBF5A021A_var*
//#UC END# *46A45DA20336_4B9FBF5A021A_var*
begin
//#UC START# *46A45DA20336_4B9FBF5A021A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DA20336_4B9FBF5A021A_impl*
end;//Tl3RangeManager.HasPage

function Tl3RangeManager.Get_Count: Integer;
//#UC START# *46A45DC20057_4B9FBF5A021Aget_var*
//#UC END# *46A45DC20057_4B9FBF5A021Aget_var*
begin
//#UC START# *46A45DC20057_4B9FBF5A021Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DC20057_4B9FBF5A021Aget_impl*
end;//Tl3RangeManager.Get_Count

function Tl3RangeManager.Get_Pages(anIndex: Integer): Integer;
//#UC START# *46A45DE80156_4B9FBF5A021Aget_var*
//#UC END# *46A45DE80156_4B9FBF5A021Aget_var*
begin
//#UC START# *46A45DE80156_4B9FBF5A021Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45DE80156_4B9FBF5A021Aget_impl*
end;//Tl3RangeManager.Get_Pages

function Tl3RangeManager.Get_IndexOfPage(Page: Integer): Integer;
//#UC START# *46A45EB10245_4B9FBF5A021Aget_var*
//#UC END# *46A45EB10245_4B9FBF5A021Aget_var*
begin
//#UC START# *46A45EB10245_4B9FBF5A021Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A45EB10245_4B9FBF5A021Aget_impl*
end;//Tl3RangeManager.Get_IndexOfPage

end.
