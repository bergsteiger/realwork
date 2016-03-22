unit kwShowMailMessage;
 {* ShowMailWindow }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwShowMailMessage.pas"
// ���������: "ScriptKeyword"
// ������� ������: "TkwShowMailMessage" MUID: (4F0C26900161)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwShowMailMessage = class(TtfwRegisterableWord)
  {* ShowMailWindow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwShowMailMessage
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwShowMailMessage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F0C26900161_var*
//#UC END# *4DAEEDE10285_4F0C26900161_var*
begin
//#UC START# *4DAEEDE10285_4F0C26900161_impl*
 if aCtx.rEngine.IsTopInt then
  ArShowMailWindow(aCtx.rEngine.PopInt)
 else
  Assert(False, '�� ����� ����� ��������� ���������.');
//#UC END# *4DAEEDE10285_4F0C26900161_impl*
end;//TkwShowMailMessage.DoDoIt

class function TkwShowMailMessage.GetWordNameForRegister: AnsiString;
begin
 Result := 'ShowMailWindow';
end;//TkwShowMailMessage.GetWordNameForRegister

initialization
 TkwShowMailMessage.RegisterInEngine;
 {* ����������� TkwShowMailMessage }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
