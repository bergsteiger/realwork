unit kwSubPanelGetPopupMenuForSub;

interface

uses
 l3IntfUses
 , kwSubPanelFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubPanelGetPopupMenuForSub = class(TkwSubPanelFromStackWord)
  {* *��������*: ���������� ���� ��� ���� �� ���������.
*������:*
[code]
aSubPanel aSubPanelSub SubPanel:GetPopupMenuForSub
[code]
aSubPanel - ������� ��� ������.
aSubPanelSub - ������ ������ TevSubPanelSub }
  procedure DoWithSubPanel(aControl: TevCustomSubPanel;
   const aCtx: TtfwContext);
 end;//TkwSubPanelGetPopupMenuForSub
 
implementation

uses
 l3ImplUses
 , evSubPanelSub
 , nevFacade
 , l3Interfaces
 , Types
 , l3PopupMenuHelper
;

end.
