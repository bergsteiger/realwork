unit nsCommentModifier;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsCommentModifier.pas"
// Начат: 25.11.2010 16:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::EVD Schema Tuning::TnsCommentModifier
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  evCommentPara_Wrap,
  l3Variant
  ;

type
 TnsCommentModifier = class(TevCommentModifier)
 public
 // overridden public methods
   class function MarkModified(aTag: Tl3Variant): Boolean; override;
 end;//TnsCommentModifier

implementation

uses
  F1TagDataProviderInterface,
  SysUtils
  ;

// start class TnsCommentModifier

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