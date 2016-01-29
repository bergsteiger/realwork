unit evDocumentPreviewInfoList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TevDocumentPreviewInfoList = class(_l3InterfaceRefList_)
  procedure StopAllPreviews;
   {* Остановить построение превью }
 end;//TevDocumentPreviewInfoList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
