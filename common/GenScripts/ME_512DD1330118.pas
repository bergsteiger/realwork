unit kwCloseActiveWindow;
 {* *������:*  CloseActiveWindow
*��������:* ��������� ������� �������� ���� ���������.
 *������:*
 [code]
CloseActiveWindow
 [code] }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwCloseActiveWindow.pas"
// ���������: "ScriptKeyword"

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
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCloseActiveWindow
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
;

procedure TkwCloseActiveWindow.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512DD1330118_var*
//#UC END# *4DAEEDE10285_512DD1330118_var*
begin
//#UC START# *4DAEEDE10285_512DD1330118_impl*
 CloseDocument;
//#UC END# *4DAEEDE10285_512DD1330118_impl*
end;//TkwCloseActiveWindow.DoDoIt

class function TkwCloseActiveWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'CloseActiveWindow';
end;//TkwCloseActiveWindow.GetWordNameForRegister

initialization
 TkwCloseActiveWindow.RegisterInEngine;
 {* ����������� CloseActiveWindow }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
