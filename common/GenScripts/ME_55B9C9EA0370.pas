unit evExpandedTextFilter;
 {* Фильтр "дорисовывающий" отступы для вложенных параграфов. }

// Модуль: "w:\common\components\gui\Garant\Everest\evExpandedTextFilter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3LongintList
 , l3Variant
;

type
 TevExpandedTextFilter = {final} class(Tk2TagFilter)
  {* Фильтр "дорисовывающий" отступы для вложенных параграфов. }
  private
   f_StyledSpace: Integer;
   f_StyleIDStack: Tl3LongintList;
   f_WasStyle: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure StartChild(TypeID: Tl3Type); override;
   procedure CloseStructure(NeedUndo: Boolean); override;
    {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevExpandedTextFilter

implementation

uses
 l3ImplUses
 , Block_Const
 , evdStyles
 , k2Tags
 , Document_Const
 , SysUtils
;

procedure TevExpandedTextFilter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55B9C9EA0370_var*
//#UC END# *479731C50290_55B9C9EA0370_var*
begin
//#UC START# *479731C50290_55B9C9EA0370_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_55B9C9EA0370_impl*
end;//TevExpandedTextFilter.Cleanup

procedure TevExpandedTextFilter.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_55B9C9EA0370_var*
//#UC END# *4836D4650177_55B9C9EA0370_var*
begin
//#UC START# *4836D4650177_55B9C9EA0370_impl*
 if TypeID = k2_typDocument then
 begin
  f_StyledSpace := 0;
  Assert(f_StyleIDStack = nil);
  f_StyleIDStack := Tl3LongintList.Crete;
 end; // if TypeID = k2_typDocument then
//  if TypeID = k2_typBlock then
//#UC END# *4836D4650177_55B9C9EA0370_impl*
end;//TevExpandedTextFilter.StartChild

procedure TevExpandedTextFilter.CloseStructure(NeedUndo: Boolean);
 {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
//#UC START# *4836D4C20059_55B9C9EA0370_var*
//#UC END# *4836D4C20059_55B9C9EA0370_var*
begin
//#UC START# *4836D4C20059_55B9C9EA0370_impl*

//#UC END# *4836D4C20059_55B9C9EA0370_impl*
end;//TevExpandedTextFilter.CloseStructure

procedure TevExpandedTextFilter.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_55B9C9EA0370_var*
//#UC END# *4836D52400D9_55B9C9EA0370_var*
begin
//#UC START# *4836D52400D9_55B9C9EA0370_impl*
 if (AtomIndex = k2_tiStyle) then
 begin
  if CurrentType = k2_typBlock then
  // Value.AsInteger

 end; // if f_CheckStyle and (AtomIndex = k2_tiStyle) and (Value.AsInteger = ev_saExpandedText) then
//#UC END# *4836D52400D9_55B9C9EA0370_impl*
end;//TevExpandedTextFilter.AddAtomEx

end.
