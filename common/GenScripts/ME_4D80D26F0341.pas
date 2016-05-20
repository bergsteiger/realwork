{$IfNDef FiltersUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "FiltersUserTypes" MUID: (4D80D26F0341)
// ��� ����: "_FiltersUserTypes_"

{$Define FiltersUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _FiltersUserTypes_ = {abstract} class(_FiltersUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
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

{$If NOT Defined(NoVCM)}
procedure _FiltersUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utFiltersName,
  str_utFiltersCaption,
  str_utFiltersSettingsCaption,
  False,
  40,
  50,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utFiltersName
end;//_FiltersUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$Else FiltersUserTypes_imp_impl}

 str_utFiltersCaption.Init;
 {* ������������� str_utFiltersCaption }
 str_utFiltersSettingsCaption.Init;
 {* ������������� str_utFiltersSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf FiltersUserTypes_imp_impl}

{$EndIf FiltersUserTypes_imp}

