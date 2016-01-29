{$IfNDef FiltersUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/FiltersUserTypes.imp.pas"
// �����: 16.03.2011 18:08
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::FiltersUserTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define FiltersUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _FiltersUserTypes_ = {abstract form} class(_FiltersUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_FiltersUserTypes_
{$Else}

 _FiltersUserTypes_ = _FiltersUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else FiltersUserTypes_imp}

{$IfNDef FiltersUserTypes_imp_impl}
{$Define FiltersUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ utFiltersLocalConstants }
  str_utFiltersCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersCaption'; rValue : '�������');
   { ��������� ����������������� ���� "�������" }
  str_utFiltersSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFiltersSettingsCaption'; rValue : '������� (�������)');
   { ��������� ����������������� ���� "�������" ��� ��������� ������� ������������ }

// start class _FiltersUserTypes_

procedure _FiltersUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utFiltersName,
  str_utFiltersCaption,
  str_utFiltersSettingsCaption,
  true,
  40,
  50,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utFiltersName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  FiltersUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_utFiltersCaption
 str_utFiltersCaption.Init;
// ������������� str_utFiltersSettingsCaption
 str_utFiltersSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf FiltersUserTypes_imp_impl}
{$EndIf FiltersUserTypes_imp}
