unit vcmApplicationRef;
 {* ��� ��� ����������� ��������������� ������� }

// ������: "w:\common\components\gui\Garant\VCM\implementation\Design\vcmApplicationRef.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmApplicationRef" MUID: (4AB22E5E003E)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmApplication
;

type
 TvcmApplicationRef = class(TvcmApplication)
  {* ��� ��� ����������� ��������������� ������� }
 end;//TvcmApplicationRef
{$IfEnd} // Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)

implementation

{$If Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmApplicationRef);
 {* ����������� TvcmApplicationRef }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)

end.
