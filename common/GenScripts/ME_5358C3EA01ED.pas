unit evdStartAndTimeEliminator;
 {* Обнуляет Start и Time у документа. }

// Модуль: "w:\common\components\gui\Garant\Everest\evdStartAndTimeEliminator.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdStartAndTimeEliminator = class(Tk2TagFilter)
  {* Обнуляет Start и Time у документа. }
  protected
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdStartAndTimeEliminator

implementation

uses
 l3ImplUses
 , Document_Const
 , k2Tags
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
