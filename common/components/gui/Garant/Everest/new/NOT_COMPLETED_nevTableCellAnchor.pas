unit NOT_COMPLETED_nevTableCellAnchor;
 {* Якорь для ячейки таблицы }

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevTableCellAnchor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevTableCellAnchor" MUID: (4A5D82380323)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaListAnchor
 , nevTools
 {$If Defined(evUseVisibleCursors)}
 , nevParaListAnchorModifyTypes
 {$IfEnd} // Defined(evUseVisibleCursors)
;

type
 TnevTableCellAnchor = class(TnevParaListAnchor)
  {* Якорь для ячейки таблицы }
  protected
   function pm_GetHasInner: Boolean; override;
   {$If Defined(evUseVisibleCursors)}
   function DoIncLine(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean;
    const aChildrenInfo: TnevChildrenInfo): Integer; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   procedure ClearInnerInFire; override;
 end;//TnevTableCellAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , evdTypes
 , k2Tags
;

function TnevTableCellAnchor.pm_GetHasInner: Boolean;
//#UC START# *4A58BA550111_4A5D82380323get_var*
//#UC END# *4A58BA550111_4A5D82380323get_var*
begin
//#UC START# *4A58BA550111_4A5D82380323get_impl*
 Result := TevMergeStatus(IntA[k2_tiMergeStatus]) <> ev_msContinue;
 if Result then
  Result := inherited pm_GetHasInner;
//#UC END# *4A58BA550111_4A5D82380323get_impl*
end;//TnevTableCellAnchor.pm_GetHasInner

{$If Defined(evUseVisibleCursors)}
function TnevTableCellAnchor.DoIncLine(const aView: InevView;
 var theLine: Integer;
 aSmall: Boolean;
 const aChildrenInfo: TnevChildrenInfo): Integer;
//#UC START# *4B1D18650208_4A5D82380323_var*
//#UC END# *4B1D18650208_4A5D82380323_var*
begin
//#UC START# *4B1D18650208_4A5D82380323_impl*
 if TevMergeStatus(IntA[k2_tiMergeStatus]) = ev_msContinue then
  Result := 0
 else
  Result := inherited DoIncLine(aView, theLine, aSmall, aChildrenInfo);
//#UC END# *4B1D18650208_4A5D82380323_impl*
end;//TnevTableCellAnchor.DoIncLine
{$IfEnd} // Defined(evUseVisibleCursors)

procedure TnevTableCellAnchor.ClearInnerInFire;
//#UC START# *55376B1B00F8_4A5D82380323_var*
//#UC END# *55376B1B00F8_4A5D82380323_var*
begin
//#UC START# *55376B1B00F8_4A5D82380323_impl*
 // Выключено в: http://mdp.garant.ru/pages/viewpage.action?pageId=597332678
 // Если понадобиться восстановить, то нужно учесть, что при сбросе Inner нужно информировать родительский, т.е. базовую линию от таблицы.
 // Ибо её тогда нужно перестроить. И редактор нужно перерисовать, т.к. наверняка понадобится прокрутка. 
//#UC END# *55376B1B00F8_4A5D82380323_impl*
end;//TnevTableCellAnchor.ClearInnerInFire
{$IfEnd} // Defined(k2ForEditor)

end.
