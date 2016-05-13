unit kwOpen;
 {* *������:*  Open
*��������:* �������� �������� � ����������� .evd � ������ ����� � ����� ���� ���������.
 *������:*
 [code]
Open
 [code]
 *���������:* ����� ������ ����� �������� � ������ ����� � ����������� .evd }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwOpen.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Open" MUID: (512D9C56000B)
// ��� ����: "TkwOpen"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwOpen = {final} class(TtfwRegisterableWord)
  {* *������:*  Open
*��������:* �������� �������� � ����������� .evd � ������ ����� � ����� ���� ���������.
 *������:*
 [code]
Open
 [code]
 *���������:* ����� ������ ����� �������� � ������ ����� � ����������� .evd }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOpen
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
 , SysUtils
;

class function TkwOpen.GetWordNameForRegister: AnsiString;
begin
 Result := 'Open';
end;//TkwOpen.GetWordNameForRegister

procedure TkwOpen.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512D9C56000B_var*
var
 l_FileName: TFileName;
//#UC END# *4DAEEDE10285_512D9C56000B_var*
begin
//#UC START# *4DAEEDE10285_512D9C56000B_impl*
 l_FileName := ChangeFileExt(aCtx.rStreamFactory.Filename, '.evd');
 l_FileName := ExtractFileName(l_FileName);
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 Assert(FileExists(l_FileName), Format('���� �� ����������: %s', [l_FileName]));
 OpenDocument(l_FileName);
//#UC END# *4DAEEDE10285_512D9C56000B_impl*
end;//TkwOpen.DoDoIt

initialization
 TkwOpen.RegisterInEngine;
 {* ����������� Open }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
