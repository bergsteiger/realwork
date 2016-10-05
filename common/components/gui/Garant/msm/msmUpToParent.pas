unit msmUpToParent;

// Модуль: "w:\common\components\gui\Garant\msm\msmUpToParent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmUpToParent" MUID: (57D175C401BD)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListOperation
 , msmOperations
;

type
 TmsmUpToParent = class(TmsmListOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
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

function TmsmUpToParent.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57D175C401BD_var*
//#UC END# *57EB6D020381_57D175C401BD_var*
begin
//#UC START# *57EB6D020381_57D175C401BD_impl*
 Result := false;
 if (Self.Model.List = nil) then
  Exit;
 if (Self.Model.List.Owner = nil) then
  Exit;
 if (Self.Model.List.Owner.Parent = nil) then
  Exit;
 Result := true;
//#UC END# *57EB6D020381_57D175C401BD_impl*
end;//TmsmUpToParent.GetEnabled

procedure TmsmUpToParent.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57D175C401BD_var*
//#UC END# *57EBADA9033E_57D175C401BD_var*
begin
//#UC START# *57EBADA9033E_57D175C401BD_impl*
 inherited;
 theParams.rImageIndex := 36;
//#UC END# *57EBADA9033E_57D175C401BD_impl*
end;//TmsmUpToParent.InitOperationParams

end.
