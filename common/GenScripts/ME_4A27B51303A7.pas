unit evControlsBlockHotSpotTesterPrim;

// Модуль: "w:\common\components\gui\Garant\Everest\evControlsBlockHotSpotTesterPrim.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evDocumentPartHotSpotTester
 , nevGUIInterfaces
 , nevTools
 , evQueryCardInt
 , l3Units
 , afwInterfaces
;

type
 TContrBlockActFlags = (
  ev_cbNoAction
  , ev_cbMainSurface
  , ev_cbButton
 );//TContrBlockActFlags

 TevControlsBlockHotSpotTesterPrim = class(TevDocumentPartHotSpotTester, IevMouseMoveHandler)
  private
   f_CommonControl: IevCommonControl;
    {* Поле для свойства CommonControl }
  protected
   function pm_GetCommonControl: IevCommonControl;
   function GetControl: IevQueryGroup;
   function PtToPara(const aPt: TafwPoint): Tl3Point;
   function MouseInBtn(const aPt: Tl3Point): Boolean;
   function TransMouseMove(const aView: InevControlView;
    const aKeys: TevMouseState;
    out theActiveElement: InevActiveElement): Boolean;
    {* Собственно реальный MouseMove, передаваемый редактору }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  protected
   property CommonControl: IevCommonControl
    read pm_GetCommonControl;
 end;//TevControlsBlockHotSpotTesterPrim
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , SysUtils
 , evControlsBlockConst
;

function TevControlsBlockHotSpotTesterPrim.pm_GetCommonControl: IevCommonControl;
//#UC START# *4A27B7B10328_4A27B51303A7get_var*
//#UC END# *4A27B7B10328_4A27B51303A7get_var*
begin
//#UC START# *4A27B7B10328_4A27B51303A7get_impl*
 if f_CommonControl = nil then
  Supports(ParaX, IevCommonControl, f_CommonControl);
 Result := f_CommonControl;
//#UC END# *4A27B7B10328_4A27B51303A7get_impl*
end;//TevControlsBlockHotSpotTesterPrim.pm_GetCommonControl

function TevControlsBlockHotSpotTesterPrim.GetControl: IevQueryGroup;
//#UC START# *4A27B59E000D_4A27B51303A7_var*
//#UC END# *4A27B59E000D_4A27B51303A7_var*
begin
//#UC START# *4A27B59E000D_4A27B51303A7_impl*
 GetRedirect.QT(IevQueryGroup, Result);
//#UC END# *4A27B59E000D_4A27B51303A7_impl*
end;//TevControlsBlockHotSpotTesterPrim.GetControl

function TevControlsBlockHotSpotTesterPrim.PtToPara(const aPt: TafwPoint): Tl3Point;
//#UC START# *4A27B66101A0_4A27B51303A7_var*
//#UC END# *4A27B66101A0_4A27B51303A7_var*
begin
//#UC START# *4A27B66101A0_4A27B51303A7_impl*
 Result := Tl3Point(aPt).Sub(Tl3Rect(thisMap.Bounds).TopLeft);
//#UC END# *4A27B66101A0_4A27B51303A7_impl*
end;//TevControlsBlockHotSpotTesterPrim.PtToPara

function TevControlsBlockHotSpotTesterPrim.MouseInBtn(const aPt: Tl3Point): Boolean;
//#UC START# *4A27B6890151_4A27B51303A7_var*
var
 l_Width : Integer;
//#UC END# *4A27B6890151_4A27B51303A7_var*
begin
//#UC START# *4A27B6890151_4A27B51303A7_impl*
 l_Width := thisMap.FI.rLimitWidth;
 Result := (aPt.X >= (l_Width - evControlBlockBtnWidth)) and (aPt.X <= l_Width)
   and (aPt.Y >= evControlBlockTop) and
   (aPt.Y <= (evControlBlockBefore - evControlBlockTop));
//#UC END# *4A27B6890151_4A27B51303A7_impl*
end;//TevControlsBlockHotSpotTesterPrim.MouseInBtn

function TevControlsBlockHotSpotTesterPrim.TransMouseMove(const aView: InevControlView;
 const aKeys: TevMouseState;
 out theActiveElement: InevActiveElement): Boolean;
 {* Собственно реальный MouseMove, передаваемый редактору }
//#UC START# *48E2638F0358_4A27B51303A7_var*
var
 l_Control : IevQueryGroup;                                                     
 l_Pt      : Tl3Point;
 l_Upper   : Boolean;
//#UC END# *48E2638F0358_4A27B51303A7_var*
begin
//#UC START# *48E2638F0358_4A27B51303A7_impl*
 l_Control := GetControl; 
 if l_Control <> nil then
 begin
  l_Pt := PtToPara(aKeys.rPoint); 
  l_Upper := MouseInBtn(l_Pt) and l_Control.CanCollapsed;
  if l_Upper <> CommonControl.Upper then
   CommonControl.Upper := l_Upper;
  if l_Upper then
   l_Control.UpperChange;
 end; 
 Result := True;
//#UC END# *48E2638F0358_4A27B51303A7_impl*
end;//TevControlsBlockHotSpotTesterPrim.TransMouseMove

procedure TevControlsBlockHotSpotTesterPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A27B51303A7_var*
//#UC END# *479731C50290_4A27B51303A7_var*
begin
//#UC START# *479731C50290_4A27B51303A7_impl*
 f_CommonControl := nil;
 inherited;
//#UC END# *479731C50290_4A27B51303A7_impl*
end;//TevControlsBlockHotSpotTesterPrim.Cleanup

procedure TevControlsBlockHotSpotTesterPrim.ClearFields;
begin
 f_CommonControl := nil;
 inherited;
end;//TevControlsBlockHotSpotTesterPrim.ClearFields
{$IfEnd} // Defined(evNeedHotSpot)

end.
