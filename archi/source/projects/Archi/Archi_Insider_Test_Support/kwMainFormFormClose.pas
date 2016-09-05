unit kwMainFormFormClose;
 {* ��������� ���������� FormClose ������� �����, �������� ����� ���������� ��� � �������� ���������.
������: 
[code]
MainForm:FormClose
[code] }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwMainFormFormClose.pas"
// ���������: "ScriptKeyword"
// ������� ������: "MainForm_FormClose" MUID: (53EB19070285)
// ��� ����: "TkwMainFormFormClose"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMainFormFormClose = {final} class(TtfwRegisterableWord)
  {* ��������� ���������� FormClose ������� �����, �������� ����� ���������� ��� � �������� ���������.
������: 
[code]
MainForm:FormClose
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwMainFormFormClose
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
 //#UC START# *53EB19070285impl_uses*
 //#UC END# *53EB19070285impl_uses*
;

class function TkwMainFormFormClose.GetWordNameForRegister: AnsiString;
begin
 Result := 'MainForm:FormClose';
end;//TkwMainFormFormClose.GetWordNameForRegister

procedure TkwMainFormFormClose.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53EB19070285_var*
//#UC END# *4DAEEDE10285_53EB19070285_var*
begin
//#UC START# *4DAEEDE10285_53EB19070285_impl*
 AcMainFormFormClose;
//#UC END# *4DAEEDE10285_53EB19070285_impl*
end;//TkwMainFormFormClose.DoDoIt

initialization
 TkwMainFormFormClose.RegisterInEngine;
 {* ����������� MainForm_FormClose }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
