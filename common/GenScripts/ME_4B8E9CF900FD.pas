unit vcmCustomizeToolsRes;

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmCustomizeToolsRes.pas"
// ���������: "UtilityPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 , l3StringIDEx
;

const
 {* ������������ ������ ToolbarPos }
 str_vcmetbpTop: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpTop'; rValue : '�������');
  {* '�������' }
 str_vcmetbpBottom: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpBottom'; rValue : '������');
  {* '������' }
 str_vcmetbpLeft: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpLeft'; rValue : '�����');
  {* '�����' }
 str_vcmetbpRight: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmetbpRight'; rValue : '������');
  {* '������' }
 {* ����� �������������� �������������� ����� ToolbarPos }
 Top: Pl3StringIDEx = str_vcmetbpTop;
 Bottom: Pl3StringIDEx = str_vcmetbpBottom;
 Left: Pl3StringIDEx = str_vcmetbpLeft;
 Right: Pl3StringIDEx = str_vcmetbpRight;
 {* ������������ ������ Local }
 str_vcmSeparator: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmSeparator'; rValue : '- ����������� -');
  {* '- ����������� -' }
 str_vcmAskResoreToolbar: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmAskResoreToolbar'; rValue : '�� ������������� ������ ������������ ������� � ����� �������� ���� ������� ������������ ������� �� ���������?');
  {* '�� ������������� ������ ������������ ������� � ����� �������� ���� ������� ������������ ������� �� ���������?' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_vcmetbpTop.Init;
 {* ������������� str_vcmetbpTop }
 str_vcmetbpBottom.Init;
 {* ������������� str_vcmetbpBottom }
 str_vcmetbpLeft.Init;
 {* ������������� str_vcmetbpLeft }
 str_vcmetbpRight.Init;
 {* ������������� str_vcmetbpRight }
 str_vcmSeparator.Init;
 {* ������������� str_vcmSeparator }
 str_vcmAskResoreToolbar.Init;
 {* ������������� str_vcmAskResoreToolbar }
{$IfEnd} // NOT Defined(NoVCM)

end.
