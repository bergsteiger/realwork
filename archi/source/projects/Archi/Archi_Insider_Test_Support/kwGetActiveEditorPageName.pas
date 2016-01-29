unit kwGetActiveEditorPageName;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwGetActiveEditorPageName.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwGetActiveEditorPageName
//
// *������:* main_form:GetActivePageName
// *��������:* �������� � ���� ����� �������� ������� � ���� �������������� ���������.
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
 TkwGetActiveEditorPageName = {scriptword} class(TtfwRegisterableWord)
  {* *������:* main_form:GetActivePageName
*��������:* �������� � ���� ����� �������� ������� � ���� �������������� ���������.
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
 end;//TkwGetActiveEditorPageName
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(AppClientSide)}
  ,
  Editwin
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  Main
  {$IfEnd} //AppClientSide
  
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwGetActiveEditorPageName

procedure TkwGetActiveEditorPageName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E60CB00004F_var*
//#UC END# *4DAEEDE10285_4E60CB00004F_var*
begin
//#UC START# *4DAEEDE10285_4E60CB00004F_impl*
 aCtx.rEngine.PushString((MainForm.ActiveMDIChild as TDocEditorWindow).nbkDocPages.ActivePageName);
//#UC END# *4DAEEDE10285_4E60CB00004F_impl*
end;//TkwGetActiveEditorPageName.DoDoIt

class function TkwGetActiveEditorPageName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'main_form:GetActivePageName';
end;//TkwGetActiveEditorPageName.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwGetActiveEditorPageName
 TkwGetActiveEditorPageName.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.