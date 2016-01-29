unit kwPopQueryCardAttributeGetLogicOperation;

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
 TkwPopQueryCardAttributeGetLogicOperation = class(TkwQueryCardFromStackWord)
  procedure DoModelImpl;
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardAttributeGetLogicOperation
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

end.
