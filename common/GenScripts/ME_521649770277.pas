unit VCMSandBoxRes;
 {* �������� ���������� VCM }

// ������: "w:\common\components\SandBox\VCM\VCMSandBoxRes.pas"
// ���������: "VCMApplication"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmApplication
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_VCMSandBoxTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'VCMSandBoxTitle'; rValue : '�������� ���������� VCM');
  {* '�������� ���������� VCM' }

type
 TvcmApplicationRef = TVCMSandBoxRes;
  {* ������ �� ���������� ��� DesignTime ���������� }

 TVCMSandBoxRes = {final} class(TvcmApplication)
  {* �������� ���������� VCM }
 end;//TVCMSandBoxRes

implementation

uses
 l3ImplUses
 , moDocument
 , moList
 , l3MessageID
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 str_VCMSandBoxTitle.Init;
 {* ������������� str_VCMSandBoxTitle }

end.
