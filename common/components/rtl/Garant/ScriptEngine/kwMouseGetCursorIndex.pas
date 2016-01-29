unit kwMouseGetCursorIndex;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// �����: �������� �.
// ������: "kwMouseGetCursorIndex.pas"
// �����: 16.12.2011
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::MouseInput::mouse_GetCursorIndex
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwMouseGetCursorIndex = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseGetCursorIndex
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Messages,
  Windows
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwMouseGetCursorIndex

procedure TkwMouseGetCursorIndex.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EEB67C500AE_var*
{$IfNDef NoVCL}
var
 l_CursorPos: TPoint;
 l_Window: THandle;
 l_HitTest: Longint;
 l_Index: TCursor;
 l_Cursor: HCURSOR;
{$EndIf  NoVCL}
//#UC END# *4DAEEDE10285_4EEB67C500AE_var*
begin
//#UC START# *4DAEEDE10285_4EEB67C500AE_impl*
 {$IfNDef NoVCL}
 GetCursorPos(l_CursorPos);
 l_Window := WindowFromPoint(l_CursorPos);
 l_HitTest := SendMessage(l_Window, WM_NCHITTEST, 0, LongInt(PointToSmallPoint(l_CursorPos)));
 SendMessage(l_Window, WM_SETCURSOR, l_Window, MakeLong(l_HitTest, WM_MOUSEMOVE));

 l_Cursor := Windows.GetCursor;
 for l_Index := crSizeAll to crDefault do
  if Forms.Screen.Cursors[l_Index] = l_Cursor then
  begin
   aCtx.rEngine.PushInt(Integer(l_Index));
   Exit;
  end;

 aCtx.rEngine.PushInt(Integer(crDefault));
 {$Else NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *4DAEEDE10285_4EEB67C500AE_impl*
end;//TkwMouseGetCursorIndex.DoDoIt

class function TkwMouseGetCursorIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'mouse:GetCursorIndex';
end;//TkwMouseGetCursorIndex.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� mouse_GetCursorIndex
 TkwMouseGetCursorIndex.RegisterInEngine;
{$IfEnd} //not NoScripts

end.