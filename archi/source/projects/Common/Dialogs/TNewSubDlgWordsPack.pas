unit TNewSubDlgWordsPack;

// ������: "w:\archi\source\projects\Common\Dialogs\TNewSubDlgWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "TNewSubDlgWordsPack" MUID: (55C8CD9D0010)

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
 , d_edMSub
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopNewSubDlgFake = {final} class(TtfwClassLike)
  {* ����� ������� pop:NewSubDlg:Fake }
  private
   procedure Fake(const aCtx: TtfwContext;
    aNewSubDlg: TNewSubDlg);
    {* ���������� ����� ������� pop:NewSubDlg:Fake }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewSubDlgFake

procedure TkwPopNewSubDlgFake.Fake(const aCtx: TtfwContext;
 aNewSubDlg: TNewSubDlg);
 {* ���������� ����� ������� pop:NewSubDlg:Fake }
//#UC START# *55C8CE1E0042_55C8CE1E0042_4DFB50A6024F_Word_var*
//#UC END# *55C8CE1E0042_55C8CE1E0042_4DFB50A6024F_Word_var*
begin
//#UC START# *55C8CE1E0042_55C8CE1E0042_4DFB50A6024F_Word_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *55C8CE1E0042_55C8CE1E0042_4DFB50A6024F_Word_impl*
end;//TkwPopNewSubDlgFake.Fake

class function TkwPopNewSubDlgFake.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:NewSubDlg:Fake';
end;//TkwPopNewSubDlgFake.GetWordNameForRegister

function TkwPopNewSubDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopNewSubDlgFake.GetResultTypeInfo

function TkwPopNewSubDlgFake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopNewSubDlgFake.GetAllParamsCount

function TkwPopNewSubDlgFake.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewSubDlg)]);
end;//TkwPopNewSubDlgFake.ParamsTypes

procedure TkwPopNewSubDlgFake.DoDoIt(const aCtx: TtfwContext);
var l_aNewSubDlg: TNewSubDlg;
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

initialization
 TkwPopNewSubDlgFake.RegisterInEngine;
 {* ����������� pop_NewSubDlg_Fake }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TNewSubDlg));
 {* ����������� ���� TNewSubDlg }
{$IfEnd} // NOT Defined(NoScripts)

end.
