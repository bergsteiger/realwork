unit evReqGroupHotSpotTester;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evReqGroupHotSpotTester.pas"
// Начат: 22.02.2011 21:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevReqGroupHotSpotTester
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot) AND defined(evReqGroupNeedsRadio)}
uses
  k2Interfaces,
  nevGUIInterfaces,
  evHotSpot,
  k2ProcessorTagTool,
  evTableHotSpot,
  l3Variant,
  nevTools,
  afwInterfaces,
  l3Interfaces
  ;
{$IfEnd} //evNeedHotSpot AND evReqGroupNeedsRadio

{$If defined(evNeedHotSpot) AND defined(evReqGroupNeedsRadio)}
type
 _nevParaListTool_Parent_ = TevHotSpot;
{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}
 TevReqGroupHotSpot = class(_nevParaListTool_, IevAdvancedHotSpot)
 protected
 // realized methods
   function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
     {* обрабатывает событие от мыши. Возвращает true - если обработано, иначе - false }
   function CanDrag: Boolean;
 protected
 // overridden protected methods
   procedure DoHitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo); override;
 public
 // public methods
   class function Make(aTag: Tl3Variant;
     const aProcessor: Ik2Processor): IevAdvancedHotSpot; reintroduce;
     {* Сигнатура фабрики TevReqGroupHotSpot.Make }
 end;//TevReqGroupHotSpot

 TevReqGroupHotSpotTester = class(TevTableHotSpotTester)
 protected
 // overridden protected methods
   function GetChildHotSpot(const aView: InevControlView;
     const aState: TevCursorState;
     const aPt: InevBasePoint;
     const aMap: InevMap;
     const aChild: InevObject;
     out theSpot: IevHotSpot): Boolean; override;
 end;//TevReqGroupHotSpotTester
{$IfEnd} //evNeedHotSpot AND evReqGroupNeedsRadio

implementation

{$If defined(evNeedHotSpot) AND defined(evReqGroupNeedsRadio)}
uses
  ReqGroup_Const,
  SysUtils,
  evHotSpotMisc,
  k2Tags,
  l3Units,
  l3Const,
  l3MinMax
  ;
{$IfEnd} //evNeedHotSpot AND evReqGroupNeedsRadio

{$If defined(evNeedHotSpot) AND defined(evReqGroupNeedsRadio)}

{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}

// start class TevReqGroupHotSpot

class function TevReqGroupHotSpot.Make(aTag: Tl3Variant;
  const aProcessor: Ik2Processor): IevAdvancedHotSpot;
var
 l_Inst : TevReqGroupHotSpot;
begin
 l_Inst := Create(aTag, aProcessor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TevReqGroupHotSpot.MouseAction(const aView: InevControlView;
  aButton: Tl3MouseButton;
  anAction: Tl3MouseAction;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E263CD01BD_4D64077A0131_var*
var
 l_N : InevPara;
//#UC END# *48E263CD01BD_4D64077A0131_var*
begin
//#UC START# *48E263CD01BD_4D64077A0131_impl*
 Result := true;
 if (aButton = l3_mbLeft) AND (anAction = l3_maUp) then
 begin
  if not ParaX.BoolA[k2_tiChecked] then
  begin
   ParaX.BoolA[k2_tiChecked] := true;
   l_N := ParaX.Prev;
   while (l_N <> nil) AND l_N.IsValid AND l_N.InheritsFrom(k2_idReqGroup) do
   begin
    l_N.BoolA[k2_tiChecked] := false;
    l_N := l_N.Prev;
   end;//while (l_N <> nil)..
   l_N := ParaX.Next;
   while (l_N <> nil) AND l_N.IsValid AND l_N.InheritsFrom(k2_idReqGroup) do
   begin
    l_N.BoolA[k2_tiChecked] := false;
    l_N := l_N.Next;
   end;//while (l_N <> nil)..
   aView.Control.ViewArea.Invalidate;
  end;//not ParaX.BoolA[k2_tiChecked]
 end;//aButton = l3_mbLeft..
//#UC END# *48E263CD01BD_4D64077A0131_impl*
end;//TevReqGroupHotSpot.MouseAction

function TevReqGroupHotSpot.CanDrag: Boolean;
//#UC START# *4ECCD6840014_4D64077A0131_var*
//#UC END# *4ECCD6840014_4D64077A0131_var*
begin
//#UC START# *4ECCD6840014_4D64077A0131_impl*
 Result := True;
//#UC END# *4ECCD6840014_4D64077A0131_impl*
end;//TevReqGroupHotSpot.CanDrag

procedure TevReqGroupHotSpot.DoHitTest(const aView: InevControlView;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *4A267FC6016B_4D64077A0131_var*
//#UC END# *4A267FC6016B_4D64077A0131_var*
begin
//#UC START# *4A267FC6016B_4D64077A0131_impl*
 inherited;
 theInfo.rCursor := ev_csArrow;
//#UC END# *4A267FC6016B_4D64077A0131_impl*
end;//TevReqGroupHotSpot.DoHitTest

function TevReqGroupHotSpotTester.GetChildHotSpot(const aView: InevControlView;
  const aState: TevCursorState;
  const aPt: InevBasePoint;
  const aMap: InevMap;
  const aChild: InevObject;
  out theSpot: IevHotSpot): Boolean;
//#UC START# *4D6406EE0228_4D64068D027B_var*
var
 l_P : Tl3Point;
//#UC END# *4D6406EE0228_4D64068D027B_var*
begin
//#UC START# *4D6406EE0228_4D64068D027B_impl*
 if (aChild <> nil) AND
    (aChild.PID = Max(0, (ParaX.ChildrenCount - 1) div 2)) then
 begin
  l_P := Tl3Point(aState.rPoint).Sub(aMap.Bounds.TopLeft);
  if {(l_P.X > 0) AND }(l_P.X < l3Inch div 4) then
  begin
   Result := true;
   theSpot := TevHotSpotWrap.Make(TevReqGroupHotSpot.Make(ParaX, Processor), aView);
   Exit;
  end;//l_P.X > 0
 end;//aChild <> nil..
(* if not ParaX.BoolA[k2_tiChecked] then
 begin
  Result := false;
  theSpot := nil;
 end//not ParaX.BoolA[k2_tiChecked]
 else*)
  Result := inherited GetChildHotSpot(aView, aState, aPt, aMap, aChild, theSpot);
//#UC END# *4D6406EE0228_4D64068D027B_impl*
end;//TevReqGroupHotSpotTester.GetChildHotSpot

{$IfEnd} //evNeedHotSpot AND evReqGroupNeedsRadio

end.