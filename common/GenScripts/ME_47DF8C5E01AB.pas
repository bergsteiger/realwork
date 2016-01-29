unit afwComplexDocumentPreviewFactory;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , afwInterfaces
 , l3ObjectList
 , afwComplexDocumentPreview
;

type
 TafwComplexDocumentPreviewFactory = class(Tl3CacheableBase, IafwComplexDocumentPreviewFactory)
  {* Фабрика Предварительный просмотр печати с кэшем. }
  function MakeI: IafwComplexDocumentPreviewFactory;
  function Make: IafwComplexDocumentPreview;
  function Count: Integer;
  procedure ResetCache(ResetInfo: Boolean);
  function Item: IafwComplexDocumentPreview;
 end;//TafwComplexDocumentPreviewFactory
 
implementation

uses
 l3ImplUses
 , l3Printer
 , SysUtils
 , RTLConsts
;

type
 TafwCachedComplexDocumentPreview = class(TafwComplexDocumentPreview)
  procedure Create(aFactory: TafwComplexDocumentPreviewFactory);
 end;//TafwCachedComplexDocumentPreview
 
end.
