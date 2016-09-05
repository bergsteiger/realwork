unit ChromeLikeThemedWindowCaptionButtons;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeThemedWindowCaptionButtons.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ChromeLikeThemedWindowCaptionButtons" MUID: (533D1518032F)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , ChromeLikeBaseThemedWindowCaptionButton
 , l3Interfaces
;

type
 TChromeLikeThemedCloseCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
  protected
   function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams; override;
   function GetHintText: Il3CString; override;
 end;//TChromeLikeThemedCloseCaptionButton

 TChromeLikeThemedMaximizeCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
  protected
   function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams; override;
   function NeedUpdateHint: Boolean; override;
   function GetHintText: Il3CString; override;
 end;//TChromeLikeThemedMaximizeCaptionButton

 TChromeLikeThemedMinimizeCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
  protected
   function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams; override;
   function GetHintText: Il3CString; override;
 end;//TChromeLikeThemedMinimizeCaptionButton
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , UxTheme
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , ChromeLikeBaseWindowCaptionButton
 , ChromeLikeWindowCaptionButtonsRes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *533D1518032Fimpl_uses*
 //#UC END# *533D1518032Fimpl_uses*
;

function TChromeLikeThemedCloseCaptionButton.GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams;
//#UC START# *533D091902B8_533D0B3A02F3_var*
const
 cCloseCaptionButtonStateArr: array[TChromeLikeWindowCaptionButtonState] of Integer =
  (CBS_DISABLED, CBS_HOT, CBS_NORMAL, CBS_PUSHED);
//#UC END# *533D091902B8_533D0B3A02F3_var*
begin
//#UC START# *533D091902B8_533D0B3A02F3_impl*
 Result := inherited GetPaintParams;
 with Result do
 begin
  rPartID := WP_CLOSEBUTTON;
  rStateID := cCloseCaptionButtonStateArr[State];
 end;//with Result
//#UC END# *533D091902B8_533D0B3A02F3_impl*
end;//TChromeLikeThemedCloseCaptionButton.GetPaintParams

function TChromeLikeThemedCloseCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D0B3A02F3_var*
//#UC END# *5474500600DA_533D0B3A02F3_var*
begin
//#UC START# *5474500600DA_533D0B3A02F3_impl*
 Result := str_Close.AsCStr;
//#UC END# *5474500600DA_533D0B3A02F3_impl*
end;//TChromeLikeThemedCloseCaptionButton.GetHintText

function TChromeLikeThemedMaximizeCaptionButton.GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams;
//#UC START# *533D091902B8_533D0B640155_var*
const
 cMaximizeRestoreCaptionPartArr: array[Boolean] of Integer = (WP_MAXBUTTON,
  WP_RESTOREBUTTON);
 //
 cMaximizeCaptionButtonStateArr: array[TChromeLikeWindowCaptionButtonState] of Integer =
  (MAXBS_DISABLED, MAXBS_HOT, MAXBS_NORMAL, MAXBS_PUSHED);
 //
 cRestoreCaptionButtonStateArr: array[TChromeLikeWindowCaptionButtonState] of Integer =
  (RBS_DISABLED, RBS_HOT, RBS_NORMAL, RBS_PUSHED);
var
 l_IsMaximized: Boolean;
 l_State: Integer;
//#UC END# *533D091902B8_533D0B640155_var*
begin
//#UC START# *533D091902B8_533D0B640155_impl*
 Result := inherited GetPaintParams;
 if (ParentForm <> nil) then
 begin
  // Если окно развернуто на весь экран - рисуем кнопку "Восстановить",
  // если нет - "Развернуть"
  l_IsMaximized := (ParentForm.WindowState = wsMaximized);
  Result.rPartID := cMaximizeRestoreCaptionPartArr[l_IsMaximized];
  if not l_IsMaximized then
   l_State := cMaximizeCaptionButtonStateArr[State]
  else
   l_State := cRestoreCaptionButtonStateArr[State];
  Result.rStateID := l_State;
 end;//if (ParentForm <> nil)
//#UC END# *533D091902B8_533D0B640155_impl*
end;//TChromeLikeThemedMaximizeCaptionButton.GetPaintParams

function TChromeLikeThemedMaximizeCaptionButton.NeedUpdateHint: Boolean;
//#UC START# *54744FED0113_533D0B640155_var*
//#UC END# *54744FED0113_533D0B640155_var*
begin
//#UC START# *54744FED0113_533D0B640155_impl*
 Result := True;
//#UC END# *54744FED0113_533D0B640155_impl*
end;//TChromeLikeThemedMaximizeCaptionButton.NeedUpdateHint

function TChromeLikeThemedMaximizeCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D0B640155_var*
//#UC END# *5474500600DA_533D0B640155_var*
begin
//#UC START# *5474500600DA_533D0B640155_impl*
 if (ParentForm.WindowState = wsMaximized) then
  Result := str_Restore.AsCStr
 else
  Result := str_Maximize.AsCStr;
//#UC END# *5474500600DA_533D0B640155_impl*
end;//TChromeLikeThemedMaximizeCaptionButton.GetHintText

function TChromeLikeThemedMinimizeCaptionButton.GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams;
//#UC START# *533D091902B8_533D0B4B022A_var*
const
 cMinimizeCaptionButtonStateArr: array[TChromeLikeWindowCaptionButtonState] of Integer =
  (MINBS_DISABLED, MINBS_HOT, MINBS_NORMAL, MINBS_PUSHED);
//#UC END# *533D091902B8_533D0B4B022A_var*
begin
//#UC START# *533D091902B8_533D0B4B022A_impl*
 Result := inherited GetPaintParams;
 with Result do
 begin
  rPartID := WP_MINBUTTON;
  rStateID := cMinimizeCaptionButtonStateArr[State];
 end;//with Result
//#UC END# *533D091902B8_533D0B4B022A_impl*
end;//TChromeLikeThemedMinimizeCaptionButton.GetPaintParams

function TChromeLikeThemedMinimizeCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D0B4B022A_var*
//#UC END# *5474500600DA_533D0B4B022A_var*
begin
//#UC START# *5474500600DA_533D0B4B022A_impl*
 Result := str_Minimize.AsCStr;
//#UC END# *5474500600DA_533D0B4B022A_impl*
end;//TChromeLikeThemedMinimizeCaptionButton.GetHintText

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeThemedCloseCaptionButton);
 {* Регистрация TChromeLikeThemedCloseCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeThemedMaximizeCaptionButton);
 {* Регистрация TChromeLikeThemedMaximizeCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeThemedMinimizeCaptionButton);
 {* Регистрация TChromeLikeThemedMinimizeCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
