unit kwScrollInfoWord;

interface

uses
 l3IntfUses
 , kwWinControlFromStackWord
 , Windows
 , tfwScriptingInterfaces
 , Controls
;

type
 TkwScrollInfoWord = class(TkwWinControlFromStackWord)
  procedure DoScrollInfo(const aCtx: TtfwContext);
  procedure DoWinControl(aControl: TWinControl;
   const aCtx: TtfwContext);
 end;//TkwScrollInfoWord
 
implementation

uses
 l3ImplUses
;

end.
