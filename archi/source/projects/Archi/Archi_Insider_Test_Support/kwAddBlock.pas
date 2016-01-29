unit kwAddBlock;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwAddBlock.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwAddBlock
//
// ����_���������:����������_����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwAddBlock = {scriptword} class(TtfwRegisterableWord)
  {* ����_���������:����������_���� }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwAddBlock
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwAddBlock

procedure TkwAddBlock.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EA94ED30365_var*
//#UC END# *4DAEEDE10285_4EA94ED30365_var*
begin
//#UC START# *4DAEEDE10285_4EA94ED30365_impl*
 ArAddBlock
//#UC END# *4DAEEDE10285_4EA94ED30365_impl*
end;//TkwAddBlock.DoDoIt

class function TkwAddBlock.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '����_���������:����������_����';
end;//TkwAddBlock.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwAddBlock
 TkwAddBlock.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.