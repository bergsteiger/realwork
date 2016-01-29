unit kwWinControlFromStackWord;

interface

uses
 l3IntfUses
 , Controls
 , tfwScriptingInterfaces
;

type
 TkwWinControlFromStackWord = class(_kwControlFromStackWord_)
  procedure DoWinControl(aControl: TWinControl;
   const aCtx: TtfwContext);
  procedure DoControl(aControl: TControl;
   const aCtx: TtfwContext);
 end;//TkwWinControlFromStackWord
 
implementation

uses
 l3ImplUses
;

end.
