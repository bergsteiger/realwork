unit evCustomTextSource;

interface

uses
 l3IntfUses
 , l3InterfacedComponent
 , nevTools
 , nevBase
 , l3Variant
;

type
 TevGetControlItemImgEvent = procedure(aSender: TObject;
  const aControl: TnevControlInfo;
  out theImageInfo: TnevControlImageInfo) of object;
 
 TevDocumentChangedEvent = procedure(aSender: TObject;
  anOldDocument: Tl3Tag;
  aNewDocument: Tl3Tag) of object;
 
 TevCustomTextSource = class(Tl3InterfacedComponent)
  {* Реализация источника документа. }
  function DoMakeDocumentContainer: InevDocumentContainer;
 end;//TevCustomTextSource
 
implementation

uses
 l3ImplUses
;

end.
