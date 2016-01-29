unit evDeadCursor;

interface

uses
 l3IntfUses
 , nevTools
;

type
 TevDeadCursor = class(IevSavedCursor)
  procedure Store(const Cursor: InevBasePoint);
  procedure Load(const Cursor: InevBasePoint);
  function Clone: IevSavedCursor;
 end;//TevDeadCursor
 
 TevDeadCursorParent = class(TevDeadCursor)
 end;//TevDeadCursorParent
 
 TevTextParaDeadCursor = class(TevDeadCursor)
 end;//TevTextParaDeadCursor
 
implementation

uses
 l3ImplUses
;

end.
