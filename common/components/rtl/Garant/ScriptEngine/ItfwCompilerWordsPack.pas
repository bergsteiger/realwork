unit ItfwCompilerWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "ItfwCompilerWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Words RTTI::ItfwCompilerWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwClassLike,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopCompilerCompileInParameterPopCode = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Compiler:CompileInParameterPopCode
*������:*
[code]
 aParameterToPop aCompiler pop:Compiler:CompileInParameterPopCode
[code]  }
 private
 // private methods
   procedure CompileInParameterPopCode(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aParameterToPop: TtfwWord);
     {* ���������� ����� ������� pop:Compiler:CompileInParameterPopCode }
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
 end;//TkwPopCompilerCompileInParameterPopCode

// start class TkwPopCompilerCompileInParameterPopCode

procedure TkwPopCompilerCompileInParameterPopCode.CompileInParameterPopCode(const aCtx: TtfwContext;
  aCompiler: TtfwCompiler;
  aParameterToPop: TtfwWord);
//#UC START# *8AF404C5D805_1EEC2B16B8DA_var*
//#UC END# *8AF404C5D805_1EEC2B16B8DA_var*
begin
//#UC START# *8AF404C5D805_1EEC2B16B8DA_impl*
 aCompiler.CompileInParameterPopCode(aCtx, aParameterToPop);
//#UC END# *8AF404C5D805_1EEC2B16B8DA_impl*
end;//TkwPopCompilerCompileInParameterPopCode.CompileInParameterPopCode

procedure TkwPopCompilerCompileInParameterPopCode.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCompiler : TtfwCompiler;
 l_aParameterToPop : TtfwWord;
begin
 try
  l_aCompiler := TtfwCompiler(aCtx.rEngine.PopObjAs(TtfwCompiler));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aParameterToPop := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord, true));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParameterToPop: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CompileInParameterPopCode(aCtx, l_aCompiler, l_aParameterToPop);
end;//TkwPopCompilerCompileInParameterPopCode.DoDoIt

class function TkwPopCompilerCompileInParameterPopCode.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Compiler:CompileInParameterPopCode';
end;//TkwPopCompilerCompileInParameterPopCode.GetWordNameForRegister

function TkwPopCompilerCompileInParameterPopCode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopCompilerCompileInParameterPopCode.GetResultTypeInfo

function TkwPopCompilerCompileInParameterPopCode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopCompilerCompileInParameterPopCode.GetAllParamsCount

function TkwPopCompilerCompileInParameterPopCode.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler), TypeInfo(TtfwWord)]);
end;//TkwPopCompilerCompileInParameterPopCode.ParamsTypes

type
 TkwPopCompilerGetWordCompilingNow = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Compiler:GetWordCompilingNow
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aCompiler pop:Compiler:GetWordCompilingNow >>> l_TtfwWord
[code]  }
 private
 // private methods
   function GetWordCompilingNow(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwWord;
     {* ���������� ����� ������� pop:Compiler:GetWordCompilingNow }
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
 end;//TkwPopCompilerGetWordCompilingNow

// start class TkwPopCompilerGetWordCompilingNow

function TkwPopCompilerGetWordCompilingNow.GetWordCompilingNow(const aCtx: TtfwContext;
  aCompiler: TtfwCompiler): TtfwWord;
//#UC START# *2865825201AC_E67ED9D1F090_var*
//#UC END# *2865825201AC_E67ED9D1F090_var*
begin
//#UC START# *2865825201AC_E67ED9D1F090_impl*
 Result := aCompiler;
//#UC END# *2865825201AC_E67ED9D1F090_impl*
end;//TkwPopCompilerGetWordCompilingNow.GetWordCompilingNow

procedure TkwPopCompilerGetWordCompilingNow.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCompiler : TtfwCompiler;
begin
 try
  l_aCompiler := TtfwCompiler(aCtx.rEngine.PopObjAs(TtfwCompiler));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GetWordCompilingNow(aCtx, l_aCompiler)));
end;//TkwPopCompilerGetWordCompilingNow.DoDoIt

class function TkwPopCompilerGetWordCompilingNow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Compiler:GetWordCompilingNow';
end;//TkwPopCompilerGetWordCompilingNow.GetWordNameForRegister

function TkwPopCompilerGetWordCompilingNow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopCompilerGetWordCompilingNow.GetResultTypeInfo

function TkwPopCompilerGetWordCompilingNow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopCompilerGetWordCompilingNow.GetAllParamsCount

function TkwPopCompilerGetWordCompilingNow.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler)]);
end;//TkwPopCompilerGetWordCompilingNow.ParamsTypes

type
 TkwPopCompilerAddCodePart = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Compiler:AddCodePart
*������:*
[code]
 aWord aCompiler pop:Compiler:AddCodePart
[code]  }
 private
 // private methods
   procedure AddCodePart(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aWord: TtfwWord);
     {* ���������� ����� ������� pop:Compiler:AddCodePart }
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
 end;//TkwPopCompilerAddCodePart

// start class TkwPopCompilerAddCodePart

procedure TkwPopCompilerAddCodePart.AddCodePart(const aCtx: TtfwContext;
  aCompiler: TtfwCompiler;
  aWord: TtfwWord);
//#UC START# *1B3CE4878CE9_0A08F7650387_var*
//#UC END# *1B3CE4878CE9_0A08F7650387_var*
begin
//#UC START# *1B3CE4878CE9_0A08F7650387_impl*
 aCompiler.AddCodePart(aWord, aCtx, tfw_sniNo);
//#UC END# *1B3CE4878CE9_0A08F7650387_impl*
end;//TkwPopCompilerAddCodePart.AddCodePart

procedure TkwPopCompilerAddCodePart.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCompiler : TtfwCompiler;
 l_aWord : TtfwWord;
begin
 try
  l_aCompiler := TtfwCompiler(aCtx.rEngine.PopObjAs(TtfwCompiler));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AddCodePart(aCtx, l_aCompiler, l_aWord);
end;//TkwPopCompilerAddCodePart.DoDoIt

class function TkwPopCompilerAddCodePart.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Compiler:AddCodePart';
end;//TkwPopCompilerAddCodePart.GetWordNameForRegister

function TkwPopCompilerAddCodePart.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopCompilerAddCodePart.GetResultTypeInfo

function TkwPopCompilerAddCodePart.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopCompilerAddCodePart.GetAllParamsCount

function TkwPopCompilerAddCodePart.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler), TypeInfo(TtfwWord)]);
end;//TkwPopCompilerAddCodePart.ParamsTypes

type
 TkwPopCompilerKeywordFinder = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Compiler:KeywordFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aCompiler pop:Compiler:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
 private
 // private methods
   function KeywordFinder(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwKeywordFinder;
     {* ���������� ����� ������� pop:Compiler:KeywordFinder }
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
 end;//TkwPopCompilerKeywordFinder

// start class TkwPopCompilerKeywordFinder

function TkwPopCompilerKeywordFinder.KeywordFinder(const aCtx: TtfwContext;
  aCompiler: TtfwCompiler): TtfwKeywordFinder;
//#UC START# *ACAA83F81CD5_3521615FAE64_var*
//#UC END# *ACAA83F81CD5_3521615FAE64_var*
begin
//#UC START# *ACAA83F81CD5_3521615FAE64_impl*
 Result := aCompiler.KeywordFinder(aCtx);
//#UC END# *ACAA83F81CD5_3521615FAE64_impl*
end;//TkwPopCompilerKeywordFinder.KeywordFinder

procedure TkwPopCompilerKeywordFinder.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCompiler : TtfwCompiler;
begin
 try
  l_aCompiler := TtfwCompiler(aCtx.rEngine.PopObjAs(TtfwCompiler));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((KeywordFinder(aCtx, l_aCompiler)));
end;//TkwPopCompilerKeywordFinder.DoDoIt

class function TkwPopCompilerKeywordFinder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Compiler:KeywordFinder';
end;//TkwPopCompilerKeywordFinder.GetWordNameForRegister

procedure TkwPopCompilerKeywordFinder.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� KeywordFinder', aCtx);
end;//TkwPopCompilerKeywordFinder.SetValuePrim

function TkwPopCompilerKeywordFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwPopCompilerKeywordFinder.GetResultTypeInfo

function TkwPopCompilerKeywordFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopCompilerKeywordFinder.GetAllParamsCount

function TkwPopCompilerKeywordFinder.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler)]);
end;//TkwPopCompilerKeywordFinder.ParamsTypes

type
 TkwPopCompilerNewWordDefinitor = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:Compiler:NewWordDefinitor
*��� ����������:* TtfwNewWordDefinitor
*������:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 aCompiler pop:Compiler:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
 private
 // private methods
   function NewWordDefinitor(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
     {* ���������� ����� ������� pop:Compiler:NewWordDefinitor }
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
 end;//TkwPopCompilerNewWordDefinitor

// start class TkwPopCompilerNewWordDefinitor

function TkwPopCompilerNewWordDefinitor.NewWordDefinitor(const aCtx: TtfwContext;
  aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
//#UC START# *E66311949296_468F9B6E6285_var*
//#UC END# *E66311949296_468F9B6E6285_var*
begin
//#UC START# *E66311949296_468F9B6E6285_impl*
 Result := aCompiler.NewWordDefinitor;
//#UC END# *E66311949296_468F9B6E6285_impl*
end;//TkwPopCompilerNewWordDefinitor.NewWordDefinitor

procedure TkwPopCompilerNewWordDefinitor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCompiler : TtfwCompiler;
begin
 try
  l_aCompiler := TtfwCompiler(aCtx.rEngine.PopObjAs(TtfwCompiler));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NewWordDefinitor(aCtx, l_aCompiler)));
end;//TkwPopCompilerNewWordDefinitor.DoDoIt

class function TkwPopCompilerNewWordDefinitor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Compiler:NewWordDefinitor';
end;//TkwPopCompilerNewWordDefinitor.GetWordNameForRegister

procedure TkwPopCompilerNewWordDefinitor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� NewWordDefinitor', aCtx);
end;//TkwPopCompilerNewWordDefinitor.SetValuePrim

function TkwPopCompilerNewWordDefinitor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwNewWordDefinitor);
end;//TkwPopCompilerNewWordDefinitor.GetResultTypeInfo

function TkwPopCompilerNewWordDefinitor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopCompilerNewWordDefinitor.GetAllParamsCount

function TkwPopCompilerNewWordDefinitor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwCompiler)]);
end;//TkwPopCompilerNewWordDefinitor.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_Compiler_CompileInParameterPopCode
 TkwPopCompilerCompileInParameterPopCode.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Compiler_GetWordCompilingNow
 TkwPopCompilerGetWordCompilingNow.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Compiler_AddCodePart
 TkwPopCompilerAddCodePart.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Compiler_KeywordFinder
 TkwPopCompilerKeywordFinder.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Compiler_NewWordDefinitor
 TkwPopCompilerNewWordDefinitor.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwCompiler
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwCompiler));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwKeywordFinder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwNewWordDefinitor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwNewWordDefinitor));
{$IfEnd} //not NoScripts

end.