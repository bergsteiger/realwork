unit vcmMainFormRes;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormRes.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3MessageID
;

const
 {* ������������ ������ Local }
 str_TooManyWindowsOpened: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened'; rValue : '������� ������������ ���������� ���� ������� ������. �������� �������� ���� ��� ����������� ������ � ������� ����');
  {* '������� ������������ ���������� ���� ������� ������. �������� �������� ���� ��� ����������� ������ � ������� ����' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 {* �������� ������ ��� ������� TooManyWindowsOpened }
 str_TooManyWindowsOpened_Choice_First: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_First'; rValue : '������� � ������� ����');
  {* '������� � ������� ����' }
 str_TooManyWindowsOpened_Choice_Second: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_Second'; rValue : '������');
  {* '������' }

initialization
 str_TooManyWindowsOpened_Choice_First.Init;
 {* ������������� str_TooManyWindowsOpened_Choice_First }
 str_TooManyWindowsOpened_Choice_Second.Init;
 {* ������������� str_TooManyWindowsOpened_Choice_Second }
 str_TooManyWindowsOpened.Init;
!!! Lost Message ini !!!
 {* ������������� str_TooManyWindowsOpened }
{$IfEnd} // NOT Defined(NoVCM)

end.
