unit ChromeLikeLegacyWindowCaptionButtons;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeLegacyWindowCaptionButtons.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::ChromeLikeLegacyWindowCaptionButtons
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Windows,
  ChromeLikeBaseWindowCaptionButton,
  l3Interfaces
  ;

type
 TChromeLikeLegacyWindowCaptionButton = class(TChromeLikeBaseWindowCaptionButton)
 private
 // private methods
   function GetButtonStateFlag: UINT;
 end;//TChromeLikeLegacyWindowCaptionButton

 TChromeLikeLegacyMinimizeCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
 protected
 // overridden protected methods
    {$If not defined(NoVCL)}
   procedure Paint; override;
     {* Сигнатура метода Paint }
    {$IfEnd} //not NoVCL
   function GetHintText: Il3CString; override;
 end;//TChromeLikeLegacyMinimizeCaptionButton

 TChromeLikeLegacyMaximizeCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
 protected
 // overridden protected methods
    {$If not defined(NoVCL)}
   procedure Paint; override;
     {* Сигнатура метода Paint }
    {$IfEnd} //not NoVCL
   function NeedUpdateHint: Boolean; override;
   function GetHintText: Il3CString; override;
 end;//TChromeLikeLegacyMaximizeCaptionButton

 TChromeLikeLegacyCloseCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
 protected
 // overridden protected methods
    {$If not defined(NoVCL)}
   procedure Paint; override;
     {* Сигнатура метода Paint }
    {$IfEnd} //not NoVCL
   function GetHintText: Il3CString; override;
 end;//TChromeLikeLegacyCloseCaptionButton
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  ChromeLikeWindowCaptionButtonsRes
  ;

// start class TChromeLikeLegacyWindowCaptionButton

function TChromeLikeLegacyWindowCaptionButton.GetButtonStateFlag: UINT;
//#UC START# *533D11CA0022_533D0BCB00A2_var*
const
 cButtonStateArr: array[Boolean] of UINT = (0, DFCS_PUSHED);
//#UC END# *533D11CA0022_533D0BCB00A2_var*
begin
//#UC START# *533D11CA0022_533D0BCB00A2_impl*
 Result := cButtonStateArr[State = cbsPushed];
//#UC END# *533D11CA0022_533D0BCB00A2_impl*
end;//TChromeLikeLegacyWindowCaptionButton.GetButtonStateFlag
// start class TChromeLikeLegacyMinimizeCaptionButton

{$If not defined(NoVCL)}
procedure TChromeLikeLegacyMinimizeCaptionButton.Paint;
//#UC START# *5028A60300AD_533D0C2F000A_var*
//#UC END# *5028A60300AD_533D0C2F000A_var*
begin
//#UC START# *5028A60300AD_533D0C2F000A_impl*
 DrawFrameControl(Canvas.Handle, ClientRect, DFC_CAPTION,
  DFCS_CAPTIONMIN or GetButtonStateFlag);
//#UC END# *5028A60300AD_533D0C2F000A_impl*
end;//TChromeLikeLegacyMinimizeCaptionButton.Paint
{$IfEnd} //not NoVCL

function TChromeLikeLegacyMinimizeCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D0C2F000A_var*
//#UC END# *5474500600DA_533D0C2F000A_var*
begin
//#UC START# *5474500600DA_533D0C2F000A_impl*
 Result := str_Minimize.AsCStr;
//#UC END# *5474500600DA_533D0C2F000A_impl*
end;//TChromeLikeLegacyMinimizeCaptionButton.GetHintText
// start class TChromeLikeLegacyMaximizeCaptionButton

{$If not defined(NoVCL)}
procedure TChromeLikeLegacyMaximizeCaptionButton.Paint;
//#UC START# *5028A60300AD_533D0C3A0179_var*
var
 l_ButtonType: UINT;
//#UC END# *5028A60300AD_533D0C3A0179_var*
begin
//#UC START# *5028A60300AD_533D0C3A0179_impl*
 if (ParentForm.WindowState = wsMaximized) then
  l_ButtonType := DFCS_CAPTIONRESTORE
 else
  l_ButtonType := DFCS_CAPTIONMAX;
 DrawFrameControl(Canvas.Handle, ClientRect, DFC_CAPTION,
  l_ButtonType or GetButtonStateFlag);
//#UC END# *5028A60300AD_533D0C3A0179_impl*
end;//TChromeLikeLegacyMaximizeCaptionButton.Paint
{$IfEnd} //not NoVCL

function TChromeLikeLegacyMaximizeCaptionButton.NeedUpdateHint: Boolean;
//#UC START# *54744FED0113_533D0C3A0179_var*
//#UC END# *54744FED0113_533D0C3A0179_var*
begin
//#UC START# *54744FED0113_533D0C3A0179_impl*
 Result := True;
//#UC END# *54744FED0113_533D0C3A0179_impl*
end;//TChromeLikeLegacyMaximizeCaptionButton.NeedUpdateHint

function TChromeLikeLegacyMaximizeCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D0C3A0179_var*
//#UC END# *5474500600DA_533D0C3A0179_var*
begin
//#UC START# *5474500600DA_533D0C3A0179_impl*
 if (ParentForm.WindowState = wsMaximized) then
  Result := str_Restore.AsCStr
 else
  Result := str_Maximize.AsCStr;
//#UC END# *5474500600DA_533D0C3A0179_impl*
end;//TChromeLikeLegacyMaximizeCaptionButton.GetHintText
// start class TChromeLikeLegacyCloseCaptionButton

{$If not defined(NoVCL)}
procedure TChromeLikeLegacyCloseCaptionButton.Paint;
//#UC START# *5028A60300AD_533D0C20013A_var*
//#UC END# *5028A60300AD_533D0C20013A_var*
begin
//#UC START# *5028A60300AD_533D0C20013A_impl*
 DrawFrameControl(Canvas.Handle, ClientRect, DFC_CAPTION,
  DFCS_CAPTIONCLOSE or GetButtonStateFlag);
//#UC END# *5028A60300AD_533D0C20013A_impl*
end;//TChromeLikeLegacyCloseCaptionButton.Paint
{$IfEnd} //not NoVCL

function TChromeLikeLegacyCloseCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D0C20013A_var*
//#UC END# *5474500600DA_533D0C20013A_var*
begin
//#UC START# *5474500600DA_533D0C20013A_impl*
 Result := str_Close.AsCStr;
//#UC END# *5474500600DA_533D0C20013A_impl*
end;//TChromeLikeLegacyCloseCaptionButton.GetHintText
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeLegacyWindowCaptionButton
 TtfwClassRef.Register(TChromeLikeLegacyWindowCaptionButton);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeLegacyMinimizeCaptionButton
 TtfwClassRef.Register(TChromeLikeLegacyMinimizeCaptionButton);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeLegacyMaximizeCaptionButton
 TtfwClassRef.Register(TChromeLikeLegacyMaximizeCaptionButton);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeLegacyCloseCaptionButton
 TtfwClassRef.Register(TChromeLikeLegacyCloseCaptionButton);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene

end.