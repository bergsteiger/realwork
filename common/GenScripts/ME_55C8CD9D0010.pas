unit TNewSubDlgWordsPack;

// ������: "w:\archi\source\projects\Common\Dialogs\TNewSubDlgWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include arCommon.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , d_edMSub
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
 TkwPopNewSubDlgFake = {final} class(TtfwClassLike)
  {* ����� ������� pop:NewSubDlg:Fake
*������:*
[code]
 aNewSubDlg pop:NewSubDlg:Fake
[code]  }
  private
   procedure Fake(const aCtx: TtfwContext;
    aNewSubDlg: TNewSubDlg);
    {* ���������� ����� ������� pop:NewSubDlg:Fake }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewSubDlgFake

procedure TkwPopNewSubDlgFake.Fake(const aCtx: TtfwContext;
 aNewSubDlg: TNewSubDlg);
 {* ���������� ����� ������� pop:NewSubDlg:Fake }
//#UC START# *BEDAA2A137B4_744BF601F735_var*
//#UC END# *BEDAA2A137B4_744BF601F735_var*
begin
//#UC START# *BEDAA2A137B4_744BF601F735_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *BEDAA2A137B4_744BF601F735_impl*
end;//TkwPopNewSubDlgFake.Fake

procedure TkwPopNewSubDlgFake.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_744BF601F735_var*
//#UC END# *4DAEEDE10285_744BF601F735_var*
begin
//#UC START# *4DAEEDE10285_744BF601F735_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_744BF601F735_impl*
end;//TkwPopNewSubDlgFake.DoDoIt

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
 Result := OpenTypesToTypes([]);
end;//TkwPopNewSubDlgFake.ParamsTypes

initialization
 TkwPopNewSubDlgFake.RegisterInEngine;
 {* ����������� pop_NewSubDlg_Fake }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TNewSubDlg));
 {* ����������� ���� TNewSubDlg }
{$IfEnd} // NOT Defined(NoScripts)

end.
