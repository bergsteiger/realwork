unit ddDocument;

interface

uses
 l3IntfUses
 , k2CustomFileGenerator
 , k2Interfaces
 , l3_Base
;

type
 TddDocumentGenerator = class(Tk2CustomFileGenerator)
  procedure DoStartBlock;
  procedure DoCloseBlock;
  procedure Apply2Sub(AtomIndex: LongInt;
   const Value: Tk2Variant);
  procedure DoStartDocument;
  function NeedWritePara: Boolean;
   {* Ручки "наружу" для Writer'а. Писать или не писать параграф в зависимости от стиля. }
  function BlockIndent: Integer;
   {* Ручки "наружу" для Writer'а. Отступ для дочернего параграфа. }
  function IgnoreLeftIndent: Boolean;
  procedure CheckFilterPara(aFromFilter: Boolean);
 end;//TddDocumentGenerator
 
 TddDocument = class(Tl3_Base)
 end;//TddDocument
 
implementation

uses
 l3ImplUses
 , evdAllParaEliminator
;

end.
