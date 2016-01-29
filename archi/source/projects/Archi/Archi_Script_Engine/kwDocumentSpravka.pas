unit kwDocumentSpravka;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Script Engine"
// ������: "w:/archi/source/projects/Archi/Archi_Script_Engine/kwDocumentSpravka.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$ScriptEngine::Archi Script Engine::ScriptEngine::TkwDocumentSpravka
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

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

type
 TkwDocumentSpravka = {scriptword} class(TtfwRegisterableWord)
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
 end;//TkwDocumentSpravka

implementation

uses
  SysUtils
  {$If defined(AppClientSide)}
  ,
  Main
  {$IfEnd} //AppClientSide
  
  {$If defined(AppClientSide)}
  ,
  Editwin
  {$IfEnd} //AppClientSide
  
  ;

// start class TkwDocumentSpravka

{$If not defined(NoScripts)}
procedure TkwDocumentSpravka.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E5C937F00B2_var*
//#UC END# *4DAEEDE10285_4E5C937F00B2_var*
begin
//#UC START# *4DAEEDE10285_4E5C937F00B2_impl*
 if (MainForm.ActiveMDIChild is TDocEditorWindow) then
  (MainForm.ActiveMDIChild as TDocEditorWindow).acPageSprv.Execute;
//#UC END# *4DAEEDE10285_4E5C937F00B2_impl*
end;//TkwDocumentSpravka.DoDoIt
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function TkwDocumentSpravka.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '��::��������_�������_�_���������';
end;//TkwDocumentSpravka.GetWordNameForRegister
{$IfEnd} //not NoScripts

initialization
// ����������� TkwDocumentSpravka
 TkwDocumentSpravka.RegisterInEngine;

end.