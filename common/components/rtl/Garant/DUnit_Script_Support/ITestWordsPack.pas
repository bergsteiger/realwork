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
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
 , tfwGlobalKeyWord
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 //#UC START# *5BD9647988E7ci*
 //#UC END# *5BD9647988E7ci*
 //#UC START# *5BD9647988E7cit*
 //#UC END# *5BD9647988E7cit*
 TITestWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *5BD9647988E7publ*
 //#UC END# *5BD9647988E7publ*
 end;//TITestWordsPackResNameGetter

 TkwPopTestName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aTest pop:Test:Name >>> l_String
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    const aTest: ITest): AnsiString;
    {* Реализация слова скрипта pop:Test:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestName

 TkwPopTestEnabled = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:Enabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:Enabled >>> l_Boolean
[code]  }
  private
   function Enabled(const aCtx: TtfwContext;
    const aTest: ITest): Boolean;
    {* Реализация слова скрипта pop:Test:Enabled }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestEnabled

 TkwPopTestSubFolder = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:SubFolder
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aTest pop:Test:SubFolder >>> l_String
[code]  }
  private
   function SubFolder(const aCtx: TtfwContext;
    const aTest: ITest): AnsiString;
    {* Реализация слова скрипта pop:Test:SubFolder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestSubFolder

 TkwPopTestHasScriptChildren = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:HasScriptChildren
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:HasScriptChildren >>> l_Boolean
[code]  }
  private
   function HasScriptChildren(const aCtx: TtfwContext;
    const aTest: ITest): Boolean;
    {* Реализация слова скрипта pop:Test:HasScriptChildren }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestHasScriptChildren

 TkwTestShouldStop = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта test:ShouldStop
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 test:ShouldStop >>> l_Boolean
[code]  }
  private
   function test_ShouldStop(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта test:ShouldStop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTestShouldStop

class function TITestWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'ITestWordsPack';
end;//TITestWordsPackResNameGetter.ResName

 {$R ITestWordsPack.res}

function TkwPopTestName.Name(const aCtx: TtfwContext;
 const aTest: ITest): AnsiString;
 {* Реализация слова скрипта pop:Test:Name }
begin
 Result := aTest.Name;
end;//TkwPopTestName.Name

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

procedure TkwPopTestName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopTestName.SetValuePrim

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

class function TkwPopTestName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:Name';
end;//TkwPopTestName.GetWordNameForRegister

function TkwPopTestEnabled.Enabled(const aCtx: TtfwContext;
 const aTest: ITest): Boolean;
 {* Реализация слова скрипта pop:Test:Enabled }
begin
 Result := aTest.Enabled;
end;//TkwPopTestEnabled.Enabled

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

procedure TkwPopTestEnabled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Enabled', aCtx);
end;//TkwPopTestEnabled.SetValuePrim

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

class function TkwPopTestEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:Enabled';
end;//TkwPopTestEnabled.GetWordNameForRegister

function TkwPopTestSubFolder.SubFolder(const aCtx: TtfwContext;
 const aTest: ITest): AnsiString;
 {* Реализация слова скрипта pop:Test:SubFolder }
//#UC START# *DA47640487D6_4638C704D78B_var*
//#UC END# *DA47640487D6_4638C704D78B_var*
begin
//#UC START# *DA47640487D6_4638C704D78B_impl*
 Result := aTest.GetSubFolder;
//#UC END# *DA47640487D6_4638C704D78B_impl*
end;//TkwPopTestSubFolder.SubFolder

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

procedure TkwPopTestSubFolder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SubFolder', aCtx);
end;//TkwPopTestSubFolder.SetValuePrim

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

class function TkwPopTestSubFolder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:SubFolder';
end;//TkwPopTestSubFolder.GetWordNameForRegister

function TkwPopTestHasScriptChildren.HasScriptChildren(const aCtx: TtfwContext;
 const aTest: ITest): Boolean;
 {* Реализация слова скрипта pop:Test:HasScriptChildren }
begin
 Result := aTest.HasScriptChildren;
end;//TkwPopTestHasScriptChildren.HasScriptChildren

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

procedure TkwPopTestHasScriptChildren.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HasScriptChildren', aCtx);
end;//TkwPopTestHasScriptChildren.SetValuePrim

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

class function TkwPopTestHasScriptChildren.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Test:HasScriptChildren';
end;//TkwPopTestHasScriptChildren.GetWordNameForRegister

function TkwTestShouldStop.test_ShouldStop(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта test:ShouldStop }
//#UC START# *4E0E008C1CF6_AFCC4A8F1DF4_var*
//#UC END# *4E0E008C1CF6_AFCC4A8F1DF4_var*
begin
//#UC START# *4E0E008C1CF6_AFCC4A8F1DF4_impl*
 Result := aCtx.rCaller.ShouldStop;
//#UC END# *4E0E008C1CF6_AFCC4A8F1DF4_impl*
end;//TkwTestShouldStop.test_ShouldStop

procedure TkwTestShouldStop.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(test_ShouldStop(aCtx));
end;//TkwTestShouldStop.DoDoIt

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

class function TkwTestShouldStop.GetWordNameForRegister: AnsiString;
begin
 Result := 'test:ShouldStop';
end;//TkwTestShouldStop.GetWordNameForRegister

initialization
 TITestWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwPopTestName.RegisterInEngine;
 {* Регистрация pop_Test_Name }
 TkwPopTestEnabled.RegisterInEngine;
 {* Регистрация pop_Test_Enabled }
 TkwPopTestSubFolder.RegisterInEngine;
 {* Регистрация pop_Test_SubFolder }
 TkwPopTestHasScriptChildren.RegisterInEngine;
 {* Регистрация pop_Test_HasScriptChildren }
 TkwTestShouldStop.RegisterInEngine;
 {* Регистрация test_ShouldStop }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ITest));
 {* Регистрация типа ITest }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
