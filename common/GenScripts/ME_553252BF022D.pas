unit CustomFormProcessingPack;

interface

uses
 l3IntfUses
 , Forms
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TCustomFormProcessingPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TCustomFormProcessingPackResNameGetter
 
 TkwPopFormFormStyle = class(TtfwClassLike)
  {* Слово скрипта pop:form:FormStyle
*Тип результата:* TFormStyle
*Пример:*
[code]
TFormStyle VAR l_TFormStyle
 aForm pop:form:FormStyle >>> l_TFormStyle
[code]  }
  function pop_form_FormStyle(const aCtx: TtfwContext;
   aForm: TCustomForm): TFormStyle;
   {* Реализация слова скрипта pop:form:FormStyle }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormFormStyle
 
end.
