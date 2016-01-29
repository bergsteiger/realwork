unit evDocumentPartGeneratorPrim;

interface

uses
 l3IntfUses
 , evHighLevelDocumentGenerator
 , evGeneratorsInterfaces
 , nevBase
;

type
 TevDocumentPartGeneratorPrim = class(TevHighLevelDocumentGenerator, IevJoinGenerator)
  procedure AtEndChanged;
  function NeedJoin: Boolean;
   {* —войство определ€ющее надо ли объедин€ть параграфы при вставке }
  function AtEnd: Boolean;
  function NeedSkipSubDocuments: Boolean;
  function LoadFlags: TevLoadFlags;
   {* ‘лаги загрузки }
 end;//TevDocumentPartGeneratorPrim
 
implementation

uses
 l3ImplUses
;

end.
