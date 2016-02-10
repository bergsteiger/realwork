unit TTextSearchDlgWordsPack;

// ������: "w:\archi\source\projects\Common\Dialogs\TTextSearchDlgWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include arCommon.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , D_TxSrch
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
 TkwPopTextSearchDlgFake = {final} class(TtfwClassLike)
  {* ����� ������� pop:TextSearchDlg:Fake
[panel]���� ����� ����� ���� ��� ����, ����� ��������������� ������ � ���������� ������.[panel]
*������:*
[code]
 aTextSearchDlg pop:TextSearchDlg:Fake
[code]  }
  private
   procedure Fake(const aCtx: TtfwContext;
    aTextSearchDlg: TTextSearchDlg);
    {* ���������� ����� ������� pop:TextSearchDlg:Fake }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTextSearchDlgFake

procedure TkwPopTextSearchDlgFake.Fake(const aCtx: TtfwContext;
 aTextSearchDlg: TTextSearchDlg);
 {* ���������� ����� ������� pop:TextSearchDlg:Fake }
//#UC START# *29B068DE5F56_2975C5F7A803_var*
//#UC END# *29B068DE5F56_2975C5F7A803_var*
begin
//#UC START# *29B068DE5F56_2975C5F7A803_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *29B068DE5F56_2975C5F7A803_impl*
end;//TkwPopTextSearchDlgFake.Fake

procedure TkwPopTextSearchDlgFake.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2975C5F7A803_var*
//#UC END# *4DAEEDE10285_2975C5F7A803_var*
begin
//#UC START# *4DAEEDE10285_2975C5F7A803_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2975C5F7A803_impl*
end;//TkwPopTextSearchDlgFake.DoDoIt

class function TkwPopTextSearchDlgFake.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TextSearchDlg:Fake';
end;//TkwPopTextSearchDlgFake.GetWordNameForRegister

function TkwPopTextSearchDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopTextSearchDlgFake.GetResultTypeInfo

function TkwPopTextSearchDlgFake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTextSearchDlgFake.GetAllParamsCount

function TkwPopTextSearchDlgFake.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2975C5F7A803_var*
//#UC END# *5617F4D00243_2975C5F7A803_var*
begin
//#UC START# *5617F4D00243_2975C5F7A803_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2975C5F7A803_impl*
end;//TkwPopTextSearchDlgFake.ParamsTypes

initialization
 TkwPopTextSearchDlgFake.RegisterInEngine;
 {* ����������� pop_TextSearchDlg_Fake }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextSearchDlg));
 {* ����������� ���� TTextSearchDlg }
{$IfEnd} // NOT Defined(NoScripts)

end.
