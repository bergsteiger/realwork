unit CustomFormProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CustomFormProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CustomFormProcessingPack" MUID: (553252BF022D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Forms
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *C209DE35C0DBci*
 //#UC END# *C209DE35C0DBci*
 //#UC START# *C209DE35C0DBcit*
 //#UC END# *C209DE35C0DBcit*
 TCustomFormProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *C209DE35C0DBpubl*
 //#UC END# *C209DE35C0DBpubl*
 end;//TCustomFormProcessingPackResNameGetter

 TkwPopFormFormStyle = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:FormStyle
*Тип результата:* TFormStyle
*Пример:*
[code]
TFormStyle VAR l_TFormStyle
 aForm pop:form:FormStyle >>> l_TFormStyle
[code]  }
  private
   function pop_form_FormStyle(const aCtx: TtfwContext;
    aForm: TCustomForm): TFormStyle;
    {* Реализация слова скрипта pop:form:FormStyle }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormFormStyle

class function TCustomFormProcessingPackResNameGetter.ResName: AnsiString;
begin
  Result := 'CustomFormProcessingPack';
end;//TCustomFormProcessingPackResNameGetter.ResName

 {$R CustomFormProcessingPack.res}

function TkwPopFormFormStyle.pop_form_FormStyle(const aCtx: TtfwContext;
 aForm: TCustomForm): TFormStyle;
 {* Реализация слова скрипта pop:form:FormStyle }
//#UC START# *BCF4960E4290_3ADE91F9FA16_var*
//#UC END# *BCF4960E4290_3ADE91F9FA16_var*
begin
//#UC START# *BCF4960E4290_3ADE91F9FA16_impl*
 Result := TForm(aForm).FormStyle;
//#UC END# *BCF4960E4290_3ADE91F9FA16_impl*
end;//TkwPopFormFormStyle.pop_form_FormStyle

procedure TkwPopFormFormStyle.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TCustomForm;
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
 aCtx.rEngine.PushInt(Ord(pop_form_FormStyle(aCtx, l_aForm)));
end;//TkwPopFormFormStyle.DoDoIt

function TkwPopFormFormStyle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TFormStyle);
end;//TkwPopFormFormStyle.GetResultTypeInfo

function TkwPopFormFormStyle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormFormStyle.GetAllParamsCount

function TkwPopFormFormStyle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomForm)]);
end;//TkwPopFormFormStyle.ParamsTypes

class function TkwPopFormFormStyle.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FormStyle';
end;//TkwPopFormFormStyle.GetWordNameForRegister

initialization
 TCustomFormProcessingPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwPopFormFormStyle.RegisterInEngine;
 {* Регистрация pop_form_FormStyle }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomForm));
 {* Регистрация типа TCustomForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TFormStyle));
 {* Регистрация типа TFormStyle }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
