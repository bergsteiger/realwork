unit kwOpenWith;
 {* *������:*  OpenWith aFileName
*��������:* �������� �������� � ������ aFileName � ����� ���� ���������.
 *������:*
 [code]
OpenWith 'MyEvd.doc'
 [code]
 *���������:* ����� ������ ����� �������� � ������ ����� 'MyEvd.doc' }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwOpenWith.pas"
// ���������: "ScriptKeyword"
// ������� ������: "OpenWith" MUID: (5143073402A1)
// ��� ����: "TkwOpenWith"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwOpenWith = {final} class(TtfwRegisterableWord)
  {* *������:*  OpenWith aFileName
*��������:* �������� �������� � ������ aFileName � ����� ���� ���������.
 *������:*
 [code]
OpenWith 'MyEvd.doc'
 [code]
 *���������:* ����� ������ ����� �������� � ������ ����� 'MyEvd.doc' }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOpenWith
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
 , SysUtils
;

class function TkwOpenWith.GetWordNameForRegister: AnsiString;
begin
 Result := 'OpenWith';
end;//TkwOpenWith.GetWordNameForRegister

procedure TkwOpenWith.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5143073402A1_var*
var
 l_FileName: String;
//#UC END# *4DAEEDE10285_5143073402A1_var*
begin
//#UC START# *4DAEEDE10285_5143073402A1_impl*
 if aCtx.rEngine.IsTopString then
 begin
  l_FileName := aCtx.rEngine.PopDelphiString;
  l_FileName := ExtractFileName(l_FileName);
  l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
  Assert(FileExists(l_FileName), Format('���� �� ����������: %s', [l_FileName]));
  OpenDocument(l_FileName);
 end // if aCtx.rEngine.IsTopString then
 else
  Assert(False, '�� ������ ��� ����� ��� ��������!');
//#UC END# *4DAEEDE10285_5143073402A1_impl*
end;//TkwOpenWith.DoDoIt

initialization
 TkwOpenWith.RegisterInEngine;
 {* ����������� OpenWith }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
