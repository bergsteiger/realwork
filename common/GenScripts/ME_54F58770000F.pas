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
begin
 Result := aRadioGroup.ItemIndex;
end;//TkwPopRadioGroupItemIndex.ItemIndex

procedure TkwPopRadioGroupItemIndex.DoDoIt(const aCtx: TtfwContext);
var l_aRadioGroup: TRadioGroup;
begin
 try
  l_aRadioGroup := TRadioGroup(aCtx.rEngine.PopObjAs(TRadioGroup));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRadioGroup: TRadioGroup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(ItemIndex(aCtx, l_aRadioGroup));
end;//TkwPopRadioGroupItemIndex.DoDoIt

class function TkwPopRadioGroupItemIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RadioGroup:ItemIndex';
end;//TkwPopRadioGroupItemIndex.GetWordNameForRegister

procedure TkwPopRadioGroupItemIndex.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_RadioGroup: TRadioGroup;
begin
 try
  l_RadioGroup := TRadioGroup(aCtx.rEngine.PopObjAs(TRadioGroup));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра RadioGroup: TRadioGroup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_RadioGroup.ItemIndex := aValue.AsInt;
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
begin
 Result := OpenTypesToTypes([TypeInfo(TRadioGroup)]);
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
