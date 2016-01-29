unit evDescriptionReq;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/qf/evDescriptionReq.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::qf::TevDescriptionReq
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevTools,
  evQueryCardInt,
  evCustomControlTool,
  l3Interfaces
  ;

type
 TevDescriptionReq = class(TevCustomControlTool, IevDescriptionReq)
 private
 // private fields
   f_DescControl : IevCommonControl;
 private
 // private methods
   procedure InitModel;
 protected
 // realized methods
   function pm_GetReqName: Il3CString;
   function pm_GetCollapsed: Boolean;
   procedure pm_SetCollapsed(aValue: Boolean);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(const aPara: InevPara); override;
 public
 // public methods
   class function Make(const aValue: InevPara): IevDescriptionReq; reintroduce;
 end;//TevDescriptionReq

implementation

uses
  k2Tags,
  SysUtils,
  evdTypes,
  nevFacade,
  ControlPara_Const
  ;

// start class TevDescriptionReq

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
end;

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