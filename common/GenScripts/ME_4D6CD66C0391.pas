unit evCommentsEliminator;

interface

uses
 l3IntfUses
 , k2TagFilter
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevFullCommentsEliminator = class(TevdLeafParaFilter)
 end;//TevFullCommentsEliminator
 
 TevCommentsEliminator = class(Tk2TagFilter)
 end;//TevCommentsEliminator
 
implementation

uses
 l3ImplUses
 , CommentPara_Const
;

end.
