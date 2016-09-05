unit kwEndWaitPrint;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwEndWaitPrint.pas"
// ���������: "ScriptKeyword"
// ������� ������: "EndWait_Print" MUID: (4F72BA72006B)
// ��� ����: "TkwEndWaitPrint"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwEndWaitPrint = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwEndWaitPrint
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(InsiderTest)}
 , kwPrintDataSaver
 {$IfEnd} // Defined(InsiderTest)
 //#UC START# *4F72BA72006Bimpl_uses*
 //#UC END# *4F72BA72006Bimpl_uses*
;

class function TkwEndWaitPrint.GetWordNameForRegister: AnsiString;
begin
 Result := 'EndWait:Print';
end;//TkwEndWaitPrint.GetWordNameForRegister

procedure TkwEndWaitPrint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F72BA72006B_var*
//#UC END# *4DAEEDE10285_4F72BA72006B_var*
begin
//#UC START# *4DAEEDE10285_4F72BA72006B_impl*
 {$If defined(InsiderTest)}
 TkwPrintDataSaver.Instance.EndWatingToPrint;
 {$IfEnd}
//#UC END# *4DAEEDE10285_4F72BA72006B_impl*
end;//TkwEndWaitPrint.DoDoIt

initialization
 TkwEndWaitPrint.RegisterInEngine;
 {* ����������� EndWait_Print }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
