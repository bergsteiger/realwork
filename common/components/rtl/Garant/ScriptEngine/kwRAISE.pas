unit kwRAISE;
 {* ����������������� ����� RAISE. ���������� raise �� Delphi. ���� �� ���� ����������, �� ������������ EtfwScriptException.
������:
[code]
TRY
 '�������� ����������' RAISE
EXCEPT
 true >>> WasException
END
[code] }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwRAISE.pas"
// ���������: "ScriptKeyword"
// ������� ������: "RAISE" MUID: (4DBAE64F02F7)
// ��� ����: "TkwRAISE"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwRAISE = class(TtfwRegisterableWord)
  {* ����������������� ����� RAISE. ���������� raise �� Delphi. ���� �� ���� ����������, �� ������������ EtfwScriptException.
������:
[code]
TRY
 '�������� ����������' RAISE
EXCEPT
 true >>> WasException
END
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwRAISE
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *4DBAE64F02F7impl_uses*
 //#UC END# *4DBAE64F02F7impl_uses*
;

class function TkwRAISE.GetWordNameForRegister: AnsiString;
begin
 Result := 'RAISE';
end;//TkwRAISE.GetWordNameForRegister

procedure TkwRAISE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBAE64F02F7_var*
type
 RException = class of Exception;
//#UC END# *4DAEEDE10285_4DBAE64F02F7_var*
begin
//#UC START# *4DAEEDE10285_4DBAE64F02F7_impl*
 if (aCtx.rException <> nil) then
  raise RException(aCtx.rException.ClassType).Create(aCtx.rException.Message)
 else
  raise EtfwScriptException.Create(aCtx.rEngine.PopDelphiString);
//#UC END# *4DAEEDE10285_4DBAE64F02F7_impl*
end;//TkwRAISE.DoDoIt

initialization
 TkwRAISE.RegisterInEngine;
 {* ����������� RAISE }
{$IfEnd} // NOT Defined(NoScripts)

end.
