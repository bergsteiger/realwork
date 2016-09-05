unit evHotSpotProxy;

// Модуль: "w:\common\components\gui\Garant\Everest\evHotSpotProxy.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevHotSpotProxy" MUID: (4E1D76D101D0)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , l3CProtoObject
 , nevGUIInterfaces
 , nevTools
 , l3Interfaces
 , afwInterfaces
;

type
 TevHotSpotProxy = class(Tl3CProtoObject, IevMouseMoveHandler, IevHotSpot)
  private
   f_HotSpot: IevHotSpot;
  protected
   function DoLButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean; virtual;
   function DoLButtonDoubleClick(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; virtual;
   function DoTransMouseMove(const aView: InevControlView;
    const aKeys: TevMouseState;
    out theActiveElement: InevActiveElement): Boolean; virtual;
   function DoLButtonDown(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; virtual;
   function DoMButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean; virtual;
   function TransMouseMove(const aView: InevControlView;
    const aKeys: TevMouseState;
    out theActiveElement: InevActiveElement): Boolean;
    {* Собственно реальный MouseMove, передаваемый редактору }
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
   procedure ClearFields; override;
  public
   constructor Create(const aHotSpot: IevHotSpot); reintroduce;
   class function Make(const aHotSpot: IevHotSpot): IevHotSpot; reintroduce;
   procedure HitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo);
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
    {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//TevHotSpotProxy
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 //#UC START# *4E1D76D101D0impl_uses*
 //#UC END# *4E1D76D101D0impl_uses*
;

constructor TevHotSpotProxy.Create(const aHotSpot: IevHotSpot);
//#UC START# *4E1D77B700A5_4E1D76D101D0_var*
//#UC END# *4E1D77B700A5_4E1D76D101D0_var*
begin
//#UC START# *4E1D77B700A5_4E1D76D101D0_impl*
 Assert(aHotSpot <> nil);
 inherited Create;
 f_HotSpot := aHotSpot;
//#UC END# *4E1D77B700A5_4E1D76D101D0_impl*
end;//TevHotSpotProxy.Create

class function TevHotSpotProxy.Make(const aHotSpot: IevHotSpot): IevHotSpot;
var
 l_Inst : TevHotSpotProxy;
begin
 l_Inst := Create(aHotSpot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevHotSpotProxy.Make

function TevHotSpotProxy.DoLButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
//#UC START# *4E1D7BDF01C4_4E1D76D101D0_var*
//#UC END# *4E1D7BDF01C4_4E1D76D101D0_var*
begin
//#UC START# *4E1D7BDF01C4_4E1D76D101D0_impl*
 Result := f_HotSpot.LButtonUp(aView, Keys);
//#UC END# *4E1D7BDF01C4_4E1D76D101D0_impl*
end;//TevHotSpotProxy.DoLButtonUp

function TevHotSpotProxy.DoLButtonDoubleClick(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
//#UC START# *4E1D7C16028B_4E1D76D101D0_var*
//#UC END# *4E1D7C16028B_4E1D76D101D0_var*
begin
//#UC START# *4E1D7C16028B_4E1D76D101D0_impl*
 Result := f_HotSpot.LButtonDoubleClick(aView, Keys, Effect);
//#UC END# *4E1D7C16028B_4E1D76D101D0_impl*
end;//TevHotSpotProxy.DoLButtonDoubleClick

function TevHotSpotProxy.DoTransMouseMove(const aView: InevControlView;
 const aKeys: TevMouseState;
 out theActiveElement: InevActiveElement): Boolean;
//#UC START# *4E1D94EF002C_4E1D76D101D0_var*
var
 l_MMH : IevMouseMoveHandler;
//#UC END# *4E1D94EF002C_4E1D76D101D0_var*
begin
//#UC START# *4E1D94EF002C_4E1D76D101D0_impl*
 if Supports(f_HotSpot, IevMouseMoveHandler, l_MMH) then
  try
   Result := l_MMH.TransMouseMove(aView, aKeys, theActiveElement);
  finally
   l_MMH := nil;
  end//try..finally
 else
  Result := false;
//#UC END# *4E1D94EF002C_4E1D76D101D0_impl*
end;//TevHotSpotProxy.DoTransMouseMove

function TevHotSpotProxy.DoLButtonDown(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
//#UC START# *4E1DC2FF02BB_4E1D76D101D0_var*
//#UC END# *4E1DC2FF02BB_4E1D76D101D0_var*
begin
//#UC START# *4E1DC2FF02BB_4E1D76D101D0_impl*
 Result := f_HotSpot.LButtonDown(aView, Keys, Effect);
//#UC END# *4E1DC2FF02BB_4E1D76D101D0_impl*
end;//TevHotSpotProxy.DoLButtonDown

function TevHotSpotProxy.DoMButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
//#UC START# *548B10B4010F_4E1D76D101D0_var*
//#UC END# *548B10B4010F_4E1D76D101D0_var*
begin
//#UC START# *548B10B4010F_4E1D76D101D0_impl*
 f_HotSpot.MButtonUp(aView, Keys);
//#UC END# *548B10B4010F_4E1D76D101D0_impl*
end;//TevHotSpotProxy.DoMButtonUp

procedure TevHotSpotProxy.HitTest(const aView: InevControlView;
 const aState: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *48E2622A03C4_4E1D76D101D0_var*
//#UC END# *48E2622A03C4_4E1D76D101D0_var*
begin
//#UC START# *48E2622A03C4_4E1D76D101D0_impl*
 f_HotSpot.HitTest(aView, aState, theInfo);
//#UC END# *48E2622A03C4_4E1D76D101D0_impl*
end;//TevHotSpotProxy.HitTest

function TevHotSpotProxy.TransMouseMove(const aView: InevControlView;
 const aKeys: TevMouseState;
 out theActiveElement: InevActiveElement): Boolean;
 {* Собственно реальный MouseMove, передаваемый редактору }
//#UC START# *48E2638F0358_4E1D76D101D0_var*
//#UC END# *48E2638F0358_4E1D76D101D0_var*
begin
//#UC START# *48E2638F0358_4E1D76D101D0_impl*
 Result := DoTransMouseMove(aView, aKeys, theActiveElement);
//#UC END# *48E2638F0358_4E1D76D101D0_impl*
end;//TevHotSpotProxy.TransMouseMove

function TevHotSpotProxy.MouseMove(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает перемещение мыши }
//#UC START# *48E266730188_4E1D76D101D0_var*
//#UC END# *48E266730188_4E1D76D101D0_var*
begin
//#UC START# *48E266730188_4E1D76D101D0_impl*
 Result := f_HotSpot.MouseMove(aView, Keys);
//#UC END# *48E266730188_4E1D76D101D0_impl*
end;//TevHotSpotProxy.MouseMove

function TevHotSpotProxy.LButtonDown(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
 {* Обрабатывает нажатие левой кнопки мыши }
//#UC START# *48E266AA00A4_4E1D76D101D0_var*
//#UC END# *48E266AA00A4_4E1D76D101D0_var*
begin
//#UC START# *48E266AA00A4_4E1D76D101D0_impl*
 Result := DoLButtonDown(aView, Keys, Effect);
//#UC END# *48E266AA00A4_4E1D76D101D0_impl*
end;//TevHotSpotProxy.LButtonDown

function TevHotSpotProxy.LButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание левой кнопки мыши }
//#UC START# *48E266C70128_4E1D76D101D0_var*
//#UC END# *48E266C70128_4E1D76D101D0_var*
begin
//#UC START# *48E266C70128_4E1D76D101D0_impl*
 Result := DoLButtonUp(aView, Keys);
//#UC END# *48E266C70128_4E1D76D101D0_impl*
end;//TevHotSpotProxy.LButtonUp

function TevHotSpotProxy.LButtonDoubleClick(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
 {* Обрабатывает двойное нажатие левой кнопки мыши }
//#UC START# *48E266DE026B_4E1D76D101D0_var*
//#UC END# *48E266DE026B_4E1D76D101D0_var*
begin
//#UC START# *48E266DE026B_4E1D76D101D0_impl*
 Result := DoLButtonDoubleClick(aView, Keys, Effect);
//#UC END# *48E266DE026B_4E1D76D101D0_impl*
end;//TevHotSpotProxy.LButtonDoubleClick

function TevHotSpotProxy.RButtonDown(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает нажатие правой кнопки мыши }
//#UC START# *48E266FB01FC_4E1D76D101D0_var*
//#UC END# *48E266FB01FC_4E1D76D101D0_var*
begin
//#UC START# *48E266FB01FC_4E1D76D101D0_impl*
 Result := f_HotSpot.RButtonDown(aView, Keys);
//#UC END# *48E266FB01FC_4E1D76D101D0_impl*
end;//TevHotSpotProxy.RButtonDown

function TevHotSpotProxy.RButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание правой конопки мыши }
//#UC START# *48E267150266_4E1D76D101D0_var*
//#UC END# *48E267150266_4E1D76D101D0_var*
begin
//#UC START# *48E267150266_4E1D76D101D0_impl*
 Result := f_HotSpot.RButtonUp(aView, Keys);
//#UC END# *48E267150266_4E1D76D101D0_impl*
end;//TevHotSpotProxy.RButtonUp

function TevHotSpotProxy.MButtonDown(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает нажатие колеса мыши }
//#UC START# *49DB4675025E_4E1D76D101D0_var*
//#UC END# *49DB4675025E_4E1D76D101D0_var*
begin
//#UC START# *49DB4675025E_4E1D76D101D0_impl*
 Result := f_HotSpot.MButtonDown(aView, Keys);
//#UC END# *49DB4675025E_4E1D76D101D0_impl*
end;//TevHotSpotProxy.MButtonDown

function TevHotSpotProxy.MButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание колеса мыши }
//#UC START# *49DB468302A5_4E1D76D101D0_var*
//#UC END# *49DB468302A5_4E1D76D101D0_var*
begin
//#UC START# *49DB468302A5_4E1D76D101D0_impl*
 Result := //f_HotSpot.MButtonUp(aView, Keys);
  DoMButtonUp(aView, Keys);
//#UC END# *49DB468302A5_4E1D76D101D0_impl*
end;//TevHotSpotProxy.MButtonUp

function TevHotSpotProxy.CanDrag: Boolean;
//#UC START# *4ECCD6840014_4E1D76D101D0_var*
//#UC END# *4ECCD6840014_4E1D76D101D0_var*
begin
//#UC START# *4ECCD6840014_4E1D76D101D0_impl*
 Result := True;
//#UC END# *4ECCD6840014_4E1D76D101D0_impl*
end;//TevHotSpotProxy.CanDrag

function TevHotSpotProxy.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
//#UC START# *47A0AD3A01F7_4E1D76D101D0_var*
//#UC END# *47A0AD3A01F7_4E1D76D101D0_var*
begin
//#UC START# *47A0AD3A01F7_4E1D76D101D0_impl*
 Result := inherited QueryInterface(IID, Obj);
 if l3IFail(Result) then
  Result := f_HotSpot.QueryInterface(IID, Obj);
//#UC END# *47A0AD3A01F7_4E1D76D101D0_impl*
end;//TevHotSpotProxy.QueryInterface

procedure TevHotSpotProxy.ClearFields;
begin
 f_HotSpot := nil;
 inherited;
end;//TevHotSpotProxy.ClearFields
{$IfEnd} // Defined(evNeedHotSpot)

end.
