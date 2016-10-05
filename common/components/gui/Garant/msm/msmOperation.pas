unit msmOperation;

// Модуль: "w:\common\components\gui\Garant\msm\msmOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmOperation" MUID: (57CEB1C1010D)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmOperations
 , msmModels
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TmsmOperation = {abstract} class(Tl3ProtoObject, ImsmOperation)
  private
   f_Caption: AnsiString;
   f_Model: ImsmModel;
   f_Action: TAction;
  protected
   function pm_GetAction: TAction;
   function GetCaption: AnsiString; virtual;
   procedure DoDoIt; virtual; abstract;
   function GetEnabled: Boolean; virtual; abstract;
   procedure InitOperationParams(var theParams: TmsmOperationParams); virtual;
   function Caption: AnsiString;
   procedure DoIt;
   function Get_Action: TAction;
   function Enabled: Boolean;
   function Get_Params: TmsmOperationParams;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aCaption: AnsiString;
    const aModel: ImsmModel); reintroduce;
   class function Make(const aCaption: AnsiString;
    const aModel: ImsmModel): ImsmOperation; reintroduce;
  protected
   property Model: ImsmModel
    read f_Model;
   property Action: TAction
    read pm_GetAction;
 end;//TmsmOperation

implementation

uses
 l3ImplUses
 , msmOperationAction
 , msmImages
 //#UC START# *57CEB1C1010Dimpl_uses*
 , SysUtils
 //#UC END# *57CEB1C1010Dimpl_uses*
;

function TmsmOperation.pm_GetAction: TAction;
//#UC START# *57EB5F2E0209_57CEB1C1010Dget_var*
//#UC END# *57EB5F2E0209_57CEB1C1010Dget_var*
begin
//#UC START# *57EB5F2E0209_57CEB1C1010Dget_impl*
 if (f_Action = nil) then
  f_Action := TmsmOperationAction.Create(Self);
 Result := f_Action; 
//#UC END# *57EB5F2E0209_57CEB1C1010Dget_impl*
end;//TmsmOperation.pm_GetAction

function TmsmOperation.GetCaption: AnsiString;
//#UC START# *57CEB1E803C0_57CEB1C1010D_var*
//#UC END# *57CEB1E803C0_57CEB1C1010D_var*
begin
//#UC START# *57CEB1E803C0_57CEB1C1010D_impl*
 Result := f_Caption;
//#UC END# *57CEB1E803C0_57CEB1C1010D_impl*
end;//TmsmOperation.GetCaption

constructor TmsmOperation.Create(const aCaption: AnsiString;
 const aModel: ImsmModel);
//#UC START# *57CEB3750096_57CEB1C1010D_var*
//#UC END# *57CEB3750096_57CEB1C1010D_var*
begin
//#UC START# *57CEB3750096_57CEB1C1010D_impl*
 f_Caption := aCaption;
 f_Model := aModel;
 inherited Create;
//#UC END# *57CEB3750096_57CEB1C1010D_impl*
end;//TmsmOperation.Create

class function TmsmOperation.Make(const aCaption: AnsiString;
 const aModel: ImsmModel): ImsmOperation;
var
 l_Inst : TmsmOperation;
begin
 l_Inst := Create(aCaption, aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmOperation.Make

procedure TmsmOperation.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57CEB1C1010D_var*
//#UC END# *57EBADA9033E_57CEB1C1010D_var*
begin
//#UC START# *57EBADA9033E_57CEB1C1010D_impl*
 // - ничего не делаем
//#UC END# *57EBADA9033E_57CEB1C1010D_impl*
end;//TmsmOperation.InitOperationParams

function TmsmOperation.Caption: AnsiString;
//#UC START# *57CEACFF03A3_57CEB1C1010D_var*
//#UC END# *57CEACFF03A3_57CEB1C1010D_var*
begin
//#UC START# *57CEACFF03A3_57CEB1C1010D_impl*
 Result := GetCaption;
//#UC END# *57CEACFF03A3_57CEB1C1010D_impl*
end;//TmsmOperation.Caption

procedure TmsmOperation.DoIt;
//#UC START# *57CEAD1C0068_57CEB1C1010D_var*
//#UC END# *57CEAD1C0068_57CEB1C1010D_var*
begin
//#UC START# *57CEAD1C0068_57CEB1C1010D_impl*
 DoDoIt;
//#UC END# *57CEAD1C0068_57CEB1C1010D_impl*
end;//TmsmOperation.DoIt

function TmsmOperation.Get_Action: TAction;
//#UC START# *57EB68C602CD_57CEB1C1010Dget_var*
//#UC END# *57EB68C602CD_57CEB1C1010Dget_var*
begin
//#UC START# *57EB68C602CD_57CEB1C1010Dget_impl*
 Result := Self.Action;
//#UC END# *57EB68C602CD_57CEB1C1010Dget_impl*
end;//TmsmOperation.Get_Action

function TmsmOperation.Enabled: Boolean;
//#UC START# *57EB6CCA0101_57CEB1C1010D_var*
//#UC END# *57EB6CCA0101_57CEB1C1010D_var*
begin
//#UC START# *57EB6CCA0101_57CEB1C1010D_impl*
 try
  Result := Self.GetEnabled;
 except
  on EAbstractError do
   Result := false;
 end;//try..except
//#UC END# *57EB6CCA0101_57CEB1C1010D_impl*
end;//TmsmOperation.Enabled

function TmsmOperation.Get_Params: TmsmOperationParams;
//#UC START# *57EBACCE031B_57CEB1C1010Dget_var*
//#UC END# *57EBACCE031B_57CEB1C1010Dget_var*
begin
//#UC START# *57EBACCE031B_57CEB1C1010Dget_impl*
 Result := TmsmOperationParams_C(Self.Caption, Self.Enabled);
 InitOperationParams(Result);
//#UC END# *57EBACCE031B_57CEB1C1010Dget_impl*
end;//TmsmOperation.Get_Params

procedure TmsmOperation.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57CEB1C1010D_var*
//#UC END# *479731C50290_57CEB1C1010D_var*
begin
//#UC START# *479731C50290_57CEB1C1010D_impl*
 FreeAndNil(f_Action);
 inherited;
//#UC END# *479731C50290_57CEB1C1010D_impl*
end;//TmsmOperation.Cleanup

procedure TmsmOperation.ClearFields;
begin
 f_Caption := '';
 f_Model := nil;
 inherited;
end;//TmsmOperation.ClearFields

end.
