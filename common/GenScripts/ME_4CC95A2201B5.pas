{$IfNDef SkinnedForm_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Skins\SkinnedForm.imp.pas"
// Стереотип: "VCMForm"

{$Define SkinnedForm_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _SkinnedForm_ = {abstract} class(_SkinnedForm_Parent_)
  {* Форма с поддержкой скинов }
  protected
   function IsSkinned: Boolean; virtual;
 end;//_SkinnedForm_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_SkinnedForm_ = _SkinnedForm_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else SkinnedForm_imp}

{$IfNDef SkinnedForm_imp_impl}

{$Define SkinnedForm_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _SkinnedForm_.IsSkinned: Boolean;
//#UC START# *4CC95A76016F_4CC95A2201B5_var*
//#UC END# *4CC95A76016F_4CC95A2201B5_var*
begin
//#UC START# *4CC95A76016F_4CC95A2201B5_impl*
 Result := true;
//#UC END# *4CC95A76016F_4CC95A2201B5_impl*
end;//_SkinnedForm_.IsSkinned
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf SkinnedForm_imp_impl}

{$EndIf SkinnedForm_imp}

