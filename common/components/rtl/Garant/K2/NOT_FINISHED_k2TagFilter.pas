unit NOT_FINISHED_k2TagFilter;

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_FINISHED_k2TagFilter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2TagFilter" MUID: (49E487A70144)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TagTerminator
 , k2Base
 , l3Variant
;

type
 Tk2TagFilterOpenMode = (
 );//Tk2TagFilterOpenMode

 Tk2TagFilter = class(Tk2TagTerminator)
  protected
   function NeedTranslateChildToNextPrim(anOpenMode: Tk2TagFilterOpenMode): Boolean; virtual;
   procedure DoCloseStructure(NeedUndo: Boolean); virtual;
   procedure DoStartChild(TypeID: Tk2Type); virtual;
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); virtual;
   function NeedTranslateChildToNext: Boolean; virtual;
 end;//Tk2TagFilter

implementation

uses
 l3ImplUses
 //#UC START# *49E487A70144impl_uses*
 //#UC END# *49E487A70144impl_uses*
;

function Tk2TagFilter.NeedTranslateChildToNextPrim(anOpenMode: Tk2TagFilterOpenMode): Boolean;
//#UC START# *4E15CBD5018B_49E487A70144_var*
//#UC END# *4E15CBD5018B_49E487A70144_var*
begin
//#UC START# *4E15CBD5018B_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E15CBD5018B_49E487A70144_impl*
end;//Tk2TagFilter.NeedTranslateChildToNextPrim

procedure Tk2TagFilter.DoCloseStructure(NeedUndo: Boolean);
//#UC START# *4E45166B0156_49E487A70144_var*
//#UC END# *4E45166B0156_49E487A70144_var*
begin
//#UC START# *4E45166B0156_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E45166B0156_49E487A70144_impl*
end;//Tk2TagFilter.DoCloseStructure

procedure Tk2TagFilter.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_49E487A70144_var*
//#UC END# *4A2D1217037A_49E487A70144_var*
begin
//#UC START# *4A2D1217037A_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A2D1217037A_49E487A70144_impl*
end;//Tk2TagFilter.DoStartChild

procedure Tk2TagFilter.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_49E487A70144_var*
//#UC END# *4A2D1634025B_49E487A70144_var*
begin
//#UC START# *4A2D1634025B_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A2D1634025B_49E487A70144_impl*
end;//Tk2TagFilter.DoAddAtomEx

function Tk2TagFilter.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_49E487A70144_var*
//#UC END# *4CA3006302BC_49E487A70144_var*
begin
//#UC START# *4CA3006302BC_49E487A70144_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CA3006302BC_49E487A70144_impl*
end;//Tk2TagFilter.NeedTranslateChildToNext

end.
