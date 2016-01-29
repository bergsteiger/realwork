unit kwVTControlsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$VT"
// Модуль: "kwVTControlsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::vtControlsFromStackWords::kwVTControlsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  DragData,
  tfwGlobalKeyWord
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwDDSupportGetState = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта DDSupport:GetState
[panel]Возвращает текщее состояние DDSupport
Формат: 
[code]
DDSupport:GetState
[code][panel]
*Тип результата:* TDragDataState
*Пример:*
[code]
TDragDataState VAR l_TDragDataState
 DDSupport:GetState >>> l_TDragDataState
[code]  }
 private
 // private methods
   function DDSupportGetState(const aCtx: TtfwContext): TDragDataState;
     {* Реализация слова скрипта DDSupport:GetState }
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
 end;//TkwDDSupportGetState

// start class TkwDDSupportGetState

function TkwDDSupportGetState.DDSupportGetState(const aCtx: TtfwContext): TDragDataState;
//#UC START# *7A2DDC297C52_765DA382B537_var*
//#UC END# *7A2DDC297C52_765DA382B537_var*
begin
//#UC START# *7A2DDC297C52_765DA382B537_impl*
 Result := TDragDataSupport.Instance.DragState; 
//#UC END# *7A2DDC297C52_765DA382B537_impl*
end;//TkwDDSupportGetState.DDSupportGetState

procedure TkwDDSupportGetState.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt(Ord(DDSupportGetState(aCtx)));
end;//TkwDDSupportGetState.DoDoIt

class function TkwDDSupportGetState.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DDSupport:GetState';
end;//TkwDDSupportGetState.GetWordNameForRegister

function TkwDDSupportGetState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TDragDataState);
end;//TkwDDSupportGetState.GetResultTypeInfo

function TkwDDSupportGetState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwDDSupportGetState.GetAllParamsCount

function TkwDDSupportGetState.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwDDSupportGetState.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация DDSupport_GetState
 TkwDDSupportGetState.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TDragDataState
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDragDataState));
{$IfEnd} //not NoScripts

end.