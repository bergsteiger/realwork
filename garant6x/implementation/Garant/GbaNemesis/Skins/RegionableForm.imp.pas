{$IfNDef RegionableForm_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Skins"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Skins/RegionableForm.imp.pas"
// Начат: 27.10.2010
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Интерфейсные элементы::NewInterface2010::Skins::Core::RegionableForm
//
// Форма с поддержкой региона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define RegionableForm_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _RegionableControl_Parent_ = _RegionableForm_Parent_;
 {$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
 _RegionableForm_ = {abstract form} class(_RegionableControl_)
  {* Форма с поддержкой региона }
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
