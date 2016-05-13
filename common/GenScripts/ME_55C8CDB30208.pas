unit TSpellCheckDlgWordsPack;

// ������: "w:\archi\source\projects\Common\Dialogs\TSpellCheckDlgWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "TSpellCheckDlgWordsPack" MUID: (55C8CDB30208)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , D_spell
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopSpellCheckDlgFake = {final} class(TtfwClassLike)
  {* ����� ������� pop:SpellCheckDlg:Fake }
  private
   procedure Fake(const aCtx: TtfwContext;
    aSpellCheckDlg: TSpellCheckDlg);
    {* ���������� ����� ������� pop:SpellCheckDlg:Fake }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopSpellCheckDlgFake

procedure TkwPopSpellCheckDlgFake.Fake(const aCtx: TtfwContext;
 aSpellCheckDlg: TSpellCheckDlg);
 {* ���������� ����� ������� pop:SpellCheckDlg:Fake }
//#UC START# *55C8CE2102C9_B3D7A1E7CA69_var*
//#UC END# *55C8CE2102C9_B3D7A1E7CA69_var*
begin
//#UC START# *55C8CE2102C9_B3D7A1E7CA69_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *55C8CE2102C9_B3D7A1E7CA69_impl*
end;//TkwPopSpellCheckDlgFake.Fake

procedure TkwPopSpellCheckDlgFake.DoDoIt(const aCtx: TtfwContext);
var l_aSpellCheckDlg: TSpellCheckDlg;
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
begin
 Result := 'pop:SpellCheckDlg:Fake';
end;//TkwPopSpellCheckDlgFake.GetWordNameForRegister

function TkwPopSpellCheckDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopSpellCheckDlgFake.GetResultTypeInfo

function TkwPopSpellCheckDlgFake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopSpellCheckDlgFake.GetAllParamsCount

function TkwPopSpellCheckDlgFake.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSpellCheckDlg)]);
end;//TkwPopSpellCheckDlgFake.ParamsTypes

initialization
 TkwPopSpellCheckDlgFake.RegisterInEngine;
 {* ����������� pop_SpellCheckDlg_Fake }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSpellCheckDlg));
 {* ����������� ���� TSpellCheckDlg }
{$IfEnd} // NOT Defined(NoScripts)

end.
