unit kwKeyWordsPack;

// ������: "w:\common\components\rtl\Garant\DUnit_Script_Support\kwKeyWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , GUITestRunner
 , TestFrameWork
 , ComCtrls
 , tfwAxiomaticsResNameGetter
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
 , tfwClassLike
 , tfwGlobalKeyWord
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ITestWordsPack
 , TTreeNodeForTestsWordsPack
 , TestForm4Scripts
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *56D015564877ci*
 //#UC END# *56D015564877ci*
 //#UC START# *56D015564877cit*
 //#UC END# *56D015564877cit*
 TkwKeyWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *56D015564877publ*
 //#UC END# *56D015564877publ*
 end;//TkwKeyWordsPackResNameGetter

 TkwGUITestRunnerPushDUnitForm = {final} class(TtfwRegisterableWord)
  {* ����� ������� GUITestRunner:push:DUnitForm
*��� ����������:* TGUITestRunner
*������:*
[code]
OBJECT VAR l_TGUITestRunner
 GUITestRunner:push:DUnitForm >>> l_TGUITestRunner
[code]  }
  private
   function push_DUnitForm(const aCtx: TtfwContext): TGUITestRunner;
    {* ���������� ����� ������� GUITestRunner:push:DUnitForm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGUITestRunnerPushDUnitForm

 TkwPopGUITestRunnerNodeToTest = {final} class(TtfwClassLike)
  {* ����� ������� pop:GUITestRunner:NodeToTest
*��� ����������:* ITest
*������:*
[code]
INTERFACE VAR l_ITest
 aNode aGUITestRunner pop:GUITestRunner:NodeToTest >>> l_ITest
[code]  }
  private
   function NodeToTest(const aCtx: TtfwContext;
    aGUITestRunner: TGUITestRunner;
    aNode: TTreeNode): ITest;
    {* ���������� ����� ������� pop:GUITestRunner:NodeToTest }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopGUITestRunnerNodeToTest

 TkwDeleteEtalons = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� DeleteEtalons
*������:*
[code]
 anIsScript aSubFolder aName DeleteEtalons
[code]  }
  private
   procedure DeleteEtalons(const aCtx: TtfwContext;
    const aName: AnsiString;
    const aSubFolder: AnsiString;
    anIsScript: Boolean);
    {* ���������� ����� ������� DeleteEtalons }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDeleteEtalons

class function TkwKeyWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'kwKeyWordsPack';
end;//TkwKeyWordsPackResNameGetter.ResName

 {$R kwKeyWordsPack.res}

function TkwGUITestRunnerPushDUnitForm.push_DUnitForm(const aCtx: TtfwContext): TGUITestRunner;
 {* ���������� ����� ������� GUITestRunner:push:DUnitForm }
//#UC START# *8CDAC59949AC_0200DD1E29D8_var*
//#UC END# *8CDAC59949AC_0200DD1E29D8_var*
begin
//#UC START# *8CDAC59949AC_0200DD1E29D8_impl*
 Result := TestForm4Scripts.GetTestForm;
//#UC END# *8CDAC59949AC_0200DD1E29D8_impl*
end;//TkwGUITestRunnerPushDUnitForm.push_DUnitForm

procedure TkwGUITestRunnerPushDUnitForm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0200DD1E29D8_var*
//#UC END# *4DAEEDE10285_0200DD1E29D8_var*
begin
//#UC START# *4DAEEDE10285_0200DD1E29D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0200DD1E29D8_impl*
end;//TkwGUITestRunnerPushDUnitForm.DoDoIt

class function TkwGUITestRunnerPushDUnitForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'GUITestRunner:push:DUnitForm';
end;//TkwGUITestRunnerPushDUnitForm.GetWordNameForRegister

function TkwGUITestRunnerPushDUnitForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0200DD1E29D8_var*
//#UC END# *551544E2001A_0200DD1E29D8_var*
begin
//#UC START# *551544E2001A_0200DD1E29D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0200DD1E29D8_impl*
end;//TkwGUITestRunnerPushDUnitForm.GetResultTypeInfo

function TkwGUITestRunnerPushDUnitForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGUITestRunnerPushDUnitForm.GetAllParamsCount

function TkwGUITestRunnerPushDUnitForm.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0200DD1E29D8_var*
//#UC END# *5617F4D00243_0200DD1E29D8_var*
begin
//#UC START# *5617F4D00243_0200DD1E29D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0200DD1E29D8_impl*
end;//TkwGUITestRunnerPushDUnitForm.ParamsTypes

function TkwPopGUITestRunnerNodeToTest.NodeToTest(const aCtx: TtfwContext;
 aGUITestRunner: TGUITestRunner;
 aNode: TTreeNode): ITest;
 {* ���������� ����� ������� pop:GUITestRunner:NodeToTest }
//#UC START# *03113FE401D9_D7892D333B1E_var*
//#UC END# *03113FE401D9_D7892D333B1E_var*
begin
//#UC START# *03113FE401D9_D7892D333B1E_impl*
 Result := aGUITestRunner.NodeToTest(aNode)
//#UC END# *03113FE401D9_D7892D333B1E_impl*
end;//TkwPopGUITestRunnerNodeToTest.NodeToTest

procedure TkwPopGUITestRunnerNodeToTest.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D7892D333B1E_var*
//#UC END# *4DAEEDE10285_D7892D333B1E_var*
begin
//#UC START# *4DAEEDE10285_D7892D333B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D7892D333B1E_impl*
end;//TkwPopGUITestRunnerNodeToTest.DoDoIt

class function TkwPopGUITestRunnerNodeToTest.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:GUITestRunner:NodeToTest';
end;//TkwPopGUITestRunnerNodeToTest.GetWordNameForRegister

function TkwPopGUITestRunnerNodeToTest.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D7892D333B1E_var*
//#UC END# *551544E2001A_D7892D333B1E_var*
begin
//#UC START# *551544E2001A_D7892D333B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D7892D333B1E_impl*
end;//TkwPopGUITestRunnerNodeToTest.GetResultTypeInfo

function TkwPopGUITestRunnerNodeToTest.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopGUITestRunnerNodeToTest.GetAllParamsCount

function TkwPopGUITestRunnerNodeToTest.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D7892D333B1E_var*
//#UC END# *5617F4D00243_D7892D333B1E_var*
begin
//#UC START# *5617F4D00243_D7892D333B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D7892D333B1E_impl*
end;//TkwPopGUITestRunnerNodeToTest.ParamsTypes

procedure TkwDeleteEtalons.DeleteEtalons(const aCtx: TtfwContext;
 const aName: AnsiString;
 const aSubFolder: AnsiString;
 anIsScript: Boolean);
 {* ���������� ����� ������� DeleteEtalons }
//#UC START# *32E2191A0272_6F1D31444115_var*
//#UC END# *32E2191A0272_6F1D31444115_var*
begin
//#UC START# *32E2191A0272_6F1D31444115_impl*
 KTestRunner.DeleteEtalons(aName, aSubFolder, anIsScript);
//#UC END# *32E2191A0272_6F1D31444115_impl*
end;//TkwDeleteEtalons.DeleteEtalons

procedure TkwDeleteEtalons.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6F1D31444115_var*
//#UC END# *4DAEEDE10285_6F1D31444115_var*
begin
//#UC START# *4DAEEDE10285_6F1D31444115_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6F1D31444115_impl*
end;//TkwDeleteEtalons.DoDoIt

class function TkwDeleteEtalons.GetWordNameForRegister: AnsiString;
begin
 Result := 'DeleteEtalons';
end;//TkwDeleteEtalons.GetWordNameForRegister

function TkwDeleteEtalons.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6F1D31444115_var*
//#UC END# *551544E2001A_6F1D31444115_var*
begin
//#UC START# *551544E2001A_6F1D31444115_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6F1D31444115_impl*
end;//TkwDeleteEtalons.GetResultTypeInfo

function TkwDeleteEtalons.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwDeleteEtalons.GetAllParamsCount

function TkwDeleteEtalons.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6F1D31444115_var*
//#UC END# *5617F4D00243_6F1D31444115_var*
begin
//#UC START# *5617F4D00243_6F1D31444115_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6F1D31444115_impl*
end;//TkwDeleteEtalons.ParamsTypes

initialization
 TkwKeyWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwGUITestRunnerPushDUnitForm.RegisterInEngine;
 {* ����������� GUITestRunner_push_DUnitForm }
 TkwPopGUITestRunnerNodeToTest.RegisterInEngine;
 {* ����������� pop_GUITestRunner_NodeToTest }
 TkwDeleteEtalons.RegisterInEngine;
 {* ����������� DeleteEtalons }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TGUITestRunner));
 {* ����������� ���� TGUITestRunner }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* ����������� ���� TTreeNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ITest));
 {* ����������� ���� ITest }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
