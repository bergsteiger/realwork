{$IfNDef FiltersUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes.imp.pas"
// ���������: "VCMForm"

{$Define FiltersUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _FiltersUserTypes_ = {abstract} class(_FiltersUserTypes_Parent_)
 end;//_FiltersUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_FiltersUserTypes_ = _FiltersUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else FiltersUserTypes_imp}

{$IfNDef FiltersUserTypes_imp_impl}

{$Define FiltersUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ utFiltersLocalConstants }
 str_utFiltersCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersCaption'; rValue : '�������');
  {* ��������� ����������������� ���� "�������" }
 str_utFiltersSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersSettingsCaption'; rValue : '������� (�������)');
  {* ��������� ����������������� ���� "�������" ��� ��������� ������� ������������ }

{$Else FiltersUserTypes_imp_impl}

 str_utFiltersCaption.Init;
 {* ������������� str_utFiltersCaption }
 str_utFiltersSettingsCaption.Init;
 {* ������������� str_utFiltersSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf FiltersUserTypes_imp_impl}

{$EndIf FiltersUserTypes_imp}

