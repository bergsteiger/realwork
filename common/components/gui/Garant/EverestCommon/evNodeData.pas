unit evNodeData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evNodeData.pas"
// Начат: 26.12.2006 17:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::DataObjects::TevNodeData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  l3TreeInterfaces,
  evNodeDataObject,
  l3Interfaces,
  l3InternalInterfaces,
  l3DataObject,
  ActiveX,
  Windows,
  l3IID,
  l3StringList
  ;

type
 _DataType_ = Il3SimpleNode;
 _DataClass_ = TevNodeDataObject;
 {$Include ..\EverestCommon\evTreeData.imp.pas}
 TevNodeData = class(_evTreeData_)
 protected
 // overridden protected methods
   function GetFormats: Tl3ClipboardFormats; override;
 end;//TevNodeData

implementation

uses
  evTypes,
  l3TreeConst,
  SysUtils,
  l3Base,
  l3InterfacesMisc,
  k2Tags,
  ddRTFWriter,
  l3Filer,
  l3String,
  l3Types,
  Document_Const,
  TextPara_Const
  ;

{$Include ..\EverestCommon\evTreeData.imp.pas}

// start class TevNodeData

function TevNodeData.GetFormats: Tl3ClipboardFormats;
//#UC START# *48F4B33501DE_48F7014003A5_var*
//#UC END# *48F4B33501DE_48F7014003A5_var*
begin
//#UC START# *48F4B33501DE_48F7014003A5_impl*
 if Ext then
  Result := l3FormatArray([cf_TreeNode, cf_EverestBin,
                           CF_RTF, CF_TEXT, CF_UNICODETEXT,
                           CF_HDROP])
 else
  Result := inherited GetFormats;
//#UC END# *48F4B33501DE_48F7014003A5_impl*
end;//TevNodeData.GetFormats

end.