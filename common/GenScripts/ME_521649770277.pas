unit NOT_COMPLETED_VCMSandBoxRes;
 {* �������� ���������� VCM }

// ������: "w:\common\components\SandBox\VCM\NOT_COMPLETED_VCMSandBoxRes.pas"
// ���������: "VCMApplication"
// ������� ������: "VCMSandBox" MUID: (521649770277)
// ��� ����: "TVCMSandBoxRes"

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
 TVCMSandBoxRes = {final} class({$If NOT Defined(NoVCM)}
 TvcmApplication
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* �������� ���������� VCM }
  protected
   procedure Loaded; override;
 end;//TVCMSandBoxRes

 TvcmApplicationRef = TVCMSandBoxRes;
  {* ������ �� ���������� ��� DesignTime ���������� }

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

{$If NOT Defined(NoVCM)}
procedure TVCMSandBoxRes.Loaded;
begin
 inherited;
end;//TVCMSandBoxRes.Loaded

initialization
 str_VCMSandBoxTitle.Init;
 {* ������������� str_VCMSandBoxTitle }
{$IfEnd} // NOT Defined(NoVCM)

end.
