unit nevDocumentProviderEx;

interface

uses
 l3IntfUses
 , nevDocumentProvider
 , afwInterfaces
 , l3Variant
 , nevTools
 , l3Interfaces
;

type
 TnevDocumentProviderEx = class(TnevDocumentProvider, IafwPageSetup)
  procedure Create(const aStorable: InevStorable;
   aDocument: Tl3Variant);
  function Make(const aStorable: InevStorable;
   aDocument: Tl3Variant): InevDocumentProvider;
  function Margins: TafwRect;
  function Orientation: Tl3PageOrientation;
 end;//TnevDocumentProviderEx
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Units
 , evPreviewForTestsTuning
 , afwFacade
 , SysUtils
;

end.
