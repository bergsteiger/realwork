unit evCommentPara_Wrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCommentPara_Wrap.pas"
// Начат: 24.11.2010 18:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Wrapper::Class>> Shared Delphi::Everest::Standard::WevCommentPara
//
// Обёртка для CommentPara
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evPara_Wrap,
  l3Variant
  ;

type
 TevCommentStorer = class
  {* Объект умеющий сохранять комментарии }
 protected
 // protected methods
   class procedure ForceStore(aTag: Tl3Variant); virtual;
 end;//TevCommentStorer

 RevCommentStorer = class of TevCommentStorer;

 TevCommentModifier = class(TevdParaModifier)
 end;//TevCommentModifier

 RevCommentModifier = class of TevCommentModifier;

 WevCommentPara = class(WevPara)
  {* Обёртка для CommentPara }
 public
 // overridden public methods
   procedure ForceStore(aTag: Tl3Variant); override;
   function MarkModified(aTag: Tl3Variant): Boolean; override;
 end;//WevCommentPara

var
   g_CommentStorer : RevCommentStorer = nil;
var
   g_CommentModifier : RevCommentModifier = nil;

implementation

// start class TevCommentStorer

class procedure TevCommentStorer.ForceStore(aTag: Tl3Variant);
//#UC START# *4CED30D901C7_4CED304B0270_var*
//#UC END# *4CED30D901C7_4CED304B0270_var*
begin
//#UC START# *4CED30D901C7_4CED304B0270_impl*
 // - ничего не делаем, полагаемся на потомков
//#UC END# *4CED30D901C7_4CED304B0270_impl*
end;//TevCommentStorer.ForceStore
// start class WevCommentPara

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