unit msmPaste;

// Модуль: "w:\common\components\gui\Garant\msm\msmPaste.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmPaste" MUID: (57E28018005C)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
 , msmOperations
;

type
 TmsmPaste = class(TmsmListLikeOperation)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
 end;//TmsmPaste

implementation

uses
 l3ImplUses
 , msmConcreteModels
 //#UC START# *57E28018005Cimpl_uses*
 , SysUtils
 , l3Interfaces
 , l3SysUtils
 , l3Base
 //#UC END# *57E28018005Cimpl_uses*
;

procedure TmsmPaste.DoDoIt;
//#UC START# *57CEB1F602D1_57E28018005C_var*
var
 l_IData : IDataObject;
 l_Sel : ImsmElementSelection;
//#UC END# *57CEB1F602D1_57E28018005C_var*
begin
//#UC START# *57CEB1F602D1_57E28018005C_impl*
 if not l3IFail(OleGetClipboard(l_IData)) then
  try
   if Supports(l_IData, ImsmElementSelection, l_Sel) then
    try
     Self.Model.Paste(l_Sel);
    finally
     l_Sel := nil;
    end;//try..finally
  finally
   l_IData := nil;
  end;//try..finally
//#UC END# *57CEB1F602D1_57E28018005C_impl*
end;//TmsmPaste.DoDoIt

function TmsmPaste.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57E28018005C_var*
var
 l_IData : IDataObject;
 l_Sel : ImsmElementSelection;
//#UC END# *57EB6D020381_57E28018005C_var*
begin
//#UC START# *57EB6D020381_57E28018005C_impl*
 Result := false;
 if not l3IFail(OleGetClipboard(l_IData)) then
  try
   if Supports(l_IData, ImsmElementSelection, l_Sel) then
    try
     Result := Self.Model.CanPaste(l_Sel);
    finally
     l_Sel := nil;
    end;//try..finally
  finally
   l_IData := nil;
  end;//try..finally
//#UC END# *57EB6D020381_57E28018005C_impl*
end;//TmsmPaste.GetEnabled

procedure TmsmPaste.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57E28018005C_var*
//#UC END# *57EBADA9033E_57E28018005C_var*
begin
//#UC START# *57EBADA9033E_57E28018005C_impl*
 inherited;
 theParams.rImageIndex := 10;
 theParams.SetShortCut('Ctrl+V');
//#UC END# *57EBADA9033E_57E28018005C_impl*
end;//TmsmPaste.InitOperationParams

end.
