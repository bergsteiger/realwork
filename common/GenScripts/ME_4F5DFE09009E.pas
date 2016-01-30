{$IfNDef PrimSaveLoadUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes.imp.pas"
// ���������: "VCMForm"

{$Define PrimSaveLoadUserTypes_imp}

{$If NOT Defined(Admin)}
 _PrimSaveLoadUserTypes_ = {abstract} class(_PrimSaveLoadUserTypes_Parent_)
 end;//_PrimSaveLoadUserTypes_

{$Else NOT Defined(Admin)}

_PrimSaveLoadUserTypes_ = _PrimSaveLoadUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin)
{$Else PrimSaveLoadUserTypes_imp}

{$IfNDef PrimSaveLoadUserTypes_imp_impl}

{$Define PrimSaveLoadUserTypes_imp_impl}

{$If NOT Defined(Admin)}
const
 {* ������������ ������ slqtAttributeLocalConstants }
 str_slqtAttributeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtAttributeCaption'; rValue : '�����: �� ����������');
  {* ��������� ����������������� ���� "�����: �� ����������" }
 {* ������������ ������ slqtKWLocalConstants }
 str_slqtKWCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtKWCaption'; rValue : '�����: �� ��������');
  {* ��������� ����������������� ���� "�����: �� ��������" }
 {* ������������ ������ slqtOldKWLocalConstants }
 str_slqtOldKWCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWCaption'; rValue : '�����: �� ��������');
  {* ��������� ����������������� ���� "�����: �� ��������" }
 str_slqtOldKWSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWSettingsCaption'; rValue : '�����: �� �������� (�������������)');
  {* ��������� ����������������� ���� "�����: �� ��������" ��� ��������� ������� ������������ }
 {* ������������ ������ slqtPublishSourceLocalConstants }
 str_slqtPublishSourceCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtPublishSourceCaption'; rValue : '�����: �� ��������� �������������');
  {* ��������� ����������������� ���� "�����: �� ��������� �������������" }
 {* ������������ ������ slqtFiltersLocalConstants }
 str_slqtFiltersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtFiltersCaption'; rValue : '�������� ��������');
  {* ��������� ����������������� ���� "�������� ��������" }
 {* ������������ ������ slqtLegislationReviewLocalConstants }
 str_slqtLegislationReviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtLegislationReviewCaption'; rValue : '�����: �����. ����� ��������� ����������������');
  {* ��������� ����������������� ���� "�����: �����. ����� ��������� ����������������" }
 {* ������������ ������ slqtPostingOrderLocalConstants }
 str_slqtPostingOrderCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtPostingOrderCaption'; rValue : '��������� �������������� ����� ��������');
  {* ��������� ����������������� ���� "��������� �������������� ����� ��������" }
 {* ������������ ������ slqtConsultLocalConstants }
 str_slqtConsultCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtConsultCaption'; rValue : '�������� ��������� ������');
  {* ��������� ����������������� ���� "�������� ��������� ������" }
 {* ������������ ������ slqtInpharmSearchLocalConstants }
 str_slqtInpharmSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtInpharmSearchCaption'; rValue : '����� ������������� �������');
  {* ��������� ����������������� ���� "����� ������������� �������" }

{$Else PrimSaveLoadUserTypes_imp_impl}

 str_slqtAttributeCaption.Init;
 {* ������������� str_slqtAttributeCaption }
 str_slqtKWCaption.Init;
 {* ������������� str_slqtKWCaption }
 str_slqtOldKWCaption.Init;
 {* ������������� str_slqtOldKWCaption }
 str_slqtOldKWSettingsCaption.Init;
 {* ������������� str_slqtOldKWSettingsCaption }
 str_slqtPublishSourceCaption.Init;
 {* ������������� str_slqtPublishSourceCaption }
 str_slqtFiltersCaption.Init;
 {* ������������� str_slqtFiltersCaption }
 str_slqtLegislationReviewCaption.Init;
 {* ������������� str_slqtLegislationReviewCaption }
 str_slqtPostingOrderCaption.Init;
 {* ������������� str_slqtPostingOrderCaption }
 str_slqtConsultCaption.Init;
 {* ������������� str_slqtConsultCaption }
 str_slqtInpharmSearchCaption.Init;
 {* ������������� str_slqtInpharmSearchCaption }
{$IfEnd} // NOT Defined(Admin)

{$EndIf PrimSaveLoadUserTypes_imp_impl}

{$EndIf PrimSaveLoadUserTypes_imp}

