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
  {* ����� ������� DDSupport:GetState
[panel]���������� ������ ��������� DDSupport
������: 
[code]
DDSupport:GetState
[code][panel]
*��� ����������:* TDragDataState
*������:*
[code]
TDragDataState VAR l_TDragDataState
 DDSupport:GetState >>> l_TDragDataState
[code]  }
  function DDSupport_GetState(const aCtx: TtfwContext): TDragDataState;
   {* ���������� ����� ������� DDSupport:GetState }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDDSupportGetState
 
end.
