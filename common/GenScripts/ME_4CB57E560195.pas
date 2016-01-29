unit nevDocumentProvider;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
 , l3Variant
 , afwInterfaces
 , nevBase
 , evdInterfaces
;

type
 TnevDocumentProvider = class(Tl3ProtoObject, InevDocumentProvider)
  procedure Create(const aStorable: InevStorable);
  function Make(const aStorable: InevStorable): InevDocumentProvider;
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* сохраняет выделение в G. }
  function CanProvideOriginalDocument: Boolean;
  function PageSetup: IafwPageSetup;
   {* Параметры страницы }
  function OriginalDocument: Tl3Variant;
 end;//TnevDocumentProvider
 
implementation

uses
 l3ImplUses
 , afwFacade
 , evPreviewForTestsTuning
;

end.
