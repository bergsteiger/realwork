unit evDropControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/qf/evDropControl.pas"
// Начат: 25.01.2005 10:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::qf::TevDropControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  nevBase,
  l3Units,
  nevTools,
  evQueryCardDropControlsInt
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  evEditControl,
  Messages
  ;

type
 TevDropControl = class(TevEditControl, IevDropControl)
 private
 // private methods
   procedure CalcControlPosition(const aView: InevView;
    const aPt0: Tl3Point;
    const aExtend: Tl3Point;
    var aDropPoint: TPoint;
    var aInvert: Boolean;
    var aWidth: Integer);
   function DocumentToScreen(const aPt: Tl3Point): TPoint;
 protected
 // realized methods
   procedure AfterHideControl;
   procedure EscPressed;
     {* Обработчик закрытия дерева по ESC. }
   procedure HideControl;
     {* Прячет выпадающий контрол. }
   function MouseWheel(aDown: Boolean): Boolean;
     {* Обработчик прокрутки колеса мыши. }
   function KeyDown(const aView: InevView;
    var Msg: TWMKeyDown): Boolean;
   procedure CloseTree;
     {* Прячет дерево как по нажатию Esc - с посылкой сообщения редактору. }
   function Get_Down: Boolean;
   procedure Set_Down(aValue: Boolean);
   function DropDown(const aView: InevView;
    const aTextPara: InevPara;
    ByUser: Boolean): Boolean;
     {* Реализует выпадение дерева или календаря. }
   function Get_Para: InevPara;
   procedure DropDownCurrentChanged(const aNode: InevSimpleNode);
 protected
 // overridden protected methods
   function DoLMouseBtnUp(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    anInPara: Boolean): Boolean; override;
   function DoLMouseBtnDown(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    anInPara: Boolean;
    const aMap: InevMap): Boolean; override;
 public
 // overridden public methods
   function DoKeyCommand(const aView: InevControlView;
    aCmd: Word;
    const aTextPara: InevPara): Boolean; override;
 protected
 // protected methods
   function DropContainer: IevDropContainer;
     {* Возвращает интерфейс контейнера с обработкой событий дерева }
   function GetControl: TControl;
   function DropControlHeigth: Integer;
   procedure DoDrop(const aPoint: TPoint;
    AInvert: Boolean;
    AWidth: Integer;
    ByUser: Boolean); virtual; abstract;
     {* Вываливает выпадающий виджет по указанным координатам }
   function PtInButton(const aPt: TnevPoint;
    const aMap: InevMap): Boolean;
     {* Щелчок по кнопке редактора }
   procedure DoEscPressed; virtual;
   procedure DoDropDownCurrentChanged(const aNode: InevSimpleNode); virtual;
   procedure DoAfterHideControl; virtual;
 end;//TevDropControl

implementation

uses
  Windows,
  k2Tags,
  OvcConst
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nevFacade,
  SysUtils
  ;

// start class TevDropControl

function TevDropControl.DropContainer: IevDropContainer;
//#UC START# *48D378F50068_48D367B20014_var*
//#UC END# *48D378F50068_48D367B20014_var*
begin
//#UC START# *48D378F50068_48D367B20014_impl*
 Get_Req.QueryCard.QueryInterface(IevDropContainer, Result);
//#UC END# *48D378F50068_48D367B20014_impl*
end;//TevDropControl.DropContainer

function TevDropControl.GetControl: TControl;
//#UC START# *48D3795502E6_48D367B20014_var*
//#UC END# *48D3795502E6_48D367B20014_var*
begin
//#UC START# *48D3795502E6_48D367B20014_impl*
 Result := DropContainer.GetControl;
//#UC END# *48D3795502E6_48D367B20014_impl*
end;//TevDropControl.GetControl

procedure TevDropControl.CalcControlPosition(const aView: InevView;
  const aPt0: Tl3Point;
  const aExtend: Tl3Point;
  var aDropPoint: TPoint;
  var aInvert: Boolean;
  var aWidth: Integer);
//#UC START# *48D37B8500D3_48D367B20014_var*
var
 l_PtS        : Tl3SPoint;  
 l_Extend     : Tl3Point;
 l_SpacesTop  : Tl3Point;
 l_Monitor    : TMonitor;
 l_SpaceAfter : Integer;
//#UC END# *48D37B8500D3_48D367B20014_var*
begin
//#UC START# *48D37B8500D3_48D367B20014_impl*
 aInvert := False;
 with Para do 
 begin
  l_Extend := l3Point(aExtend.X, 0); //Ширина
  l_SpaceAfter := (Para.AsObject.IntA[k2_tiSpaceAfter] div 2);
  l_SpacesTop := l3Point(aPt0.X,
    aPt0.Y + aExtend.Y - l_SpaceAfter);
 end;//with Para do
 l_PtS := aView.Metrics.InfoCanvas.LP2DP(l_Extend);    
 l_PtS.X := l_PtS.X - 2;  
 aDropPoint := DocumentToScreen(l_SpacesTop);            
 aDropPoint.Y := aDropPoint.Y + 2;
 // - смещаем на высоту рамки http://mdp.garant.ru/pages/viewpage.action?pageId=228691765
 //Пересчет параметров
 l_Monitor := Screen.MonitorFromPoint(aDropPoint);
 if Screen.Width < ((aDropPoint.X - l_Monitor.Left) + l_PtS.X) then
  l_PtS.X := Screen.Width - (aDropPoint.X - l_Monitor.Left);
 with Para do
  if ((aDropPoint.Y + DropControlHeigth) > Screen.Height) and
    ((Screen.Height - aDropPoint.Y) < aDropPoint.Y) then 
   if not aInvert then 
   begin
    aInvert := True;
    l_SpacesTop := l3Point(aPt0.X, aPt0.Y + Para.AsObject.IntA[k2_tiSpaceAfter]);
    aDropPoint := DocumentToScreen(l_SpacesTop);
    aDropPoint.Y := aDropPoint.Y + 2;
   end;//if not l_Invert then
 aWidth := l_PtS.X;
//#UC END# *48D37B8500D3_48D367B20014_impl*
end;//TevDropControl.CalcControlPosition

function TevDropControl.DocumentToScreen(const aPt: Tl3Point): TPoint;
//#UC START# *48D37D3303B1_48D367B20014_var*
//#UC END# *48D37D3303B1_48D367B20014_var*
begin
//#UC START# *48D37D3303B1_48D367B20014_impl*
 Result := Get_Req.QueryCard.Editor.LP2DP(aPt, true);
//#UC END# *48D37D3303B1_48D367B20014_impl*
end;//TevDropControl.DocumentToScreen

function TevDropControl.DropControlHeigth: Integer;
//#UC START# *48D37D4E0201_48D367B20014_var*
//#UC END# *48D37D4E0201_48D367B20014_var*
begin
//#UC START# *48D37D4E0201_48D367B20014_impl*
 Result := DropContainer.DropControlHeigth;
//#UC END# *48D37D4E0201_48D367B20014_impl*
end;//TevDropControl.DropControlHeigth

function TevDropControl.PtInButton(const aPt: TnevPoint;
  const aMap: InevMap): Boolean;
//#UC START# *48D37D94002E_48D367B20014_var*
//#UC END# *48D37D94002E_48D367B20014_var*
begin
//#UC START# *48D37D94002E_48D367B20014_impl*
 Result := (aPt.X > aMap.FI.Width) and
           (aPt.X < (aMap.FI.Width + Para.AsObject.IntA[k2_tiRightIndent]));
//#UC END# *48D37D94002E_48D367B20014_impl*
end;//TevDropControl.PtInButton

procedure TevDropControl.DoEscPressed;
//#UC START# *48D3824000D5_48D367B20014_var*
//#UC END# *48D3824000D5_48D367B20014_var*
begin
//#UC START# *48D3824000D5_48D367B20014_impl*
//#UC END# *48D3824000D5_48D367B20014_impl*
end;//TevDropControl.DoEscPressed

procedure TevDropControl.DoDropDownCurrentChanged(const aNode: InevSimpleNode);
//#UC START# *48D38273036D_48D367B20014_var*
//#UC END# *48D38273036D_48D367B20014_var*
begin
//#UC START# *48D38273036D_48D367B20014_impl*
//#UC END# *48D38273036D_48D367B20014_impl*
end;//TevDropControl.DoDropDownCurrentChanged

procedure TevDropControl.DoAfterHideControl;
//#UC START# *48D382AA012A_48D367B20014_var*
//#UC END# *48D382AA012A_48D367B20014_var*
begin
//#UC START# *48D382AA012A_48D367B20014_impl*
//#UC END# *48D382AA012A_48D367B20014_impl*
end;//TevDropControl.DoAfterHideControl

procedure TevDropControl.AfterHideControl;
//#UC START# *47CE9ECA031E_48D367B20014_var*
//#UC END# *47CE9ECA031E_48D367B20014_var*
begin
//#UC START# *47CE9ECA031E_48D367B20014_impl*
 DoAfterHideControl;
//#UC END# *47CE9ECA031E_48D367B20014_impl*
end;//TevDropControl.AfterHideControl

procedure TevDropControl.EscPressed;
//#UC START# *47CE9ED103AA_48D367B20014_var*
//#UC END# *47CE9ED103AA_48D367B20014_var*
begin
//#UC START# *47CE9ED103AA_48D367B20014_impl*
 DoEscPressed;
//#UC END# *47CE9ED103AA_48D367B20014_impl*
end;//TevDropControl.EscPressed

procedure TevDropControl.HideControl;
//#UC START# *47CE9EE302A2_48D367B20014_var*
//#UC END# *47CE9EE302A2_48D367B20014_var*
begin
//#UC START# *47CE9EE302A2_48D367B20014_impl*
 DropContainer.HideControl(true);
 SetChecked(False);
//#UC END# *47CE9EE302A2_48D367B20014_impl*
end;//TevDropControl.HideControl

function TevDropControl.MouseWheel(aDown: Boolean): Boolean;
//#UC START# *47CE9EF3009B_48D367B20014_var*
//#UC END# *47CE9EF3009B_48D367B20014_var*
begin
//#UC START# *47CE9EF3009B_48D367B20014_impl*
 Result := True;
 if aDown then
  GetControl.Perform(WM_VScroll, SB_LINEDOWN, 0)
 else
  GetControl.Perform(WM_VScroll, SB_LINEUP, 0);
//#UC END# *47CE9EF3009B_48D367B20014_impl*
end;//TevDropControl.MouseWheel

function TevDropControl.KeyDown(const aView: InevView;
  var Msg: TWMKeyDown): Boolean;
//#UC START# *47CE9F040044_48D367B20014_var*
//#UC END# *47CE9F040044_48D367B20014_var*
begin
//#UC START# *47CE9F040044_48D367B20014_impl*
 Result := DropContainer.KeyDown(aView, Msg, Para.AsObject);
//#UC END# *47CE9F040044_48D367B20014_impl*
end;//TevDropControl.KeyDown

procedure TevDropControl.CloseTree;
//#UC START# *47CE9F4300B1_48D367B20014_var*
//#UC END# *47CE9F4300B1_48D367B20014_var*
begin
//#UC START# *47CE9F4300B1_48D367B20014_impl*
 HideControl;
//#UC END# *47CE9F4300B1_48D367B20014_impl*
end;//TevDropControl.CloseTree

function TevDropControl.Get_Down: Boolean;
//#UC START# *47CE9F560359_48D367B20014get_var*
//#UC END# *47CE9F560359_48D367B20014get_var*
begin
//#UC START# *47CE9F560359_48D367B20014get_impl*
 Result := Para.AsObject.BoolA[k2_tiChecked];
//#UC END# *47CE9F560359_48D367B20014get_impl*
end;//TevDropControl.Get_Down

procedure TevDropControl.Set_Down(aValue: Boolean);
//#UC START# *47CE9F560359_48D367B20014set_var*
//#UC END# *47CE9F560359_48D367B20014set_var*
begin
//#UC START# *47CE9F560359_48D367B20014set_impl*
 SetChecked(aValue);
//#UC END# *47CE9F560359_48D367B20014set_impl*
end;//TevDropControl.Set_Down

function TevDropControl.DropDown(const aView: InevView;
  const aTextPara: InevPara;
  ByUser: Boolean): Boolean;
//#UC START# *47CE9F82032D_48D367B20014_var*
var
 l_Pt0       : Tl3Point;
 l_Ex        : Tl3Point;
 l_Point     : TPoint;
 l_DataPanel : IevDropControl;
 l_Invert    : Boolean;
 l_Width     : Integer;
 l_QueryAd   : IevDropContainer;
 l_Map       : InevMap;
 l_CV        : InevControlView;
//#UC END# *47CE9F82032D_48D367B20014_var*
begin
//#UC START# *47CE9F82032D_48D367B20014_impl*
 Result := False;
 l_QueryAd := DropContainer;
 try
  if l_QueryAd.IsDropTreeVisible then
  begin
   l_DataPanel := nil;
   EscPressed;
   SetChecked(False);
  end 
  else
   l_DataPanel := Self;
  try
   if (aView = nil) then
    Exit;
   l_Map := aView.MapByPoint(aTextPara.MakePoint);
   if (l_Map = nil) then
   begin
    if Supports(aView, InevControlView, l_CV) then
     try
      l_CV.Control.ForceRepaint;
      l_Map := aView.MapByPoint(aTextPara.MakePoint);
     finally
      l_CV := nil;
     end//try..finally
    else
     Exit;
    if (l_Map = nil) then
     Exit;
   end;//l_Map = nil
   l_QueryAd.SetDropTree(l_DataPanel, Para);
   if (l_DataPanel <> nil) then
   begin
    Assert(l_Map <> nil);
    with Tl3Rect(l_Map.Bounds) do
    begin
     l_Pt0 := TopLeft;
     l_Ex := BottomRight.Sub(l_Pt0);
    end;//with l_Map.Bounds
    if (l_Pt0.X < 0) AND (l_Ex.X <= 0) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=204113269
    // Параграф не отформатирован (не отрисован) надо попробовать перерисовать всё
    // и потом взять новые координаты.
    begin
     if Supports(aView, InevControlView, l_CV) then
      try
       l_CV.Control.ForceRepaint;
       with Tl3Rect(l_Map.Bounds) do
       begin
        l_Pt0 := TopLeft;
        l_Ex := BottomRight.Sub(l_Pt0);
       end;//with l_Map.Bounds
       Assert((l_Pt0.X >= 0) OR (l_Ex.X > 0));
      finally
       l_CV := nil;
      end//try..finally
     else
      Exit;
    end;//l_Pt0.X < 0
    Set_Para(aTextPara);
    CalcControlPosition(aView, l_Pt0, l_Ex, l_Point, l_Invert, l_Width);
    DoDrop(l_Point, l_Invert, l_Width, ByUser);
    SetChecked(l_QueryAd.IsDropTreeVisible);
    Result := True;
   end;//if (l_DataPanel <> nil) then
  finally
   l_DataPanel := nil;
  end;//try..finally
 finally
  l_QueryAd := nil;
 end;//try..finally
//#UC END# *47CE9F82032D_48D367B20014_impl*
end;//TevDropControl.DropDown

function TevDropControl.Get_Para: InevPara;
//#UC START# *47CE9FA402DC_48D367B20014get_var*
//#UC END# *47CE9FA402DC_48D367B20014get_var*
begin
//#UC START# *47CE9FA402DC_48D367B20014get_impl*
 Result := inherited Get_Para;
//#UC END# *47CE9FA402DC_48D367B20014get_impl*
end;//TevDropControl.Get_Para

procedure TevDropControl.DropDownCurrentChanged(const aNode: InevSimpleNode);
//#UC START# *48845FB30308_48D367B20014_var*
//#UC END# *48845FB30308_48D367B20014_var*
begin
//#UC START# *48845FB30308_48D367B20014_impl*
// Do Nothing;
 DoDropDownCurrentChanged(aNode);
//#UC END# *48845FB30308_48D367B20014_impl*
end;//TevDropControl.DropDownCurrentChanged

function TevDropControl.DoKeyCommand(const aView: InevControlView;
  aCmd: Word;
  const aTextPara: InevPara): Boolean;
//#UC START# *48D145B8036A_48D367B20014_var*
//#UC END# *48D145B8036A_48D367B20014_var*
begin
//#UC START# *48D145B8036A_48D367B20014_impl*
 if aCmd = ccFastFindNext then
 begin
  DropDown(aView, aTextPara, True);
  Result := True;
 end
 else
  if (aCmd = ccActionItem) then
  begin
   Get_Req.KeyAction(aCmd);
   Result := True;  
  end
  else  
   Result := False;
//#UC END# *48D145B8036A_48D367B20014_impl*
end;//TevDropControl.DoKeyCommand

function TevDropControl.DoLMouseBtnUp(const aView: InevControlView;
  const aTextPara: InevPara;
  const aPt: TnevPoint;
  const Keys: TevMouseState;
  anInPara: Boolean): Boolean;
//#UC START# *48D1461101C6_48D367B20014_var*
//#UC END# *48D1461101C6_48D367B20014_var*
begin
//#UC START# *48D1461101C6_48D367B20014_impl*
 Result := True;
//#UC END# *48D1461101C6_48D367B20014_impl*
end;//TevDropControl.DoLMouseBtnUp

function TevDropControl.DoLMouseBtnDown(const aView: InevControlView;
  const aTextPara: InevPara;
  const aPt: TnevPoint;
  const Keys: TevMouseState;
  anInPara: Boolean;
  const aMap: InevMap): Boolean;
//#UC START# *48D1464501E8_48D367B20014_var*
//#UC END# *48D1464501E8_48D367B20014_var*
begin
//#UC START# *48D1464501E8_48D367B20014_impl*
 if anInPara and PtInButton(aPt, aMap) then 
  Result := DropDown(aView, aTextPara, True)
 else 
  Result := False;//anInPara;
//#UC END# *48D1464501E8_48D367B20014_impl*
end;//TevDropControl.DoLMouseBtnDown

end.