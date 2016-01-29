unit kwPopQueryCardGetCurrentReqName;

interface

uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
;

type
 TkwPopQueryCardGetCurrentReqName = class(TkwQueryCardFromStackWord)
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardGetCurrentReqName
 
implementation

uses
 l3ImplUses
 , evQueryCardInt
;

end.
