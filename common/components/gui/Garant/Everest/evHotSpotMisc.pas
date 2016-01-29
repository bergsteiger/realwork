unit evHotSpotMisc;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evHotSpotMisc.pas"
// Начат: 09.10.2000 11:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::HotSpots::evHotSpotMisc
//
// Вспомогательные объекты для работы с горячими точками
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
  nevTools,
  evInternalInterfaces,
  l3ProtoObject,
  nevGUIInterfaces,
  afwInterfaces,
  l3Interfaces
  ;

type
 TevHotSpotWrap = class(Tl3ProtoObject, IevAdvancedHotSpot, IevHotSpot)
 private
 // private fields
   f_HotSpot : IevAdvancedHotSpot;
   f_HotSpotSink : IevHotSpotSink;
 protected
 // realized methods
   function MouseAction(const aView: InevControlView;
    aButton: Tl3MouseButton;
    anAction: Tl3MouseAction;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
     {* обрабатывает событие от мыши. Возвращает true - если обработано, иначе - false }
   function MouseMove(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
     {* Обрабатывает перемещение мыши }
   function LButtonDown(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
     {* Обрабатывает нажатие левой кнопки мыши }
   function LButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
     {* Обрабатывает отпускание левой кнопки мыши }
   function LButtonDoubleClick(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
     {* Обрабатывает двойное нажатие левой кнопки мыши }
   function RButtonDown(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
     {* Обрабатывает нажатие правой кнопки мыши }
   function RButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
     {* Обрабатывает отпускание правой конопки мыши }
   function MButtonDown(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
     {* Обрабатывает нажатие колеса мыши }
   function MButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
     {* Обрабатывает отпускание колеса мыши }
   function CanDrag: Boolean;
 public
 // realized methods
   procedure HitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
     {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 public
 // public methods
   constructor Create(const aHotSpot: IevAdvancedHotSpot;
     const aView: InevControlView); reintroduce; overload; 
   class function Make(const aHotSpot: IevAdvancedHotSpot;
     const aView: InevControlView): IevHotSpot; reintroduce; overload; 
     {* Сигнатура фабрики TevHotSpotWrap.Make }
   constructor Create(const aHotSpot: IevAdvancedHotSpot;
    const aHotSpotSink: IevHotSpotSink); reintroduce; overload; 
   class function Make(const aHotSpot: IevAdvancedHotSpot;
    const aHotSpotSink: IevHotSpotSink = nil): IevHotSpot; reintroduce; overload; 
 end;//TevHotSpotWrap
function EvTranslateMouseAction(const aView: InevControlView;
  const aHotSpot: IevHotSpot;
  aButton: TevMouseButton;
  anAction: TevMouseAction;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  SysUtils,
  l3Base,
  Classes,
  l3InterfacesMisc
  ;

// unit methods

function EvTranslateMouseAction(const aView: InevControlView;
  const aHotSpot: IevHotSpot;
  aButton: TevMouseButton;
  anAction: TevMouseAction;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *4A4384E70140_4A269456002A_var*
//#UC END# *4A4384E70140_4A269456002A_var*
var
 l_HotSpotSink : IevHotSpotSink;
begin
//#UC START# *4A4384E70140_4A269456002A_impl*
 if Supports(aView.Control, IevHotSpotSink, l_HotSpotSink) then
  try
   Result := l_HotSpotSink.MouseAction(aHotSpot, aButton, anAction, Keys, Effect);
  finally
   l_HotSpotSink := nil;
  end{try..finally}
 else
  Result := false;
//#UC END# *4A4384E70140_4A269456002A_impl*
end;//EvTranslateMouseAction
// start class TevHotSpotWrap

constructor TevHotSpotWrap.Create(const aHotSpot: IevAdvancedHotSpot;
  const aView: InevControlView);
//#UC START# *4D66245B02FA_4A43869A02C2_var*
var
 l_S : IevHotSpotSink;
//#UC END# *4D66245B02FA_4A43869A02C2_var*
begin
//#UC START# *4D66245B02FA_4A43869A02C2_impl*
 Supports(aView.Control, IevHotSpotSink, l_S);
 Create(aHotSpot, l_S);
//#UC END# *4D66245B02FA_4A43869A02C2_impl*
end;//TevHotSpotWrap.Create

class function TevHotSpotWrap.Make(const aHotSpot: IevAdvancedHotSpot;
  const aView: InevControlView): IevHotSpot;
var
 l_Inst : TevHotSpotWrap;
begin
 l_Inst := Create(aHotSpot, aView);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TevHotSpotWrap.Create(const aHotSpot: IevAdvancedHotSpot;
  const aHotSpotSink: IevHotSpotSink);
//#UC START# *4A4387070198_4A43869A02C2_var*
//#UC END# *4A4387070198_4A43869A02C2_var*
begin
//#UC START# *4A4387070198_4A43869A02C2_impl*
 Assert(aHotSpot <> nil, 'aHotSpot = nil !!!');
 inherited Create;
 f_HotSpot := aHotSpot;
 f_HotSpotSink := aHotSpotSink;
//#UC END# *4A4387070198_4A43869A02C2_impl*
end;//TevHotSpotWrap.Create

class function TevHotSpotWrap.Make(const aHotSpot: IevAdvancedHotSpot;
  const aHotSpotSink: IevHotSpotSink = nil): IevHotSpot;
var
 l_Inst : TevHotSpotWrap;
begin
 l_Inst := Create(aHotSpot, aHotSpotSink);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TevHotSpotWrap.HitTest(const aView: InevControlView;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *48E2622A03C4_4A43869A02C2_var*
//#UC END# *48E2622A03C4_4A43869A02C2_var*
begin
//#UC START# *48E2622A03C4_4A43869A02C2_impl*
 f_HotSpot.HitTest(aView, aState, theInfo);
//#UC END# *48E2622A03C4_4A43869A02C2_impl*
end;//TevHotSpotWrap.HitTest

function TevHotSpotWrap.MouseAction(const aView: InevControlView;
  aButton: Tl3MouseButton;
  anAction: Tl3MouseAction;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E263CD01BD_4A43869A02C2_var*
//#UC END# *48E263CD01BD_4A43869A02C2_var*
begin
//#UC START# *48E263CD01BD_4A43869A02C2_impl*
 Result := f_HotSpot.MouseAction(aView, aButton, anAction, Keys, Effect);
 if not Result AND (f_HotSpotSink <> nil) then
  Result := f_HotSpotSink.MouseAction(Self, aButton, anAction, Keys, Effect);
//#UC END# *48E263CD01BD_4A43869A02C2_impl*
end;//TevHotSpotWrap.MouseAction

function TevHotSpotWrap.MouseMove(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266730188_4A43869A02C2_var*
var
 l_MouseButton : TevMouseButton;
 l_Dummy       : TevMouseEffect;
//#UC END# *48E266730188_4A43869A02C2_var*
begin
//#UC START# *48E266730188_4A43869A02C2_impl*
 if (ssLeft in Keys.rKeys) then
  l_MouseButton := ev_mbLeft
 else
 if (ssRight in Keys.rKeys) then
  l_MouseButton := ev_mbRight
 else
  l_MouseButton := ev_mbMiddle;
 l3FillChar(l_Dummy, SizeOf(l_Dummy), 0);
 Result := MouseAction(aView, l_MouseButton, ev_maMove, Keys, l_Dummy);
//#UC END# *48E266730188_4A43869A02C2_impl*
end;//TevHotSpotWrap.MouseMove

function TevHotSpotWrap.LButtonDown(const aView: InevControlView;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E266AA00A4_4A43869A02C2_var*
//#UC END# *48E266AA00A4_4A43869A02C2_var*
begin
//#UC START# *48E266AA00A4_4A43869A02C2_impl*
 Result := MouseAction(aView, ev_mbLeft, ev_maDown, Keys, Effect);
//#UC END# *48E266AA00A4_4A43869A02C2_impl*
end;//TevHotSpotWrap.LButtonDown

function TevHotSpotWrap.LButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266C70128_4A43869A02C2_var*
var
 l_Dummy : TevMouseEffect;
//#UC END# *48E266C70128_4A43869A02C2_var*
begin
//#UC START# *48E266C70128_4A43869A02C2_impl*
 l3FillChar(l_Dummy, SizeOf(l_Dummy), 0);
 Result := MouseAction(aView, ev_mbLeft, ev_maUp, Keys, l_Dummy);
//#UC END# *48E266C70128_4A43869A02C2_impl*
end;//TevHotSpotWrap.LButtonUp

function TevHotSpotWrap.LButtonDoubleClick(const aView: InevControlView;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E266DE026B_4A43869A02C2_var*
//#UC END# *48E266DE026B_4A43869A02C2_var*
begin
//#UC START# *48E266DE026B_4A43869A02C2_impl*
 Result := MouseAction(aView, ev_mbLeft, ev_maDouble, Keys, Effect);
//#UC END# *48E266DE026B_4A43869A02C2_impl*
end;//TevHotSpotWrap.LButtonDoubleClick

function TevHotSpotWrap.RButtonDown(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266FB01FC_4A43869A02C2_var*
var
 l_Dummy : TevMouseEffect;
//#UC END# *48E266FB01FC_4A43869A02C2_var*
begin
//#UC START# *48E266FB01FC_4A43869A02C2_impl*
 l3FillChar(l_Dummy, SizeOf(l_Dummy), 0);
 Result := MouseAction(aView, ev_mbRight, ev_maDown, Keys, l_Dummy);
//#UC END# *48E266FB01FC_4A43869A02C2_impl*
end;//TevHotSpotWrap.RButtonDown

function TevHotSpotWrap.RButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E267150266_4A43869A02C2_var*
var
 l_Dummy : TevMouseEffect;
//#UC END# *48E267150266_4A43869A02C2_var*
begin
//#UC START# *48E267150266_4A43869A02C2_impl*
 l3FillChar(l_Dummy, SizeOf(l_Dummy), 0);
 Result := MouseAction(aView, ev_mbRight, ev_maUp, Keys, l_Dummy);
//#UC END# *48E267150266_4A43869A02C2_impl*
end;//TevHotSpotWrap.RButtonUp

function TevHotSpotWrap.MButtonDown(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *49DB4675025E_4A43869A02C2_var*
var
 l_Dummy : TevMouseEffect;
//#UC END# *49DB4675025E_4A43869A02C2_var*
begin
//#UC START# *49DB4675025E_4A43869A02C2_impl*
 l3FillChar(l_Dummy, SizeOf(l_Dummy), 0);
 Result := MouseAction(aView, ev_mbMiddle, ev_maDown, Keys, l_Dummy);
//#UC END# *49DB4675025E_4A43869A02C2_impl*
end;//TevHotSpotWrap.MButtonDown

function TevHotSpotWrap.MButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *49DB468302A5_4A43869A02C2_var*
var
 l_Dummy : TevMouseEffect;
//#UC END# *49DB468302A5_4A43869A02C2_var*
begin
//#UC START# *49DB468302A5_4A43869A02C2_impl*
 l3FillChar(l_Dummy, SizeOf(l_Dummy), 0);
 Result := MouseAction(aView, ev_mbMiddle, ev_maUp, Keys, l_Dummy);
//#UC END# *49DB468302A5_4A43869A02C2_impl*
end;//TevHotSpotWrap.MButtonUp

function TevHotSpotWrap.CanDrag: Boolean;
//#UC START# *4ECCD6840014_4A43869A02C2_var*
//#UC END# *4ECCD6840014_4A43869A02C2_var*
begin
//#UC START# *4ECCD6840014_4A43869A02C2_impl*
 Result := f_HotSpot.CanDrag;
//#UC END# *4ECCD6840014_4A43869A02C2_impl*
end;//TevHotSpotWrap.CanDrag

procedure TevHotSpotWrap.Cleanup;
//#UC START# *479731C50290_4A43869A02C2_var*
//#UC END# *479731C50290_4A43869A02C2_var*
begin
//#UC START# *479731C50290_4A43869A02C2_impl*
 f_HotSpotSink := nil;
 f_HotSpot := nil;
 inherited;
//#UC END# *479731C50290_4A43869A02C2_impl*
end;//TevHotSpotWrap.Cleanup

function TevHotSpotWrap.QueryInterface(const IID: TGUID;
  out Obj): HResult;
//#UC START# *47A0AD3A01F7_4A43869A02C2_var*
//#UC END# *47A0AD3A01F7_4A43869A02C2_var*
begin
//#UC START# *47A0AD3A01F7_4A43869A02C2_impl*
 Result := inherited QueryInterface(IID, Obj);
 if l3IFail(Result) then
  Result := f_HotSpot.QueryInterface(IID, Obj);
//#UC END# *47A0AD3A01F7_4A43869A02C2_impl*
end;//TevHotSpotWrap.QueryInterface
{$IfEnd} //evNeedHotSpot

end.