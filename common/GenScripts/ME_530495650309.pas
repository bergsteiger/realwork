{$IfNDef nscFormWithArrangeGrid_imp}

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscFormWithArrangeGrid.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nscFormWithArrangeGrid" MUID: (530495650309)
// Имя типа: "_nscFormWithArrangeGrid_"

{$Define nscFormWithArrangeGrid_imp}

{$If Defined(Nemesis)}
 _nscFormWithArrangeGrid_ = class(_nscFormWithArrangeGrid_Parent_)
  private
   f_Grid: InscArrangeGrid;
   f_ArrangeCount: Integer;
  protected
   procedure BuildGrid;
   procedure ArrangeGrid;
   procedure RecalcGrid;
   function GridParentControl: TWinControl; virtual; abstract;
   function DoBuildGrid: InscArrangeGrid; virtual; abstract;
   procedure DoRecalcGrid(const aGrid: InscArrangeGrid); virtual; abstract;
   procedure GridSizeChanged(aSender: TObject);
   procedure GridParentControlResize(aSender: TObject); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   {$If Defined(l3HackedVCL) AND NOT Defined(NoVCL)}
   function NeedAutoScroll: Boolean; override;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL)
 end;//_nscFormWithArrangeGrid_

{$Else Defined(Nemesis)}

_nscFormWithArrangeGrid_ = _nscFormWithArrangeGrid_Parent_;

{$IfEnd} // Defined(Nemesis)
{$Else nscFormWithArrangeGrid_imp}

{$IfNDef nscFormWithArrangeGrid_imp_impl}

{$Define nscFormWithArrangeGrid_imp_impl}

{$If Defined(Nemesis)}
type
 THackControl = class(TControl)
 end;//THackControl

procedure _nscFormWithArrangeGrid_.BuildGrid;
//#UC START# *5304958A00B1_530495650309_var*
//#UC END# *5304958A00B1_530495650309_var*
begin
//#UC START# *5304958A00B1_530495650309_impl*
 f_Grid := nil;
 f_Grid := DoBuildGrid;
 Assert(f_Grid <> nil);
 f_Grid.OnSizeChanged := GridSizeChanged;
 THackControl(GridParentControl).OnResize := GridParentControlResize;
 if f_Grid.TwoStageBuild then
  RecalcGrid;
//#UC END# *5304958A00B1_530495650309_impl*
end;//_nscFormWithArrangeGrid_.BuildGrid

procedure _nscFormWithArrangeGrid_.ArrangeGrid;
//#UC START# *530495F40209_530495650309_var*
//#UC END# *530495F40209_530495650309_var*
begin
//#UC START# *530495F40209_530495650309_impl*
 Inc(f_ArrangeCount);
 try
  if (f_ArrangeCount = 1) then
   agArrangeGrid(f_Grid, Self, GridParentControl, 0);
 finally
  Dec(f_ArrangeCount);
 end;//try..finally
//#UC END# *530495F40209_530495650309_impl*
end;//_nscFormWithArrangeGrid_.ArrangeGrid

procedure _nscFormWithArrangeGrid_.RecalcGrid;
//#UC START# *5304960402E1_530495650309_var*
//#UC END# *5304960402E1_530495650309_var*
begin
//#UC START# *5304960402E1_530495650309_impl*
 if (f_Grid <> nil) then
 begin
  DoRecalcGrid(f_Grid);
  ArrangeGrid;
 end;//f_Grid <> nil
//#UC END# *5304960402E1_530495650309_impl*
end;//_nscFormWithArrangeGrid_.RecalcGrid

procedure _nscFormWithArrangeGrid_.GridSizeChanged(aSender: TObject);
//#UC START# *5304AC3C01D4_530495650309_var*
//#UC END# *5304AC3C01D4_530495650309_var*
begin
//#UC START# *5304AC3C01D4_530495650309_impl*
 ArrangeGrid;
//#UC END# *5304AC3C01D4_530495650309_impl*
end;//_nscFormWithArrangeGrid_.GridSizeChanged

procedure _nscFormWithArrangeGrid_.GridParentControlResize(aSender: TObject);
//#UC START# *5305A79C02E4_530495650309_var*
//#UC END# *5305A79C02E4_530495650309_var*
begin
//#UC START# *5305A79C02E4_530495650309_impl*
 RecalcGrid;
 ArrangeGrid;
//#UC END# *5305A79C02E4_530495650309_impl*
end;//_nscFormWithArrangeGrid_.GridParentControlResize

procedure _nscFormWithArrangeGrid_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_530495650309_var*
//#UC END# *479731C50290_530495650309_var*
begin
//#UC START# *479731C50290_530495650309_impl*
 f_Grid := nil;
 inherited;
//#UC END# *479731C50290_530495650309_impl*
end;//_nscFormWithArrangeGrid_.Cleanup

{$If Defined(l3HackedVCL) AND NOT Defined(NoVCL)}
function _nscFormWithArrangeGrid_.NeedAutoScroll: Boolean;
//#UC START# *4B0E845502C1_530495650309_var*
//#UC END# *4B0E845502C1_530495650309_var*
begin
//#UC START# *4B0E845502C1_530495650309_impl*
 Result := False;
//#UC END# *4B0E845502C1_530495650309_impl*
end;//_nscFormWithArrangeGrid_.NeedAutoScroll
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL)

{$IfEnd} // Defined(Nemesis)
{$EndIf nscFormWithArrangeGrid_imp_impl}

{$EndIf nscFormWithArrangeGrid_imp}

