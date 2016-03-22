unit kwCheckOutputWithInput;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCheckOutputWithInput.pas"
// ���������: "ScriptKeyword"
// ������� ������: "CheckOutputWithInput" MUID: (4F5F490D030B)
// ��� ����: "TkwCheckOutputWithInput"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCheckOutputWithInput = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCheckOutputWithInput
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwCheckOutputWithInput.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F5F490D030B_var*
var
 l_H : AnsiString;
 l_In : AnsiString;
 l_Out : AnsiString;
 l_Delim : AnsiChar;
//#UC END# *4DAEEDE10285_4F5F490D030B_var*
begin
//#UC START# *4DAEEDE10285_4F5F490D030B_impl*
 l_H := aCtx.rEngine.PopDelphiString;
 if (Length(l_H) > 0) then
  l_Delim := l_H[1]
 else
  l_Delim := #0; 
 //l_S := aCtx.rCaller.ResolveOutputFilePath(aCtx.rEngine.PopDelphiString);
 l_Out := aCtx.rEngine.PopDelphiString;
 RunnerAssert(Length(l_Out) > 0, '��� ����� �� ����� ���� ������', aCtx);
 l_In := aCtx.rEngine.PopDelphiString;
 RunnerAssert(Length(l_In) > 0, '��� ����� �� ����� ���� ������', aCtx);
 aCtx.rCaller.CheckOutputWithInput(l_In, l_Out, l_Delim, false, false, '', true);
//#UC END# *4DAEEDE10285_4F5F490D030B_impl*
end;//TkwCheckOutputWithInput.DoDoIt

class function TkwCheckOutputWithInput.GetWordNameForRegister: AnsiString;
begin
 Result := 'tests:CheckOutputWithInput';
end;//TkwCheckOutputWithInput.GetWordNameForRegister

initialization
 TkwCheckOutputWithInput.RegisterInEngine;
 {* ����������� CheckOutputWithInput }
{$IfEnd} // NOT Defined(NoScripts)

end.
