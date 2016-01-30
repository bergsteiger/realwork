unit kwCreate;
 {* *������:*  Create
*��������:* ������� ����� �������� � ���������.
 *������:*
 [code]
Create
 [code]
 *���������:* ����� ������ ����� ��������. }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwCreate.pas"
// ���������: "ScriptKeyword"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCreate = {final} class(TtfwRegisterableWord)
  {* *������:*  Create
*��������:* ������� ����� �������� � ���������.
 *������:*
 [code]
Create
 [code]
 *���������:* ����� ������ ����� ��������. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCreate
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
;

procedure TkwCreate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512D9C2D013F_var*
//#UC END# *4DAEEDE10285_512D9C2D013F_var*
begin
//#UC START# *4DAEEDE10285_512D9C2D013F_impl*
 CreateNewDocument;
//#UC END# *4DAEEDE10285_512D9C2D013F_impl*
end;//TkwCreate.DoDoIt

class function TkwCreate.GetWordNameForRegister: AnsiString;
begin
 Result := 'Create';
end;//TkwCreate.GetWordNameForRegister

initialization
 TkwCreate.RegisterInEngine;
 {* ����������� Create }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
