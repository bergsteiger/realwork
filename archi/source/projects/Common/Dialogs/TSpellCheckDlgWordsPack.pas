unit TSpellCheckDlgWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Dialogs"
// ������: "w:/archi/source/projects/Common/Dialogs/TSpellCheckDlgWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$common::Dialogs::Dialogs::TSpellCheckDlgWordsPack
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwRegisterableWord,
  D_spell
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopSpellCheckDlgFake = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� pop:SpellCheckDlg:Fake
*������:*
[code]
 aSpellCheckDlg pop:SpellCheckDlg:Fake
[code]  }
 private
 // private methods
   procedure Fake(const aCtx: TtfwContext;
    aSpellCheckDlg: TSpellCheckDlg);
     {* ���������� ����� ������� pop:SpellCheckDlg:Fake }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwPopSpellCheckDlgFake

// start class TkwPopSpellCheckDlgFake

procedure TkwPopSpellCheckDlgFake.Fake(const aCtx: TtfwContext;
  aSpellCheckDlg: TSpellCheckDlg);
//#UC START# *66B7B716E7E4_B3D7A1E7CA69_var*
//#UC END# *66B7B716E7E4_B3D7A1E7CA69_var*
begin
//#UC START# *66B7B716E7E4_B3D7A1E7CA69_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *66B7B716E7E4_B3D7A1E7CA69_impl*
end;//TkwPopSpellCheckDlgFake.Fake

procedure TkwPopSpellCheckDlgFake.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSpellCheckDlg : TSpellCheckDlg;
begin
 try
  l_aSpellCheckDlg := TSpellCheckDlg(aCtx.rEngine.PopObjAs(TSpellCheckDlg));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSpellCheckDlg: TSpellCheckDlg : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aSpellCheckDlg);
end;//TkwPopSpellCheckDlgFake.DoDoIt

class function TkwPopSpellCheckDlgFake.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:SpellCheckDlg:Fake';
end;//TkwPopSpellCheckDlgFake.GetWordNameForRegister

function TkwPopSpellCheckDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopSpellCheckDlgFake.GetResultTypeInfo
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_SpellCheckDlg_Fake
 TkwPopSpellCheckDlgFake.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TSpellCheckDlg
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSpellCheckDlg));
{$IfEnd} //not NoScripts

end.