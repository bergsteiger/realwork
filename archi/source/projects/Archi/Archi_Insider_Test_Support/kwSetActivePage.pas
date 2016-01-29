unit kwSetActivePage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwSetActivePage.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwSetActivePage
//
// *������:* ID_������� ����_���������:�������_��_�������
// *��������:* ������ �������� ������� � ������� ID_�������.
// *����������:*
// ��������� � �������� ������� ��������� � �����:
// {code}
// w:\archi\source\projects\Archi\TestSet\Dictionary\ArchiControls.script"
// {code}
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
 TkwSetActivePage = {scriptword} class(TtfwRegisterableWord)
  {* *������:* ID_������� ����_���������:�������_��_�������
*��������:* ������ �������� ������� � ������� ID_�������.
*����������:*
 ��������� � �������� ������� ��������� � �����:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\ArchiControls.script"
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSetActivePage
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwSetActivePage

procedure TkwSetActivePage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EAFC7190370_var*
//#UC END# *4DAEEDE10285_4EAFC7190370_var*
begin
//#UC START# *4DAEEDE10285_4EAFC7190370_impl*
 if aCtx.rEngine.IsTopInt then
  AcSetActivePage(aCtx.rEngine.PopInt)
 else
  Assert(False, '�� ����� ����� �������!');
//#UC END# *4DAEEDE10285_4EAFC7190370_impl*
end;//TkwSetActivePage.DoDoIt

class function TkwSetActivePage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '����_���������:�������_��_�������';
end;//TkwSetActivePage.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwSetActivePage
 TkwSetActivePage.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.