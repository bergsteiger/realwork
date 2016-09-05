unit ChromeLikeLegacyWindowCaptionButtons;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeLegacyWindowCaptionButtons.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ChromeLikeLegacyWindowCaptionButtons" MUID: (533D14960061)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , ChromeLikeBaseWindowCaptionButton
 , Windows
 , l3Interfaces
;

type
 TChromeLikeLegacyWindowCaptionButton = class(TChromeLikeBaseWindowCaptionButton)
  private
   function GetButtonStateFlag: UINT;
 end;//TChromeLikeLegacyWindowCaptionButton

 TChromeLikeLegacyMinimizeCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
  protected
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
   function GetHintText: Il3CString; override;
 end;//TChromeLikeLegacyMinimizeCaptionButton

 TChromeLikeLegacyMaximizeCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
  protected
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
   function NeedUpdateHint: Boolean; override;
   function GetHintText: Il3CString; override;
 end;//TChromeLikeLegacyMaximizeCaptionButton

 TChromeLikeLegacyCloseCaptionButton = class(TChromeLikeLegacyWindowCaptionButton)
  protected
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
   function GetHintText: Il3CString; override;
 end;//TChromeLikeLegacyCloseCaptionButton
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , ChromeLikeWindowCaptionButtonsRes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *533D14960061impl_uses*
 //#UC END# *533D14960061impl_uses*
;

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

{$If NOT Defined(NoVCL)}
procedure TChromeLikeLegacyMinimizeCaptionButton.Paint;
//#UC START# *5028A60300AD_533D0C2F000A_var*
//#UC END# *5028A60300AD_533D0C2F000A_var*
begin
//#UC START# *5028A60300AD_533D0C2F000A_impl*
 DrawFrameControl(Canvas.Handle, ClientRect, DFC_CAPTION,
  DFCS_CAPTIONMIN or GetButtonStateFlag);
//#UC END# *5028A60300AD_533D0C2F000A_impl*
end;//TChromeLikeLegacyMinimizeCaptionButton.Paint
{$IfEnd} // NOT Defined(NoVCL)

function TChromeLikeLegacyMinimizeCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D0C2F000A_var*
//#UC END# *5474500600DA_533D0C2F000A_var*
begin
//#UC START# *5474500600DA_533D0C2F000A_impl*
 Result := str_Minimize.AsCStr;
//#UC END# *5474500600DA_533D0C2F000A_impl*
end;//TChromeLikeLegacyMinimizeCaptionButton.GetHintText

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

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

{$If NOT Defined(NoVCL)}
procedure TChromeLikeLegacyCloseCaptionButton.Paint;
//#UC START# *5028A60300AD_533D0C20013A_var*
//#UC END# *5028A60300AD_533D0C20013A_var*
begin
//#UC START# *5028A60300AD_533D0C20013A_impl*
 DrawFrameControl(Canvas.Handle, ClientRect, DFC_CAPTION,
  DFCS_CAPTIONCLOSE or GetButtonStateFlag);
//#UC END# *5028A60300AD_533D0C20013A_impl*
end;//TChromeLikeLegacyCloseCaptionButton.Paint
{$IfEnd} // NOT Defined(NoVCL)

function TChromeLikeLegacyCloseCaptionButton.GetHintText: Il3CString;
//#UC START# *5474500600DA_533D0C20013A_var*
//#UC END# *5474500600DA_533D0C20013A_var*
begin
//#UC START# *5474500600DA_533D0C20013A_impl*
 Result := str_Close.AsCStr;
//#UC END# *5474500600DA_533D0C20013A_impl*
end;//TChromeLikeLegacyCloseCaptionButton.GetHintText

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeLegacyWindowCaptionButton);
 {* Регистрация TChromeLikeLegacyWindowCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeLegacyMinimizeCaptionButton);
 {* Регистрация TChromeLikeLegacyMinimizeCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeLegacyMaximizeCaptionButton);
 {* Регистрация TChromeLikeLegacyMaximizeCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeLegacyCloseCaptionButton);
 {* Регистрация TChromeLikeLegacyCloseCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
