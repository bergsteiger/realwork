unit SelectPtTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TSelectPtTest = class(TTextEditorVisitor)
  {* “ест вида - загрузили и ткнули в точку со смещением относительно какого-нибудь параграфа }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ќбработать текст }
 end;//TSelectPtTest
 
implementation

uses
 l3ImplUses
 , l3Units
 , TestFrameWork
;

end.
