unit msmUpToParent;

// Модуль: "w:\common\components\gui\Garant\msm\msmUpToParent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmUpToParent" MUID: (57D175C401BD)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListOperation
;

type
 TmsmUpToParent = class(TmsmListOperation)
  protected
   procedure DoDoIt; override;
 end;//TmsmUpToParent

implementation

uses
 l3ImplUses
 //#UC START# *57D175C401BDimpl_uses*
 //#UC END# *57D175C401BDimpl_uses*
;

procedure TmsmUpToParent.DoDoIt;
//#UC START# *57CEB1F602D1_57D175C401BD_var*
//#UC END# *57CEB1F602D1_57D175C401BD_var*
begin
//#UC START# *57CEB1F602D1_57D175C401BD_impl*
 if (Self.Model.List = nil) then
  Exit;
 if (Self.Model.List.Owner = nil) then
  Exit;
 if (Self.Model.List.Owner.Parent = nil) then
  Exit;
 Self.Model.ShowElementAsList(Self.Model.List.Owner.Parent);
//#UC END# *57CEB1F602D1_57D175C401BD_impl*
end;//TmsmUpToParent.DoDoIt

end.
