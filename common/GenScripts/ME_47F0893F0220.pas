unit nevInternalInterfaces;

interface

uses
 l3IntfUses
 , nevTools
 , l3Variant
 , l3Interfaces
 , nevBase
 , k2Base
;

type
 Tk2CustomReader = record
 end;//Tk2CustomReader
 
 InevTextSourceInternal = interface(InevTextSource)
 end;//InevTextSourceInternal
 
 InevTextSourcePool = interface(InevTextSourceInternal)
 end;//InevTextSourcePool
 
 Tk2TagGenerator = record
 end;//Tk2TagGenerator
 
 InevDocumentContainerInternal = interface
  procedure GetReader(aFormat: TnevFormat;
   const aPool: IStream;
   out theReader: Tk2CustomReader;
   anInternal: Boolean;
   aCodePage: Integer;
   const aBlock: IUnknown);
  procedure GetWriter(aFormat: TnevFormat;
   anInternal: Boolean;
   out theWriter: Tk2TagGenerator;
   const aFilters: InevTagGenerator;
   aCodePage: Integer); overload;
 end;//InevDocumentContainerInternal
 
 TnevFilerEvents = record
 end;//TnevFilerEvents
 
implementation

uses
 l3ImplUses
;

end.
