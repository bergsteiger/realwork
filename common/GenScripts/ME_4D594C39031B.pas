unit evTextParaHeaderHotSpot;
 {* HotSpot на заголовок параграфа }

// Модуль: "w:\common\components\gui\Garant\Everest\evTextParaHeaderHotSpot.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evHotSpot
 , nevGUIInterfaces
 , nevTools
 , nevBase
 , afwInterfaces
;

type
 TevTextParaHeaderHotSpot = class(TevHotSpot, IevHotSpot)
  {* HotSpot на заголовок параграфа }
  private
   f_Para: InevPara;
  private
   procedure DoCollapse(const aView: InevControlView);
  protected
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
   procedure DoHitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo); override;
   procedure ClearFields; override;
  public
   constructor Create(const aPara: InevPara;
    const aProcessor: InevProcessor); reintroduce;
   class function Make(const aPara: InevPara;
    const aProcessor: InevProcessor): IevHotSpot; reintroduce;
 end;//TevTextParaHeaderHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , k2Tags
 , evdStyles
;

const
 {* Локализуемые строки Local }
 str_tphhsShowVersionInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'tphhsShowVersionInfo'; rValue : 'Показать информацию об изменениях');
  {* 'Показать информацию об изменениях' }
 str_tphhsHideVersionInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'tphhsHideVersionInfo'; rValue : 'Скрыть информацию об изменениях');
  {* 'Скрыть информацию об изменениях' }

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
end;//TevTextParaHeaderHotSpot.Make

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

function TevTextParaHeaderHotSpot.MouseMove(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает перемещение мыши }
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
 {* Обрабатывает нажатие левой кнопки мыши }
//#UC START# *48E266AA00A4_4D594C39031B_var*
//#UC END# *48E266AA00A4_4D594C39031B_var*
begin
//#UC START# *48E266AA00A4_4D594C39031B_impl*
 Result := true;
//#UC END# *48E266AA00A4_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.LButtonDown

function TevTextParaHeaderHotSpot.LButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание левой кнопки мыши }
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
 {* Обрабатывает двойное нажатие левой кнопки мыши }
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
 {* Обрабатывает нажатие правой кнопки мыши }
//#UC START# *48E266FB01FC_4D594C39031B_var*
//#UC END# *48E266FB01FC_4D594C39031B_var*
begin
//#UC START# *48E266FB01FC_4D594C39031B_impl*
 Result := false;
//#UC END# *48E266FB01FC_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.RButtonDown

function TevTextParaHeaderHotSpot.RButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание правой конопки мыши }
//#UC START# *48E267150266_4D594C39031B_var*
//#UC END# *48E267150266_4D594C39031B_var*
begin
//#UC START# *48E267150266_4D594C39031B_impl*
 Result := false;
//#UC END# *48E267150266_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.RButtonUp

function TevTextParaHeaderHotSpot.MButtonDown(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает нажатие колеса мыши }
//#UC START# *49DB4675025E_4D594C39031B_var*
//#UC END# *49DB4675025E_4D594C39031B_var*
begin
//#UC START# *49DB4675025E_4D594C39031B_impl*
 Result := false;
//#UC END# *49DB4675025E_4D594C39031B_impl*
end;//TevTextParaHeaderHotSpot.MButtonDown

function TevTextParaHeaderHotSpot.MButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание колеса мыши }
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
begin
 f_Para := nil;
 inherited;
end;//TevTextParaHeaderHotSpot.ClearFields

initialization
 str_tphhsShowVersionInfo.Init;
 {* Инициализация str_tphhsShowVersionInfo }
 str_tphhsHideVersionInfo.Init;
 {* Инициализация str_tphhsHideVersionInfo }
{$IfEnd} // Defined(evNeedHotSpot)

end.
