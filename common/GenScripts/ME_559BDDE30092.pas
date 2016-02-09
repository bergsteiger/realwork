unit ItfwCompilerWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwCompilerWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
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
 TkwPopCompilerCompileInParameterPopCode = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:CompileInParameterPopCode
*Пример:*
[code]
 aParameterToPop aCompiler pop:Compiler:CompileInParameterPopCode
[code]  }
  private
   procedure CompileInParameterPopCode(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aParameterToPop: TtfwWord);
    {* Реализация слова скрипта pop:Compiler:CompileInParameterPopCode }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerCompileInParameterPopCode

 TkwPopCompilerGetWordCompilingNow = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:GetWordCompilingNow
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aCompiler pop:Compiler:GetWordCompilingNow >>> l_TtfwWord
[code]  }
  private
   function GetWordCompilingNow(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwWord;
    {* Реализация слова скрипта pop:Compiler:GetWordCompilingNow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerGetWordCompilingNow

 TkwPopCompilerAddCodePart = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Compiler:AddCodePart
*Пример:*
[code]
 aWord aCompiler pop:Compiler:AddCodePart
[code]  }
  private
   procedure AddCodePart(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:Compiler:AddCodePart }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerAddCodePart

 TkwPopCompilerKeywordFinder = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Compiler:KeywordFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aCompiler pop:Compiler:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  private
   function KeywordFinder(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwKeywordFinder;
    {* Реализация слова скрипта pop:Compiler:KeywordFinder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerKeywordFinder

 TkwPopCompilerNewWordDefinitor = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Compiler:NewWordDefinitor
*Тип результата:* TtfwNewWordDefinitor
*Пример:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 aCompiler pop:Compiler:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
  private
   function NewWordDefinitor(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
    {* Реализация слова скрипта pop:Compiler:NewWordDefinitor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerNewWordDefinitor

procedure TkwPopCompilerCompileInParameterPopCode.CompileInParameterPopCode(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler;
 aParameterToPop: TtfwWord);
 {* Реализация слова скрипта pop:Compiler:CompileInParameterPopCode }
//#UC START# *8AF404C5D805_1EEC2B16B8DA_var*
//#UC END# *8AF404C5D805_1EEC2B16B8DA_var*
begin
//#UC START# *8AF404C5D805_1EEC2B16B8DA_impl*
 aCompiler.CompileInParameterPopCode(aCtx, aParameterToPop);
//#UC END# *8AF404C5D805_1EEC2B16B8DA_impl*
end;//TkwPopCompilerCompileInParameterPopCode.CompileInParameterPopCode

procedure TkwPopCompilerCompileInParameterPopCode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1EEC2B16B8DA_var*
//#UC END# *4DAEEDE10285_1EEC2B16B8DA_var*
begin
//#UC START# *4DAEEDE10285_1EEC2B16B8DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1EEC2B16B8DA_impl*
end;//TkwPopCompilerCompileInParameterPopCode.DoDoIt

class function TkwPopCompilerCompileInParameterPopCode.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:CompileInParameterPopCode';
end;//TkwPopCompilerCompileInParameterPopCode.GetWordNameForRegister

function TkwPopCompilerCompileInParameterPopCode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1EEC2B16B8DA_var*
//#UC END# *551544E2001A_1EEC2B16B8DA_var*
begin
//#UC START# *551544E2001A_1EEC2B16B8DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1EEC2B16B8DA_impl*
end;//TkwPopCompilerCompileInParameterPopCode.GetResultTypeInfo

function TkwPopCompilerCompileInParameterPopCode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopCompilerCompileInParameterPopCode.GetAllParamsCount

function TkwPopCompilerCompileInParameterPopCode.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1EEC2B16B8DA_var*
//#UC END# *5617F4D00243_1EEC2B16B8DA_var*
begin
//#UC START# *5617F4D00243_1EEC2B16B8DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1EEC2B16B8DA_impl*
end;//TkwPopCompilerCompileInParameterPopCode.ParamsTypes

function TkwPopCompilerGetWordCompilingNow.GetWordCompilingNow(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwWord;
 {* Реализация слова скрипта pop:Compiler:GetWordCompilingNow }
//#UC START# *2865825201AC_E67ED9D1F090_var*
//#UC END# *2865825201AC_E67ED9D1F090_var*
begin
//#UC START# *2865825201AC_E67ED9D1F090_impl*
 Result := aCompiler;
//#UC END# *2865825201AC_E67ED9D1F090_impl*
end;//TkwPopCompilerGetWordCompilingNow.GetWordCompilingNow

procedure TkwPopCompilerGetWordCompilingNow.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E67ED9D1F090_var*
//#UC END# *4DAEEDE10285_E67ED9D1F090_var*
begin
//#UC START# *4DAEEDE10285_E67ED9D1F090_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E67ED9D1F090_impl*
end;//TkwPopCompilerGetWordCompilingNow.DoDoIt

class function TkwPopCompilerGetWordCompilingNow.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:GetWordCompilingNow';
end;//TkwPopCompilerGetWordCompilingNow.GetWordNameForRegister

function TkwPopCompilerGetWordCompilingNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E67ED9D1F090_var*
//#UC END# *551544E2001A_E67ED9D1F090_var*
begin
//#UC START# *551544E2001A_E67ED9D1F090_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E67ED9D1F090_impl*
end;//TkwPopCompilerGetWordCompilingNow.GetResultTypeInfo

function TkwPopCompilerGetWordCompilingNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCompilerGetWordCompilingNow.GetAllParamsCount

function TkwPopCompilerGetWordCompilingNow.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E67ED9D1F090_var*
//#UC END# *5617F4D00243_E67ED9D1F090_var*
begin
//#UC START# *5617F4D00243_E67ED9D1F090_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E67ED9D1F090_impl*
end;//TkwPopCompilerGetWordCompilingNow.ParamsTypes

procedure TkwPopCompilerAddCodePart.AddCodePart(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:Compiler:AddCodePart }
//#UC START# *1B3CE4878CE9_0A08F7650387_var*
//#UC END# *1B3CE4878CE9_0A08F7650387_var*
begin
//#UC START# *1B3CE4878CE9_0A08F7650387_impl*
 aCompiler.AddCodePart(aWord, aCtx, tfw_sniNo);
//#UC END# *1B3CE4878CE9_0A08F7650387_impl*
end;//TkwPopCompilerAddCodePart.AddCodePart

procedure TkwPopCompilerAddCodePart.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0A08F7650387_var*
//#UC END# *4DAEEDE10285_0A08F7650387_var*
begin
//#UC START# *4DAEEDE10285_0A08F7650387_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0A08F7650387_impl*
end;//TkwPopCompilerAddCodePart.DoDoIt

class function TkwPopCompilerAddCodePart.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:AddCodePart';
end;//TkwPopCompilerAddCodePart.GetWordNameForRegister

function TkwPopCompilerAddCodePart.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0A08F7650387_var*
//#UC END# *551544E2001A_0A08F7650387_var*
begin
//#UC START# *551544E2001A_0A08F7650387_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0A08F7650387_impl*
end;//TkwPopCompilerAddCodePart.GetResultTypeInfo

function TkwPopCompilerAddCodePart.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopCompilerAddCodePart.GetAllParamsCount

function TkwPopCompilerAddCodePart.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0A08F7650387_var*
//#UC END# *5617F4D00243_0A08F7650387_var*
begin
//#UC START# *5617F4D00243_0A08F7650387_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0A08F7650387_impl*
end;//TkwPopCompilerAddCodePart.ParamsTypes

function TkwPopCompilerKeywordFinder.KeywordFinder(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwKeywordFinder;
 {* Реализация слова скрипта pop:Compiler:KeywordFinder }
//#UC START# *ACAA83F81CD5_3521615FAE64_var*
//#UC END# *ACAA83F81CD5_3521615FAE64_var*
begin
//#UC START# *ACAA83F81CD5_3521615FAE64_impl*
 Result := aCompiler.KeywordFinder(aCtx);
//#UC END# *ACAA83F81CD5_3521615FAE64_impl*
end;//TkwPopCompilerKeywordFinder.KeywordFinder

procedure TkwPopCompilerKeywordFinder.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3521615FAE64_var*
//#UC END# *4DAEEDE10285_3521615FAE64_var*
begin
//#UC START# *4DAEEDE10285_3521615FAE64_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3521615FAE64_impl*
end;//TkwPopCompilerKeywordFinder.DoDoIt

class function TkwPopCompilerKeywordFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:KeywordFinder';
end;//TkwPopCompilerKeywordFinder.GetWordNameForRegister

procedure TkwPopCompilerKeywordFinder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3521615FAE64_var*
//#UC END# *52D00B00031A_3521615FAE64_var*
begin
//#UC START# *52D00B00031A_3521615FAE64_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3521615FAE64_impl*
end;//TkwPopCompilerKeywordFinder.SetValuePrim

function TkwPopCompilerKeywordFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3521615FAE64_var*
//#UC END# *551544E2001A_3521615FAE64_var*
begin
//#UC START# *551544E2001A_3521615FAE64_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3521615FAE64_impl*
end;//TkwPopCompilerKeywordFinder.GetResultTypeInfo

function TkwPopCompilerKeywordFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCompilerKeywordFinder.GetAllParamsCount

function TkwPopCompilerKeywordFinder.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3521615FAE64_var*
//#UC END# *5617F4D00243_3521615FAE64_var*
begin
//#UC START# *5617F4D00243_3521615FAE64_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3521615FAE64_impl*
end;//TkwPopCompilerKeywordFinder.ParamsTypes

function TkwPopCompilerNewWordDefinitor.NewWordDefinitor(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
 {* Реализация слова скрипта pop:Compiler:NewWordDefinitor }
//#UC START# *E66311949296_468F9B6E6285_var*
//#UC END# *E66311949296_468F9B6E6285_var*
begin
//#UC START# *E66311949296_468F9B6E6285_impl*
 Result := aCompiler.NewWordDefinitor;
//#UC END# *E66311949296_468F9B6E6285_impl*
end;//TkwPopCompilerNewWordDefinitor.NewWordDefinitor

procedure TkwPopCompilerNewWordDefinitor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_468F9B6E6285_var*
//#UC END# *4DAEEDE10285_468F9B6E6285_var*
begin
//#UC START# *4DAEEDE10285_468F9B6E6285_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_468F9B6E6285_impl*
end;//TkwPopCompilerNewWordDefinitor.DoDoIt

class function TkwPopCompilerNewWordDefinitor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:NewWordDefinitor';
end;//TkwPopCompilerNewWordDefinitor.GetWordNameForRegister

procedure TkwPopCompilerNewWordDefinitor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_468F9B6E6285_var*
//#UC END# *52D00B00031A_468F9B6E6285_var*
begin
//#UC START# *52D00B00031A_468F9B6E6285_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_468F9B6E6285_impl*
end;//TkwPopCompilerNewWordDefinitor.SetValuePrim

function TkwPopCompilerNewWordDefinitor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_468F9B6E6285_var*
//#UC END# *551544E2001A_468F9B6E6285_var*
begin
//#UC START# *551544E2001A_468F9B6E6285_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_468F9B6E6285_impl*
end;//TkwPopCompilerNewWordDefinitor.GetResultTypeInfo

function TkwPopCompilerNewWordDefinitor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCompilerNewWordDefinitor.GetAllParamsCount

function TkwPopCompilerNewWordDefinitor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_468F9B6E6285_var*
//#UC END# *5617F4D00243_468F9B6E6285_var*
begin
//#UC START# *5617F4D00243_468F9B6E6285_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_468F9B6E6285_impl*
end;//TkwPopCompilerNewWordDefinitor.ParamsTypes

initialization
 TkwPopCompilerCompileInParameterPopCode.RegisterInEngine;
 {* Регистрация pop_Compiler_CompileInParameterPopCode }
 TkwPopCompilerGetWordCompilingNow.RegisterInEngine;
 {* Регистрация pop_Compiler_GetWordCompilingNow }
 TkwPopCompilerAddCodePart.RegisterInEngine;
 {* Регистрация pop_Compiler_AddCodePart }
 TkwPopCompilerKeywordFinder.RegisterInEngine;
 {* Регистрация pop_Compiler_KeywordFinder }
 TkwPopCompilerNewWordDefinitor.RegisterInEngine;
 {* Регистрация pop_Compiler_NewWordDefinitor }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwCompiler));
 {* Регистрация типа TtfwCompiler }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* Регистрация типа TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwNewWordDefinitor));
 {* Регистрация типа TtfwNewWordDefinitor }
{$IfEnd} // NOT Defined(NoScripts)

end.
