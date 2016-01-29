unit nevDocumentContainerListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TnevDocumentContainerListPrim = class(_l3InterfaceRefList_)
  {* Список контейнеров документов. }
 end;//TnevDocumentContainerListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
