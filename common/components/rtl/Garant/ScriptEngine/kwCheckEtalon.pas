unit kwCheckEtalon;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCheckEtalon.pas"
// ���������: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCheckEtalon = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCheckEtalon
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwCheckEtalon.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DD547B70001_var*
var
 l_H : AnsiString;
 l_S : AnsiString;
 l_Delim : AnsiChar;
//#UC END# *4DAEEDE10285_4DD547B70001_var*
begin
//#UC START# *4DAEEDE10285_4DD547B70001_impl*
 l_H := aCtx.rEngine.PopDelphiString;
 if (Length(l_H) > 0) then
  l_Delim := l_H[1]
 else
  l_Delim := #0; 
 l_S := aCtx.rCaller.ResolveOutputFilePath(aCtx.rEngine.PopDelphiString);
 RunnerAssert(Length(l_S) > 0, '��� ����� �� ����� ���� ������', aCtx);
 aCtx.rCaller.CheckWithEtalon(l_S, l_Delim);
//#UC END# *4DAEEDE10285_4DD547B70001_impl*
end;//TkwCheckEtalon.DoDoIt

class function TkwCheckEtalon.GetWordNameForRegister: AnsiString;
begin
 Result := 'tests:CheckEtalon';
end;//TkwCheckEtalon.GetWordNameForRegister

initialization
 TkwCheckEtalon.RegisterInEngine;
 {* ����������� CheckEtalon }
{$IfEnd} // NOT Defined(NoScripts)

end.
