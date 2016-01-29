unit evTextParaHeaderHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTextParaHeaderHotSpot.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevTextParaHeaderHotSpot
//
// HotSpot на заголовок параграфа
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
  nevBase,
  nevTools,
  nevGUIInterfaces,
  evHotSpot,
  l3StringIDEx,
  afwInterfaces
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevTextParaHeaderHotSpot = class(TevHotSpot, IevHotSpot)
  {* HotSpot на заголовок параграфа }
 private
 // private fields
   f_Para : InevPara;
 private
 // private methods
   procedure DoCollapse(const aView: InevControlView);
 protected
 // realized methods
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
 protected
 // overridden protected methods
   procedure DoHitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aPara: InevPara;
     const aProcessor: InevProcessor); reintroduce;
   class function Make(const aPara: InevPara;
     const aProcessor: InevProcessor): IevHotSpot; reintroduce;
     {* Сигнатура фабрики TevTextParaHeaderHotSpot.Make }
 end;//TevTextParaHeaderHotSpot
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  k2Tags,
  evdStyles,
  l3MessageID
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

var
   { Локализуемые строки Local }
  str_tphhsShowVersionInfo : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'tphhsShowVersionInfo'; rValue : 'Показать информацию об изменениях');
   { 'Показать информацию об изменениях' }
  str_tphhsHideVersionInfo : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'tphhsHideVersionInfo'; rValue : 'Скрыть информацию об изменениях');
   { 'Скрыть информацию об изменениях' }

// start class TevTextParaHeaderHotSpot

procedure TevTextParaHeaderHotSpot.DoCollapse(const aView: InevControlView);
//#UC START# *4D59515E0255_4D594C39031B_var*
var
 l_C  : Boolean;
 l_Op : InevOp;
 l_S  : Integer;
 l_P  : InevPara;
//#UC END# *4D59515E0255_4D594C39031B_var*
begin
//#UC START# *4D59515E0255_4D594C39031B_impl*
 l_S := f_Para.AsObject.IntA[k2_tiStyle];
 l_C := not aView.IsObjectCollapsed[f_Para];
 l_P := f_Para;
 l_Op := Processor.StartOp;
 try
  while (l_P <> nil) AND l_P.AsObject.IsValid AND
        (l_P.AsObject.IntA[k2_tiStyle] = l_S) do
  begin
   aView.IsObjectCollapsed[l_P] := l_C;
   l_P := evNextOverallPara(l_P);
  end;//while (l_P <> nil)..
 finally
  l_Op := nil;
 end;//try..finally
 f_Para.Invalidate([nev_spExtent]);
//#UC END# *4D59515E0255_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.DoCollapse

constructor TevTextParaHeaderHotSpot.Create(const aPara: InevPara;
  const aProcessor: InevProcessor);
//#UC START# *4D594C980253_4D594C39031B_var*
//#UC END# *4D594C980253_4D594C39031B_var*
begin
//#UC START# *4D594C980253_4D594C39031B_impl*
 inherited Create(aPara.AsObject, aProcessor);
 f_Para := aPara;
//#UC END# *4D594C980253_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.Create

class function TevTextParaHeaderHotSpot.Make(const aPara: InevPara;
  const aProcessor: InevProcessor): IevHotSpot;
var
 l_Inst : TevTextParaHeaderHotSpot;
begin
 l_Inst := Create(aPara, aProcessor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TevTextParaHeaderHotSpot.MouseMove(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266730188_4D594C39031B_var*
//#UC END# *48E266730188_4D594C39031B_var*
begin
//#UC START# *48E266730188_4D594C39031B_impl*
 Result := false;
//#UC END# *48E266730188_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.MouseMove

function TevTextParaHeaderHotSpot.LButtonDown(const aView: InevControlView;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E266AA00A4_4D594C39031B_var*
//#UC END# *48E266AA00A4_4D594C39031B_var*
begin
//#UC START# *48E266AA00A4_4D594C39031B_impl*
 Result := true;
//#UC END# *48E266AA00A4_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.LButtonDown

function TevTextParaHeaderHotSpot.LButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266C70128_4D594C39031B_var*
//#UC END# *48E266C70128_4D594C39031B_var*
begin
//#UC START# *48E266C70128_4D594C39031B_impl*
 DoCollapse(aView);
 Result := true;
//#UC END# *48E266C70128_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.LButtonUp

function TevTextParaHeaderHotSpot.LButtonDoubleClick(const aView: InevControlView;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E266DE026B_4D594C39031B_var*
//#UC END# *48E266DE026B_4D594C39031B_var*
begin
//#UC START# *48E266DE026B_4D594C39031B_impl*
 DoCollapse(aView);
 Result := true;
//#UC END# *48E266DE026B_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.LButtonDoubleClick

function TevTextParaHeaderHotSpot.RButtonDown(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266FB01FC_4D594C39031B_var*
//#UC END# *48E266FB01FC_4D594C39031B_var*
begin
//#UC START# *48E266FB01FC_4D594C39031B_impl*
 Result := false;
//#UC END# *48E266FB01FC_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.RButtonDown

function TevTextParaHeaderHotSpot.RButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E267150266_4D594C39031B_var*
//#UC END# *48E267150266_4D594C39031B_var*
begin
//#UC START# *48E267150266_4D594C39031B_impl*
 Result := false;
//#UC END# *48E267150266_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.RButtonUp

function TevTextParaHeaderHotSpot.MButtonDown(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *49DB4675025E_4D594C39031B_var*
//#UC END# *49DB4675025E_4D594C39031B_var*
begin
//#UC START# *49DB4675025E_4D594C39031B_impl*
 Result := false;
//#UC END# *49DB4675025E_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.MButtonDown

function TevTextParaHeaderHotSpot.MButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *49DB468302A5_4D594C39031B_var*
//#UC END# *49DB468302A5_4D594C39031B_var*
begin
//#UC START# *49DB468302A5_4D594C39031B_impl*
 Result := false;
//#UC END# *49DB468302A5_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.MButtonUp

function TevTextParaHeaderHotSpot.CanDrag: Boolean;
//#UC START# *4ECCD6840014_4D594C39031B_var*
//#UC END# *4ECCD6840014_4D594C39031B_var*
begin
//#UC START# *4ECCD6840014_4D594C39031B_impl*
 Result := True;
//#UC END# *4ECCD6840014_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.CanDrag

procedure TevTextParaHeaderHotSpot.DoHitTest(const aView: InevControlView;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *4A267FC6016B_4D594C39031B_var*
//#UC END# *4A267FC6016B_4D594C39031B_var*
begin
//#UC START# *4A267FC6016B_4D594C39031B_impl*
 inherited;
 theInfo.rCursor := ev_csHandPoint;
 if aView.IsObjectCollapsed[f_Para] then
  theInfo.rHint := str_tphhsShowVersionInfo.AsCStr
 else
  theInfo.rHint := str_tphhsHideVersionInfo.AsCStr;
//#UC END# *4A267FC6016B_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.DoHitTest

procedure TevTextParaHeaderHotSpot.ClearFields;
 {-}
begin
 {$If defined(evNeedHotSpot)}
 f_Para := nil;
 {$IfEnd} //evNeedHotSpot
 inherited;
end;//TevTextParaHeaderHotSpot.ClearFields

{$IfEnd} //evNeedHotSpot

initialization
{$If defined(evNeedHotSpot)}
// Инициализация str_tphhsShowVersionInfo
 str_tphhsShowVersionInfo.Init;
{$IfEnd} //evNeedHotSpot
{$If defined(evNeedHotSpot)}
// Инициализация str_tphhsHideVersionInfo
 str_tphhsHideVersionInfo.Init;
{$IfEnd} //evNeedHotSpot

end.