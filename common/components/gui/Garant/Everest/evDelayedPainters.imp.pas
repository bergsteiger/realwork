{$IfNDef evDelayedPainters_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/evDelayedPainters.imp.pas"
// Начат: 06.06.2007 11:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::ParaList Painters::evDelayedPainters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evDelayedPainters_imp}
{$If defined(evNeedPainters)}
 _evDelayedPainters_ = {mixin} class(_evDelayedPainters_Parent_, InevPaintersHolder)
 private
 // private fields
   f_SelectedList : TevSelectedParts;
    {* Список кусочков выделения}
   f_RowHeights : Tl3LongintList;
    {* Массив высот строк}
 private
 // private methods
   function GetRowHeights: Tl3LongintList;
 protected
 // realized methods
   procedure RemeberSelPart(const aChildMap: InevMap;
     aSelection: Boolean);
     {* Запомнить прямоугольник для отрисовки. }
   procedure SetHeight(aHeight: Integer);
 protected
 // protected methods
   procedure Release; override;
   procedure BeforeAddToCache; override;
 public
 // public methods
   procedure PaintSelectionParts;
 end;//_evDelayedPainters_
{$Else}

 _evDelayedPainters_ = _evDelayedPainters_Parent_;

{$IfEnd} //evNeedPainters

{$Else evDelayedPainters_imp}

{$If defined(evNeedPainters)}

// start class _evDelayedPainters_

function _evDelayedPainters_.GetRowHeights: Tl3LongintList;
//#UC START# *48C9294D0370_48C928EE0282_var*
//#UC END# *48C9294D0370_48C928EE0282_var*
begin
//#UC START# *48C9294D0370_48C928EE0282_impl*
 if f_RowHeights = nil then
  f_RowHeights := Tl3LongIntList.Make;
 Result := f_RowHeights;
//#UC END# *48C9294D0370_48C928EE0282_impl*
end;//_evDelayedPainters_.GetRowHeights

procedure _evDelayedPainters_.PaintSelectionParts;
//#UC START# *48C929A40284_48C928EE0282_var*

 function DrawSelItem(const Data: TevSelectedPart; Index: Integer): Boolean;
 begin
  Result := True;
  with Area.rCanvas do
  begin
   PushWO;
   try
    with Data do
    begin
     WindowOrg := Tl3Point(rWindowOrg);
     if rSelection then
      BeginInvert;
     FillEmptyRect(l3Rect(0, 0, rWidth, f_RowHeights[rRowIndex]));
     if rSelection then
      EndInvert;
    end;//with Data
   finally
    PopWO;
   end;//try..finally
  end;//with Area.rCanvas
 end;

//#UC END# *48C929A40284_48C928EE0282_var*
begin
//#UC START# *48C929A40284_48C928EE0282_impl*
 if f_SelectedList <> nil then
 begin
  f_SelectedList.IterateAllF(l3L2IA(@DrawSelItem));
  {$IFDEF nsTest}
  if TevDelayedPaintersSpy.Exists then
   TevDelayedPaintersSpy.Instance.LogSelections(f_SelectedList, f_RowHeights);
  {$ENDIF nsTest}
  f_SelectedList.Clear;
 end;
 if f_RowHeights <> nil then
  f_RowHeights.Clear;
//#UC END# *48C929A40284_48C928EE0282_impl*
end;//_evDelayedPainters_.PaintSelectionParts

procedure _evDelayedPainters_.Release;
//#UC START# *4A56234C0060_48C928EE0282_var*
//#UC END# *4A56234C0060_48C928EE0282_var*
begin
//#UC START# *4A56234C0060_48C928EE0282_impl*
 l3Free(f_SelectedList);
 l3Free(f_RowHeights);
 inherited;
//#UC END# *4A56234C0060_48C928EE0282_impl*
end;//_evDelayedPainters_.Release

procedure _evDelayedPainters_.BeforeAddToCache;
//#UC START# *4A56235D01C9_48C928EE0282_var*
//#UC END# *4A56235D01C9_48C928EE0282_var*
begin
//#UC START# *4A56235D01C9_48C928EE0282_impl*
 if (f_SelectedList <> nil) then
  f_SelectedList.Clear;
 if (f_RowHeights <> nil) then
  f_RowHeights.Clear;
 inherited;
//#UC END# *4A56235D01C9_48C928EE0282_impl*
end;//_evDelayedPainters_.BeforeAddToCache

procedure _evDelayedPainters_.RemeberSelPart(const aChildMap: InevMap;
  aSelection: Boolean);
//#UC START# *47C7DE3200E4_48C928EE0282_var*
var
 l_SelectItem: TevSelectedPart;
//#UC END# *47C7DE3200E4_48C928EE0282_var*
begin
//#UC START# *47C7DE3200E4_48C928EE0282_impl*
 with Area.rCanvas do
  if not IsVirtual then
   with aChildMap.Bounds do
   begin
    if f_SelectedList = nil then
     f_SelectedList := TevSelectedParts.Create;
    with l_SelectItem do
    begin
     rRowIndex := GetRowHeights.Count;
     rWidth := Right - Left;
     rWindowOrg := WindowOrg;
     rSelection := aSelection;
    end;//with l_SelectItem
    f_SelectedList.Add(l_SelectItem);
   end;//aChildMap.Bounds
//#UC END# *47C7DE3200E4_48C928EE0282_impl*
end;//_evDelayedPainters_.RemeberSelPart

procedure _evDelayedPainters_.SetHeight(aHeight: Integer);
//#UC START# *47C7DE42020F_48C928EE0282_var*
//#UC END# *47C7DE42020F_48C928EE0282_var*
begin
//#UC START# *47C7DE42020F_48C928EE0282_impl*
 if not Area.rCanvas.IsVirtual then
  GetRowHeights.Add(aHeight);
//#UC END# *47C7DE42020F_48C928EE0282_impl*
end;//_evDelayedPainters_.SetHeight

{$IfEnd} //evNeedPainters

{$EndIf evDelayedPainters_imp}
