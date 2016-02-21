unit kwKeyWordsPack;

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\kwKeyWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\DUnit_Script_Support\dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , GUITestRunner
 , TestFrameWork
 , ComCtrls
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
 , tfwClassLike
 , tfwGlobalKeyWord
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
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *56D015564877publ*
 //#UC END# *56D015564877publ*
 end;//TkwKeyWordsPackResNameGetter

 TkwGUITestRunnerPushDUnitForm = {final} class(TtfwRegisterableWord)
  {* Слово скрипта GUITestRunner:push:DUnitForm
*Тип результата:* TGUITestRunner
*Пример:*
[code]
OBJECT VAR l_TGUITestRunner
 GUITestRunner:push:DUnitForm >>> l_TGUITestRunner
[code]  }
  private
   function push_DUnitForm(const aCtx: TtfwContext): TGUITestRunner;
    {* Реализация слова скрипта GUITestRunner:push:DUnitForm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGUITestRunnerPushDUnitForm

 TkwPopGUITestRunnerNodeToTest = {final} class(TtfwClassLike)
  {* Слово скрипта pop:GUITestRunner:NodeToTest
*Тип результата:* ITest
*Пример:*
[code]
INTERFACE VAR l_ITest
 aNode aGUITestRunner pop:GUITestRunner:NodeToTest >>> l_ITest
[code]  }
  private
   function NodeToTest(const aCtx: TtfwContext;
    aGUITestRunner: TGUITestRunner;
    aNode: TTreeNode): ITest;
    {* Реализация слова скрипта pop:GUITestRunner:NodeToTest }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopGUITestRunnerNodeToTest

 TkwDeleteEtalons = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DeleteEtalons
*Пример:*
[code]
 anIsScript aSubFolder aName DeleteEtalons
[code]  }
  private
   procedure DeleteEtalons(const aCtx: TtfwContext;
    const aName: AnsiString;
    const aSubFolder: AnsiString;
    anIsScript: Boolean);
    {* Реализация слова скрипта DeleteEtalons }
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
 {* Реализация слова скрипта GUITestRunner:push:DUnitForm }
//#UC START# *8CDAC59949AC_0200DD1E29D8_var*
//#UC END# *8CDAC59949AC_0200DD1E29D8_var*
begin
//#UC START# *8CDAC59949AC_0200DD1E29D8_impl*
 Result := TestForm4Scripts.GetTestForm;
//#UC END# *8CDAC59949AC_0200DD1E29D8_impl*
end;//TkwGUITestRunnerPushDUnitForm.push_DUnitForm

procedure TkwGUITestRunnerPushDUnitForm.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(push_DUnitForm(aCtx));
end;//TkwGUITestRunnerPushDUnitForm.DoDoIt

class function TkwGUITestRunnerPushDUnitForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'GUITestRunner:push:DUnitForm';
end;//TkwGUITestRunnerPushDUnitForm.GetWordNameForRegister

function TkwGUITestRunnerPushDUnitForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TGUITestRunner);
end;//TkwGUITestRunnerPushDUnitForm.GetResultTypeInfo

function TkwGUITestRunnerPushDUnitForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGUITestRunnerPushDUnitForm.GetAllParamsCount

function TkwGUITestRunnerPushDUnitForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TGUITestRunner)]);
end;//TkwGUITestRunnerPushDUnitForm.ParamsTypes

function TkwPopGUITestRunnerNodeToTest.NodeToTest(const aCtx: TtfwContext;
 aGUITestRunner: TGUITestRunner;
 aNode: TTreeNode): ITest;
 {* Реализация слова скрипта pop:GUITestRunner:NodeToTest }
//#UC START# *03113FE401D9_D7892D333B1E_var*
//#UC END# *03113FE401D9_D7892D333B1E_var*
begin
//#UC START# *03113FE401D9_D7892D333B1E_impl*
 Result := aGUITestRunner.NodeToTest(aNode)
//#UC END# *03113FE401D9_D7892D333B1E_impl*
end;//TkwPopGUITestRunnerNodeToTest.NodeToTest

procedure TkwPopGUITestRunnerNodeToTest.DoDoIt(const aCtx: TtfwContext);
var l_aGUITestRunner: TGUITestRunner;
var l_aNode: TTreeNode;
begin
 try
  l_aGUITestRunner := TGUITestRunner(aCtx.rEngine.PopObjAs(TGUITestRunner));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aGUITestRunner: TGUITestRunner : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(NodeToTest(aCtx, l_aGUITestRunner, l_aNode), TypeInfo(ITest));
end;//TkwPopGUITestRunnerNodeToTest.DoDoIt

class function TkwPopGUITestRunnerNodeToTest.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:GUITestRunner:NodeToTest';
end;//TkwPopGUITestRunnerNodeToTest.GetWordNameForRegister

function TkwPopGUITestRunnerNodeToTest.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ITest);
end;//TkwPopGUITestRunnerNodeToTest.GetResultTypeInfo

function TkwPopGUITestRunnerNodeToTest.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopGUITestRunnerNodeToTest.GetAllParamsCount

function TkwPopGUITestRunnerNodeToTest.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TGUITestRunner), TypeInfo(TTreeNode)]);
end;//TkwPopGUITestRunnerNodeToTest.ParamsTypes

procedure TkwDeleteEtalons.DeleteEtalons(const aCtx: TtfwContext;
 const aName: AnsiString;
 const aSubFolder: AnsiString;
 anIsScript: Boolean);
 {* Реализация слова скрипта DeleteEtalons }
//#UC START# *32E2191A0272_6F1D31444115_var*
//#UC END# *32E2191A0272_6F1D31444115_var*
begin
//#UC START# *32E2191A0272_6F1D31444115_impl*
 KTestRunner.DeleteEtalons(aName, aSubFolder, anIsScript);
//#UC END# *32E2191A0272_6F1D31444115_impl*
end;//TkwDeleteEtalons.DeleteEtalons

procedure TkwDeleteEtalons.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
var l_aSubFolder: AnsiString;
var l_anIsScript: Boolean;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubFolder := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubFolder: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIsScript := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIsScript: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DeleteEtalons(aCtx, l_aName, l_aSubFolder, l_anIsScript);
end;//TkwDeleteEtalons.DoDoIt

class function TkwDeleteEtalons.GetWordNameForRegister: AnsiString;
begin
 Result := 'DeleteEtalons';
end;//TkwDeleteEtalons.GetWordNameForRegister

function TkwDeleteEtalons.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDeleteEtalons.GetResultTypeInfo

function TkwDeleteEtalons.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwDeleteEtalons.GetAllParamsCount

function TkwDeleteEtalons.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, TypeInfo(Boolean)]);
end;//TkwDeleteEtalons.ParamsTypes

initialization
 TkwKeyWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwGUITestRunnerPushDUnitForm.RegisterInEngine;
 {* Регистрация GUITestRunner_push_DUnitForm }
 TkwPopGUITestRunnerNodeToTest.RegisterInEngine;
 {* Регистрация pop_GUITestRunner_NodeToTest }
 TkwDeleteEtalons.RegisterInEngine;
 {* Регистрация DeleteEtalons }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TGUITestRunner));
 {* Регистрация типа TGUITestRunner }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* Регистрация типа TTreeNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ITest));
 {* Регистрация типа ITest }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
