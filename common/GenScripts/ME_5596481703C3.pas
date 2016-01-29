unit ddRTFShape;

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddDocumentAtomList
 , ddRTFState
 , destNorm
 , ddPicture
 , ddTextParagraph
 , k2Interfaces
 , ddCustomDestination
;

type
 TddRTFShape = class(TddDocumentAtom)
  {* Объект для работы с Shape и извлечением из них нужной информации. }
  procedure Append(aState: TddRTFState;
   aDest: TdestNorm);
  procedure AddPicture(aPicture: TddPicture;
   aState: TddRTFState);
  function BottomAndRight(aShape: TddRTFShape): Boolean;
  function AddTextPara: TddTextParagraph;
  function LastPara: TddTextParagraph;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aNeedProcessRow: Boolean;
   LiteVersion: Boolean);
 end;//TddRTFShape
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ddParagraphProperty
 , l3MinMax
 , ddTable
;

end.
