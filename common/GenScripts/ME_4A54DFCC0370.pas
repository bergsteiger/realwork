{$IfNDef l3DataContainer_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas"
// ���������: "Impurity"

{$Define l3DataContainer_imp}

 _l3DataContainer_ = {abstract} class(_l3DataContainer_Parent_)
  protected
   function pm_GetEmpty: Boolean;
   function GetEmpty: Boolean; virtual;
  public
   property Empty: Boolean
    read pm_GetEmpty;
 end;//_l3DataContainer_

{$Else l3DataContainer_imp}

{$IfNDef l3DataContainer_imp_impl}

{$Define l3DataContainer_imp_impl}

function _l3DataContainer_.pm_GetEmpty: Boolean;
//#UC START# *4A54E02500D2_4A54DFCC0370get_var*
//#UC END# *4A54E02500D2_4A54DFCC0370get_var*
begin
//#UC START# *4A54E02500D2_4A54DFCC0370get_impl*
 Result := (Self = nil) OR GetEmpty;
//#UC END# *4A54E02500D2_4A54DFCC0370get_impl*
end;//_l3DataContainer_.pm_GetEmpty

function _l3DataContainer_.GetEmpty: Boolean;
//#UC START# *4A54E03B009A_4A54DFCC0370_var*
//#UC END# *4A54E03B009A_4A54DFCC0370_var*
begin
//#UC START# *4A54E03B009A_4A54DFCC0370_impl*
 Result := false;
//#UC END# *4A54E03B009A_4A54DFCC0370_impl*
end;//_l3DataContainer_.GetEmpty

{$EndIf l3DataContainer_imp_impl}

{$EndIf l3DataContainer_imp}

