unit kwMouseGetCursorNameByIndex;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorNameByIndex.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMouseGetCursorNameByIndex = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseGetCursorNameByIndex
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwMouseGetCursorNameByIndex.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EF09324028B_var*
{$IfNDef NoVCL}
var
 l_CursorIndex: TCursor;
{$EndIf NoVCL}
//#UC END# *4DAEEDE10285_4EF09324028B_var*
begin
//#UC START# *4DAEEDE10285_4EF09324028B_impl*
 {$IfNDef NoVCL}
 l_CursorIndex := aCtx.rEngine.PopInt;
 aCtx.rEngine.PushString(Controls.CursorToString(l_CursorIndex));
 {$Else  NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *4DAEEDE10285_4EF09324028B_impl*
end;//TkwMouseGetCursorNameByIndex.DoDoIt

class function TkwMouseGetCursorNameByIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'mouse:GetCursorNameByIndex';
end;//TkwMouseGetCursorNameByIndex.GetWordNameForRegister

initialization
 TkwMouseGetCursorNameByIndex.RegisterInEngine;
 {* Регистрация mouse_GetCursorNameByIndex }
{$IfEnd} // NOT Defined(NoScripts)

end.
