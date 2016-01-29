unit csIdIOHandlerAbstractAdapter;

interface

uses
 l3IntfUses
 , csIdIOHandlerAbstractAdapterPrim
;

type
 TcsIdIOHandlerAbstractAdapter = class(TcsIdIOHandlerAbstractAdapterPrim)
  procedure WriteBufferOpen(AThreshhold: Integer);
  procedure WriteBufferClose;
  procedure WriteBufferClear;
  function Connected: Boolean;
  procedure WriteFile(const aFile: AnsiString);
  procedure InputBufferClear;
 end;//TcsIdIOHandlerAbstractAdapter
 
implementation

uses
 l3ImplUses
;

end.
