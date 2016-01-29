unit kwGotoSub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwGotoSub.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwGotoSub
//
// ����_���������:�������_�_�����
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
 TkwGotoSub = {scriptword} class(TtfwRegisterableWord)
  {* ����_���������:�������_�_����� }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwGotoSub
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestsAdapter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwGotoSub

procedure TkwGotoSub.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EEF07E80201_var*
var
 l_Index: Integer;
//#UC END# *4DAEEDE10285_4EEF07E80201_var*
begin
//#UC START# *4DAEEDE10285_4EEF07E80201_impl*
 if aCtx.rEngine.IsTopInt then
  l_Index := aCtx.rEngine.PopInt
 else
  Assert(False, '�� ����� ����� �����!');
 ArGotoSub(l_Index);
//#UC END# *4DAEEDE10285_4EEF07E80201_impl*
end;//TkwGotoSub.DoDoIt

class function TkwGotoSub.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '����_���������:�������_�_�����';
end;//TkwGotoSub.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwGotoSub
 TkwGotoSub.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.