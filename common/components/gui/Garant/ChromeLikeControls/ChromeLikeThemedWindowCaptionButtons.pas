unit ChromeLikeThemedWindowCaptionButtons;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeThemedWindowCaptionButtons.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::ChromeLikeThemedWindowCaptionButtons
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  ChromeLikeBaseThemedWindowCaptionButton,
  l3Interfaces
  ;

type
 TChromeLikeThemedCloseCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
 protected
 // overridden protected methods
   function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams; override;
   function GetHintText: Il3CString; override;
 end;//TChromeLikeThemedCloseCaptionButton

 TChromeLikeThemedMaximizeCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
 protected
 // overridden protected methods
   function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams; override;
   function NeedUpdateHint: Boolean; override;
   function GetHintText: Il3CString; override;
 end;//TChromeLikeThemedMaximizeCaptionButton

 TChromeLikeThemedMinimizeCaptionButton = class(TChromeLikeBaseThemedWindowCaptionButton)
 protected
 // overridden protected methods
   function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams; override;
   function GetHintText: Il3CString; override;
 end;//TChromeLikeThemedMinimizeCaptionButton
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  UxTheme
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  ChromeLikeBaseWindowCaptionButton,
  ChromeLikeWindowCaptionButtonsRes
  ;

// start class TChromeLikeThemedCloseCaptionButton

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
// start class TChromeLikeThemedMaximizeCaptionButton

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
// start class TChromeLikeThemedMinimizeCaptionButton

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
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeThemedCloseCaptionButton
 TtfwClassRef.Register(TChromeLikeThemedCloseCaptionButton);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeThemedMaximizeCaptionButton
 TtfwClassRef.Register(TChromeLikeThemedMaximizeCaptionButton);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeThemedMinimizeCaptionButton
 TtfwClassRef.Register(TChromeLikeThemedMinimizeCaptionButton);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene

end.