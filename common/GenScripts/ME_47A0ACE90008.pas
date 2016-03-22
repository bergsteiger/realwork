{$IfNDef l3Castable_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3Castable.imp.pas"
// ���������: "Impurity"
// ������� ������: "l3Castable" MUID: (47A0ACE90008)
// ��� ����: "_l3Castable_"

{$Define l3Castable_imp}

 _l3Castable_ = class(_l3Castable_Parent_)
  {* �����-������� � ������� QueryInterface }
  public
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; virtual; stdcall;
    {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
 end;//_l3Castable_

{$Else l3Castable_imp}

{$IfNDef l3Castable_imp_impl}

{$Define l3Castable_imp_impl}

function _l3Castable_.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
//#UC START# *47A0AD3A01F7_47A0ACE90008_var*
//#UC END# *47A0AD3A01F7_47A0ACE90008_var*
begin
//#UC START# *47A0AD3A01F7_47A0ACE90008_impl*
 if TObject(Self).GetInterface(IID, Obj) then
  Result := S_Ok
 else
  Result := E_NoInterface;
//#UC END# *47A0AD3A01F7_47A0ACE90008_impl*
end;//_l3Castable_.QueryInterface

{$EndIf l3Castable_imp_impl}

{$EndIf l3Castable_imp}

