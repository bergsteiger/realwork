unit evConstStringData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Автор: Лукьянец Р.В.
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evConstStringData.pas"
// Начат: 16.07.2007
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::DataObjects::TevConstStringData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  evConstStringDataObject,
  evdInterfaces,
  l3Interfaces,
  l3InternalInterfaces,
  l3DataObject,
  ActiveX,
  Windows,
  l3IID,
  l3StringList
  ;

type
 _DataClass_ = TevConstStringDataObject;
 _DataType_ = IevdHyperlinkInfo;
 {$Include ..\EverestCommon\evTreeData.imp.pas}
 TevConstStringData = class(_evTreeData_)
 protected
 // overridden protected methods
   function GetFormats: Tl3ClipboardFormats; override;
 end;//TevConstStringData

implementation

uses
  evTypes,
  SysUtils,
  l3Base,
  l3InterfacesMisc,
  k2Tags,
  ddRTFWriter,
  l3Filer,
  l3TreeInterfaces,
  l3String,
  l3Types,
  Document_Const,
  TextPara_Const,
  l3TreeConst
  ;

{$Include ..\EverestCommon\evTreeData.imp.pas}

// start class TevConstStringData

function TevConstStringData.GetFormats: Tl3ClipboardFormats;
//#UC START# *48F4B33501DE_48F4CF9903D6_var*
//#UC END# *48F4B33501DE_48F4CF9903D6_var*
begin
//#UC START# *48F4B33501DE_48F4CF9903D6_impl*
 if Ext then
  Result := l3FormatArray([cf_EverestBin,
                           CF_RTF, CF_TEXT, CF_UNICODETEXT])
 else
  Result := inherited GetFormats;
//#UC END# *48F4B33501DE_48F4CF9903D6_impl*
end;//TevConstStringData.GetFormats

end.