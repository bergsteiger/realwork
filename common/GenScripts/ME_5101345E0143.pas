unit TaskPanelWords;

interface

uses
 l3IntfUses
 , nscTasksPanelView
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopTaskPanelGetHideField = class(TtfwClassLike)
  {* Слово скрипта pop:TaskPanel:GetHideField
*Тип результата:* TnscTasksPanelHideField
*Пример:*
[code]
OBJECT VAR l_TnscTasksPanelHideField
 anIndex aTaskPanel pop:TaskPanel:GetHideField >>> l_TnscTasksPanelHideField
[code]  }
  function GetHideField(const aCtx: TtfwContext;
   aTaskPanel: TnscTasksPanelView;
   anIndex: Integer): TnscTasksPanelHideField;
   {* Реализация слова скрипта pop:TaskPanel:GetHideField }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTaskPanelGetHideField
 
 TkwPopTaskPanelCount = class(TtfwPropertyLike)
  {* Слово скрипта pop:TaskPanel:Count
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTaskPanel pop:TaskPanel:Count >>> l_Integer
[code]  }
  function Count(const aCtx: TtfwContext;
   aTaskPanel: TnscTasksPanelView): Integer;
   {* Реализация слова скрипта pop:TaskPanel:Count }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTaskPanelCount
 
end.
