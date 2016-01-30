unit vtOutlinerWithQuickSearch;

// Модуль: "w:\common\components\gui\Garant\VT\vtOutlinerWithQuickSearch.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , vtOutliner
 , Types
 , Classes
;

type
 //#UC START# *4B97EA0802EBci*
 //#UC END# *4B97EA0802EBci*
 //#UC START# *4B97EA0802EBcit*
 //#UC END# *4B97EA0802EBcit*
 TvtOutlinerWithQuickSearch = class(TvtCustomOutliner)
  private
   f_MousePos: TPoint;
  private
   procedure QuickSearchHandler(Sender: TObject;
    const aString: AnsiString);
   procedure QuickSearchHintTimerEvent(Sender: TObject);
  public
   constructor Create(AOwner: TComponent); override;
 //#UC START# *4B97EA0802EBpubl*
 published
 // published properties
   property Color;
   property OnIsCommandProcessed;
   property OnGetItemHeight;
 //#UC END# *4B97EA0802EBpubl*
 end;//TvtOutlinerWithQuickSearch

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvtOutlinerWithQuickSearch.QuickSearchHandler(Sender: TObject;
 const aString: AnsiString);
//#UC START# *5166DD350150_4B97EA0802EB_var*
var
  l_HintWindow: THintWindow;
  l_Rect: TRect;
//#UC END# *5166DD350150_4B97EA0802EB_var*
begin
//#UC START# *5166DD350150_4B97EA0802EB_impl*
{use Application.Hint
  if aString = '' then
    FreeHintWindow
  else begin
    GetCursorPos(f_MousePos);
    l_Rect := GetDrawTextRect(Current);
    with l_Rect do begin
      TopLeft := ClientToScreen(TopLeft);
      BottomRight := ClientToScreen(BottomRight);
      Top := Bottom;
      Left := Left  - 1;
      Top := Top - 3;
      Right := Left + Canvas.Canvas.TextWidth(aString) + 6;
      Bottom := Top + Canvas.Canvas.TextHeight(aString) + 2;
      ShowHintWindow(aString, TopLeft);
    end;
    fHintTimer.OnTimer := QuickSearchHintTimerEvent;
    fHintTimer.Enabled := True;
  end;
}
//use fHintWindow
  if (aString = '') then
    FreeHintWindow
  else
  begin
   l_HintWindow := GetHintWindow;
   if Assigned(l_HintWindow) then
   begin
    GetCursorPos(f_MousePos);
    l_Rect := GetDrawTextRect(Current);
    with l_Rect do
    begin
     TopLeft := ClientToScreen(TopLeft);
     BottomRight := ClientToScreen(BottomRight);
     Top := Bottom;
     DrawText(
       hDC(l_HintWindow.Canvas.Handle),
       PChar(aString),
       -1,
       l_Rect,//with
       DT_CALCRECT or DT_LEFT);// or DT_WORDBREAK
     Left := Left  - 1;
     Top := Top - 3;
     Right := Right + 6;
     Bottom := Bottom - 2;
    end;//with l_Rect
    l_HintWindow.ActivateHint(l_Rect, aString);
    f_HintTimer.OnTimer := QuickSearchHintTimerEvent;
    f_HintTimer.Enabled := True;
   end;//Assigned(l_HintWindow)
  end;//aString = ''
//#UC END# *5166DD350150_4B97EA0802EB_impl*
end;//TvtOutlinerWithQuickSearch.QuickSearchHandler

procedure TvtOutlinerWithQuickSearch.QuickSearchHintTimerEvent(Sender: TObject);
//#UC START# *5166DD570238_4B97EA0802EB_var*
var
  l_Point: TPoint;
//#UC END# *5166DD570238_4B97EA0802EB_var*
begin
//#UC START# *5166DD570238_4B97EA0802EB_impl*
 GetCursorPos(l_Point);
 if (f_MousePos.X = l_Point.X) and (f_MousePos.Y = l_Point.Y) then
  exit;
 with ScreentoClient(l_Point) do
  if (X < 0) or (X > ClientWidth) or (Y < 0) or (Y > ClientHeight) or (not Application.Active) then
   FreeHintWindow;
//#UC END# *5166DD570238_4B97EA0802EB_impl*
end;//TvtOutlinerWithQuickSearch.QuickSearchHintTimerEvent

constructor TvtOutlinerWithQuickSearch.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4B97EA0802EB_var*
//#UC END# *47D1602000C6_4B97EA0802EB_var*
begin
//#UC START# *47D1602000C6_4B97EA0802EB_impl*
 inherited Create(AOwner);
 OnQuickSearchStrChanged := QuickSearchHandler;
//#UC END# *47D1602000C6_4B97EA0802EB_impl*
end;//TvtOutlinerWithQuickSearch.Create

//#UC START# *4B97EA0802EBimpl*
//#UC END# *4B97EA0802EBimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtOutlinerWithQuickSearch);
 {* Регистрация TvtOutlinerWithQuickSearch }
{$IfEnd} // NOT Defined(NoScripts)

end.
