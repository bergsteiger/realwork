{$IfNDef nevTextParaTool_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevTextParaTool.imp.pas"
// Начат: 04.04.2005 15:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::nevUtils::nevTextParaTool
//
// Инструмент для InevTextPara
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevTextParaTool_imp}
 _X_ = InevTextPara;
 _nevParaXTool_Parent_ = _nevTextParaTool_Parent_;
 {$Include ..\new\nevParaXTool.imp.pas}
 _nevTextParaTool_ = {mixin} class(_nevParaXTool_)
  {* Инструмент для InevTextPara }
 end;//_nevTextParaTool_

{$Else nevTextParaTool_imp}

{$Include ..\new\nevParaXTool.imp.pas}


{$EndIf nevTextParaTool_imp}
