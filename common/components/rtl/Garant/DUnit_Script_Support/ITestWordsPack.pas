unit ITestWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnit Script Support"
// Модуль: "w:/common/components/rtl/Garant/DUnit_Script_Support/ITestWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Testing Framework::DUnit Script Support::DUnit Keywords::ITestWordsPack
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
  TestFrameWork,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwPropertyLike,
  tfwGlobalKeyWord
  ;

{$IfEnd} //nsTest AND not NoScripts AND not NoVCL

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *5BD9647988E7ci*
//#UC END# *5BD9647988E7ci*
//#UC START# *5BD9647988E7cit*
//#UC END# *5BD9647988E7cit*
 TITestWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *5BD9647988E7publ*
//#UC END# *5BD9647988E7publ*
 end;//TITestWordsPackResNameGetter

// start class TITestWordsPackResNameGetter

class function TITestWordsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'ITestWordsPack';
end;//TITestWordsPackResNameGetter.ResName

 {$R ITestWordsPack.res}

type
 TkwPopTestName = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aTest pop:Test:Name >>> l_String
[code]  }
 private
 // private methods
   function Name(const aCtx: TtfwContext;
    const aTest: ITest): AnsiString;
     {* Реализация слова скрипта pop:Test:Name }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestName

// start class TkwPopTestName

function TkwPopTestName.Name(const aCtx: TtfwContext;
  const aTest: ITest): AnsiString;
 {-}
begin
 Result := aTest.Name;
end;//TkwPopTestName.Name

procedure TkwPopTestName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTest : ITest;
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
 aCtx.rEngine.PushString((Name(aCtx, l_aTest)));
end;//TkwPopTestName.DoDoIt

class function TkwPopTestName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Test:Name';
end;//TkwPopTestName.GetWordNameForRegister

procedure TkwPopTestName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopTestName.SetValuePrim

function TkwPopTestName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopTestName.GetResultTypeInfo

function TkwPopTestName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTestName.GetAllParamsCount

function TkwPopTestName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ITest)]);
end;//TkwPopTestName.ParamsTypes

type
 TkwPopTestEnabled = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:Enabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:Enabled >>> l_Boolean
[code]  }
 private
 // private methods
   function Enabled(const aCtx: TtfwContext;
    const aTest: ITest): Boolean;
     {* Реализация слова скрипта pop:Test:Enabled }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestEnabled

// start class TkwPopTestEnabled

function TkwPopTestEnabled.Enabled(const aCtx: TtfwContext;
  const aTest: ITest): Boolean;
 {-}
begin
 Result := aTest.Enabled;
end;//TkwPopTestEnabled.Enabled

procedure TkwPopTestEnabled.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTest : ITest;
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
 aCtx.rEngine.PushBool((Enabled(aCtx, l_aTest)));
end;//TkwPopTestEnabled.DoDoIt

class function TkwPopTestEnabled.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Test:Enabled';
end;//TkwPopTestEnabled.GetWordNameForRegister

procedure TkwPopTestEnabled.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Enabled', aCtx);
end;//TkwPopTestEnabled.SetValuePrim

function TkwPopTestEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTestEnabled.GetResultTypeInfo

function TkwPopTestEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTestEnabled.GetAllParamsCount

function TkwPopTestEnabled.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ITest)]);
end;//TkwPopTestEnabled.ParamsTypes

type
 TkwPopTestSubFolder = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:SubFolder
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aTest pop:Test:SubFolder >>> l_String
[code]  }
 private
 // private methods
   function SubFolder(const aCtx: TtfwContext;
    const aTest: ITest): AnsiString;
     {* Реализация слова скрипта pop:Test:SubFolder }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestSubFolder

// start class TkwPopTestSubFolder

function TkwPopTestSubFolder.SubFolder(const aCtx: TtfwContext;
  const aTest: ITest): AnsiString;
//#UC START# *DA47640487D6_4638C704D78B_var*
//#UC END# *DA47640487D6_4638C704D78B_var*
begin
//#UC START# *DA47640487D6_4638C704D78B_impl*
 Result := aTest.GetSubFolder;
//#UC END# *DA47640487D6_4638C704D78B_impl*
end;//TkwPopTestSubFolder.SubFolder

procedure TkwPopTestSubFolder.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTest : ITest;
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
 aCtx.rEngine.PushString((SubFolder(aCtx, l_aTest)));
end;//TkwPopTestSubFolder.DoDoIt

class function TkwPopTestSubFolder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Test:SubFolder';
end;//TkwPopTestSubFolder.GetWordNameForRegister

procedure TkwPopTestSubFolder.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству SubFolder', aCtx);
end;//TkwPopTestSubFolder.SetValuePrim

function TkwPopTestSubFolder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopTestSubFolder.GetResultTypeInfo

function TkwPopTestSubFolder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTestSubFolder.GetAllParamsCount

function TkwPopTestSubFolder.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ITest)]);
end;//TkwPopTestSubFolder.ParamsTypes

type
 TkwPopTestHasScriptChildren = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:HasScriptChildren
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:HasScriptChildren >>> l_Boolean
[code]  }
 private
 // private methods
   function HasScriptChildren(const aCtx: TtfwContext;
    const aTest: ITest): Boolean;
     {* Реализация слова скрипта pop:Test:HasScriptChildren }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTestHasScriptChildren

// start class TkwPopTestHasScriptChildren

function TkwPopTestHasScriptChildren.HasScriptChildren(const aCtx: TtfwContext;
  const aTest: ITest): Boolean;
 {-}
begin
 Result := aTest.HasScriptChildren;
end;//TkwPopTestHasScriptChildren.HasScriptChildren

procedure TkwPopTestHasScriptChildren.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTest : ITest;
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
 aCtx.rEngine.PushBool((HasScriptChildren(aCtx, l_aTest)));
end;//TkwPopTestHasScriptChildren.DoDoIt

class function TkwPopTestHasScriptChildren.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Test:HasScriptChildren';
end;//TkwPopTestHasScriptChildren.GetWordNameForRegister

procedure TkwPopTestHasScriptChildren.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HasScriptChildren', aCtx);
end;//TkwPopTestHasScriptChildren.SetValuePrim

function TkwPopTestHasScriptChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTestHasScriptChildren.GetResultTypeInfo

function TkwPopTestHasScriptChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTestHasScriptChildren.GetAllParamsCount

function TkwPopTestHasScriptChildren.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ITest)]);
end;//TkwPopTestHasScriptChildren.ParamsTypes

type
 TkwTestShouldStop = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта test:ShouldStop
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 test:ShouldStop >>> l_Boolean
[code]  }
 private
 // private methods
   function TestShouldStop(const aCtx: TtfwContext): Boolean;
     {* Реализация слова скрипта test:ShouldStop }
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
 end;//TkwTestShouldStop

// start class TkwTestShouldStop

function TkwTestShouldStop.TestShouldStop(const aCtx: TtfwContext): Boolean;
//#UC START# *4E0E008C1CF6_AFCC4A8F1DF4_var*
//#UC END# *4E0E008C1CF6_AFCC4A8F1DF4_var*
begin
//#UC START# *4E0E008C1CF6_AFCC4A8F1DF4_impl*
 Result := aCtx.rCaller.ShouldStop;
//#UC END# *4E0E008C1CF6_AFCC4A8F1DF4_impl*
end;//TkwTestShouldStop.TestShouldStop

procedure TkwTestShouldStop.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushBool((TestShouldStop(aCtx)));
end;//TkwTestShouldStop.DoDoIt

class function TkwTestShouldStop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'test:ShouldStop';
end;//TkwTestShouldStop.GetWordNameForRegister

function TkwTestShouldStop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwTestShouldStop.GetResultTypeInfo

function TkwTestShouldStop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwTestShouldStop.GetAllParamsCount

function TkwTestShouldStop.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwTestShouldStop.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация скриптованой аксиоматики
 TITestWordsPackResNameGetter.Register;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Test_Name
 TkwPopTestName.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Test_Enabled
 TkwPopTestEnabled.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Test_SubFolder
 TkwPopTestSubFolder.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Test_HasScriptChildren
 TkwPopTestHasScriptChildren.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация test_ShouldStop
 TkwTestShouldStop.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
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