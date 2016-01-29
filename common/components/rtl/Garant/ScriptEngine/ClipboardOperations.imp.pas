{$IfNDef ClipboardOperations_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "ClipboardOperations.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi::ScriptEngine$Everest::MixIns::ClipboardOperations
//
// ������� ��� ��������� ������ � ������� ������ (� ��� �������� ����� ������).
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ClipboardOperations_imp}
{$If not defined(NoScripts)}
 _ClipboardOperations_ = {mixin} class(_ClipboardOperations_Parent_)
  {* ������� ��� ��������� ������ � ������� ������ (� ��� �������� ����� ������). }
 public
 // public methods
   procedure CopyToClipboard(aText: TevCustomEditorWindow);
     {* ����������� ��������� � ����� ������ }
   procedure PasteFromClipboard(aText: TevCustomEditorWindow);
     {* �������� �� ������ ������ }
   procedure ClearClipboard;
     {* ������� ������ ������ (����� �� ���� ������ ������). }
   procedure CopyAndPaste2DocumentBottom(aText: TevCustomEditorWindow);
     {* ����������� ���������� � ��������� � ����� ���������. }
 end;//_ClipboardOperations_
{$Else}

 _ClipboardOperations_ = _ClipboardOperations_Parent_;

{$IfEnd} //not NoScripts

{$Else ClipboardOperations_imp}

{$If not defined(NoScripts)}

// start class _ClipboardOperations_

procedure _ClipboardOperations_.CopyToClipboard(aText: TevCustomEditorWindow);
//#UC START# *4CE134D20213_4CE1344403AC_var*
//#UC END# *4CE134D20213_4CE1344403AC_var*
begin
//#UC START# *4CE134D20213_4CE1344403AC_impl*
 aText.Copy;
//#UC END# *4CE134D20213_4CE1344403AC_impl*
end;//_ClipboardOperations_.CopyToClipboard

procedure _ClipboardOperations_.PasteFromClipboard(aText: TevCustomEditorWindow);
//#UC START# *4CE135070353_4CE1344403AC_var*
//#UC END# *4CE135070353_4CE1344403AC_var*
begin
//#UC START# *4CE135070353_4CE1344403AC_impl*
 aText.Paste;
//#UC END# *4CE135070353_4CE1344403AC_impl*
end;//_ClipboardOperations_.PasteFromClipboard

procedure _ClipboardOperations_.ClearClipboard;
//#UC START# *4CE1357800B5_4CE1344403AC_var*
//#UC END# *4CE1357800B5_4CE1344403AC_var*
begin
//#UC START# *4CE1357800B5_4CE1344403AC_impl*
 l3System.ClearClipboard;
//#UC END# *4CE1357800B5_4CE1344403AC_impl*
end;//_ClipboardOperations_.ClearClipboard

procedure _ClipboardOperations_.CopyAndPaste2DocumentBottom(aText: TevCustomEditorWindow);
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

{$IfEnd} //not NoScripts

{$EndIf ClipboardOperations_imp}
