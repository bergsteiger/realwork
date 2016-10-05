unit msmOperationAction;

// Модуль: "w:\common\components\gui\Garant\msm\msmOperationAction.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmOperationAction" MUID: (57EB5D9D002B)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , msmOperation
;

type
 TmsmOperationAction = class({$If NOT Defined(NoVCL)}
 TAction
 {$IfEnd} // NOT Defined(NoVCL)
 )
  private
   f_Operation: TmsmOperation;
  protected
   function Update: Boolean; override;
   function Execute: Boolean; override;
  public
   constructor Create(anOperation: TmsmOperation); reintroduce;
   destructor Destroy; override;
 end;//TmsmOperationAction

implementation

uses
 l3ImplUses
 , msmOperationsActionList
 , msmImages
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57EB5D9D002Bimpl_uses*
 , msmOperations
 //, msmImages
 //#UC END# *57EB5D9D002Bimpl_uses*
;

{$If NOT Defined(NoVCL)}
constructor TmsmOperationAction.Create(anOperation: TmsmOperation);
//#UC START# *57EB5ED2020D_57EB5D9D002B_var*
//#UC END# *57EB5ED2020D_57EB5D9D002B_var*
begin
//#UC START# *57EB5ED2020D_57EB5D9D002B_impl*
 Assert(anOperation <> nil);
 inherited Create(nil);
 Self.ActionList := TmsmOperationsActionList.Instance;
 f_Operation := anOperation;
 Self.Caption := ImsmOperation(f_Operation).Caption;
//#UC END# *57EB5ED2020D_57EB5D9D002B_impl*
end;//TmsmOperationAction.Create

destructor TmsmOperationAction.Destroy;
//#UC START# *48077504027E_57EB5D9D002B_var*
//#UC END# *48077504027E_57EB5D9D002B_var*
begin
//#UC START# *48077504027E_57EB5D9D002B_impl*
 f_Operation := nil;
 inherited;
//#UC END# *48077504027E_57EB5D9D002B_impl*
end;//TmsmOperationAction.Destroy

function TmsmOperationAction.Update: Boolean;
//#UC START# *57EB5BE402D1_57EB5D9D002B_var*
var
 l_P : TmsmOperationParams;
//#UC END# *57EB5BE402D1_57EB5D9D002B_var*
begin
//#UC START# *57EB5BE402D1_57EB5D9D002B_impl*
 Result := true;
 l_P := ImsmOperation(f_Operation).Params;
 Self.Caption := l_P.rCaption;
 Self.Enabled := l_P.rEnabled;
 Self.ImageIndex := TmsmImages.Instance.GetImageForOperation(l_P.rImageIndex{9}{opCopy});
//#UC END# *57EB5BE402D1_57EB5D9D002B_impl*
end;//TmsmOperationAction.Update

function TmsmOperationAction.Execute: Boolean;
//#UC START# *57EB5E6D011D_57EB5D9D002B_var*
//#UC END# *57EB5E6D011D_57EB5D9D002B_var*
begin
//#UC START# *57EB5E6D011D_57EB5D9D002B_impl*
 Result := true;
 ImsmOperation(f_Operation).DoIt;
//#UC END# *57EB5E6D011D_57EB5D9D002B_impl*
end;//TmsmOperationAction.Execute

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmOperationAction);
 {* Регистрация TmsmOperationAction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
