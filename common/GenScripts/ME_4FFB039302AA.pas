{$IfNDef ContentsUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "ContentsUserTypes" MUID: (4FFB039302AA)
// ��� ����: "_ContentsUserTypes_"

{$Define ContentsUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ContentsUserTypes_ = {abstract} class(_ContentsUserTypes_Parent_)
 end;//_ContentsUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ContentsUserTypes_ = _ContentsUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ContentsUserTypes_imp}

{$IfNDef ContentsUserTypes_imp_impl}

{$Define ContentsUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ utContentsLocalConstants }
 str_utContentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utContentsCaption'; rValue : '��������� ���������');
  {* ��������� ����������������� ���� "��������� ���������" }
 str_utContentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utContentsSettingsCaption'; rValue : '��������: ��������� (�������)');
  {* ��������� ����������������� ���� "��������� ���������" ��� ��������� ������� ������������ }
 {* ������������ ������ utDrugContentsLocalConstants }
 str_utDrugContentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDrugContentsCaption'; rValue : '��������� ���������');
  {* ��������� ����������������� ���� "��������� ���������" }
 str_utDrugContentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDrugContentsSettingsCaption'; rValue : '��������: ��������� (�������)');
  {* ��������� ����������������� ���� "��������� ���������" ��� ��������� ������� ������������ }

{$Else ContentsUserTypes_imp_impl}

 str_utContentsCaption.Init;
 {* ������������� str_utContentsCaption }
 str_utContentsSettingsCaption.Init;
 {* ������������� str_utContentsSettingsCaption }
 str_utDrugContentsCaption.Init;
 {* ������������� str_utDrugContentsCaption }
 str_utDrugContentsSettingsCaption.Init;
 {* ������������� str_utDrugContentsSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ContentsUserTypes_imp_impl}

{$EndIf ContentsUserTypes_imp}

