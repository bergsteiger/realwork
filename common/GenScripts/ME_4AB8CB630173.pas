unit NOT_FINISHED_vcmStringList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\NOT_FINISHED_vcmStringList.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3VCLStrings
;

type
 TvcmStringList = class(Tl3Strings)
 end;//TvcmStringList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
