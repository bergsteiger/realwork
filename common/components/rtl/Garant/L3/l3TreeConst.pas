unit l3TreeConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3TreeConst.pas"
// Начат: 26.12.2007 16:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3DataObject::l3TreeConst
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces
  ;

var CF_TreeNode : Tl3ClipboardFormat = 0;
 {* формат для на одного узла в буфере}

var CF_TreeNodes : Tl3ClipboardFormat = 0;
 {* формат для нескольких узлов в буфере}

implementation

uses
  Windows
  ;


initialization
//#UC START# *48F4B57C010F*
  CF_TreeNode := Windows.RegisterClipboardFormat('Tree Node');
  CF_TreeNodes := Windows.RegisterClipboardFormat('Tree Nodes');
//#UC END# *48F4B57C010F*

end.