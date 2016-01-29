unit kwKeyWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnit Script Support"
// Модуль: "w:/common/components/rtl/Garant/DUnit_Script_Support/kwKeyWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Testing Framework::DUnit Script Support::DUnit Keywords::kwKeyWordsPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnit_Script_Support\dsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
uses
  ComCtrls,
  GUITestRunner,
  TestFrameWork,
  tfwScriptingInterfaces,
  tfwRegisterableWord,
  tfwAxiomaticsResNameGetter,
  tfwClassLike,
  tfwGlobalKeyWord
  ;

{$IfEnd} //nsTest AND not NoScripts AND not NoVCL

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
uses
  ITestWordsPack,
  TTreeNodeForTestsWordsPack,
  TestForm4Scripts
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *56D015564877ci*
//#UC END# *56D015564877ci*
//#UC START# *56D015564877cit*
//#UC END# *56D015564877cit*
 TkwKeyWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *56D015564877publ*
//#UC END# *56D015564877publ*
 end;//TkwKeyWordsPackResNameGetter

// start class TkwKeyWordsPackResNameGetter

class function TkwKeyWordsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'kwKeyWordsPack';
end;//TkwKeyWordsPackResNameGetter.ResName

 {$R kwKeyWordsPack.res}

type
 TkwGUITestRunnerPushDUnitForm = {final scriptword} class(TtfwRegisterableWord)
  {* Слово скрипта GUITestRunner:push:DUnitForm
*Тип результата:* TGUITestRunner
*Пример:*
[code]
OBJECT VAR l_TGUITestRunner
 GUITestRunner:push:DUnitForm >>> l_TGUITestRunner
[code]  }
 private
 // private methods
   function PushDUnitForm(const aCtx: TtfwContext): TGUITestRunner;
     {* Реализация слова скрипта GUITestRunner:push:DUnitForm }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGUITestRunnerPushDUnitForm

// start class TkwGUITestRunnerPushDUnitForm

function TkwGUITestRunnerPushDUnitForm.PushDUnitForm(const aCtx: TtfwContext): TGUITestRunner;
//#UC START# *8CDAC59949AC_0200DD1E29D8_var*
//#UC END# *8CDAC59949AC_0200DD1E29D8_var*
begin
//#UC START# *8CDAC59949AC_0200DD1E29D8_impl*
 Result := TestForm4Scripts.GetTestForm;
//#UC END# *8CDAC59949AC_0200DD1E29D8_impl*
end;//TkwGUITestRunnerPushDUnitForm.PushDUnitForm

procedure TkwGUITestRunnerPushDUnitForm.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((PushDUnitForm(aCtx)));
end;//TkwGUITestRunnerPushDUnitForm.DoDoIt

class function TkwGUITestRunnerPushDUnitForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'GUITestRunner:push:DUnitForm';
end;//TkwGUITestRunnerPushDUnitForm.GetWordNameForRegister

function TkwGUITestRunnerPushDUnitForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TGUITestRunner);
end;//TkwGUITestRunnerPushDUnitForm.GetResultTypeInfo

function TkwGUITestRunnerPushDUnitForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwGUITestRunnerPushDUnitForm.GetAllParamsCount

function TkwGUITestRunnerPushDUnitForm.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwGUITestRunnerPushDUnitForm.ParamsTypes

type
 TkwPopGUITestRunnerNodeToTest = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:GUITestRunner:NodeToTest
*Тип результата:* ITest
*Пример:*
[code]
INTERFACE VAR l_ITest
 aNode aGUITestRunner pop:GUITestRunner:NodeToTest >>> l_ITest
[code]  }
 private
 // private methods
   function NodeToTest(const aCtx: TtfwContext;
    aGUITestRunner: TGUITestRunner;
    aNode: TTreeNode): ITest;
     {* Реализация слова скрипта pop:GUITestRunner:NodeToTest }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopGUITestRunnerNodeToTest

// start class TkwPopGUITestRunnerNodeToTest

function TkwPopGUITestRunnerNodeToTest.NodeToTest(const aCtx: TtfwContext;
  aGUITestRunner: TGUITestRunner;
  aNode: TTreeNode): ITest;
//#UC START# *03113FE401D9_D7892D333B1E_var*
//#UC END# *03113FE401D9_D7892D333B1E_var*
begin
//#UC START# *03113FE401D9_D7892D333B1E_impl*
 Result := aGUITestRunner.NodeToTest(aNode)
//#UC END# *03113FE401D9_D7892D333B1E_impl*
end;//TkwPopGUITestRunnerNodeToTest.NodeToTest

procedure TkwPopGUITestRunnerNodeToTest.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aGUITestRunner : TGUITestRunner;
 l_aNode : TTreeNode;
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
  l_aNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode, true));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf((NodeToTest(aCtx, l_aGUITestRunner, l_aNode)), TypeInfo(ITest));
end;//TkwPopGUITestRunnerNodeToTest.DoDoIt

class function TkwPopGUITestRunnerNodeToTest.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:GUITestRunner:NodeToTest';
end;//TkwPopGUITestRunnerNodeToTest.GetWordNameForRegister

function TkwPopGUITestRunnerNodeToTest.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ITest);
end;//TkwPopGUITestRunnerNodeToTest.GetResultTypeInfo

function TkwPopGUITestRunnerNodeToTest.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopGUITestRunnerNodeToTest.GetAllParamsCount

function TkwPopGUITestRunnerNodeToTest.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TGUITestRunner), TypeInfo(TTreeNode)]);
end;//TkwPopGUITestRunnerNodeToTest.ParamsTypes

type
 TkwDeleteEtalons = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта DeleteEtalons
*Пример:*
[code]
 anIsScript aSubFolder aName DeleteEtalons
[code]  }
 private
 // private methods
   procedure DeleteEtalons(const aCtx: TtfwContext;
    const aName: AnsiString;
    const aSubFolder: AnsiString;
    anIsScript: Boolean);
     {* Реализация слова скрипта DeleteEtalons }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDeleteEtalons

// start class TkwDeleteEtalons

procedure TkwDeleteEtalons.DeleteEtalons(const aCtx: TtfwContext;
  const aName: AnsiString;
  const aSubFolder: AnsiString;
  anIsScript: Boolean);
//#UC START# *32E2191A0272_6F1D31444115_var*
//#UC END# *32E2191A0272_6F1D31444115_var*
begin
//#UC START# *32E2191A0272_6F1D31444115_impl*
 KTestRunner.DeleteEtalons(aName, aSubFolder, anIsScript);
//#UC END# *32E2191A0272_6F1D31444115_impl*
end;//TkwDeleteEtalons.DeleteEtalons

procedure TkwDeleteEtalons.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aName : AnsiString;
 l_aSubFolder : AnsiString;
 l_anIsScript : Boolean;
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
 {-}
begin
 Result := 'DeleteEtalons';
end;//TkwDeleteEtalons.GetWordNameForRegister

function TkwDeleteEtalons.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwDeleteEtalons.GetResultTypeInfo

function TkwDeleteEtalons.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 3;
end;//TkwDeleteEtalons.GetAllParamsCount

function TkwDeleteEtalons.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString), TypeInfo(AnsiString), TypeInfo(Boolean)]);
end;//TkwDeleteEtalons.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация скриптованой аксиоматики
 TkwKeyWordsPackResNameGetter.Register;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация GUITestRunner_push_DUnitForm
 TkwGUITestRunnerPushDUnitForm.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_GUITestRunner_NodeToTest
 TkwPopGUITestRunnerNodeToTest.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация DeleteEtalons
 TkwDeleteEtalons.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TGUITestRunner
 TtfwTypeRegistrator.RegisterType(TypeInfo(TGUITestRunner));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TTreeNode
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа ITest
 TtfwTypeRegistrator.RegisterType(TypeInfo(ITest));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL

end.