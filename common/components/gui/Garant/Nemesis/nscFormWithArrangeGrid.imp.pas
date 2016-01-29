{$IfNDef nscFormWithArrangeGrid_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscFormWithArrangeGrid.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi For F1::Nemesis::Grid::nscFormWithArrangeGrid
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nscFormWithArrangeGrid_imp}
{$If defined(Nemesis)}
 _nscFormWithArrangeGrid_ = {mixin} class(_nscFormWithArrangeGrid_Parent_)
 private
 // private fields
   f_Grid : InscArrangeGrid;
   f_ArrangeCount : Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   {$If defined(l3HackedVCL) AND not defined(NoVCL)}
   function NeedAutoScroll: Boolean; override;
   {$IfEnd} //l3HackedVCL AND not NoVCL
 protected
 // protected methods
   procedure BuildGrid;
     {* Сигнатура метода BuildGrid }
   procedure ArrangeGrid;
     {* Сигнатура метода ArrangeGrid }
   procedure RecalcGrid;
     {* Сигнатура метода RecalcGrid }
   function GridParentControl: TWinControl; virtual; abstract;
   function DoBuildGrid: InscArrangeGrid; virtual; abstract;
   procedure DoRecalcGrid(const aGrid: InscArrangeGrid); virtual; abstract;
   procedure GridSizeChanged(aSender: TObject);
   procedure GridParentControlResize(aSender: TObject); virtual;
 end;//_nscFormWithArrangeGrid_
{$Else}

 _nscFormWithArrangeGrid_ = _nscFormWithArrangeGrid_Parent_;

{$IfEnd} //Nemesis

{$Else nscFormWithArrangeGrid_imp}

{$If defined(Nemesis)}

type
  THackControl = class(TControl)
  end;//THackControl

// start class _nscFormWithArrangeGrid_

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
//#UC START# *479731C50290_530495650309_var*
//#UC END# *479731C50290_530495650309_var*
begin
//#UC START# *479731C50290_530495650309_impl*
 f_Grid := nil;
 inherited;
//#UC END# *479731C50290_530495650309_impl*
end;//_nscFormWithArrangeGrid_.Cleanup

{$If defined(l3HackedVCL) AND not defined(NoVCL)}
function _nscFormWithArrangeGrid_.NeedAutoScroll: Boolean;
//#UC START# *4B0E845502C1_530495650309_var*
//#UC END# *4B0E845502C1_530495650309_var*
begin
//#UC START# *4B0E845502C1_530495650309_impl*
 Result := False;
//#UC END# *4B0E845502C1_530495650309_impl*
end;//_nscFormWithArrangeGrid_.NeedAutoScroll
{$IfEnd} //l3HackedVCL AND not NoVCL

{$IfEnd} //Nemesis

{$EndIf nscFormWithArrangeGrid_imp}
