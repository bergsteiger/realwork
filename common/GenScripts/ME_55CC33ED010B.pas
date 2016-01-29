unit evAACTextPainter;

interface

uses
 l3IntfUses
 , evTextParaPainter
 , l3Variant
 , l3Units
 , nevBase
;

type
 TevAACTextPainter = class(TevTextParaPainter)
  {* ¬се "заточки" дл€ отрисовки текста и содержани€ AAC. }
  procedure CheckDrawFocused;
  procedure ValidateSegFont(aSeg: Tl3Variant);
  procedure BeforeDrawLeaf;
  procedure AfterDrawLeaf;
 end;//TevAACTextPainter
 
implementation

uses
 l3ImplUses
 , evAACContentUtils
 , Graphics
 , k2Tags
 , HyperLink_Const
 , evdTextStyle_Const
;

end.
