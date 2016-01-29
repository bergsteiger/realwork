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
  {* *Описание*: возвращает меню для саба на сабпанели.
*Формат:*
[code]
aSubPanel aSubPanelSub SubPanel:GetPopupMenuForSub
[code]
aSubPanel - контрол саб панели.
aSubPanelSub - объект класса TevSubPanelSub }
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
