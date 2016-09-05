unit evTableFilter;
 {* Удаляет из ячеек-продолжений дочерние параграфы. }

// Модуль: "w:\common\components\gui\Garant\Everest\evTableFilter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTableFilter" MUID: (4E48B5AE01E3)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , evdTypes
 , k2Base
 , l3Variant
;

type
 TevTableFilter = class(TevdCustomChildBufferedFilter)
  {* Удаляет из ячеек-продолжений дочерние параграфы. }
  private
   f_MergeStatus: TevMergeStatus;
  protected
   procedure DoStartChild(TypeID: Tk2Type); override;
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   function NeedStartBuffering(aID: Integer): Boolean; override;
   function NeedFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer): Boolean; override;
   procedure DoCloseStructure(NeedUndo: Boolean); override;
 end;//TevTableFilter

implementation

uses
 l3ImplUses
 , TableCell_Const
 , TableRow_Const
 , k2Tags
 //#UC START# *4E48B5AE01E3impl_uses*
 //#UC END# *4E48B5AE01E3impl_uses*
;

procedure TevTableFilter.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_4E48B5AE01E3_var*
//#UC END# *4A2D1217037A_4E48B5AE01E3_var*
begin
//#UC START# *4A2D1217037A_4E48B5AE01E3_impl*
 if (TypeID = k2_typTableCell) or (TypeID = k2_typTableRow) then
  f_MergeStatus := ev_msNone;
 inherited;
//#UC END# *4A2D1217037A_4E48B5AE01E3_impl*
end;//TevTableFilter.DoStartChild

procedure TevTableFilter.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4E48B5AE01E3_var*
//#UC END# *4A2D1634025B_4E48B5AE01E3_var*
begin
//#UC START# *4A2D1634025B_4E48B5AE01E3_impl*
 if AtomIndex = k2_tiMergeStatus then
  f_MergeStatus := TevMergeStatus(VariantAsInteger(AtomIndex, Value));
 inherited;
//#UC END# *4A2D1634025B_4E48B5AE01E3_impl*
end;//TevTableFilter.DoAddAtomEx

function TevTableFilter.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_4E48B5AE01E3_var*
//#UC END# *4C56D54B002A_4E48B5AE01E3_var*
begin
//#UC START# *4C56D54B002A_4E48B5AE01E3_impl*
 Result := (aID < 0) AND TypeTable.TypeByHandle[-aID].IsKindOf(ChildTypeForFiltering);
 if Result then
  Result := f_MergeStatus = ev_msContinue;
//#UC END# *4C56D54B002A_4E48B5AE01E3_impl*
end;//TevTableFilter.NeedStartBuffering

function TevTableFilter.NeedFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer): Boolean;
//#UC START# *4CF7BC520161_4E48B5AE01E3_var*
//#UC END# *4CF7BC520161_4E48B5AE01E3_var*
begin
//#UC START# *4CF7BC520161_4E48B5AE01E3_impl*
 Result := not NeedStartBuffering(aTagId);
//#UC END# *4CF7BC520161_4E48B5AE01E3_impl*
end;//TevTableFilter.NeedFlushBuffer

procedure TevTableFilter.DoCloseStructure(NeedUndo: Boolean);
//#UC START# *4E45166B0156_4E48B5AE01E3_var*
//#UC END# *4E45166B0156_4E48B5AE01E3_var*
begin
//#UC START# *4E45166B0156_4E48B5AE01E3_impl*
 if CurrentType.IsKindOf(k2_typTableCell) then
  f_MergeStatus := ev_msNone;
 inherited;
//#UC END# *4E45166B0156_4E48B5AE01E3_impl*
end;//TevTableFilter.DoCloseStructure

end.
