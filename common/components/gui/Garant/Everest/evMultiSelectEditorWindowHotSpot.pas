unit evMultiSelectEditorWindowHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evMultiSelectEditorWindowHotSpot.pas"
// Начат: 19.01.2004 18:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevMultiSelectEditorWindowHotSpot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evEditorWindowHotSpot,
  evMultiSelection,
  nevTools
  ;

type
 TevMultiSelectEditorWindowHotSpot = class(TevEditorWindowHotSpot)
 private
 // private fields
   f_MultiSelection : TevMultiSelection;
    {* если иннициализировано, то находимся в процессе множественного выделения}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DoLButtonDown(const aView: InevControlView;
    const aKeys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; override;
   procedure AlignMarks(const aView: InevControlView;
    const aKeys: TevMouseState); override;
     {* "выравнивает" StartMark и FinishMark - например на границу слова }
   procedure DoExtendBlock(const aView: InevControlView;
    const aSelection: InevSelection); override;
     {* устанавливает StartMark и FinishMark в выделение }
   function DoLButtonUp(const aView: InevControlView;
    const aKeys: TevMouseState;
    aNeedUnselect: Boolean): Boolean; override;
     {* обрабатывает отпускание левой кнопки мыши }
 end;//TevMultiSelectEditorWindowHotSpot

implementation

uses
  l3Base,
  afwInterfaces,
  Classes
  ;

// start class TevMultiSelectEditorWindowHotSpot

procedure TevMultiSelectEditorWindowHotSpot.Cleanup;
//#UC START# *479731C50290_48E497E40042_var*
//#UC END# *479731C50290_48E497E40042_var*
begin
//#UC START# *479731C50290_48E497E40042_impl*
 l3Free(f_MultiSelection);
 inherited;
//#UC END# *479731C50290_48E497E40042_impl*
end;//TevMultiSelectEditorWindowHotSpot.Cleanup

function TevMultiSelectEditorWindowHotSpot.DoLButtonDown(const aView: InevControlView;
  const aKeys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E4A99D02A2_48E497E40042_var*
var
 l_Op              : InevOp;
 l_Sel             : Tl3Base;
 l_NeedUnselect    : Boolean;
 //l_CursorBefore    : InevBasePoint;
//#UC END# *48E4A99D02A2_48E497E40042_var*
begin
//#UC START# *48E4A99D02A2_48E497E40042_impl*
 if not TryDragDrop(aKeys) then
 begin
  l_Op := BeginMouseOp(aView, l_Sel);
  try
   if (l_Sel is TevMultiSelection) then
   begin
    (*if TevMultiSelection(l_Sel).Collapsed then
     l_CursorBefore := TevMultiSelection(l_Sel).Cursor.ClonePoint(aView)
    else
     l_CursorBefore := TevMultiSelection(l_Sel).StartMark.ClonePoint(aView);
    try*)
     TranslatePt(aView, aKeys);
     l3Set(f_MultiSelection, TevMultiSelection(l_Sel));
     //Effect.rExtendingSelection := ([ssCtrl, ssShift, ssAlt] * aKeys.rKeys) = [ssShift];
     l_NeedUnselect := not Effect.rExtendingSelection;
     if f_MultiSelection.Persistent xor (ssCtrl in aKeys.rKeys) then
      l_NeedUnselect := false;
     f_MultiSelection.SelectionStart(l_NeedUnselect);
     (*if Effect.rExtendingSelection then
      ClickCursor.M.AssignPoint(aView, l_CursorBefore);*)
     Result := true;
     Exit;
    (*finally
     l_CursorBefore := nil;
    end;//try..finally*)
   end;//l_Sel is TevMultiSelection
   Result := inherited DoLButtonDown(aView, aKeys, Effect);
  finally
   l3Free(l_Sel);
   l_Op := nil;
  end;//try..finally
 end//not TryDragDrop(aPt)
 else
  Result := False;
//#UC END# *48E4A99D02A2_48E497E40042_impl*
end;//TevMultiSelectEditorWindowHotSpot.DoLButtonDown

procedure TevMultiSelectEditorWindowHotSpot.AlignMarks(const aView: InevControlView;
  const aKeys: TevMouseState);
//#UC START# *48EF380C026E_48E497E40042_var*
//#UC END# *48EF380C026E_48E497E40042_var*
begin
//#UC START# *48EF380C026E_48E497E40042_impl*
 if not Assigned(f_MultiSelection) OR (aKeys.rInitialClick <> afw_ckSingle) then
  inherited;
//#UC END# *48EF380C026E_48E497E40042_impl*
end;//TevMultiSelectEditorWindowHotSpot.AlignMarks

procedure TevMultiSelectEditorWindowHotSpot.DoExtendBlock(const aView: InevControlView;
  const aSelection: InevSelection);
//#UC START# *48EF3A860139_48E497E40042_var*
var
 l_Op  : InevOp;
 l_Sel : Tl3Base;
//#UC END# *48EF3A860139_48E497E40042_var*
begin
//#UC START# *48EF3A860139_48E497E40042_impl*
 if (f_MultiSelection = nil) then
 begin
  l_Op := BeginMouseOp(aView, l_Sel);
  try
   l3Set(f_MultiSelection, TevMultiSelection(l_Sel));
   f_MultiSelection.SelectionStart(false);
  finally
   l3Free(l_Sel);
   l_Op := nil;
  end;//try..finally
 end//f_MultiSelection = nil
 else
  f_MultiSelection.SelectionProcess(StartMark, FinishMark);
 inherited DoExtendBlock(aView, aSelection);
//#UC END# *48EF3A860139_48E497E40042_impl*
end;//TevMultiSelectEditorWindowHotSpot.DoExtendBlock

function TevMultiSelectEditorWindowHotSpot.DoLButtonUp(const aView: InevControlView;
  const aKeys: TevMouseState;
  aNeedUnselect: Boolean): Boolean;
//#UC START# *48EF3C6E0276_48E497E40042_var*
//#UC END# *48EF3C6E0276_48E497E40042_var*
begin
//#UC START# *48EF3C6E0276_48E497E40042_impl*
 if Assigned(f_MultiSelection) then
 begin
  aNeedUnselect := false;
  try
   //TranslatePt(aView, aPt); // - это не надо, иначе гиперссылки отваливаются
   f_MultiSelection.SelectionFinish(StartMark, FinishMark, aNeedUnselect);
  finally
   l3Free(f_MultiSelection);
  end;//try..finally
 end;//f_InMultiSelect
 Result := inherited DoLButtonUp(aView, aKeys, aNeedUnselect);
//#UC END# *48EF3C6E0276_48E497E40042_impl*
end;//TevMultiSelectEditorWindowHotSpot.DoLButtonUp

end.