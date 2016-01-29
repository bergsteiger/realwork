{$IfNDef nevParaTool_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevParaTool.imp.pas"
// Начат: 04.04.2008 11:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::nevUtils::nevParaTool
//
// Инструмент для InevPara
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevParaTool_imp}
 _X_ = InevPara;
 _nevParaXTool_Parent_ = _nevParaTool_Parent_;
 {$Include ..\new\nevParaXTool.imp.pas}
 _nevParaTool_ = {mixin} class(_nevParaXTool_)
  {* Инструмент для InevPara }
 end;//_nevParaTool_

{$Else nevParaTool_imp}

{$Include ..\new\nevParaXTool.imp.pas}


{$EndIf nevParaTool_imp}
