unit TNewSubDlgWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Dialogs"
// ������: "w:/archi/source/projects/Common/Dialogs/TNewSubDlgWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$common::Dialogs::Dialogs::TNewSubDlgWordsPack
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
  d_edMSub,
  tfwRegisterableWord
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
 TkwPopNewSubDlgFake = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� pop:NewSubDlg:Fake
*������:*
[code]
 aNewSubDlg pop:NewSubDlg:Fake
[code]  }
 private
 // private methods
   procedure Fake(const aCtx: TtfwContext;
    aNewSubDlg: TNewSubDlg);
     {* ���������� ����� ������� pop:NewSubDlg:Fake }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwPopNewSubDlgFake

// start class TkwPopNewSubDlgFake

procedure TkwPopNewSubDlgFake.Fake(const aCtx: TtfwContext;
  aNewSubDlg: TNewSubDlg);
//#UC START# *BEDAA2A137B4_744BF601F735_var*
//#UC END# *BEDAA2A137B4_744BF601F735_var*
begin
//#UC START# *BEDAA2A137B4_744BF601F735_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *BEDAA2A137B4_744BF601F735_impl*
end;//TkwPopNewSubDlgFake.Fake

procedure TkwPopNewSubDlgFake.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNewSubDlg : TNewSubDlg;
begin
 try
  l_aNewSubDlg := TNewSubDlg(aCtx.rEngine.PopObjAs(TNewSubDlg));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewSubDlg: TNewSubDlg : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aNewSubDlg);
end;//TkwPopNewSubDlgFake.DoDoIt

class function TkwPopNewSubDlgFake.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:NewSubDlg:Fake';
end;//TkwPopNewSubDlgFake.GetWordNameForRegister

function TkwPopNewSubDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopNewSubDlgFake.GetResultTypeInfo
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_NewSubDlg_Fake
 TkwPopNewSubDlgFake.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TNewSubDlg
 TtfwTypeRegistrator.RegisterType(TypeInfo(TNewSubDlg));
{$IfEnd} //not NoScripts

end.