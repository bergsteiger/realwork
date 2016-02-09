unit kwVTControlsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwVTControlsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DragData
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwDDSupportGetState = {final} class(TtfwGlobalKeyWord)
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
   function DDSupport_GetState(const aCtx: TtfwContext): TDragDataState;
    {* Реализация слова скрипта DDSupport:GetState }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDDSupportGetState

function TkwDDSupportGetState.DDSupport_GetState(const aCtx: TtfwContext): TDragDataState;
 {* Реализация слова скрипта DDSupport:GetState }
//#UC START# *7A2DDC297C52_765DA382B537_var*
//#UC END# *7A2DDC297C52_765DA382B537_var*
begin
//#UC START# *7A2DDC297C52_765DA382B537_impl*
 Result := TDragDataSupport.Instance.DragState; 
//#UC END# *7A2DDC297C52_765DA382B537_impl*
end;//TkwDDSupportGetState.DDSupport_GetState

procedure TkwDDSupportGetState.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_765DA382B537_var*
//#UC END# *4DAEEDE10285_765DA382B537_var*
begin
//#UC START# *4DAEEDE10285_765DA382B537_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_765DA382B537_impl*
end;//TkwDDSupportGetState.DoDoIt

class function TkwDDSupportGetState.GetWordNameForRegister: AnsiString;
begin
 Result := 'DDSupport:GetState';
end;//TkwDDSupportGetState.GetWordNameForRegister

function TkwDDSupportGetState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_765DA382B537_var*
//#UC END# *551544E2001A_765DA382B537_var*
begin
//#UC START# *551544E2001A_765DA382B537_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_765DA382B537_impl*
end;//TkwDDSupportGetState.GetResultTypeInfo

function TkwDDSupportGetState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDDSupportGetState.GetAllParamsCount

function TkwDDSupportGetState.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_765DA382B537_var*
//#UC END# *5617F4D00243_765DA382B537_var*
begin
//#UC START# *5617F4D00243_765DA382B537_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_765DA382B537_impl*
end;//TkwDDSupportGetState.ParamsTypes

initialization
 TkwDDSupportGetState.RegisterInEngine;
 {* Регистрация DDSupport_GetState }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDragDataState));
 {* Регистрация типа TDragDataState }
{$IfEnd} // NOT Defined(NoScripts)

end.
