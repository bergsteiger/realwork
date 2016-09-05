unit vcmMainFormRes;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainFormRes.pas"
// ���������: "UtilityPack"
// ������� ������: "vcmMainFormRes" MUID: (51E7E79A0341)

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
 //#UC START# *51E7E79A0341impl_uses*
 //#UC END# *51E7E79A0341impl_uses*
;

const
 {* �������� ������ ��� ������� TooManyWindowsOpened }
 str_TooManyWindowsOpened_Choice_First: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_First'; rValue : '������� � ������� ����');
  {* '������� � ������� ����' }
 str_TooManyWindowsOpened_Choice_Second: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_Second'; rValue : '������');
  {* '������' }

initialization
 str_TooManyWindowsOpened.Init;
 str_TooManyWindowsOpened.AddChoice(str_TooManyWindowsOpened_Choice_First);
 str_TooManyWindowsOpened.AddChoice(str_TooManyWindowsOpened_Choice_Second);
 str_TooManyWindowsOpened.AddCustomChoice(str_TooManyWindowsOpened_Choice_Second);
 str_TooManyWindowsOpened.AddDefaultChoice(str_TooManyWindowsOpened_Choice_First);
 str_TooManyWindowsOpened.SetDlgType(mtConfirmation);
 {* ������������� str_TooManyWindowsOpened }
 str_TooManyWindowsOpened_Choice_First.Init;
 {* ������������� str_TooManyWindowsOpened_Choice_First }
 str_TooManyWindowsOpened_Choice_Second.Init;
 {* ������������� str_TooManyWindowsOpened_Choice_Second }
{$IfEnd} // NOT Defined(NoVCM)

end.
