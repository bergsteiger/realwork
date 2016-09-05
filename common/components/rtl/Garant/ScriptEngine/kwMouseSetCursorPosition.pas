unit kwMouseSetCursorPosition;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseSetCursorPosition.pas"
// ���������: "ScriptKeyword"
// ������� ������: "mouse_SetCursorPosition" MUID: (4EF0939D025E)
// ��� ����: "TkwMouseSetCursorPosition"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMouseSetCursorPosition = class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwMouseSetCursorPosition
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 //#UC START# *4EF0939D025Eimpl_uses*
 //#UC END# *4EF0939D025Eimpl_uses*
;

class function TkwMouseSetCursorPosition.GetWordNameForRegister: AnsiString;
begin
 Result := 'mouse:SetCursorPosition';
end;//TkwMouseSetCursorPosition.GetWordNameForRegister

procedure TkwMouseSetCursorPosition.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EF0939D025E_var*
var
 X, Y: Integer;
//#UC END# *4DAEEDE10285_4EF0939D025E_var*
begin
//#UC START# *4DAEEDE10285_4EF0939D025E_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, '�� ������ ���������� ��� ����� mouse:SetCursorPosition', aCtx);
 Y := aCtx.rEngine.PopInt;
 RunnerAssert(aCtx.rEngine.IsTopInt, '�� ������ ���������� ��� ����� mouse:SetCursorPosition', aCtx);
 X := aCtx.rEngine.PopInt;
 Windows.SetCursorPos(X, Y);
//#UC END# *4DAEEDE10285_4EF0939D025E_impl*
end;//TkwMouseSetCursorPosition.DoDoIt

initialization
 TkwMouseSetCursorPosition.RegisterInEngine;
 {* ����������� mouse_SetCursorPosition }
{$IfEnd} // NOT Defined(NoScripts)

end.
