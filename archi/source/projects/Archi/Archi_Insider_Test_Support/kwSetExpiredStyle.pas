unit kwSetExpiredStyle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwSetExpiredStyle.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwSetExpiredStyle
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
 TkwSetExpiredStyle = {scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSetExpiredStyle
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwSetExpiredStyle

procedure TkwSetExpiredStyle.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F22AFC0008A_var*
//#UC END# *4DAEEDE10285_4F22AFC0008A_var*
begin
//#UC START# *4DAEEDE10285_4F22AFC0008A_impl*
 if aCtx.rEngine.IsTopInt then
  aCtx.rEngine.PopInt
 else
  Assert(False, '�� ������ �������� StyleID');
//#UC END# *4DAEEDE10285_4F22AFC0008A_impl*
end;//TkwSetExpiredStyle.DoDoIt

class function TkwSetExpiredStyle.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '����_���������:SetExpiredStyle';
end;//TkwSetExpiredStyle.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwSetExpiredStyle
 TkwSetExpiredStyle.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.