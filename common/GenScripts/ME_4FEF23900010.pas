unit kwPopQueryCardAttributeGetCollapsed;

interface

uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
;

type
 TkwPopQueryCardAttributeGetCollapsed = class(TkwQueryCardFromStackWord)
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardAttributeGetCollapsed
 
implementation

uses
 l3ImplUses
 , l3Interfaces
 , evQueryCardInt
 , l3String
 , evReqIterator
 , nevBase
;

end.
