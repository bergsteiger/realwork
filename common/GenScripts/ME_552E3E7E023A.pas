unit StatusBarWordsPack;

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
 TkwPopStatusBarGetPanel = class(TtfwClassLike)
  {* Слово скрипта pop:vtStatusBar:GetPanel
[panel]*Описание:* Помещает в стек панель статусбара по номеру.
Формат:
[code]
anIndex aStatusControl pop:vtStatusBar:GetPanel
[code]
anIndex - номер панели.
aStatusControl - контрол статус-бар.
В стек помещается объект класса TvtStatusPanel[panel]
*Тип результата:* TvtStatusPanel
*Пример:*
[code]
OBJECT VAR l_TvtStatusPanel
 anIndex aStatusBar pop:vtStatusBar:GetPanel >>> l_TvtStatusPanel
[code]  }
  function GetPanel(const aCtx: TtfwContext;
   aStatusBar: TvtStatusBar;
   anIndex: Integer): TvtStatusPanel;
   {* Реализация слова скрипта pop:vtStatusBar:GetPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopStatusBarGetPanel
 
end.
