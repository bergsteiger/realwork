unit evCommentPara_Wrap;
 {* Обёртка для CommentPara }

// Модуль: "w:\common\components\gui\Garant\Everest\evCommentPara_Wrap.pas"
// Стереотип: "Wrapper"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evPara_Wrap
 , CommentPara_Const
 , l3Variant
;

type
 TevCommentStorer = class
  {* Объект умеющий сохранять комментарии }
  protected
   class procedure ForceStore(aTag: Tl3Variant); virtual;
 end;//TevCommentStorer

 RevCommentStorer = class of TevCommentStorer;

 TevCommentModifier = class(TevdParaModifier)
 end;//TevCommentModifier

 RevCommentModifier = class of TevCommentModifier;

 WevCommentPara = class(WevPara)
  {* Обёртка для CommentPara }
  public
   procedure ForceStore(aTag: Tl3Variant); override;
   function MarkModified(aTag: Tl3Variant): Boolean; override;
 end;//WevCommentPara

var g_CommentStorer: RevCommentStorer = nil;
var g_CommentModifier: RevCommentModifier = nil;

implementation

uses
 l3ImplUses
;

class procedure TevCommentStorer.ForceStore(aTag: Tl3Variant);
//#UC START# *4CED30D901C7_4CED304B0270_var*
//#UC END# *4CED30D901C7_4CED304B0270_var*
begin
//#UC START# *4CED30D901C7_4CED304B0270_impl*
 // - ничего не делаем, полагаемся на потомков
//#UC END# *4CED30D901C7_4CED304B0270_impl*
end;//TevCommentStorer.ForceStore

procedure WevCommentPara.ForceStore(aTag: Tl3Variant);
//#UC START# *4CED2E7E010A_4CED2FED0255_var*
//#UC END# *4CED2E7E010A_4CED2FED0255_var*
begin
//#UC START# *4CED2E7E010A_4CED2FED0255_impl*
 inherited;
 if (g_CommentStorer = nil) then
  TevCommentStorer.ForceStore(aTag)
 else
  g_CommentStorer.ForceStore(aTag);
//#UC END# *4CED2E7E010A_4CED2FED0255_impl*
end;//WevCommentPara.ForceStore

function WevCommentPara.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE5D3002FC_4CED2FED0255_var*
//#UC END# *4CEE5D3002FC_4CED2FED0255_var*
begin
//#UC START# *4CEE5D3002FC_4CED2FED0255_impl*
 if (g_CommentModifier = nil) then
  Result := TevCommentModifier.MarkModified(aTag)
 else
  Result := g_CommentModifier.MarkModified(aTag);
//#UC END# *4CEE5D3002FC_4CED2FED0255_impl*
end;//WevCommentPara.MarkModified

end.
