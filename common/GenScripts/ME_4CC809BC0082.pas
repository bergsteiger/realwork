{$IfNDef RegionableForm_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Skins\RegionableForm.imp.pas"
// ���������: "VCMForm"

{$Define RegionableForm_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _RegionableControl_Parent_ = _RegionableForm_Parent_;
 {$Include RegionableControl.imp.pas}
 _RegionableForm_ = {abstract} class(_RegionableControl_)
  {* ����� � ���������� ������� }
 end;//_RegionableForm_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_RegionableControl_Parent_ = _RegionableForm_Parent_;
{$Include RegionableControl.imp.pas}
_RegionableForm_ = _RegionableControl_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else RegionableForm_imp}

{$IfNDef RegionableForm_imp_impl}

{$Define RegionableForm_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include RegionableControl.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf RegionableForm_imp_impl}

{$EndIf RegionableForm_imp}

