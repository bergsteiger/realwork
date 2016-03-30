unit NOT_FINISHED_nevInternalInterfaces;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_FINISHED_nevInternalInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "nevInternalInterfaces" MUID: (47F0893F0220)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , k2Interfaces
 , nevBase
 , nevTools
 , l3Variant
 , k2Base
;

type
 Tk2CustomReader = record
 end;//Tk2CustomReader

 InevTextSourceInternal = interface(InevTextSource)
  ['{28580DD6-BCA0-4FFF-974B-E2764E2BB32C}']
 end;//InevTextSourceInternal

 InevTextSourcePool = interface(InevTextSourceInternal)
  ['{0E55EAAC-B0DB-43F2-81E3-3B51B4F0368F}']
 end;//InevTextSourcePool

 Tk2TagGenerator = record
 end;//Tk2TagGenerator

 InevDocumentContainerInternal = interface
  ['{C8427D82-9DCF-4351-B710-B4977FA3A5E9}']
  function Get_InternalDocument: Tl3Tag;
  procedure GetReader(aFormat: TnevFormat;
   const aPool: IStream;
   out theReader: Tk2CustomReader;
   anInternal: Boolean = True;
   aCodePage: Integer = CP_DefaultValue;
   const aBlock: IUnknown = nil);
  procedure GetWriter(aFormat: TnevFormat;
   anInternal: Boolean;
   out theWriter: Tk2TagGenerator;
   const aFilters: InevTagGenerator;
   aCodePage: Integer = CP_DefaultValue); overload;
  property InternalDocument: Tl3Tag
   read Get_InternalDocument;
   {* документ. }
 end;//InevDocumentContainerInternal

 TnevFilerEvents = record
 end;//TnevFilerEvents

implementation

uses
 l3ImplUses
;

end.
