unit evDocumentPreview;

interface

uses
 l3IntfUses
 , evDocumentPreviewPrim
 , afwInterfaces
 , nevTools
 , nevBase
 , l3Variant
;

type
 TevDocumentPreview = class(TevDocumentPreviewPrim)
  {* ��������������� �������� ������ ��������� }
  function Make(const aText: InevStorable;
   const aKey: TevPreviewCacheKey;
   const aHAF: IafwHAFPainter): IafwDocumentPreview; overload;
  function Make(const aText: InevDocumentProvider;
   const aKey: TevPreviewCacheKey;
   const aHAF: IafwHAFPainter): IafwDocumentPreview; overload;
  function Make(aText: Tl3Variant;
   const aKey: TevPreviewCacheKey;
   const aHAF: IafwHAFPainter): IafwDocumentPreview; overload;
 end;//TevDocumentPreview
 
implementation

uses
 l3ImplUses
;

end.
