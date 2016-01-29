unit kwPopQueryCardAttributeGetFocus;

interface

uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
;

type
 TkwPopQueryCardAttributeGetFocus = class(TkwQueryCardFromStackWord)
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardAttributeGetFocus
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evQueryCardInt
;

end.
