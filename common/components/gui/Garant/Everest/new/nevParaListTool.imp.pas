{$IfNDef nevParaListTool_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevParaListTool.imp.pas"
// Начат: 04.04.2005 15:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::nevUtils::nevParaListTool
//
// Инструмент для InevParaList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevParaListTool_imp}
 _X_ = InevParaList;
 _nevParaXTool_Parent_ = _nevParaListTool_Parent_;
 {$Include ..\new\nevParaXTool.imp.pas}
 _nevParaListTool_ = {mixin} class(_nevParaXTool_)
  {* Инструмент для InevParaList }
 end;//_nevParaListTool_

{$Else nevParaListTool_imp}

{$Include ..\new\nevParaXTool.imp.pas}


{$EndIf nevParaListTool_imp}
