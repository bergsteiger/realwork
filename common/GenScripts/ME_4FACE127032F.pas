unit ddTableCell;

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddCellProperty
 , ddTextParagraph
 , ddDocumentAtomList
 , k2Interfaces
 , ddCustomDestination
 , l3ProtoObject
;

type
 TddTableCell = class(TddDocumentAtom)
  procedure Delete(anIndex: Integer);
  procedure Add(aPara: TddDocumentAtom;
   anAssign2Last: Boolean);
  function AddParagraph: TddTextParagraph;
  function LastTableAtom: TddDocumentAtom;
   {* Возвращает последнюю открытую вложенную таблицу. }
  function IsCellEmpty: Boolean;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aNeedProcessRow: Boolean;
   LiteVersion: Boolean);
 end;//TddTableCell
 
implementation

uses
 l3ImplUses
 , ddTableRow
 , SysUtils
 , ddTable
 , ddTypes
 , k2Tags
 , evdTypes
;

end.
