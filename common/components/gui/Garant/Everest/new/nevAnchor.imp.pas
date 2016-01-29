{$IfNDef nevAnchor_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevAnchor.imp.pas"
// Начат: 09.04.2009 21:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Anchors::nevAnchor
//
// Базовая реализация якорей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevAnchor_imp}
{$If defined(k2ForEditor)}
 {$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}
 _nevParentPointFactoryEx_Parent_ = _nevBasePoint_;
 {$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}
 _nevDiff_Parent_ = _nevParentPointFactoryEx_;
 {$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}
 _nevAnchor_ = {mixin} class(_nevDiff_)
  {* Базовая реализация якорей }
 end;//_nevAnchor_
{$Else}

 {$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}
 _nevParentPointFactoryEx_Parent_ = _nevBasePoint_;
 {$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}
 _nevDiff_Parent_ = _nevParentPointFactoryEx_;
 {$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}
 _nevAnchor_ = _nevDiff_;

{$IfEnd} //k2ForEditor

{$Else nevAnchor_imp}

{$If defined(k2ForEditor)}


{$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}


{$IfEnd} //k2ForEditor

{$EndIf nevAnchor_imp}
