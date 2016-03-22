{$IfNDef ClipboardOperations_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "ClipboardOperations" MUID: (4CE1344403AC)
// Имя типа: "_ClipboardOperations_"

{$Define ClipboardOperations_imp}

{$If NOT Defined(NoScripts)}
 _ClipboardOperations_ = class(_ClipboardOperations_Parent_)
  {* Примесь для поддержки работы с буфером обмена (с его очисткой после работы). }
  public
   procedure CopyToClipboard(aText: TevCustomEditorWindow);
    {* Скопировать выдленное в буфер обмена }
   procedure PasteFromClipboard(aText: TevCustomEditorWindow);
    {* Вставить из буфера обмена }
   procedure ClearClipboard;
    {* Очистка буфера обмена (чтобы не было утечек памяти). }
   procedure CopyAndPaste2DocumentBottom(aText: TevCustomEditorWindow);
    {* Скопировать выделенное и поместить в конец документа. }
 end;//_ClipboardOperations_

{$Else NOT Defined(NoScripts)}

_ClipboardOperations_ = _ClipboardOperations_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else ClipboardOperations_imp}

{$IfNDef ClipboardOperations_imp_impl}

{$Define ClipboardOperations_imp_impl}

{$If NOT Defined(NoScripts)}
procedure _ClipboardOperations_.CopyToClipboard(aText: TevCustomEditorWindow);
 {* Скопировать выдленное в буфер обмена }
//#UC START# *4CE134D20213_4CE1344403AC_var*
//#UC END# *4CE134D20213_4CE1344403AC_var*
begin
//#UC START# *4CE134D20213_4CE1344403AC_impl*
 aText.Copy;
//#UC END# *4CE134D20213_4CE1344403AC_impl*
end;//_ClipboardOperations_.CopyToClipboard

procedure _ClipboardOperations_.PasteFromClipboard(aText: TevCustomEditorWindow);
 {* Вставить из буфера обмена }
//#UC START# *4CE135070353_4CE1344403AC_var*
//#UC END# *4CE135070353_4CE1344403AC_var*
begin
//#UC START# *4CE135070353_4CE1344403AC_impl*
 aText.Paste;
//#UC END# *4CE135070353_4CE1344403AC_impl*
end;//_ClipboardOperations_.PasteFromClipboard

procedure _ClipboardOperations_.ClearClipboard;
 {* Очистка буфера обмена (чтобы не было утечек памяти). }
//#UC START# *4CE1357800B5_4CE1344403AC_var*
//#UC END# *4CE1357800B5_4CE1344403AC_var*
begin
//#UC START# *4CE1357800B5_4CE1344403AC_impl*
 l3System.ClearClipboard;
//#UC END# *4CE1357800B5_4CE1344403AC_impl*
end;//_ClipboardOperations_.ClearClipboard

procedure _ClipboardOperations_.CopyAndPaste2DocumentBottom(aText: TevCustomEditorWindow);
 {* Скопировать выделенное и поместить в конец документа. }
//#UC START# *4CEFC0D300F4_4CE1344403AC_var*
//#UC END# *4CEFC0D300F4_4CE1344403AC_var*
begin
//#UC START# *4CEFC0D300F4_4CE1344403AC_impl*
 CopyToClipboard(aText);
 Il3CommandTarget(aText).ProcessCommand(ev_ocBottomRight, true, 1);
 PasteFromClipboard(aText);
 ClearClipboard;
//#UC END# *4CEFC0D300F4_4CE1344403AC_impl*
end;//_ClipboardOperations_.CopyAndPaste2DocumentBottom
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf ClipboardOperations_imp_impl}

{$EndIf ClipboardOperations_imp}

