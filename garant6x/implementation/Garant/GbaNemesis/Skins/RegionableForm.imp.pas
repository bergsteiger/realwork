{$IfNDef RegionableForm_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Skins"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Skins/RegionableForm.imp.pas"
// �����: 27.10.2010
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 ������������ ��������::NewInterface2010::Skins::Core::RegionableForm
//
// ����� � ���������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define RegionableForm_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _RegionableControl_Parent_ = _RegionableForm_Parent_;
 {$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
 _RegionableForm_ = {abstract form} class(_RegionableControl_)
  {* ����� � ���������� ������� }
 end;//_RegionableForm_
{$Else}

 _RegionableControl_Parent_ = _RegionableForm_Parent_;
 {$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
 _RegionableForm_ = _RegionableControl_;

{$IfEnd} //not Admin AND not Monitorings

{$Else RegionableForm_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}


{$IfEnd} //not Admin AND not Monitorings

{$EndIf RegionableForm_imp}
