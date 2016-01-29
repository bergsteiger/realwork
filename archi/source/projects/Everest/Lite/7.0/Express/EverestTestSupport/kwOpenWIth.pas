unit kwOpenWith;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestTestSupport"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/kwOpenWith.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::OpenWith
//
// *������:*  OpenWith aFileName
// *��������:* �������� �������� � ������ aFileName � ����� ���� ���������.
// *������:*
// {code}
// OpenWith 'MyEvd.doc'
// {code}
// *���������:* ����� ������ ����� �������� � ������ ����� 'MyEvd.doc'
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
 TkwOpenWith = {final scriptword} class(TtfwRegisterableWord)
  {* *������:*  OpenWith aFileName
*��������:* �������� �������� � ������ aFileName � ����� ���� ���������.
 *������:*
 [code]
OpenWith 'MyEvd.doc'
 [code]
 *���������:* ����� ������ ����� �������� � ������ ����� 'MyEvd.doc' }
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
 end;//TkwOpenWith
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  EverestLiteAdapter,
  SysUtils
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TkwOpenWith

{$If not defined(NoScripts)}
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
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function TkwOpenWith.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'OpenWith';
end;//TkwOpenWith.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$IfEnd} //InsiderTest AND nsTest

initialization
{$If defined(InsiderTest) AND defined(nsTest)}
// ����������� OpenWith
 TkwOpenWith.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest

end.