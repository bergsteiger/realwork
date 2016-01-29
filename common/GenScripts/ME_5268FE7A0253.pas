unit ddParaList;

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddDocumentAtomList
 , ddTypes
 , k2Interfaces
 , ddCustomDestination
;

type
 TddParaList = class(TddDocumentAtom)
  procedure AddList(aList: TddParaList);
  procedure AddPara;
  procedure CloseLevel;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aNeedProcessRow: Boolean;
   LiteVersion: Boolean);
 end;//TddParaList
 
implementation

uses
 l3ImplUses
 , ddTextParagraph
 , l3Base
 , SysUtils
 , l3String
;

end.
