{$IfNDef DictionContainerUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DictionContainerUserTypes.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 ���������� ��������::DictionLike::View::DictionLikeForms::DictionContainerUserTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define DictionContainerUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _DictionContainerUserTypes_ = {abstract form} class(_DictionContainerUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_DictionContainerUserTypes_
{$Else}

 _DictionContainerUserTypes_ = _DictionContainerUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else DictionContainerUserTypes_imp}

{$IfNDef DictionContainerUserTypes_imp_impl}
{$Define DictionContainerUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ slqtDictionLocalConstants }
  str_slqtDictionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtDictionCaption'; rValue : '�������� �������');
   { ��������� ����������������� ���� "�������� �������" }

var
   { ������������ ������ slqtMedicDictionLocalConstants }
  str_slqtMedicDictionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtMedicDictionCaption'; rValue : '������� ����������� ��������');
   { ��������� ����������������� ���� "������� ����������� ��������" }

// start class _DictionContainerUserTypes_

procedure _DictionContainerUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(slqtDictionName,
  str_slqtDictionCaption,
  str_slqtDictionCaption,
  true,
  60,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtDictionName
 with AddUsertype(slqtMedicDictionName,
  str_slqtMedicDictionCaption,
  str_slqtMedicDictionCaption,
  true,
  182,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtMedicDictionName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  DictionContainerUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_slqtDictionCaption
 str_slqtDictionCaption.Init;
// ������������� str_slqtMedicDictionCaption
 str_slqtMedicDictionCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf DictionContainerUserTypes_imp_impl}
{$EndIf DictionContainerUserTypes_imp}
