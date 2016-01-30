unit nevPrintingRootFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevPrintingRootFormatInfo.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevRootFormatInfo
 , nevBase
;

type
 _PrintViewDecorationRules_Parent_ = TnevRootFormatInfo;
 {$Include PrintViewDecorationRules.imp.pas}
 TnevPrintingRootFormatInfo = class(_PrintViewDecorationRules_)
 end;//TnevPrintingRootFormatInfo

implementation

uses
 l3ImplUses
 , evTextStyle_Const
 , k2Tags
;

{$Include PrintViewDecorationRules.imp.pas}

end.
