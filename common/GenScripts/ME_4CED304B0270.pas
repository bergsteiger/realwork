unit evCommentStorer;

interface

uses
 l3IntfUses
 , l3Variant
;

type
 TevCommentStorer = class
  {* Объект умеющий сохранять комментарии }
  procedure ForceStore(aTag: Tl3Variant);
 end;//TevCommentStorer
 
implementation

uses
 l3ImplUses
;

end.
