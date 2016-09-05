unit evdStartAndTimeEliminator;
 {* �������� Start � Time � ���������. }

// ������: "w:\common\components\gui\Garant\Everest\evdStartAndTimeEliminator.pas"
// ���������: "SimpleClass"
// ������� ������: "TevdStartAndTimeEliminator" MUID: (5358C3EA01ED)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdStartAndTimeEliminator = class(Tk2TagFilter)
  {* �������� Start � Time � ���������. }
  protected
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdStartAndTimeEliminator

implementation

uses
 l3ImplUses
 , Document_Const
 , k2Tags
 //#UC START# *5358C3EA01EDimpl_uses*
 //#UC END# *5358C3EA01EDimpl_uses*
;

procedure TevdStartAndTimeEliminator.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_5358C3EA01ED_var*
//#UC END# *4A2D1634025B_5358C3EA01ED_var*
begin
//#UC START# *4A2D1634025B_5358C3EA01ED_impl*
 if TopType[1].IsKindOf(k2_typDocument_SysLogRecords) then
  if ((AtomIndex = k2_tiStart) or (AtomIndex = k2_tiTime)) then Exit;
 if (AtomIndex = k2_tiHasAnno) then Exit;
 if (AtomIndex = k2_tiRelInternalHandle) then Exit;
 if (AtomIndex = k2_tiExternalVerLink) then Exit;
 if (AtomIndex = k2_tiInternalVerLink) then Exit;
 if (AtomIndex = k2_tiUserType) then Exit;
 if (AtomIndex = k2_tiNameComment) then Exit;
 if (AtomIndex = k2_tiPriceLevel) then Exit;
 if (AtomIndex = k2_tiUrgency) then Exit;
 inherited;
//#UC END# *4A2D1634025B_5358C3EA01ED_impl*
end;//TevdStartAndTimeEliminator.DoAddAtomEx

end.
