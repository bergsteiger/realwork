unit evDocumentsCachePrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3DocumentsCacheService
;

type
 TevDocumentsCacheService = class(Tl3ProtoObject, Il3DocumentsCacheService)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure Clear;
 end;//TevDocumentsCacheService
 
 TevDocumentsCachePrim = class
 end;//TevDocumentsCachePrim
 
implementation

uses
 l3ImplUses
 , evDocumentsCache
;

end.
