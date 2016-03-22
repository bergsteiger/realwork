unit kwDeleteSub;
 {* ����_���������:�������_��� }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDeleteSub.pas"
// ���������: "ScriptKeyword"
// ������� ������: "TkwDeleteSub" MUID: (4E01AD1F02CA)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDeleteSub = class(TtfwRegisterableWord)
  {* ����_���������:�������_��� }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDeleteSub
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

procedure TkwDeleteSub.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E01AD1F02CA_var*
//#UC END# *4DAEEDE10285_4E01AD1F02CA_var*
begin
//#UC START# *4DAEEDE10285_4E01AD1F02CA_impl*
 if aCtx.rEngine.IsTopInt then
  arDeleteSub(aCtx.rEngine.PopInt);
//#UC END# *4DAEEDE10285_4E01AD1F02CA_impl*
end;//TkwDeleteSub.DoDoIt

class function TkwDeleteSub.GetWordNameForRegister: AnsiString;
begin
 Result := '����_���������:�������_���';
end;//TkwDeleteSub.GetWordNameForRegister

initialization
 TkwDeleteSub.RegisterInEngine;
 {* ����������� TkwDeleteSub }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
