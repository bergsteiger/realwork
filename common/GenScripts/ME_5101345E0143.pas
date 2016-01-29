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
  {* ����� ������� pop:TaskPanel:GetHideField
*��� ����������:* TnscTasksPanelHideField
*������:*
[code]
OBJECT VAR l_TnscTasksPanelHideField
 anIndex aTaskPanel pop:TaskPanel:GetHideField >>> l_TnscTasksPanelHideField
[code]  }
  function GetHideField(const aCtx: TtfwContext;
   aTaskPanel: TnscTasksPanelView;
   anIndex: Integer): TnscTasksPanelHideField;
   {* ���������� ����� ������� pop:TaskPanel:GetHideField }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTaskPanelGetHideField
 
 TkwPopTaskPanelCount = class(TtfwPropertyLike)
  {* ����� ������� pop:TaskPanel:Count
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aTaskPanel pop:TaskPanel:Count >>> l_Integer
[code]  }
  function Count(const aCtx: TtfwContext;
   aTaskPanel: TnscTasksPanelView): Integer;
   {* ���������� ����� ������� pop:TaskPanel:Count }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTaskPanelCount
 
end.
