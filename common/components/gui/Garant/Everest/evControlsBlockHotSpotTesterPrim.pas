unit evControlsBlockHotSpotTesterPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evControlsBlockHotSpotTesterPrim.pas"
// Начат: 04.06.2009 15:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevControlsBlockHotSpotTesterPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot)}
uses
  afwInterfaces,
  l3Units,
  nevTools,
  evQueryCardInt,
  nevGUIInterfaces,
  evDocumentPartHotSpotTester
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TContrBlockActFlags = (
   ev_cbNoAction
 , ev_cbMainSurface
 , ev_cbButton
 );//TContrBlockActFlags

 TevControlsBlockHotSpotTesterPrim = class(TevDocumentPartHotSpotTester, IevMouseMoveHandler)
 private
 // private fields
   f_CommonControl : IevCommonControl;
    {* Поле для свойства CommonControl}
 protected
 // property methods
   function pm_GetCommonControl: IevCommonControl;
 protected
 // realized methods
   function TransMouseMove(const aView: InevControlView;
     const aKeys: TevMouseState;
     out theActiveElement: InevActiveElement): Boolean;
     {* Собственно реальный MouseMove, передаваемый редактору }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   function GetControl: IevQueryGroup;
   function PtToPara(const aPt: TafwPoint): Tl3Point;
   function MouseInBtn(const aPt: Tl3Point): Boolean;
 protected
 // protected properties
   property CommonControl: IevCommonControl
     read pm_GetCommonControl;
 end;//TevControlsBlockHotSpotTesterPrim
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  evControlsBlockConst,
  SysUtils
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

// start class TevControlsBlockHotSpotTesterPrim

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

function TevControlsBlockHotSpotTesterPrim.TransMouseMove(const aView: InevControlView;
  const aKeys: TevMouseState;
  out theActiveElement: InevActiveElement): Boolean;
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
//#UC START# *479731C50290_4A27B51303A7_var*
//#UC END# *479731C50290_4A27B51303A7_var*
begin
//#UC START# *479731C50290_4A27B51303A7_impl*
 f_CommonControl := nil;
 inherited;
//#UC END# *479731C50290_4A27B51303A7_impl*
end;//TevControlsBlockHotSpotTesterPrim.Cleanup

procedure TevControlsBlockHotSpotTesterPrim.ClearFields;
 {-}
begin
 {$If defined(evNeedHotSpot)}
 f_CommonControl := nil;
 {$IfEnd} //evNeedHotSpot
 inherited;
end;//TevControlsBlockHotSpotTesterPrim.ClearFields

{$IfEnd} //evNeedHotSpot

end.