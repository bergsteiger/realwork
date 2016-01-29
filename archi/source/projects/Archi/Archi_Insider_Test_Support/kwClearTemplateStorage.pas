unit kwClearTemplateStorage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwClearTemplateStorage.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::ClearTemplateStorage
//
// ������� ������ ��� '���������� �������'
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwClearTemplateStorage = {final scriptword} class(TtfwRegisterableWord)
  {* ������� ������ ��� '���������� �������' }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearTemplateStorage
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwClearTemplateStorage

procedure TkwClearTemplateStorage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B647A9029B_var*
//#UC END# *4DAEEDE10285_53B647A9029B_var*
begin
//#UC START# *4DAEEDE10285_53B647A9029B_impl*
 ArClearTemplateStorage;
//#UC END# *4DAEEDE10285_53B647A9029B_impl*
end;//TkwClearTemplateStorage.DoDoIt

class function TkwClearTemplateStorage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ClearTemplateStorage';
end;//TkwClearTemplateStorage.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� ClearTemplateStorage
 TkwClearTemplateStorage.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.