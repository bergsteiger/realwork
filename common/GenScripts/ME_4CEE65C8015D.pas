unit nsCommentModifier;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsCommentModifier.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsCommentModifier" MUID: (4CEE65C8015D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , evCommentPara_Wrap
 , l3Variant
;

type
 TnsCommentModifier = class(TevCommentModifier)
  public
   class function MarkModified(aTag: Tl3Variant): Boolean; override;
 end;//TnsCommentModifier

implementation

uses
 l3ImplUses
 , F1TagDataProviderInterface
 , SysUtils
;

class function TnsCommentModifier.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE6187015A_4CEE65C8015D_var*
var
 l_S : If1CommentSink;
//#UC END# *4CEE6187015A_4CEE65C8015D_var*
begin
//#UC START# *4CEE6187015A_4CEE65C8015D_impl*
 if aTag.QI(If1CommentSink, l_S) then
  try
   Result := true;
   if not (ns_nsInParse in l_S.State) then
    l_S.State := l_S.State + [ns_nsChanged];
  finally
   l_S := nil;
  end//try..finally
 else
  Result := inherited MarkModified(aTag);
//#UC END# *4CEE6187015A_4CEE65C8015D_impl*
end;//TnsCommentModifier.MarkModified

initialization
//#UC START# *4CEE6865016F*
 g_CommentModifier := TnsCommentModifier;
//#UC END# *4CEE6865016F*

end.
