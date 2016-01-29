unit tb97WordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$tb97"
// Модуль: "tb97WordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$tb97::tb97Words::tb97WordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoTB97)}
uses
  tb97Ctls,
  tfwScriptingInterfaces,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts AND not NoTB97

implementation

{$If not defined(NoScripts) AND not defined(NoTB97)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopTB97ButtonDown = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:TB97Button:Down
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTB97Button pop:TB97Button:Down >>> l_Boolean
[code]  }
 private
 // private methods
   function Down(const aCtx: TtfwContext;
    aTB97Button: TCustomToolbarButton97): Boolean;
     {* Реализация слова скрипта pop:TB97Button:Down }
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
 end;//TkwPopTB97ButtonDown

// start class TkwPopTB97ButtonDown

function TkwPopTB97ButtonDown.Down(const aCtx: TtfwContext;
  aTB97Button: TCustomToolbarButton97): Boolean;
 {-}
begin
 Result := aTB97Button.Down;
end;//TkwPopTB97ButtonDown.Down

procedure TkwPopTB97ButtonDown.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTB97Button : TCustomToolbarButton97;
begin
 try
  l_aTB97Button := TCustomToolbarButton97(aCtx.rEngine.PopObjAs(TCustomToolbarButton97));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTB97Button: TCustomToolbarButton97 : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Down(aCtx, l_aTB97Button)));
end;//TkwPopTB97ButtonDown.DoDoIt

class function TkwPopTB97ButtonDown.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TB97Button:Down';
end;//TkwPopTB97ButtonDown.GetWordNameForRegister

procedure TkwPopTB97ButtonDown.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Down', aCtx);
end;//TkwPopTB97ButtonDown.SetValuePrim

function TkwPopTB97ButtonDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTB97ButtonDown.GetResultTypeInfo

function TkwPopTB97ButtonDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTB97ButtonDown.GetAllParamsCount

function TkwPopTB97ButtonDown.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomToolbarButton97)]);
end;//TkwPopTB97ButtonDown.ParamsTypes
{$IfEnd} //not NoScripts AND not NoTB97

initialization
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация pop_TB97Button_Down
 TkwPopTB97ButtonDown.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация типа TCustomToolbarButton97
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomToolbarButton97));
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoTB97

end.