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
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *553252BF022Dimpl_uses*
 //#UC END# *553252BF022Dimpl_uses*
;

type
 TkwPopFormFormStyle = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:FormStyle }
  private
   function pop_form_FormStyle(const aCtx: TtfwContext;
    aForm: TCustomForm): TFormStyle;
    {* Реализация слова скрипта pop:form:FormStyle }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormFormStyle

 TCustomFormProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TCustomFormProcessingPackResNameGetter

function TkwPopFormFormStyle.pop_form_FormStyle(const aCtx: TtfwContext;
 aForm: TCustomForm): TFormStyle;
 {* Реализация слова скрипта pop:form:FormStyle }
//#UC START# *553252FA01E0_553252FA01E0_484529DC0276_Word_var*
//#UC END# *553252FA01E0_553252FA01E0_484529DC0276_Word_var*
begin
//#UC START# *553252FA01E0_553252FA01E0_484529DC0276_Word_impl*
 Result := TForm(aForm).FormStyle;
//#UC END# *553252FA01E0_553252FA01E0_484529DC0276_Word_impl*
end;//TkwPopFormFormStyle.pop_form_FormStyle

class function TkwPopFormFormStyle.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FormStyle';
end;//TkwPopFormFormStyle.GetWordNameForRegister

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

class function TCustomFormProcessingPackResNameGetter.ResName: AnsiString;
begin
 Result := 'CustomFormProcessingPack';
end;//TCustomFormProcessingPackResNameGetter.ResName

{$R CustomFormProcessingPack.res}

initialization
 TkwPopFormFormStyle.RegisterInEngine;
 {* Регистрация pop_form_FormStyle }
 TCustomFormProcessingPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomForm));
 {* Регистрация типа TCustomForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TFormStyle));
 {* Регистрация типа TFormStyle }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
