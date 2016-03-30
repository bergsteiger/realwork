{$IfNDef nevViewBounds_imp}

// ������: "w:\common\components\gui\Garant\Everest\nevViewBounds.imp.pas"
// ���������: "Impurity"
// ������� ������: "nevViewBounds" MUID: (4A5CCD5F00C1)
// ��� ����: "_nevViewBounds_"

{$Define nevViewBounds_imp}

{$If Defined(evUseVisibleCursors)}
 _nevViewBounds_ = class(_nevViewBounds_Parent_)
  {* ������� ������������� ������� }
  protected
   function GetViewBounds(const aView: InevView;
    const aMap: InevMap): TnevRect; virtual;
  public
   function ViewBounds(const aView: InevView;
    const aMap: InevMap): TnevRect;
    {* �������������� ����� "�������������". ��� ��������� ���������� ���������� �� ����� �������. ���� ����������� �������� �������������, �� ���������� ����� ������������ }
 end;//_nevViewBounds_

{$Else Defined(evUseVisibleCursors)}

_nevViewBounds_ = _nevViewBounds_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevViewBounds_imp}

{$IfNDef nevViewBounds_imp_impl}

{$Define nevViewBounds_imp_impl}

{$If Defined(evUseVisibleCursors)}
function _nevViewBounds_.GetViewBounds(const aView: InevView;
 const aMap: InevMap): TnevRect;
//#UC START# *4A5CCD9D028D_4A5CCD5F00C1_var*
//#UC END# *4A5CCD9D028D_4A5CCD5F00C1_var*
begin
//#UC START# *4A5CCD9D028D_4A5CCD5F00C1_impl*
 Result := aMap.Bounds;
//#UC END# *4A5CCD9D028D_4A5CCD5F00C1_impl*
end;//_nevViewBounds_.GetViewBounds

function _nevViewBounds_.ViewBounds(const aView: InevView;
 const aMap: InevMap): TnevRect;
 {* �������������� ����� "�������������". ��� ��������� ���������� ���������� �� ����� �������. ���� ����������� �������� �������������, �� ���������� ����� ������������ }
//#UC START# *4A5CCBFC00B3_4A5CCD5F00C1_var*
//#UC END# *4A5CCBFC00B3_4A5CCD5F00C1_var*
begin
//#UC START# *4A5CCBFC00B3_4A5CCD5F00C1_impl*
 if aMap.rVisible then
  Result := GetViewBounds(aView, aMap)
 else
  Result := nevRect0;
//#UC END# *4A5CCBFC00B3_4A5CCD5F00C1_impl*
end;//_nevViewBounds_.ViewBounds
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevViewBounds_imp_impl}

{$EndIf nevViewBounds_imp}

