unit VCMSandBoxRes;

interface

uses
 l3IntfUses
 , vcmApplication
 , l3StringIDEx
;

type
 TvcmApplicationRef = TVCMSandBoxRes;
  {* ������ �� ���������� ��� DesignTime ���������� }
 
 TVCMSandBoxRes = class(TvcmApplication)
  {* �������� ���������� VCM }
 end;//TVCMSandBoxRes
 
implementation

uses
 l3ImplUses
 , moDocument
 , moList
 , l3MessageID
 , evExtFormat
 , StdRes
;

end.
