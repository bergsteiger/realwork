unit kwCloseActiveWindow;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestTestSupport"
// ������: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestTestSupport/kwCloseActiveWindow.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$EverestLite$TestSupport::EverestTestSupport::EverestLiteKeyWords::CloseActiveWindow
//
// *������:*  CloseActiveWindow
// *��������:* ��������� ������� �������� ���� ���������.
// *������:*
// {code}
// CloseActiveWindow
// {code}
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
 TkwCloseActiveWindow = {final scriptword} class(TtfwRegisterableWord)
  {* *������:*  CloseActiveWindow
*��������:* ��������� ������� �������� ���� ���������.
 *������:*
 [code]
CloseActiveWindow
 [code] }
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
 end;//TkwCloseActiveWindow
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  EverestLiteAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TkwCloseActiveWindow

{$If not defined(NoScripts)}
procedure TkwCloseActiveWindow.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512DD1330118_var*
//#UC END# *4DAEEDE10285_512DD1330118_var*
begin
//#UC START# *4DAEEDE10285_512DD1330118_impl*
 CloseDocument;
//#UC END# *4DAEEDE10285_512DD1330118_impl*
end;//TkwCloseActiveWindow.DoDoIt
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function TkwCloseActiveWindow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CloseActiveWindow';
end;//TkwCloseActiveWindow.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$IfEnd} //InsiderTest AND nsTest

initialization
{$If defined(InsiderTest) AND defined(nsTest)}
// ����������� CloseActiveWindow
 TkwCloseActiveWindow.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest

end.