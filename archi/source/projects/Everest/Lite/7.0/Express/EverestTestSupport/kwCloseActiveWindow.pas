unit kwCloseActiveWindow;
 {* *������:*  CloseActiveWindow
*��������:* ��������� ������� �������� ���� ���������.
 *������:*
 [code]
CloseActiveWindow
 [code] }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwCloseActiveWindow.pas"
// ���������: "ScriptKeyword"
// ������� ������: "CloseActiveWindow" MUID: (512DD1330118)
// ��� ����: "TkwCloseActiveWindow"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCloseActiveWindow = {final} class(TtfwRegisterableWord)
  {* *������:*  CloseActiveWindow
*��������:* ��������� ������� �������� ���� ���������.
 *������:*
 [code]
CloseActiveWindow
 [code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCloseActiveWindow
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
 //#UC START# *512DD1330118impl_uses*
 //#UC END# *512DD1330118impl_uses*
;

class function TkwCloseActiveWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'CloseActiveWindow';
end;//TkwCloseActiveWindow.GetWordNameForRegister

procedure TkwCloseActiveWindow.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512DD1330118_var*
//#UC END# *4DAEEDE10285_512DD1330118_var*
begin
//#UC START# *4DAEEDE10285_512DD1330118_impl*
 CloseDocument;
//#UC END# *4DAEEDE10285_512DD1330118_impl*
end;//TkwCloseActiveWindow.DoDoIt

initialization
 TkwCloseActiveWindow.RegisterInEngine;
 {* ����������� CloseActiveWindow }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
