unit kwMouseGetCursorIndex;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorIndex.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "mouse_GetCursorIndex" MUID: (4EEB67C500AE)
// Имя типа: "TkwMouseGetCursorIndex"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMouseGetCursorIndex = class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwMouseGetCursorIndex
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Messages
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4EEB67C500AEimpl_uses*
 //#UC END# *4EEB67C500AEimpl_uses*
;

class function TkwMouseGetCursorIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'mouse:GetCursorIndex';
end;//TkwMouseGetCursorIndex.GetWordNameForRegister

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

initialization
 TkwMouseGetCursorIndex.RegisterInEngine;
 {* Регистрация mouse_GetCursorIndex }
{$IfEnd} // NOT Defined(NoScripts)

end.
