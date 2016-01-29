unit kwSubPanelFromStackWord;

interface

uses
 l3IntfUses
 , evSubPn
 , tfwScriptingInterfaces
 , Controls
;

type
 TkwSubPanelFromStackWord = class(_kwControlFromStackWord_)
  procedure DoWithSubPanel(aControl: TevCustomSubPanel;
   const aCtx: TtfwContext);
  procedure DoControl(aControl: TControl;
   const aCtx: TtfwContext);
 end;//TkwSubPanelFromStackWord
 
implementation

uses
 l3ImplUses
;

end.
