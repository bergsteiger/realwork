{$IfNDef l3CheckStamp_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3CheckStamp.imp.pas"
// ���������: "Impurity"

{$Define l3CheckStamp_imp}

 _l3CheckStamp_ = class(_l3CheckStamp_Parent_)
  public
   function CheckStamp(const aGUID: TGUID): Boolean;
    {* ��������� ����� ���������� ����������. �������� ��� ����, ����� ������, ��� ���������� ���� "������". }
 end;//_l3CheckStamp_

{$Else l3CheckStamp_imp}

{$IfNDef l3CheckStamp_imp_impl}

{$Define l3CheckStamp_imp_impl}

function _l3CheckStamp_.CheckStamp(const aGUID: TGUID): Boolean;
 {* ��������� ����� ���������� ����������. �������� ��� ����, ����� ������, ��� ���������� ���� "������". }
//#UC START# *467813E40207_4BE42D490361_var*
//#UC END# *467813E40207_4BE42D490361_var*
begin
//#UC START# *467813E40207_4BE42D490361_impl*
 Result := false;
//#UC END# *467813E40207_4BE42D490361_impl*
end;//_l3CheckStamp_.CheckStamp

{$EndIf l3CheckStamp_imp_impl}

{$EndIf l3CheckStamp_imp}

