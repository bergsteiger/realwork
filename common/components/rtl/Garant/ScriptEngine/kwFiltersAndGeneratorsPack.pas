unit kwFiltersAndGeneratorsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwFiltersAndGeneratorsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Variant
 , l3Interfaces
 , Classes
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , k2EVDReaderService
 , k2EVDWriterService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *9EE368A1435Dci*
 //#UC END# *9EE368A1435Dci*
 //#UC START# *9EE368A1435Dcit*
 //#UC END# *9EE368A1435Dcit*
 TkwFiltersAndGeneratorsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *9EE368A1435Dpubl*
 //#UC END# *9EE368A1435Dpubl*
 end;//TkwFiltersAndGeneratorsPackResNameGetter

 TkwGeneratorsExecute = {final} class(TtfwClassLike)
  {* Слово скрипта generators:Execute
[panel]Берёт со стека имя имя входного файла (EVD) и генератор (или цепочку). Затем делает трубу и прогоняет через неё файл.[panel]
*Пример:*
[code]
 aFileName aTagGenerator generators:Execute
[code]  }
  private
   procedure generators_Execute(const aCtx: TtfwContext;
    const aTagGenerator: Ik2TagGenerator;
    const aFileName: AnsiString);
    {* Реализация слова скрипта generators:Execute }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGeneratorsExecute

 TkwGeneratorsLink = {final} class(TtfwClassLike)
  {* Слово скрипта generators:Link
[panel]Берёт со стека два генератора и делает из них цепочку. В результате на стеке остаётся один генератор (к которому подклеен другой)[panel]
*Тип результата:* Ik2TagGenerator
*Пример:*
[code]
INTERFACE VAR l_Ik2TagGenerator
 aGenHead aTagGenerator generators:Link >>> l_Ik2TagGenerator
[code]  }
  private
   function generators_Link(const aCtx: TtfwContext;
    const aTagGenerator: Ik2TagGenerator;
    const aGenHead: Ik2TagGenerator): Ik2TagGenerator;
    {* Реализация слова скрипта generators:Link }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGeneratorsLink

class function TkwFiltersAndGeneratorsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'kwFiltersAndGeneratorsPack';
end;//TkwFiltersAndGeneratorsPackResNameGetter.ResName

 {$R kwFiltersAndGeneratorsPack.res}

procedure TkwGeneratorsExecute.generators_Execute(const aCtx: TtfwContext;
 const aTagGenerator: Ik2TagGenerator;
 const aFileName: AnsiString);
 {* Реализация слова скрипта generators:Execute }
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
end;//TkwGeneratorsExecute.generators_Execute

procedure TkwGeneratorsExecute.DoDoIt(const aCtx: TtfwContext);
var l_aTagGenerator: Ik2TagGenerator;
var l_aFileName: AnsiString;
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
 generators_Execute(aCtx, l_aTagGenerator, l_aFileName);
end;//TkwGeneratorsExecute.DoDoIt

class function TkwGeneratorsExecute.GetWordNameForRegister: AnsiString;
begin
 Result := 'generators:Execute';
end;//TkwGeneratorsExecute.GetWordNameForRegister

function TkwGeneratorsExecute.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGeneratorsExecute.GetResultTypeInfo

function TkwGeneratorsExecute.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwGeneratorsExecute.GetAllParamsCount

function TkwGeneratorsExecute.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ik2TagGenerator), @tfw_tiString]);
end;//TkwGeneratorsExecute.ParamsTypes

function TkwGeneratorsLink.generators_Link(const aCtx: TtfwContext;
 const aTagGenerator: Ik2TagGenerator;
 const aGenHead: Ik2TagGenerator): Ik2TagGenerator;
 {* Реализация слова скрипта generators:Link }
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
end;//TkwGeneratorsLink.generators_Link

procedure TkwGeneratorsLink.DoDoIt(const aCtx: TtfwContext);
var l_aTagGenerator: Ik2TagGenerator;
var l_aGenHead: Ik2TagGenerator;
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
 aCtx.rEngine.PushIntf(generators_Link(aCtx, l_aTagGenerator, l_aGenHead), TypeInfo(Ik2TagGenerator));
end;//TkwGeneratorsLink.DoDoIt

class function TkwGeneratorsLink.GetWordNameForRegister: AnsiString;
begin
 Result := 'generators:Link';
end;//TkwGeneratorsLink.GetWordNameForRegister

function TkwGeneratorsLink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Ik2TagGenerator);
end;//TkwGeneratorsLink.GetResultTypeInfo

function TkwGeneratorsLink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwGeneratorsLink.GetAllParamsCount

function TkwGeneratorsLink.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ik2TagGenerator), TypeInfo(Ik2TagGenerator)]);
end;//TkwGeneratorsLink.ParamsTypes

initialization
 TkwFiltersAndGeneratorsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwGeneratorsExecute.RegisterInEngine;
 {* Регистрация generators_Execute }
 TkwGeneratorsLink.RegisterInEngine;
 {* Регистрация generators_Link }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ik2TagGenerator));
 {* Регистрация типа Ik2TagGenerator }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
{$IfEnd} // NOT Defined(NoScripts)

end.
