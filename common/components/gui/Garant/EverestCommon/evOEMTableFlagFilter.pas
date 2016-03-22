unit evOEMTableFlagFilter;
 {* Фильтр выставления флага выливать в псевдографику таблицам. }

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evOEMTableFlagFilter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevOEMTableFlagFilter" MUID: (4C3FED3103B2)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
 , l3Variant
;

type
 TevOEMTableFlagFilter = class(Tk2TagFilter)
  {* Фильтр выставления флага выливать в псевдографику таблицам. }
  private
   f_NeedChange: Boolean;
    {* Признак нужно ли менять флаг. }
  protected
   procedure CloseStructure(NeedUndo: Boolean); override;
    {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
   procedure DoStartChild(TypeID: Tk2Type); override;
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevOEMTableFlagFilter

implementation

uses
 l3ImplUses
 , Table_Const
 , k2Tags
;

procedure TevOEMTableFlagFilter.CloseStructure(NeedUndo: Boolean);
 {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
//#UC START# *4836D4C20059_4C3FED3103B2_var*
//#UC END# *4836D4C20059_4C3FED3103B2_var*
begin
//#UC START# *4836D4C20059_4C3FED3103B2_impl*
 if CurrentType.IsKindOf(k2_typTable) then
 begin
  if f_NeedChange and (Generator <> nil) then
   Generator.AddBoolAtom(k2_tiOldNSRC, True);
 end; // if CurrentType.IsKindOf(k2_typTableCell) then
 inherited;
//#UC END# *4836D4C20059_4C3FED3103B2_impl*
end;//TevOEMTableFlagFilter.CloseStructure

procedure TevOEMTableFlagFilter.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_4C3FED3103B2_var*
//#UC END# *4A2D1217037A_4C3FED3103B2_var*
begin
//#UC START# *4A2D1217037A_4C3FED3103B2_impl*
 if (TypeID = k2_typTable) then
  f_NeedChange := True;
 inherited;
//#UC END# *4A2D1217037A_4C3FED3103B2_impl*
end;//TevOEMTableFlagFilter.DoStartChild

procedure TevOEMTableFlagFilter.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4C3FED3103B2_var*
//#UC END# *4A2D1634025B_4C3FED3103B2_var*
begin
//#UC START# *4A2D1634025B_4C3FED3103B2_impl*
 if CurrentType.IsKindOf(k2_typTable) and (AtomIndex = k2_tiOldNSRC) then
  if VariantAsInteger(AtomIndex, Value) = Ord(True) then
   f_NeedChange := False;
 inherited;
//#UC END# *4A2D1634025B_4C3FED3103B2_impl*
end;//TevOEMTableFlagFilter.DoAddAtomEx

end.
