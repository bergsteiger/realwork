unit NOT_FINISHED_nscArrangeGridCell;
 {* Ячейки сетки контролов }

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscArrangeGridCell.pas"
// Стереотип: "UtilityPack"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TnscHideFieldCell = class
 end;//TnscHideFieldCell

 TagControlCell = class
  public
   constructor Create(aControl: TControl); reintroduce; virtual;
 end;//TagControlCell
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

constructor TagControlCell.Create(aControl: TControl);
//#UC START# *4ACA31830369_4ACA309200D3_var*
//#UC END# *4ACA31830369_4ACA309200D3_var*
begin
//#UC START# *4ACA31830369_4ACA309200D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ACA31830369_4ACA309200D3_impl*
end;//TagControlCell.Create
{$IfEnd} // Defined(Nemesis)

end.
