{$IfNDef DeletingRowCorrector_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\DeletingRowCorrector.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "DeletingRowCorrector" MUID: (5108E8A403B9)
// Имя типа: "_DeletingRowCorrector_"

{$Define DeletingRowCorrector_imp}

{$If Defined(k2ForEditor)}
 _DeletingRowCorrector_ = class(_DeletingRowCorrector_Parent_)
  protected
   procedure CheckRow(const aCheckingRow: InevPara;
    const anOpPack: InevOp);
 end;//_DeletingRowCorrector_

{$Else Defined(k2ForEditor)}

_DeletingRowCorrector_ = _DeletingRowCorrector_Parent_;

{$IfEnd} // Defined(k2ForEditor)
{$Else DeletingRowCorrector_imp}

{$IfNDef DeletingRowCorrector_imp_impl}

{$Define DeletingRowCorrector_imp_impl}

{$If Defined(k2ForEditor)}
procedure _DeletingRowCorrector_.CheckRow(const aCheckingRow: InevPara;
 const anOpPack: InevOp);
//#UC START# *5108E8D80063_5108E8A403B9_var*

  function lp_CheckCell(aCell: Tl3Variant; Index: LongInt): Boolean;
  var
   l_Cell: InevTableCell;
  begin
   Result := True;
   if TevMergeStatus(aCell.IntA[k2_tiMergeStatus]) = ev_msContinue then
   begin
    aCell.QT(InevTableCell, l_Cell);
    if l_Cell.GetContinueCell(True, fc_Down) = nil then
     l_Cell.AsObject.IntW[k2_tiMergeStatus, anOpPack] := Ord(ev_msNone)
    else
     l_Cell.AsObject.IntW[k2_tiMergeStatus, anOpPack] := Ord(ev_msHead);
    evInsertPara(anOpPack, l_Cell.MakePoint, Tk2Type(aCell.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject);
   end; // if TevMergeStatus(aCell.IntA[k2_tiMergeStatus]) = ev_msContinue then
  end;

//#UC END# *5108E8D80063_5108E8A403B9_var*
begin
//#UC START# *5108E8D80063_5108E8A403B9_impl*
 aCheckingRow.AsObject.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckCell));
 aCheckingRow.Invalidate([nev_spExtent]);
//#UC END# *5108E8D80063_5108E8A403B9_impl*
end;//_DeletingRowCorrector_.CheckRow
{$IfEnd} // Defined(k2ForEditor)

{$EndIf DeletingRowCorrector_imp_impl}

{$EndIf DeletingRowCorrector_imp}

