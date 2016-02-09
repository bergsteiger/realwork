unit RadioGroupWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\RadioGroupWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , ExtCtrls
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopRadioGroupItemIndex = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:RadioGroup:ItemIndex
[panel]Индекс элемента[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRadioGroup pop:RadioGroup:ItemIndex >>> l_Integer
[code]  }
  private
   function ItemIndex(const aCtx: TtfwContext;
    aRadioGroup: TRadioGroup): Integer;
    {* Реализация слова скрипта pop:RadioGroup:ItemIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRadioGroupItemIndex

function TkwPopRadioGroupItemIndex.ItemIndex(const aCtx: TtfwContext;
 aRadioGroup: TRadioGroup): Integer;
 {* Реализация слова скрипта pop:RadioGroup:ItemIndex }
//#UC START# *E20F0AC32CE1_8E50130D7478_var*
//#UC END# *E20F0AC32CE1_8E50130D7478_var*
begin
//#UC START# *E20F0AC32CE1_8E50130D7478_impl*
 !!! Needs to be implemented !!!
//#UC END# *E20F0AC32CE1_8E50130D7478_impl*
end;//TkwPopRadioGroupItemIndex.ItemIndex

procedure TkwPopRadioGroupItemIndex.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8E50130D7478_var*
//#UC END# *4DAEEDE10285_8E50130D7478_var*
begin
//#UC START# *4DAEEDE10285_8E50130D7478_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8E50130D7478_impl*
end;//TkwPopRadioGroupItemIndex.DoDoIt

class function TkwPopRadioGroupItemIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RadioGroup:ItemIndex';
end;//TkwPopRadioGroupItemIndex.GetWordNameForRegister

procedure TkwPopRadioGroupItemIndex.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8E50130D7478_var*
//#UC END# *52D00B00031A_8E50130D7478_var*
begin
//#UC START# *52D00B00031A_8E50130D7478_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8E50130D7478_impl*
end;//TkwPopRadioGroupItemIndex.SetValuePrim

function TkwPopRadioGroupItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopRadioGroupItemIndex.GetResultTypeInfo

function TkwPopRadioGroupItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRadioGroupItemIndex.GetAllParamsCount

function TkwPopRadioGroupItemIndex.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8E50130D7478_var*
//#UC END# *5617F4D00243_8E50130D7478_var*
begin
//#UC START# *5617F4D00243_8E50130D7478_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8E50130D7478_impl*
end;//TkwPopRadioGroupItemIndex.ParamsTypes

initialization
 TkwPopRadioGroupItemIndex.RegisterInEngine;
 {* Регистрация pop_RadioGroup_ItemIndex }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRadioGroup));
 {* Регистрация типа TRadioGroup }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
