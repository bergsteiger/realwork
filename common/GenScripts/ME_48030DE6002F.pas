unit evDocumentPartGenerator;

interface

uses
 l3IntfUses
 , evDocumentPartGeneratorPrim
 , l3Variant
 , nevTools
;

type
 TevDocumentPartGenerator = class(TevDocumentPartGeneratorPrim)
  {* Реализация генератора для вставки текста в то место куда указывает курсор. }
  procedure SetInsertionPoint(const aPoint: InevBasePoint;
   aPID: Integer);
  procedure InsertPara(aChild: Tl3Variant);
  procedure StartInsertion;
  procedure FinishInsertion;
  function InsertTable(aChild: Tl3Variant): Boolean;
  procedure AtEndChanged;
 end;//TevDocumentPartGenerator
 
implementation

uses
 l3ImplUses
;

end.
