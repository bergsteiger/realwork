unit kwFiltersAndGeneratorsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$EVD"
// Модуль: "kwFiltersAndGeneratorsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$EVD::FiltersAndGenerators::kwFiltersAndGeneratorsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  l3Variant,
  tfwAxiomaticsResNameGetter,
  tfwClassLike,
  l3Interfaces,
  Classes
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  k2EVDReaderService,
  k2EVDWriterService,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *9EE368A1435Dci*
//#UC END# *9EE368A1435Dci*
//#UC START# *9EE368A1435Dcit*
//#UC END# *9EE368A1435Dcit*
 TkwFiltersAndGeneratorsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *9EE368A1435Dpubl*
//#UC END# *9EE368A1435Dpubl*
 end;//TkwFiltersAndGeneratorsPackResNameGetter

// start class TkwFiltersAndGeneratorsPackResNameGetter

class function TkwFiltersAndGeneratorsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'kwFiltersAndGeneratorsPack';
end;//TkwFiltersAndGeneratorsPackResNameGetter.ResName

 {$R kwFiltersAndGeneratorsPack.res}

type
 TkwGeneratorsExecute = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта generators:Execute
[panel]Берёт со стека имя имя входного файла (EVD) и генератор (или цепочку). Затем делает трубу и прогоняет через неё файл.[panel]
*Пример:*
[code]
 aFileName aTagGenerator generators:Execute
[code]  }
 private
 // private methods
   procedure GeneratorsExecute(const aCtx: TtfwContext;
    const aTagGenerator: Ik2TagGenerator;
    const aFileName: AnsiString);
     {* Реализация слова скрипта generators:Execute }
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
 end;//TkwGeneratorsExecute

// start class TkwGeneratorsExecute

procedure TkwGeneratorsExecute.GeneratorsExecute(const aCtx: TtfwContext;
  const aTagGenerator: Ik2TagGenerator;
  const aFileName: AnsiString);
//#UC START# *51B232178794_825779F5AD08_var*
var
 l_Filt: Ik2TagGenerator;
 l_InFN: AnsiString;
 l_OutFN: AnsiString;
 l_Reader: Il3Reader;
 l_Writer: Ik2TagGenerator;
//#UC END# *51B232178794_825779F5AD08_var*
begin
//#UC START# *51B232178794_825779F5AD08_impl*
 l_InFN := aFileName;
 l_OutFN := aCtx.rCaller.ResolveOutputFilePath(l_InFN);
 l_InFN := aCtx.rCaller.ResolveInputFilePath(l_InFN);
 RunnerAssert(FileExists(l_InFN), Format('generators:Execute - входной файл (%s) не найден', [l_InFN]), aCtx);
 l_Reader := Tk2EVDReaderService.Instance.MakeReader(l_InFN, aTagGenerator);
 try
  l_Filt := aTagGenerator;
  while l_Filt.NextGenerator <> nil do
   l_Filt := l_Filt.NextGenerator;
  l_Writer := Tk2EVDWriterService.Instance.MakeWriter(l_OutFN);
  try
   l_Filt.NextGenerator := l_Writer;
   l_Reader.Execute;
  finally
   l_Writer := nil;
  end;//try..finally
 finally
  l_Reader := nil;
 end;//try..finally
//#UC END# *51B232178794_825779F5AD08_impl*
end;//TkwGeneratorsExecute.GeneratorsExecute

procedure TkwGeneratorsExecute.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTagGenerator : Ik2TagGenerator;
 l_aFileName : AnsiString;
begin
 try
  l_aTagGenerator := Ik2TagGenerator(aCtx.rEngine.PopIntf(Ik2TagGenerator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTagGenerator: Ik2TagGenerator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 GeneratorsExecute(aCtx, l_aTagGenerator, l_aFileName);
end;//TkwGeneratorsExecute.DoDoIt

class function TkwGeneratorsExecute.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'generators:Execute';
end;//TkwGeneratorsExecute.GetWordNameForRegister

function TkwGeneratorsExecute.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwGeneratorsExecute.GetResultTypeInfo

function TkwGeneratorsExecute.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwGeneratorsExecute.GetAllParamsCount

function TkwGeneratorsExecute.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ik2TagGenerator), TypeInfo(AnsiString)]);
end;//TkwGeneratorsExecute.ParamsTypes

type
 TkwGeneratorsLink = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта generators:Link
[panel]Берёт со стека два генератора и делает из них цепочку. В результате на стеке остаётся один генератор (к которому подклеен другой)[panel]
*Тип результата:* Ik2TagGenerator
*Пример:*
[code]
INTERFACE VAR l_Ik2TagGenerator
 aGenHead aTagGenerator generators:Link >>> l_Ik2TagGenerator
[code]  }
 private
 // private methods
   function GeneratorsLink(const aCtx: TtfwContext;
    const aTagGenerator: Ik2TagGenerator;
    const aGenHead: Ik2TagGenerator): Ik2TagGenerator;
     {* Реализация слова скрипта generators:Link }
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
 end;//TkwGeneratorsLink

// start class TkwGeneratorsLink

function TkwGeneratorsLink.GeneratorsLink(const aCtx: TtfwContext;
  const aTagGenerator: Ik2TagGenerator;
  const aGenHead: Ik2TagGenerator): Ik2TagGenerator;
//#UC START# *C44F9D8AB364_E6DB290D23D7_var*
var
 l_GenHead: Ik2TagGenerator;
//#UC END# *C44F9D8AB364_E6DB290D23D7_var*
begin
//#UC START# *C44F9D8AB364_E6DB290D23D7_impl*
 l_GenHead := aGenHead;
 while (l_GenHead.NextGenerator <> nil) do
  l_GenHead := l_GenHead.NextGenerator;
 l_GenHead.NextGenerator := aTagGenerator;
 Result := aGenHead;
//#UC END# *C44F9D8AB364_E6DB290D23D7_impl*
end;//TkwGeneratorsLink.GeneratorsLink

procedure TkwGeneratorsLink.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTagGenerator : Ik2TagGenerator;
 l_aGenHead : Ik2TagGenerator;
begin
 try
  l_aTagGenerator := Ik2TagGenerator(aCtx.rEngine.PopIntf(Ik2TagGenerator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTagGenerator: Ik2TagGenerator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aGenHead := Ik2TagGenerator(aCtx.rEngine.PopIntf(Ik2TagGenerator));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aGenHead: Ik2TagGenerator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf((GeneratorsLink(aCtx, l_aTagGenerator, l_aGenHead)), TypeInfo(Ik2TagGenerator));
end;//TkwGeneratorsLink.DoDoIt

class function TkwGeneratorsLink.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'generators:Link';
end;//TkwGeneratorsLink.GetWordNameForRegister

function TkwGeneratorsLink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Ik2TagGenerator);
end;//TkwGeneratorsLink.GetResultTypeInfo

function TkwGeneratorsLink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwGeneratorsLink.GetAllParamsCount

function TkwGeneratorsLink.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ik2TagGenerator), TypeInfo(Ik2TagGenerator)]);
end;//TkwGeneratorsLink.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация скриптованой аксиоматики
 TkwFiltersAndGeneratorsPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация generators_Execute
 TkwGeneratorsExecute.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация generators_Link
 TkwGeneratorsLink.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Ik2TagGenerator
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ik2TagGenerator));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts

end.