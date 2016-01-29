unit kwPopQueryCardAttributeIsLogicOperationEnabled;

interface

uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , l3Interfaces
 , nevBase
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evQueryCardInt
;

type
 TkwPopQueryCardAttributeIsLogicOperationEnabled = class(TkwQueryCardFromStackWord)
  procedure DoModelImpl;
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardAttributeIsLogicOperationEnabled
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

end.
