unit TSpellCheckDlgWordsPack;

// ������: "w:\archi\source\projects\Common\Dialogs\TSpellCheckDlgWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include arCommon.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , D_spell
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopSpellCheckDlgFake = {final} class(TtfwClassLike)
  {* ����� ������� pop:SpellCheckDlg:Fake
*������:*
[code]
 aSpellCheckDlg pop:SpellCheckDlg:Fake
[code]  }
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
//#UC START# *66B7B716E7E4_B3D7A1E7CA69_var*
//#UC END# *66B7B716E7E4_B3D7A1E7CA69_var*
begin
//#UC START# *66B7B716E7E4_B3D7A1E7CA69_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *66B7B716E7E4_B3D7A1E7CA69_impl*
end;//TkwPopSpellCheckDlgFake.Fake

procedure TkwPopSpellCheckDlgFake.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B3D7A1E7CA69_var*
//#UC END# *4DAEEDE10285_B3D7A1E7CA69_var*
begin
//#UC START# *4DAEEDE10285_B3D7A1E7CA69_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B3D7A1E7CA69_impl*
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
//#UC START# *5617F4D00243_B3D7A1E7CA69_var*
//#UC END# *5617F4D00243_B3D7A1E7CA69_var*
begin
//#UC START# *5617F4D00243_B3D7A1E7CA69_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B3D7A1E7CA69_impl*
end;//TkwPopSpellCheckDlgFake.ParamsTypes

initialization
 TkwPopSpellCheckDlgFake.RegisterInEngine;
 {* ����������� pop_SpellCheckDlg_Fake }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSpellCheckDlg));
 {* ����������� ���� TSpellCheckDlg }
{$IfEnd} // NOT Defined(NoScripts)

end.
