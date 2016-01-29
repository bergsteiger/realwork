unit TestDocumentList;

interface

uses
 l3IntfUses
 , l3StringList
;

type
 TTestDocumentList = class(Tl3StringList)
  function Exists: Boolean;
 end;//TTestDocumentList
 
implementation

uses
 l3ImplUses
;

end.
