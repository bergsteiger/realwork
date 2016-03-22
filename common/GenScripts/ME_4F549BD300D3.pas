{$IfNDef kwEditorGetTableFromCursor_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEditorGetTableFromCursor.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "kwEditorGetTableFromCursor" MUID: (4F549BD300D3)
// Имя типа: "_kwEditorGetTableFromCursor_"

{$Define kwEditorGetTableFromCursor_imp}

{$If NOT Defined(NoScripts)}
 _kwEditorGetTableFromCursor_ = {abstract} class(_kwEditorGetTableFromCursor_Parent_)
  protected
   function GetTablePoint(const aCtx: TtfwContext;
    const aCursorPoint: InevBasePoint): InevBasePoint;
 end;//_kwEditorGetTableFromCursor_

{$Else NOT Defined(NoScripts)}

_kwEditorGetTableFromCursor_ = _kwEditorGetTableFromCursor_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else kwEditorGetTableFromCursor_imp}

{$IfNDef kwEditorGetTableFromCursor_imp_impl}

{$Define kwEditorGetTableFromCursor_imp_impl}

{$If NOT Defined(NoScripts)}
function _kwEditorGetTableFromCursor_.GetTablePoint(const aCtx: TtfwContext;
 const aCursorPoint: InevBasePoint): InevBasePoint;
//#UC START# *4F549C0101F6_4F549BD300D3_var*
var
 l_TablePoint: InevBasePoint;
//#UC END# *4F549C0101F6_4F549BD300D3_var*
begin
//#UC START# *4F549C0101F6_4F549BD300D3_impl*
 Result := aCursorPoint;
 while Result <> nil do
 begin
  while (Result <> nil) and not Result.AsObject.IsKindOf(k2_typTable) do
   Result := Result.Inner;
  if Result <> nil then
  begin
   l_TablePoint := Result;
   Result := Result.Inner;
  end; // if Result <> nil then
 end; // while Result <> nil do
 Result := l_TablePoint;
 RunnerAssert(Result <> nil, 'Курсор не в таблице.', aCtx);
//#UC END# *4F549C0101F6_4F549BD300D3_impl*
end;//_kwEditorGetTableFromCursor_.GetTablePoint
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf kwEditorGetTableFromCursor_imp_impl}

{$EndIf kwEditorGetTableFromCursor_imp}

