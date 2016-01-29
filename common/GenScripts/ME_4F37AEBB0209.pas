unit kwWordPtrPushWord;

interface

uses
 l3IntfUses
 , kwWordPtrWorker
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TkwWordPtrPushWord = class(TkwWordPtrWorker)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWordPtrPushWord
 
implementation

uses
 l3ImplUses
;

end.
