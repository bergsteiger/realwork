unit StatusPanelWordsPack;

interface

uses
 l3IntfUses
 , vtStatusBar
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
 TkwPopStatusPanelGetText = class(TtfwClassLike)
  {* Слово скрипта pop:vtStatusPanel:GetText
[panel]*Описание:* Возвращает текст панели
*Формат:* 
[code]
aPanel pop:vtStatusPanel:GetText
[code]
aPanel - объект класса TvtStatusPanel, который можно получить с помощью pop:vtStatusPanel:GetText[panel]
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aStatusPanel pop:vtStatusPanel:GetText >>> l_String
[code]  }
  function GetText(const aCtx: TtfwContext;
   aStatusPanel: TvtStatusPanel): AnsiString;
   {* Реализация слова скрипта pop:vtStatusPanel:GetText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopStatusPanelGetText
 
end.
