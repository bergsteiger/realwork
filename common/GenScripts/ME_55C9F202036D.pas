unit ITestWordsPack;

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\ITestWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ITestWordsPack" MUID: (55C9F202036D)

{$Include w:\common\components\rtl\Garant\DUnit_Script_Support\dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , TestFrameWork
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwTestShouldStop = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта test:ShouldStop }
  private
   function test_ShouldStop(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта test:ShouldStop }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTestShouldStop

 TkwPopTestName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:Name }
  private
   function Name(const aCtx: TtfwContext;
    const aTest: ITest): AnsiString;
    {* Реализация слова скрипта pop:Test:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopTestName

 TkwPopTestEnabled = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:Enabled }
  private
   function Enabled(const aCtx: TtfwContext;
    const aTest: ITest): Boolean;
    {* Реализация слова скрипта pop:Test:Enabled }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopTestEnabled

 TkwPopTestSubFolder = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:SubFolder }
  private
   function SubFolder(const aCtx: TtfwContext;
    const aTest: ITest): AnsiString;
    {* Реализация слова скрипта pop:Test:SubFolder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopTestSubFolder

 TkwPopTestHasScriptChildren = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:HasScriptChildren }
  private
   function HasScriptChildren(const aCtx: TtfwContext;
    const aTest: ITest): Boolean;
    {* Реализация слова скрипта pop:Test:HasScriptChildren }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopTestHasScriptChildren

 TITestWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TITestWordsPackResNameGetter

function TkwTestShouldStop.test_ShouldStop(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта test:ShouldStop }
//#UC START# *55C9F3150354_55C9F3150354_Word_var*
//#UC END# *55C9F3150354_55C9F3150354_Word_var*
begin
//#UC START# *55C9F3150354_55C9F3150354_Word_impl*
 Result := aCtx.rCaller.ShouldStop;
//#UC END# *55C9F3150354_55C9F3150354_Word_impl*
end;//TkwTestShouldStop.test_ShouldStop

class function TkwTestShouldStop.GetWordNameForRegister: AnsiString;
begin
 Result := 'test:ShouldStop';
end;//TkwTestShouldStop.GetWordNameForRegister

function TkwTestShouldStop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwTestShouldStop.GetResultTypeInfo

function TkwTestShouldStop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwTestShouldStop.GetAllParamsCount

function TkwTestShouldStop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTestShouldStop.ParamsTypes

procedure TkwTestShouldStop.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(test_ShouldStop(aCtx));
end;//TkwTestShouldStop.DoDoIt

function TkwPopTestName.Name(const aCtx: TtfwContext;
 const aTest: ITest): AnsiString;
 {* Реализация слова скрипта pop:Test:Name }
begin
 Result := aTest.Name;
end;//TkwPopTestName.Name

class function TkwPopTestName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:Name';
end;//TkwPopTestName.GetWordNameForRegister

function TkwPopTestName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopTestName.GetResultTypeInfo

function TkwPopTestName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTestName.GetAllParamsCount

function TkwPopTestName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ITest)]);
end;//TkwPopTestName.ParamsTypes

procedure TkwPopTestName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopTestName.SetValuePrim

procedure TkwPopTestName.DoDoIt(const aCtx: TtfwContext);
var l_aTest: ITest;
begin
 try
  l_aTest := ITest(aCtx.rEngine.PopIntf(ITest));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTest: ITest : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aTest));
end;//TkwPopTestName.DoDoIt

function TkwPopTestEnabled.Enabled(const aCtx: TtfwContext;
 const aTest: ITest): Boolean;
 {* Реализация слова скрипта pop:Test:Enabled }
begin
 Result := aTest.Enabled;
end;//TkwPopTestEnabled.Enabled

class function TkwPopTestEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:Enabled';
end;//TkwPopTestEnabled.GetWordNameForRegister

function TkwPopTestEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTestEnabled.GetResultTypeInfo

function TkwPopTestEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTestEnabled.GetAllParamsCount

function TkwPopTestEnabled.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ITest)]);
end;//TkwPopTestEnabled.ParamsTypes

procedure TkwPopTestEnabled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Enabled', aCtx);
end;//TkwPopTestEnabled.SetValuePrim

procedure TkwPopTestEnabled.DoDoIt(const aCtx: TtfwContext);
var l_aTest: ITest;
begin
 try
  l_aTest := ITest(aCtx.rEngine.PopIntf(ITest));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTest: ITest : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Enabled(aCtx, l_aTest));
end;//TkwPopTestEnabled.DoDoIt

function TkwPopTestSubFolder.SubFolder(const aCtx: TtfwContext;
 const aTest: ITest): AnsiString;
 {* Реализация слова скрипта pop:Test:SubFolder }
//#UC START# *024726117628_024726117628_4B2F420202F4_Word_var*
//#UC END# *024726117628_024726117628_4B2F420202F4_Word_var*
begin
//#UC START# *024726117628_024726117628_4B2F420202F4_Word_impl*
 Result := aTest.GetSubFolder;
//#UC END# *024726117628_024726117628_4B2F420202F4_Word_impl*
end;//TkwPopTestSubFolder.SubFolder

class function TkwPopTestSubFolder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:SubFolder';
end;//TkwPopTestSubFolder.GetWordNameForRegister

function TkwPopTestSubFolder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopTestSubFolder.GetResultTypeInfo

function TkwPopTestSubFolder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTestSubFolder.GetAllParamsCount

function TkwPopTestSubFolder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ITest)]);
end;//TkwPopTestSubFolder.ParamsTypes

procedure TkwPopTestSubFolder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SubFolder', aCtx);
end;//TkwPopTestSubFolder.SetValuePrim

procedure TkwPopTestSubFolder.DoDoIt(const aCtx: TtfwContext);
var l_aTest: ITest;
begin
 try
  l_aTest := ITest(aCtx.rEngine.PopIntf(ITest));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTest: ITest : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(SubFolder(aCtx, l_aTest));
end;//TkwPopTestSubFolder.DoDoIt

function TkwPopTestHasScriptChildren.HasScriptChildren(const aCtx: TtfwContext;
 const aTest: ITest): Boolean;
 {* Реализация слова скрипта pop:Test:HasScriptChildren }
begin
 Result := aTest.HasScriptChildren;
end;//TkwPopTestHasScriptChildren.HasScriptChildren

class function TkwPopTestHasScriptChildren.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:HasScriptChildren';
end;//TkwPopTestHasScriptChildren.GetWordNameForRegister

function TkwPopTestHasScriptChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTestHasScriptChildren.GetResultTypeInfo

function TkwPopTestHasScriptChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTestHasScriptChildren.GetAllParamsCount

function TkwPopTestHasScriptChildren.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ITest)]);
end;//TkwPopTestHasScriptChildren.ParamsTypes

procedure TkwPopTestHasScriptChildren.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HasScriptChildren', aCtx);
end;//TkwPopTestHasScriptChildren.SetValuePrim

procedure TkwPopTestHasScriptChildren.DoDoIt(const aCtx: TtfwContext);
var l_aTest: ITest;
begin
 try
  l_aTest := ITest(aCtx.rEngine.PopIntf(ITest));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTest: ITest : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HasScriptChildren(aCtx, l_aTest));
end;//TkwPopTestHasScriptChildren.DoDoIt

class function TITestWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'ITestWordsPack';
end;//TITestWordsPackResNameGetter.ResName

 {$R ITestWordsPack.res}

initialization
 TkwTestShouldStop.RegisterInEngine;
 {* Регистрация test_ShouldStop }
 TkwPopTestName.RegisterInEngine;
 {* Регистрация pop_Test_Name }
 TkwPopTestEnabled.RegisterInEngine;
 {* Регистрация pop_Test_Enabled }
 TkwPopTestSubFolder.RegisterInEngine;
 {* Регистрация pop_Test_SubFolder }
 TkwPopTestHasScriptChildren.RegisterInEngine;
 {* Регистрация pop_Test_HasScriptChildren }
 TITestWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ITest));
 {* Регистрация типа ITest }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
