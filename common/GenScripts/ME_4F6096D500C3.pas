unit kwVTControlsPack;

interface

uses
 l3IntfUses
 , DragData
 , tfwGlobalKeyWord
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
 TkwDDSupportGetState = class(TtfwGlobalKeyWord)
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
  function DDSupport_GetState(const aCtx: TtfwContext): TDragDataState;
   {* Реализация слова скрипта DDSupport:GetState }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDDSupportGetState
 
end.
