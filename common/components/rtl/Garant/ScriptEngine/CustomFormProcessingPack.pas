unit CustomFormProcessingPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "CustomFormProcessingPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::FormsProcessing::CustomFormProcessingPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  Forms,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *C209DE35C0DBci*
//#UC END# *C209DE35C0DBci*
//#UC START# *C209DE35C0DBcit*
//#UC END# *C209DE35C0DBcit*
 TCustomFormProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *C209DE35C0DBpubl*
//#UC END# *C209DE35C0DBpubl*
 end;//TCustomFormProcessingPackResNameGetter

// start class TCustomFormProcessingPackResNameGetter

class function TCustomFormProcessingPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'CustomFormProcessingPack';
end;//TCustomFormProcessingPackResNameGetter.ResName

 {$R CustomFormProcessingPack.res}

type
 TkwPopFormFormStyle = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:form:FormStyle
*Тип результата:* TFormStyle
*Пример:*
[code]
TFormStyle VAR l_TFormStyle
 aForm pop:form:FormStyle >>> l_TFormStyle
[code]  }
 private
 // private methods
   function PopFormFormStyle(const aCtx: TtfwContext;
    aForm: TCustomForm): TFormStyle;
     {* Реализация слова скрипта pop:form:FormStyle }
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
 end;//TkwPopFormFormStyle

// start class TkwPopFormFormStyle

function TkwPopFormFormStyle.PopFormFormStyle(const aCtx: TtfwContext;
  aForm: TCustomForm): TFormStyle;
//#UC START# *BCF4960E4290_3ADE91F9FA16_var*
//#UC END# *BCF4960E4290_3ADE91F9FA16_var*
begin
//#UC START# *BCF4960E4290_3ADE91F9FA16_impl*
 Result := TForm(aForm).FormStyle;
//#UC END# *BCF4960E4290_3ADE91F9FA16_impl*
end;//TkwPopFormFormStyle.PopFormFormStyle

procedure TkwPopFormFormStyle.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aForm : TCustomForm;
begin
 try
  l_aForm := TCustomForm(aCtx.rEngine.PopObjAs(TCustomForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TCustomForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(PopFormFormStyle(aCtx, l_aForm)));
end;//TkwPopFormFormStyle.DoDoIt

class function TkwPopFormFormStyle.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:form:FormStyle';
end;//TkwPopFormFormStyle.GetWordNameForRegister

function TkwPopFormFormStyle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TFormStyle);
end;//TkwPopFormFormStyle.GetResultTypeInfo

function TkwPopFormFormStyle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopFormFormStyle.GetAllParamsCount

function TkwPopFormFormStyle.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomForm)]);
end;//TkwPopFormFormStyle.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация скриптованой аксиоматики
 TCustomFormProcessingPackResNameGetter.Register;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_form_FormStyle
 TkwPopFormFormStyle.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TCustomForm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomForm));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TFormStyle
 TtfwTypeRegistrator.RegisterType(TypeInfo(TFormStyle));
{$IfEnd} //not NoScripts AND not NoVCL

end.