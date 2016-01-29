{$IfNDef SkinnedForm_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Skins"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Skins/SkinnedForm.imp.pas"
// Начат: 28.10.2010 15:11
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Интерфейсные элементы::NewInterface2010::Skins::Core::SkinnedForm
//
// Форма с поддержкой скинов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define SkinnedForm_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _SkinnedForm_ = {abstract form} class(_SkinnedForm_Parent_)
  {* Форма с поддержкой скинов }
 protected
 // protected methods
   function IsSkinned: Boolean; virtual;
 end;//_SkinnedForm_
{$Else}

 _SkinnedForm_ = _SkinnedForm_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else SkinnedForm_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _SkinnedForm_

function _SkinnedForm_.IsSkinned: Boolean;
//#UC START# *4CC95A76016F_4CC95A2201B5_var*
//#UC END# *4CC95A76016F_4CC95A2201B5_var*
begin
//#UC START# *4CC95A76016F_4CC95A2201B5_impl*
 Result := true;
//#UC END# *4CC95A76016F_4CC95A2201B5_impl*
end;//_SkinnedForm_.IsSkinned

{$IfEnd} //not Admin AND not Monitorings

{$EndIf SkinnedForm_imp}
