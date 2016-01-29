unit RadioGroupWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "RadioGroupWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ExtControlsProcessing::RadioGroupWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  ExtCtrls,
  tfwScriptingInterfaces,
  tfwPropertyLike
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
 TkwPopRadioGroupItemIndex = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RadioGroup:ItemIndex
[panel]Индекс элемента[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRadioGroup pop:RadioGroup:ItemIndex >>> l_Integer
[code]  }
 private
 // private methods
   function ItemIndex(const aCtx: TtfwContext;
    aRadioGroup: TRadioGroup): Integer;
     {* Реализация слова скрипта pop:RadioGroup:ItemIndex }
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
 end;//TkwPopRadioGroupItemIndex

// start class TkwPopRadioGroupItemIndex

function TkwPopRadioGroupItemIndex.ItemIndex(const aCtx: TtfwContext;
  aRadioGroup: TRadioGroup): Integer;
 {-}
begin
 Result := aRadioGroup.ItemIndex;
end;//TkwPopRadioGroupItemIndex.ItemIndex

procedure TkwPopRadioGroupItemIndex.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRadioGroup : TRadioGroup;
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
 aCtx.rEngine.PushInt((ItemIndex(aCtx, l_aRadioGroup)));
end;//TkwPopRadioGroupItemIndex.DoDoIt

class function TkwPopRadioGroupItemIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RadioGroup:ItemIndex';
end;//TkwPopRadioGroupItemIndex.GetWordNameForRegister

procedure TkwPopRadioGroupItemIndex.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_RadioGroup: TRadioGroup;
begin
 try
  l_RadioGroup := TRadioGroup(aCtx.rEngine.PopObjAs(TRadioGroup));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_RadioGroup: TRadioGroup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_RadioGroup.ItemIndex := (aValue.AsInt);
end;//TkwPopRadioGroupItemIndex.SetValuePrim

function TkwPopRadioGroupItemIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopRadioGroupItemIndex.GetResultTypeInfo

function TkwPopRadioGroupItemIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRadioGroupItemIndex.GetAllParamsCount

function TkwPopRadioGroupItemIndex.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRadioGroup)]);
end;//TkwPopRadioGroupItemIndex.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_RadioGroup_ItemIndex
 TkwPopRadioGroupItemIndex.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TRadioGroup
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRadioGroup));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoVCL

end.