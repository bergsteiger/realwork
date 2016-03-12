unit ItfwCompilerWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ItfwCompilerWordsPack.pas"
// ���������: "ScriptKeywordsPack"

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
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopCompilerCompileInParameterPopCode = {final} class(TtfwClassLike)
  {* ����� ������� pop:Compiler:CompileInParameterPopCode
*������:*
[code]
 aParameterToPop aCompiler pop:Compiler:CompileInParameterPopCode
[code]  }
  private
   procedure CompileInParameterPopCode(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aParameterToPop: TtfwWord);
    {* ���������� ����� ������� pop:Compiler:CompileInParameterPopCode }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerCompileInParameterPopCode

 TkwPopCompilerGetWordCompilingNow = {final} class(TtfwClassLike)
  {* ����� ������� pop:Compiler:GetWordCompilingNow
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 aCompiler pop:Compiler:GetWordCompilingNow >>> l_TtfwWord
[code]  }
  private
   function GetWordCompilingNow(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwWord;
    {* ���������� ����� ������� pop:Compiler:GetWordCompilingNow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerGetWordCompilingNow

 TkwPopCompilerAddCodePart = {final} class(TtfwClassLike)
  {* ����� ������� pop:Compiler:AddCodePart
*������:*
[code]
 aWord aCompiler pop:Compiler:AddCodePart
[code]  }
  private
   procedure AddCodePart(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    aWord: TtfwWord);
    {* ���������� ����� ������� pop:Compiler:AddCodePart }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerAddCodePart

 TkwPopCompilerAddCodePartValue = {final} class(TtfwClassLike)
  {* ����� ������� pop:Compiler:AddCodePartValue
*������:*
[code]
 aValue aCompiler pop:Compiler:AddCodePartValue
[code]  }
  private
   procedure AddCodePartValue(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler;
    const aValue: TtfwStackValue);
    {* ���������� ����� ������� pop:Compiler:AddCodePartValue }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompilerAddCodePartValue

 TkwPopCompilerKeywordFinder = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Compiler:KeywordFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aCompiler pop:Compiler:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  private
   function KeywordFinder(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwKeywordFinder;
    {* ���������� ����� ������� pop:Compiler:KeywordFinder }
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
  {* ����� ������� pop:Compiler:NewWordDefinitor
*��� ����������:* TtfwNewWordDefinitor
*������:*
[code]
OBJECT VAR l_TtfwNewWordDefinitor
 aCompiler pop:Compiler:NewWordDefinitor >>> l_TtfwNewWordDefinitor
[code]  }
  private
   function NewWordDefinitor(const aCtx: TtfwContext;
    aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
    {* ���������� ����� ������� pop:Compiler:NewWordDefinitor }
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
 {* ���������� ����� ������� pop:Compiler:CompileInParameterPopCode }
//#UC START# *8AF404C5D805_1EEC2B16B8DA_var*
//#UC END# *8AF404C5D805_1EEC2B16B8DA_var*
begin
//#UC START# *8AF404C5D805_1EEC2B16B8DA_impl*
 aCompiler.CompileInParameterPopCode(aCtx, aParameterToPop);
//#UC END# *8AF404C5D805_1EEC2B16B8DA_impl*
end;//TkwPopCompilerCompileInParameterPopCode.CompileInParameterPopCode

procedure TkwPopCompilerCompileInParameterPopCode.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
var l_aParameterToPop: TtfwWord;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aParameterToPop := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
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

function TkwPopCompilerGetWordCompilingNow.GetWordCompilingNow(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwWord;
 {* ���������� ����� ������� pop:Compiler:GetWordCompilingNow }
//#UC START# *2865825201AC_E67ED9D1F090_var*
//#UC END# *2865825201AC_E67ED9D1F090_var*
begin
//#UC START# *2865825201AC_E67ED9D1F090_impl*
 Result := aCompiler;
//#UC END# *2865825201AC_E67ED9D1F090_impl*
end;//TkwPopCompilerGetWordCompilingNow.GetWordCompilingNow

procedure TkwPopCompilerGetWordCompilingNow.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetWordCompilingNow(aCtx, l_aCompiler));
end;//TkwPopCompilerGetWordCompilingNow.DoDoIt

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

procedure TkwPopCompilerAddCodePart.AddCodePart(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler;
 aWord: TtfwWord);
 {* ���������� ����� ������� pop:Compiler:AddCodePart }
//#UC START# *1B3CE4878CE9_0A08F7650387_var*
//#UC END# *1B3CE4878CE9_0A08F7650387_var*
begin
//#UC START# *1B3CE4878CE9_0A08F7650387_impl*
 aCompiler.AddCodePart(aWord, aCtx, tfw_sniNo);
//#UC END# *1B3CE4878CE9_0A08F7650387_impl*
end;//TkwPopCompilerAddCodePart.AddCodePart

procedure TkwPopCompilerAddCodePart.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
var l_aWord: TtfwWord;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
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

procedure TkwPopCompilerAddCodePartValue.AddCodePartValue(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler;
 const aValue: TtfwStackValue);
 {* ���������� ����� ������� pop:Compiler:AddCodePartValue }
//#UC START# *4A88B5E4BF40_77BEE4F9136B_var*
var
 l_W : TtfwWord;
//#UC END# *4A88B5E4BF40_77BEE4F9136B_var*
begin
//#UC START# *4A88B5E4BF40_77BEE4F9136B_impl*
 l_W := TkwValue.Create(aValue);
 try
  aCompiler.AddCodePart(l_W, aCtx, tfw_sniNo);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *4A88B5E4BF40_77BEE4F9136B_impl*
end;//TkwPopCompilerAddCodePartValue.AddCodePartValue

procedure TkwPopCompilerAddCodePartValue.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
var l_aValue: TtfwStackValue;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AddCodePartValue(aCtx, l_aCompiler, l_aValue);
end;//TkwPopCompilerAddCodePartValue.DoDoIt

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

function TkwPopCompilerKeywordFinder.KeywordFinder(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwKeywordFinder;
 {* ���������� ����� ������� pop:Compiler:KeywordFinder }
//#UC START# *ACAA83F81CD5_3521615FAE64_var*
//#UC END# *ACAA83F81CD5_3521615FAE64_var*
begin
//#UC START# *ACAA83F81CD5_3521615FAE64_impl*
 Result := aCompiler.KeywordFinder(aCtx);
//#UC END# *ACAA83F81CD5_3521615FAE64_impl*
end;//TkwPopCompilerKeywordFinder.KeywordFinder

procedure TkwPopCompilerKeywordFinder.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(KeywordFinder(aCtx, l_aCompiler));
end;//TkwPopCompilerKeywordFinder.DoDoIt

class function TkwPopCompilerKeywordFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:KeywordFinder';
end;//TkwPopCompilerKeywordFinder.GetWordNameForRegister

procedure TkwPopCompilerKeywordFinder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� KeywordFinder', aCtx);
end;//TkwPopCompilerKeywordFinder.SetValuePrim

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

function TkwPopCompilerNewWordDefinitor.NewWordDefinitor(const aCtx: TtfwContext;
 aCompiler: TtfwCompiler): TtfwNewWordDefinitor;
 {* ���������� ����� ������� pop:Compiler:NewWordDefinitor }
//#UC START# *E66311949296_468F9B6E6285_var*
//#UC END# *E66311949296_468F9B6E6285_var*
begin
//#UC START# *E66311949296_468F9B6E6285_impl*
 Result := aCompiler.NewWordDefinitor;
//#UC END# *E66311949296_468F9B6E6285_impl*
end;//TkwPopCompilerNewWordDefinitor.NewWordDefinitor

procedure TkwPopCompilerNewWordDefinitor.DoDoIt(const aCtx: TtfwContext);
var l_aCompiler: TtfwCompiler;
begin
 try
  l_aCompiler := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiler: TtfwCompiler : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewWordDefinitor(aCtx, l_aCompiler));
end;//TkwPopCompilerNewWordDefinitor.DoDoIt

class function TkwPopCompilerNewWordDefinitor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Compiler:NewWordDefinitor';
end;//TkwPopCompilerNewWordDefinitor.GetWordNameForRegister

procedure TkwPopCompilerNewWordDefinitor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NewWordDefinitor', aCtx);
end;//TkwPopCompilerNewWordDefinitor.SetValuePrim

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

initialization
 TkwPopCompilerCompileInParameterPopCode.RegisterInEngine;
 {* ����������� pop_Compiler_CompileInParameterPopCode }
 TkwPopCompilerGetWordCompilingNow.RegisterInEngine;
 {* ����������� pop_Compiler_GetWordCompilingNow }
 TkwPopCompilerAddCodePart.RegisterInEngine;
 {* ����������� pop_Compiler_AddCodePart }
 TkwPopCompilerAddCodePartValue.RegisterInEngine;
 {* ����������� pop_Compiler_AddCodePartValue }
 TkwPopCompilerKeywordFinder.RegisterInEngine;
 {* ����������� pop_Compiler_KeywordFinder }
 TkwPopCompilerNewWordDefinitor.RegisterInEngine;
 {* ����������� pop_Compiler_NewWordDefinitor }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwCompiler));
 {* ����������� ���� TtfwCompiler }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* ����������� ���� TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwNewWordDefinitor));
 {* ����������� ���� TtfwNewWordDefinitor }
{$IfEnd} // NOT Defined(NoScripts)

end.
