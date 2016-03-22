unit nevPrintingRootFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevPrintingRootFormatInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevPrintingRootFormatInfo" MUID: (4F4B5F380298)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevRootFormatInfo
 , nevBase
;

type
 _PrintViewDecorationRules_Parent_ = TnevRootFormatInfo;
 {$Include w:\common\components\gui\Garant\Everest\PrintViewDecorationRules.imp.pas}
 TnevPrintingRootFormatInfo = class(_PrintViewDecorationRules_)
 end;//TnevPrintingRootFormatInfo

implementation

uses
 l3ImplUses
 , evTextStyle_Const
 , k2Tags
;

{$Include w:\common\components\gui\Garant\Everest\PrintViewDecorationRules.imp.pas}

end.
