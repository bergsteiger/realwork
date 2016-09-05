unit vtStyledFocusLabel;

// Модуль: "w:\common\components\gui\Garant\VT\vtStyledFocusLabel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtStyledFocusLabel" MUID: (573B55E900C9)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , vtFocusLabel
 , afwInterfaces
 , evTypes
 , Messages
 , Classes
;

type
 TvtStyledFocusLabel = class(TvtFocusLabel{$If NOT Defined(DesignTimeLibrary)}
 , IafwStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 )
  private
   f_IsActive: Boolean;
    {* мышь над ссылкой }
   f_StyleId: TevStyleId;
   f_ActiveStyleId: TevStyleId;
  private
   procedure WMMouseLeave(var Msg: TMessage); message WM_MOUSELEAVE;
  protected
   procedure pm_SetStyleId(const aValue: TevStyleId);
   procedure pm_SetActiveStyleId(const aValue: TevStyleId);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure StyleTableChanged;
    {* таблица стилей изменилась. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCL)}
   procedure MouseMove(Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   function NeedUnderLine: Boolean; override;
  public
   property StyleId: TevStyleId
    read f_StyleId
    write pm_SetStyleId;
   property ActiveStyleId: TevStyleId
    read f_ActiveStyleId
    write pm_SetActiveStyleId;
 end;//TvtStyledFocusLabel

implementation

uses
 l3ImplUses
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , evStyleInterface
 , TextPara_Const
 , evdTextStyle_Const
 , Windows
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *573B55E900C9impl_uses*
 //#UC END# *573B55E900C9impl_uses*
;

procedure TvtStyledFocusLabel.pm_SetStyleId(const aValue: TevStyleId);
//#UC START# *573B562D011B_573B55E900C9set_var*
//#UC END# *573B562D011B_573B55E900C9set_var*
begin
//#UC START# *573B562D011B_573B55E900C9set_impl*
 if (aValue <> f_StyleId) then
 begin
  f_StyleId := aValue;
  {$IfNDef DesignTimeLibrary}
  StyleTableChanged;
  {$EndIf DesignTimeLibrary}
 end;//if aValue <> f_StyleId then
//#UC END# *573B562D011B_573B55E900C9set_impl*
end;//TvtStyledFocusLabel.pm_SetStyleId

procedure TvtStyledFocusLabel.pm_SetActiveStyleId(const aValue: TevStyleId);
//#UC START# *573DC5DE03C7_573B55E900C9set_var*
//#UC END# *573DC5DE03C7_573B55E900C9set_var*
begin
//#UC START# *573DC5DE03C7_573B55E900C9set_impl*
 if (aValue <> f_ActiveStyleId) then
 begin
  f_ActiveStyleId := aValue;
  {$IfNDef DesignTimeLibrary}
  StyleTableChanged;
  {$EndIf DesignTimeLibrary}
 end;//if aValue <> f_StyleId then
//#UC END# *573DC5DE03C7_573B55E900C9set_impl*
end;//TvtStyledFocusLabel.pm_SetActiveStyleId

procedure TvtStyledFocusLabel.WMMouseLeave(var Msg: TMessage);
//#UC START# *573DD16B0002_573B55E900C9_var*
//#UC END# *573DD16B0002_573B55E900C9_var*
begin
//#UC START# *573DD16B0002_573B55E900C9_impl*
 f_IsActive := False;
 StyleTableChanged;
//#UC END# *573DD16B0002_573B55E900C9_impl*
end;//TvtStyledFocusLabel.WMMouseLeave

{$If NOT Defined(DesignTimeLibrary)}
procedure TvtStyledFocusLabel.StyleTableChanged;
 {* таблица стилей изменилась. }
//#UC START# *467D2CB10135_573B55E900C9_var*
var
 l_Style: TevStyleId;
//#UC END# *467D2CB10135_573B55E900C9_var*
begin
//#UC START# *467D2CB10135_573B55E900C9_impl*
 if f_IsActive then
  l_Style := f_ActiveStyleId
 else
  l_Style := f_StyleId;
 with TevStyleInterface.Make(k2_typTextPara, l_Style) do
 try
  Font.Assign2Font(Self.Font);
  TextColor := Font.BackColor;
  DoAutoSize;
 finally
  Free;
 end;//try..finally
//#UC END# *467D2CB10135_573B55E900C9_impl*
end;//TvtStyledFocusLabel.StyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvtStyledFocusLabel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_573B55E900C9_var*
//#UC END# *479731C50290_573B55E900C9_var*
begin
//#UC START# *479731C50290_573B55E900C9_impl*
 {$IfNDef DesignTimeLibrary}
 evDelStyleTableSpy(Self);
 {$EndIf DesignTimeLibrary}
 inherited;
//#UC END# *479731C50290_573B55E900C9_impl*
end;//TvtStyledFocusLabel.Cleanup

procedure TvtStyledFocusLabel.InitFields;
//#UC START# *47A042E100E2_573B55E900C9_var*
//#UC END# *47A042E100E2_573B55E900C9_var*
begin
//#UC START# *47A042E100E2_573B55E900C9_impl*
 inherited;
 StyleId := evd_saHyperLink;
 ActiveStyleId := evd_saActiveHyperLink;
 {$IfNDef DesignTimeLibrary}
 evAddStyleTableSpy(Self, True);
 {$EndIf DesignTimeLibrary}
//#UC END# *47A042E100E2_573B55E900C9_impl*
end;//TvtStyledFocusLabel.InitFields

{$If NOT Defined(NoVCL)}
procedure TvtStyledFocusLabel.MouseMove(Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *48E22B250241_573B55E900C9_var*
var
 l_TME: TTrackMouseEvent;
//#UC END# *48E22B250241_573B55E900C9_var*
begin
//#UC START# *48E22B250241_573B55E900C9_impl*
 if not f_IsActive then
 begin
  f_IsActive := True;
  StyleTableChanged;
 end;
 l_TME.cbSize := SizeOf(TTrackMouseEvent);
 l_TME.dwFlags := TME_LEAVE;
 l_TME.hwndTrack := Handle;
 TrackMouseEvent(l_TME);
//#UC END# *48E22B250241_573B55E900C9_impl*
end;//TvtStyledFocusLabel.MouseMove
{$IfEnd} // NOT Defined(NoVCL)

function TvtStyledFocusLabel.NeedUnderLine: Boolean;
//#UC START# *4B61371503B9_573B55E900C9_var*
//#UC END# *4B61371503B9_573B55E900C9_var*
begin
//#UC START# *4B61371503B9_573B55E900C9_impl*
 Result := f_IsActive;
//#UC END# *4B61371503B9_573B55E900C9_impl*
end;//TvtStyledFocusLabel.NeedUnderLine

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtStyledFocusLabel);
 {* Регистрация TvtStyledFocusLabel }
{$IfEnd} // NOT Defined(NoScripts)

end.
