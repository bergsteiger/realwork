unit kwKey;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// �����: ����� �.�.
// ������: "kwKey.pas"
// �����: 22.04.2011 19:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::KeyBoardInput::Key
//
// ������� �� ������ ����������.
// ������:
// {code}
// : "������" STRING IN aString
// aString key
// ;
// {code}
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCL

{$If not defined(NoScripts) AND not defined(NoVCL)}
type
 TkwKey = {scriptword} class(TtfwRegisterableWord)
  {* ������� �� ������ ����������.
������:
[code]
: "������" STRING IN aString
 aString key
;
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwKey
{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  Windows,
  Menus,
  Classes,
  Messages,
  l3MessagesService
  ;
{$IfEnd} //not NoScripts AND not NoVCL

{$If not defined(NoScripts) AND not defined(NoVCL)}

// start class TkwKey

procedure TkwKey.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB1A01E01F4_var*
{$IfNDef NoVCL}
type
 TSS = ssShift..ssDouble;
const
 cMap : array [TSS] of Integer = (VK_Shift, VK_MENU, VK_Control,
                                  0, 0, 0, 0);
var
 l_SC : TShortCut;
 l_K  : Word;
 l_Shift: TShiftState;
 l_ShiftToCheck: TShiftState;
 l_H    : THandle;
 l_KeyState: TKeyboardState;
 l_NewKeyState: TKeyboardState;
 I : Integer;
 l_SS : TSS;
 l_AltOnly : Boolean;
 l_Alt : Boolean;
{$EndIf  NoVCL}
//#UC END# *4DAEEDE10285_4DB1A01E01F4_var*
begin
//#UC START# *4DAEEDE10285_4DB1A01E01F4_impl*
 {$IfNDef NoVCL}
 l_H := GetFocus;
 l_SC := TextToShortCut(aCtx.rEngine.PopDelphiString);
 RunnerAssert(l_SC <> 0, '', aCtx);
 ShortCutToKey(l_SC, l_K, l_Shift);
 l_ShiftToCheck := l_Shift;
 l_AltOnly := false;
 l_Alt := false;
// l_AltOnly := [ssAlt] = l_ShiftToCheck;
 l_Alt := ssAlt in l_ShiftToCheck;
 GetKeyboardState(l_KeyState);
 try
  for I := Low(l_NewKeyState) to High(l_NewKeyState) do
   l_NewKeyState[I] := 0;
  for l_SS := Low(l_SS) to High(l_SS) do
  begin
   if (l_SS in l_Shift) then
   begin
    if (cMap[l_SS] <> 0) then
    begin
     l_ShiftToCheck := l_ShiftToCheck - [l_SS];
     l_NewKeyState[cMap[l_SS]] := $81;
     SetKeyboardState(l_NewKeyState);
     if (cMap[l_SS] = vk_Menu) then
     begin
      //PostMessage(l_H, WM_KEYDOWN, cMap[l_SS], $20380001);
     end//cMap[l_SS] = vk_Menu
     else
      PostMessage(l_H, WM_KEYDOWN, cMap[l_SS], $1510001);
     Tl3MessagesService.Instance.ProcessMessages;
    end;//cMap[l_SS] <> 0
   end;//l_SS in l_Shift
  end;//for l_SS
  RunnerAssert(l_ShiftToCheck = [], '', aCtx);
  l_NewKeyState[l_K] := $81;
  SetKeyboardState(l_NewKeyState);
  if l_AltOnly then
  begin
   SendMessage(l_H, WM_SYSCHAR, l_K, 0);
  end//l_AltOnly
  else
  begin
   if l_Alt then
    PostMessage(l_H, WM_SYSKEYDOWN, l_K, $20170001)
   else
    PostMessage(l_H, WM_KEYDOWN, l_K, $1510001);
   Tl3MessagesService.Instance.ProcessMessages;
   if l_Alt then
    PostMessage(l_H, WM_SYSKEYUP, l_K, $E0170001)
   else
    PostMessage(l_H, WM_KEYUP, l_K, $1510001);
   Tl3MessagesService.Instance.ProcessMessages;
  end;//l_AltOnly
  for l_SS := Low(l_SS) to High(l_SS) do
  begin
   if (l_SS in l_Shift) then
   begin
    if (cMap[l_SS] <> 0) then
    begin
     if (cMap[l_SS] = vk_Menu) then
     begin
      //PostMessage(l_H, WM_KEYUP, cMap[l_SS], $C0380001);
     end//cMap[l_SS] = vk_Menu
     else
      PostMessage(l_H, WM_KEYUP, cMap[l_SS], $1510001);
     Tl3MessagesService.Instance.ProcessMessages;
    end;//cMap[l_SS] <> 0
   end;//l_SS in l_Shift
  end;//for l_SS
 finally
  SetKeyboardState(l_KeyState);
 end;//try..finally
(* keybd_event(l_K, 0, 0, 0); { Key down }
 keybd_event(l_K, 0, KEYEVENTF_KEYUP, 0);*)
 //aCtx.rEngine.PushInt(l_K);
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *4DAEEDE10285_4DB1A01E01F4_impl*
end;//TkwKey.DoDoIt

class function TkwKey.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'key';
end;//TkwKey.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� Key
 TkwKey.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL

end.