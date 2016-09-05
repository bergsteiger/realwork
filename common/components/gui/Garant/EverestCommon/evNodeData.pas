unit evNodeData;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evNodeData.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevNodeData" MUID: (48F7014003A5)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 , evNodeDataObject
 , l3Interfaces
 , l3InternalInterfaces
 , l3IID
 , l3StringList
 , l3DataObject
;

type
 _DataType_ = Il3SimpleNode;
 _DataClass_ = TevNodeDataObject;
 {$Include w:\common\components\gui\Garant\EverestCommon\evTreeData.imp.pas}
 TevNodeData = class(_evTreeData_)
  protected
   function GetFormats: Tl3ClipboardFormats; override;
 end;//TevNodeData

implementation

uses
 l3ImplUses
 , evTypes
 , l3TreeConst
 , SysUtils
 , l3Base
 , l3InterfacesMisc
 , k2Tags
 , ddRTFWriter
 , l3Filer
 , Windows
 , l3String
 , l3Types
 , Document_Const
 , TextPara_Const
 //#UC START# *48F7014003A5impl_uses*
 //#UC END# *48F7014003A5impl_uses*
;

{$Include w:\common\components\gui\Garant\EverestCommon\evTreeData.imp.pas}

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
