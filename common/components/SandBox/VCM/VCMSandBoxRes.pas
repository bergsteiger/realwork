unit VCMSandBoxRes;
 {* �������� ���������� VCM }

// ������: "w:\common\components\SandBox\VCM\VCMSandBoxRes.pas"
// ���������: "VCMApplication"
// ������� ������: "VCMSandBox" MUID: (521649770277)
// ��� ����: "TVCMSandBoxRes"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_VCMSandBoxTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'VCMSandBoxTitle'; rValue : '�������� ���������� VCM');
  {* '�������� ���������� VCM' }

type
 TVCMSandBoxRes = {final} class
  {* �������� ���������� VCM }
 end;//TVCMSandBoxRes

implementation

uses
 l3ImplUses
 , moDocument
 , moList
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *521649770277impl_uses*
 //#UC END# *521649770277impl_uses*
;

initialization
 str_VCMSandBoxTitle.Init;
 {* ������������� str_VCMSandBoxTitle }

end.
