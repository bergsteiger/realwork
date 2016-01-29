unit AllChildreCountTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorPrim
 , l3Filer
 , l3Variant
;

type
 TAllChildreCountTest = class(TTextViaEditorProcessorPrim)
  {* “ест дл€ подсчета количества AllChildrenCount у тегов документа. }
  procedure CheckTag(aTag: Tl3Tag);
  procedure DoIt;
 end;//TAllChildreCountTest
 
implementation

uses
 l3ImplUses
 , l3Types
 , SysUtils
 , k2Tags
 , TestFrameWork
;

end.
