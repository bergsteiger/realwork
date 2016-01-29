unit kwOpen;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestTestSupport"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/kwOpen.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::Open
//
// *������:*  Open
// *��������:* �������� �������� � ����������� .evd � ������ ����� � ����� ���� ���������.
// *������:*
// {code}
// Open
// {code}
// *���������:* ����� ������ ����� �������� � ������ ����� � ����������� .evd
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  tfwRegisterableWord
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TkwOpen = {final scriptword} class(TtfwRegisterableWord)
  {* *������:*  Open
*��������:* �������� �������� � ����������� .evd � ������ ����� � ����� ���� ���������.
 *������:*
 [code]
Open
 [code]
 *���������:* ����� ������ ����� �������� � ������ ����� � ����������� .evd }
 protected
 // realized methods
    {$If not defined(NoScripts)}
   procedure DoDoIt(const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts
 protected
 // overridden protected methods
   {$If not defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} //not NoScripts
 end;//TkwOpen
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  EverestLiteAdapter,
  SysUtils
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TkwOpen

{$If not defined(NoScripts)}
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
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function TkwOpen.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Open';
end;//TkwOpen.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$IfEnd} //InsiderTest AND nsTest

initialization
{$If defined(InsiderTest) AND defined(nsTest)}
// ����������� Open
 TkwOpen.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest

end.