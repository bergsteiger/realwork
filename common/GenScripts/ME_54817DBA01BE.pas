unit eeDocumentTool;

interface

uses
 l3IntfUses
 , l3Tool
 , eeInterfacesEx
;

type
 TeeDocumentTool = class(Tl3Tool)
  procedure Create(const aDocument: IeeDocumentEx);
 end;//TeeDocumentTool
 
implementation

uses
 l3ImplUses
;

end.
