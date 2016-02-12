{$IfNDef RegionableForm_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Skins\RegionableForm.imp.pas"
// Стереотип: "VCMForm"

{$Define RegionableForm_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _RegionableControl_Parent_ = _RegionableForm_Parent_;
 {$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
 _RegionableForm_ = {abstract} class(_RegionableControl_)
  {* Форма с поддержкой региона }
 end;//_RegionableForm_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_RegionableControl_Parent_ = _RegionableForm_Parent_;
{$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
_RegionableForm_ = _RegionableControl_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else RegionableForm_imp}

{$IfNDef RegionableForm_imp_impl}

{$Define RegionableForm_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf RegionableForm_imp_impl}

{$EndIf RegionableForm_imp}

