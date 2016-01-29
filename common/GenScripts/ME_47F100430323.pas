unit evDocumentsCache;

interface

uses
 l3IntfUses
 , evDocumentsCachePrim
;

type
 TevDocumentsCache = class(TevDocumentsCachePrim)
  {* Кеш документов. }
 end;//TevDocumentsCache
 
implementation

uses
 l3ImplUses
 , nevDocumentContainerList
;

end.
