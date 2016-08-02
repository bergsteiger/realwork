unit ItfwCompilerWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwCompilerWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ItfwCompilerWordsPack" MUID: (559BDDE30092)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , TypInfo
 , tfwTypeInfo
 , tfwPropertyLike
 , kwValue
 , BasicsPack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopCompilerCompileInParameterPopCode = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:CompileInParameterPopCode }
  private
   procedure CompileInParameterPopCode(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aParameterToPop: TtfwWord);
    {* Реализация слова скрипта pop:Compiler:CompileInParameterPopCode }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerCompileInParameterPopCode

 TkwPopCompilerGetWordCompilingNow = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:GetWordCompilingNow }
  private
   function GetWordCompilingNow(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwWord;
    {* Реализация слова скрипта pop:Compiler:GetWordCompilingNow }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerGetWordCompilingNow

 TkwPopCompilerAddCodePart = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:AddCodePart }
  private
   procedure AddCodePart(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:Compiler:AddCodePart }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerAddCodePart

 TkwPopCompilerAddCodePartValue = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:AddCodePartValue }
  private
   procedure AddCodePartValue(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта pop:Compiler:AddCodePartValue }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerAddCodePartValue

 TkwPopCompilerAddCodePartRef = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:AddCodePartRef }
  private
   procedure AddCodePartRef(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:Compiler:AddCodePartRef }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerAddCodePartRef

 TkwPopCompilerKeywordFinder = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Compiler:KeywordFinder }
  private
   function KeywordFinder(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwKeywordFinder;
    {* Реализация слова скрипта pop:Compiler:KeywordFinder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopCompilerKeywordFinder

 TkwPopCompilerNewWordDefinitor = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Compiler:NewWordDefinitor }
  private
   function NewWordDefinitor(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
    {* Реализация слова скрипта pop:Compiler:NewWordDefinitor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopCompilerNewWordDefinitor

procedure TkwPopCompilerCompileInParameterPopCode.CompileInParameterPopCode(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler;
 aParameterToPop: TtfwWord);
 {* Реализация слова скрипта pop:Compiler:CompileInParameterPopCode }
//#UC START# *559BDE1700B0_559BDE1700B0_4DB6E2EE0259_Word_var*
//#UC END# *559BDE1700B0_559BDE1700B0_4DB6E2EE0259_Word_var*
begin
//#UC START# *559BDE1700B0_559BDE1700B0_4DB6E2EE0259_Word_impl*
 aCompiler.CompileInParameterPopCode(aCtx, aParameterToPop);
//#UC END# *559BDE1700B0_559BDE1700B0_4DB6E2EE0259_Word_impl*
end;//TkwPopCompilerCompileInParameterPopCode.CompileInParameterPopCode

class function TkwPopCompilerCompileInParameterPopCode.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:CompileInParameterPopCode';
end;//TkwPopCompilerCompileInParameterPopCode.GetWordNameForRegister

function TkwPopCompilerCompileInParameterPopCode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopCompilerCompileInParameterPopCode.GetResultTypeInfo

function TkwPopCompilerCompileInParameterPopCode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopCompilerCompileInParameterPopCode.GetAllParamsCount

function TkwPopCompilerCompileInParameterPopCode.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler), TypeInfo(TtfwWord)]);
end;//TkwPopCompilerCompileInParameterPopCode.ParamsTypes

procedure TkwPopCompilerCompileInParameterPopCode.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
var l_aParameterToPop: TtfwWord;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aParameterToPop := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParameterToPop: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CompileInParameterPopCode(aCtx, l_aCompiler, l_aParameterToPop);
end;//TkwPopCompilerCompileInParameterPopCode.DoDoIt

function TkwPopCompilerGetWordCompilingNow.GetWordCompilingNow(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwWord;
 {* Реализация слова скрипта pop:Compiler:GetWordCompilingNow }
//#UC START# *559BDF1000D6_559BDF1000D6_4DB6E2EE0259_Word_var*
//#UC END# *559BDF1000D6_559BDF1000D6_4DB6E2EE0259_Word_var*
begin
//#UC START# *559BDF1000D6_559BDF1000D6_4DB6E2EE0259_Word_impl*
 Result := aCompiler;
//#UC END# *559BDF1000D6_559BDF1000D6_4DB6E2EE0259_Word_impl*
end;//TkwPopCompilerGetWordCompilingNow.GetWordCompilingNow

class function TkwPopCompilerGetWordCompilingNow.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:GetWordCompilingNow';
end;//TkwPopCompilerGetWordCompilingNow.GetWordNameForRegister

function TkwPopCompilerGetWordCompilingNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopCompilerGetWordCompilingNow.GetResultTypeInfo

function TkwPopCompilerGetWordCompilingNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCompilerGetWordCompilingNow.GetAllParamsCount

function TkwPopCompilerGetWordCompilingNow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler)]);
end;//TkwPopCompilerGetWordCompilingNow.ParamsTypes

procedure TkwPopCompilerGetWordCompilingNow.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetWordCompilingNow(aCtx, l_aCompiler));
end;//TkwPopCompilerGetWordCompilingNow.DoDoIt

procedure TkwPopCompilerAddCodePart.AddCodePart(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:Compiler:AddCodePart }
//#UC START# *559BDF500382_559BDF500382_4DB6E2EE0259_Word_var*
//#UC END# *559BDF500382_559BDF500382_4DB6E2EE0259_Word_var*
begin
//#UC START# *559BDF500382_559BDF500382_4DB6E2EE0259_Word_impl*
 aCompiler.AddCodePart(aWord, aCtx, tfw_sniNo);
//#UC END# *559BDF500382_559BDF500382_4DB6E2EE0259_Word_impl*
end;//TkwPopCompilerAddCodePart.AddCodePart

class function TkwPopCompilerAddCodePart.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:AddCodePart';
end;//TkwPopCompilerAddCodePart.GetWordNameForRegister

function TkwPopCompilerAddCodePart.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopCompilerAddCodePart.GetResultTypeInfo

function TkwPopCompilerAddCodePart.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopCompilerAddCodePart.GetAllParamsCount

function TkwPopCompilerAddCodePart.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler), TypeInfo(TtfwWord)]);
end;//TkwPopCompilerAddCodePart.ParamsTypes

procedure TkwPopCompilerAddCodePart.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
var l_aWord: TtfwWord;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AddCodePart(aCtx, l_aCompiler, l_aWord);
end;//TkwPopCompilerAddCodePart.DoDoIt

procedure TkwPopCompilerAddCodePartValue.AddCodePartValue(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта pop:Compiler:AddCodePartValue }
//#UC START# *56E13F740281_56E13F740281_4DB6E2EE0259_Word_var*
var
 l_W : TtfwWord;
//#UC END# *56E13F740281_56E13F740281_4DB6E2EE0259_Word_var*
begin
//#UC START# *56E13F740281_56E13F740281_4DB6E2EE0259_Word_impl*
 l_W := TkwValue.Create(aValue);
 try
  aCompiler.AddCodePart(l_W, aCtx, tfw_sniNo);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *56E13F740281_56E13F740281_4DB6E2EE0259_Word_impl*
end;//TkwPopCompilerAddCodePartValue.AddCodePartValue

class function TkwPopCompilerAddCodePartValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:AddCodePartValue';
end;//TkwPopCompilerAddCodePartValue.GetWordNameForRegister

function TkwPopCompilerAddCodePartValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopCompilerAddCodePartValue.GetResultTypeInfo

function TkwPopCompilerAddCodePartValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopCompilerAddCodePartValue.GetAllParamsCount

function TkwPopCompilerAddCodePartValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler), @tfw_tiStruct]);
end;//TkwPopCompilerAddCodePartValue.ParamsTypes

procedure TkwPopCompilerAddCodePartValue.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
var l_aValue: TtfwStackValue;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AddCodePartValue(aCtx, l_aCompiler, l_aValue);
end;//TkwPopCompilerAddCodePartValue.DoDoIt

procedure TkwPopCompilerAddCodePartRef.AddCodePartRef(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:Compiler:AddCodePartRef }
//#UC START# *579B57270341_579B57270341_4DB6E2EE0259_Word_var*
var
 l_W : TtfwWord;
//#UC END# *579B57270341_579B57270341_4DB6E2EE0259_Word_var*
begin
//#UC START# *579B57270341_579B57270341_4DB6E2EE0259_Word_impl*
 l_W := TkwCompiledPushWord.Create(aWord, nil, aCtx);
 try
  aCompiler.AddCodePart(l_W, aCtx, tfw_sniNo);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *579B57270341_579B57270341_4DB6E2EE0259_Word_impl*
end;//TkwPopCompilerAddCodePartRef.AddCodePartRef

class function TkwPopCompilerAddCodePartRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:AddCodePartRef';
end;//TkwPopCompilerAddCodePartRef.GetWordNameForRegister

function TkwPopCompilerAddCodePartRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopCompilerAddCodePartRef.GetResultTypeInfo

function TkwPopCompilerAddCodePartRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopCompilerAddCodePartRef.GetAllParamsCount

function TkwPopCompilerAddCodePartRef.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler), TypeInfo(TtfwWord)]);
end;//TkwPopCompilerAddCodePartRef.ParamsTypes

procedure TkwPopCompilerAddCodePartRef.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
var l_aWord: TtfwWord;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AddCodePartRef(aCtx, l_aCompiler, l_aWord);
end;//TkwPopCompilerAddCodePartRef.DoDoIt

function TkwPopCompilerKeywordFinder.KeywordFinder(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwKeywordFinder;
 {* Реализация слова скрипта pop:Compiler:KeywordFinder }
//#UC START# *559BDEF4039F_559BDEF4039F_4DB6E2EE0259_Word_var*
//#UC END# *559BDEF4039F_559BDEF4039F_4DB6E2EE0259_Word_var*
begin
//#UC START# *559BDEF4039F_559BDEF4039F_4DB6E2EE0259_Word_impl*
 Result := aCompiler.KeywordFinder(aCtx);
//#UC END# *559BDEF4039F_559BDEF4039F_4DB6E2EE0259_Word_impl*
end;//TkwPopCompilerKeywordFinder.KeywordFinder

class function TkwPopCompilerKeywordFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:KeywordFinder';
end;//TkwPopCompilerKeywordFinder.GetWordNameForRegister

function TkwPopCompilerKeywordFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwPopCompilerKeywordFinder.GetResultTypeInfo

function TkwPopCompilerKeywordFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCompilerKeywordFinder.GetAllParamsCount

function TkwPopCompilerKeywordFinder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler)]);
end;//TkwPopCompilerKeywordFinder.ParamsTypes

procedure TkwPopCompilerKeywordFinder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству KeywordFinder', aCtx);
end;//TkwPopCompilerKeywordFinder.SetValuePrim

procedure TkwPopCompilerKeywordFinder.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(KeywordFinder(aCtx, l_aCompiler));
end;//TkwPopCompilerKeywordFinder.DoDoIt

function TkwPopCompilerNewWordDefinitor.NewWordDefinitor(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
 {* Реализация слова скрипта pop:Compiler:NewWordDefinitor }
//#UC START# *55A9055200C5_55A9055200C5_4DB6E2EE0259_Word_var*
//#UC END# *55A9055200C5_55A9055200C5_4DB6E2EE0259_Word_var*
begin
//#UC START# *55A9055200C5_55A9055200C5_4DB6E2EE0259_Word_impl*
 Result := aCompiler.NewWordDefinitor;
//#UC END# *55A9055200C5_55A9055200C5_4DB6E2EE0259_Word_impl*
end;//TkwPopCompilerNewWordDefinitor.NewWordDefinitor

class function TkwPopCompilerNewWordDefinitor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:NewWordDefinitor';
end;//TkwPopCompilerNewWordDefinitor.GetWordNameForRegister

function TkwPopCompilerNewWordDefinitor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwNewWordDefinitor);
end;//TkwPopCompilerNewWordDefinitor.GetResultTypeInfo

function TkwPopCompilerNewWordDefinitor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCompilerNewWordDefinitor.GetAllParamsCount

function TkwPopCompilerNewWordDefinitor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler)]);
end;//TkwPopCompilerNewWordDefinitor.ParamsTypes

procedure TkwPopCompilerNewWordDefinitor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewWordDefinitor', aCtx);
end;//TkwPopCompilerNewWordDefinitor.SetValuePrim

procedure TkwPopCompilerNewWordDefinitor.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewWordDefinitor(aCtx, l_aCompiler));
end;//TkwPopCompilerNewWordDefinitor.DoDoIt

initialization
 TkwPopCompilerCompileInParameterPopCode.RegisterInEngine;
 {* Регистрация pop_Compiler_CompileInParameterPopCode }
 TkwPopCompilerGetWordCompilingNow.RegisterInEngine;
 {* Регистрация pop_Compiler_GetWordCompilingNow }
 TkwPopCompilerAddCodePart.RegisterInEngine;
 {* Регистрация pop_Compiler_AddCodePart }
 TkwPopCompilerAddCodePartValue.RegisterInEngine;
 {* Регистрация pop_Compiler_AddCodePartValue }
 TkwPopCompilerAddCodePartRef.RegisterInEngine;
 {* Регистрация pop_Compiler_AddCodePartRef }
 TkwPopCompilerKeywordFinder.RegisterInEngine;
 {* Регистрация pop_Compiler_KeywordFinder }
 TkwPopCompilerNewWordDefinitor.RegisterInEngine;
 {* Регистрация pop_Compiler_NewWordDefinitor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwCompiler));
 {* Регистрация типа TtfwCompiler }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* Регистрация типа TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwNewWordDefinitor));
 {* Регистрация типа TtfwNewWordDefinitor }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
