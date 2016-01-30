unit evConstStringData;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evConstStringData.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evConstStringDataObject
 , evdInterfaces
 , l3Interfaces
 , l3InternalInterfaces
 , l3IID
 , l3StringList
 , l3DataObject
;

type
 _DataClass_ = TevConstStringDataObject;
 _DataType_ = IevdHyperlinkInfo;
 {$Include evTreeData.imp.pas}
 TevConstStringData = class(_evTreeData_)
  protected
   function GetFormats: Tl3ClipboardFormats; override;
 end;//TevConstStringData

implementation

uses
 l3ImplUses
 , evTypes
 , SysUtils
 , l3Base
 , l3InterfacesMisc
 , k2Tags
 , ddRTFWriter
 , l3Filer
 , l3TreeInterfaces
 , Windows
 , l3String
 , l3Types
 , Document_Const
 , TextPara_Const
 , l3TreeConst
;

{$Include evTreeData.imp.pas}

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
