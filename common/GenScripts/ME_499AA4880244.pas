unit vcmProfilersCollection_p;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmProfilersCollection_p.pas"
// Стереотип: "TestClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmProfilersCollection
 , vcmProfiler
;

type
 // TvcmProfilersCollection
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM)

end.
