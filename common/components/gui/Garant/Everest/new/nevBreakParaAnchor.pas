unit nevBreakParaAnchor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevBreakParaAnchor.pas"
// Начат: 24.11.2006 12:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Anchors::TnevBreakParaAnchor
//
// Якорь параграфа-разрыва
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\new\nevDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevSolidParaAnchor,
  nevTools
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 _nevBreakParaAnchorModify_Parent_ = TnevSolidParaAnchor;
 {$Include w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas}
 TnevBreakParaAnchor = class(_nevBreakParaAnchorModify_)
  {* Якорь параграфа-разрыва }
 end;//TnevBreakParaAnchor
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}

{$Include w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas}


{$IfEnd} //k2ForEditor
end.