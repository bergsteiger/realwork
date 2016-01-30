unit evDescriptionReq;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evDescriptionReq.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , nevTools
 , l3Interfaces
;

type
 TevDescriptionReq = class(TevCustomControlTool, IevDescriptionReq)
  private
   f_DescControl: IevCommonControl;
  private
   procedure InitModel;
  protected
   function pm_GetReqName: Il3CString;
   function pm_GetCollapsed: Boolean;
   procedure pm_SetCollapsed(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make(const aValue: InevPara): IevDescriptionReq; reintroduce;
   constructor Create(const aPara: InevPara); override;
 end;//TevDescriptionReq

implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
 , evdTypes
 , nevFacade
 , ControlPara_Const
;

class function TevDescriptionReq.Make(const aValue: InevPara): IevDescriptionReq;
var
 l_Inst : TevDescriptionReq;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevDescriptionReq.Make

procedure TevDescriptionReq.InitModel;
//#UC START# *48D3C2C7018E_48D3C237039F_var*

 function GetChildControl(const aChild: InevPara; Index: Integer): Boolean;
 begin
  Result := (f_DescControl = nil);
  if Result then
  begin
   with aChild.AsList[0] do
    if AsObject.IsKindOf(k2_typControlPara) then
     AsObject.QT(IevCommonControl,f_DescControl);
  end;//Result
 end;//GetChildLine

//#UC END# *48D3C2C7018E_48D3C237039F_var*
begin
//#UC START# *48D3C2C7018E_48D3C237039F_impl*
 with Para do
  if AsObject.IsValid then
  begin
   Assert(TevReqKind(AsObject.IntA[k2_tiReqKind]) = ev_rkDescription);
   AsList.IterateParaF(nevL2PIA(@GetChildControl));
  end;
//#UC END# *48D3C2C7018E_48D3C237039F_impl*
end;//TevDescriptionReq.InitModel

function TevDescriptionReq.pm_GetReqName: Il3CString;
//#UC START# *47CD5DF301FE_48D3C237039Fget_var*
//#UC END# *47CD5DF301FE_48D3C237039Fget_var*
begin
//#UC START# *47CD5DF301FE_48D3C237039Fget_impl*
 Para.AsObject.Attr[k2_tiReqID].QI(Il3CString, Result);
//#UC END# *47CD5DF301FE_48D3C237039Fget_impl*
end;//TevDescriptionReq.pm_GetReqName

function TevDescriptionReq.pm_GetCollapsed: Boolean;
//#UC START# *47CD5E1C00AE_48D3C237039Fget_var*
//#UC END# *47CD5E1C00AE_48D3C237039Fget_var*
begin
//#UC START# *47CD5E1C00AE_48D3C237039Fget_impl*
 Result := f_DescControl.Collapsed;
//#UC END# *47CD5E1C00AE_48D3C237039Fget_impl*
end;//TevDescriptionReq.pm_GetCollapsed

procedure TevDescriptionReq.pm_SetCollapsed(aValue: Boolean);
//#UC START# *47CD5E1C00AE_48D3C237039Fset_var*
//#UC END# *47CD5E1C00AE_48D3C237039Fset_var*
begin
//#UC START# *47CD5E1C00AE_48D3C237039Fset_impl*
 f_DescControl.Collapsed := aValue;
//#UC END# *47CD5E1C00AE_48D3C237039Fset_impl*
end;//TevDescriptionReq.pm_SetCollapsed

procedure TevDescriptionReq.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48D3C237039F_var*
//#UC END# *479731C50290_48D3C237039F_var*
begin
//#UC START# *479731C50290_48D3C237039F_impl*
 f_DescControl := nil;
 inherited;
//#UC END# *479731C50290_48D3C237039F_impl*
end;//TevDescriptionReq.Cleanup

constructor TevDescriptionReq.Create(const aPara: InevPara);
//#UC START# *47CFE07602FE_48D3C237039F_var*
//#UC END# *47CFE07602FE_48D3C237039F_var*
begin
//#UC START# *47CFE07602FE_48D3C237039F_impl*
 inherited Create(aPara);
 InitModel;
//#UC END# *47CFE07602FE_48D3C237039F_impl*
end;//TevDescriptionReq.Create

end.
