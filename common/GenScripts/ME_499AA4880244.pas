unit vcmProfilersCollection_p;

// ������: "w:\common\components\gui\Garant\VCM\vcmProfilersCollection_p.pas"
// ���������: "TestClass"

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
