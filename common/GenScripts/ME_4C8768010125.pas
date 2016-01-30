unit PrimPictureOptions_Form;
 {* Рисунок }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPictureOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimPicture_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Document_Strange_Controls
 , l3Interfaces
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _PrintableBitmap_Parent_ = TPrimPictureForm;
 {$Include PrintableBitmap.imp.pas}
 TPrimPictureOptionsForm = class(_PrintableBitmap_)
  {* Рисунок }
  protected
   function pm_GetBitmapForPrint: Graphics_Bitmap; override;
   function Name: Il3CString; override;
   function ShortName: Il3CString; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure Save; override;
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure GetAttributesFrmAct; override;
    {* Информация о документе }
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Resize; override;
   procedure Enlarge; override;
   procedure Shrink; override;
   procedure ActualSize; override;
   procedure FitInWIndow; override;
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimPictureOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsTrialSupport
 , afwFacade
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , L10nInterfaces
 , SysUtils
 , Classes
 , l3String
 , l3ValueMap
 , nsTypes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , evBitmapDataObject
 , nsFixedHAFMacroReplacer
 , nsObjectPreview
 , nevBase
 , nsHAFPainter
;

{$Include PrintableBitmap.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.Save;
 {* Сохранить }
//#UC START# *495235F401C0_4C8768010125_var*
//#UC END# *495235F401C0_4C8768010125_var*
begin
//#UC START# *495235F401C0_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Save
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C8768010125_var*
//#UC END# *4C762C910358_4C8768010125_var*
begin
//#UC START# *4C762C910358_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPictureOptionsForm.GetAttributesFrmAct;
 {* Информация о документе }
//#UC START# *4C7B9EBC01AC_4C8768010125_var*
//#UC END# *4C7B9EBC01AC_4C8768010125_var*
begin
//#UC START# *4C7B9EBC01AC_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7B9EBC01AC_4C8768010125_impl*
end;//TPrimPictureOptionsForm.GetAttributesFrmAct

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.Copy;
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C8768010125_var*
//#UC END# *4C7D0C7B0185_4C8768010125_var*
begin
//#UC START# *4C7D0C7B0185_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPictureOptionsForm.Resize;
//#UC START# *4C876C1F014C_4C8768010125_var*
//#UC END# *4C876C1F014C_4C8768010125_var*
begin
//#UC START# *4C876C1F014C_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C876C1F014C_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Resize

procedure TPrimPictureOptionsForm.Enlarge;
//#UC START# *4C876E670305_4C8768010125_var*
//#UC END# *4C876E670305_4C8768010125_var*
begin
//#UC START# *4C876E670305_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C876E670305_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Enlarge

procedure TPrimPictureOptionsForm.Shrink;
//#UC START# *4C876E850207_4C8768010125_var*
//#UC END# *4C876E850207_4C8768010125_var*
begin
//#UC START# *4C876E850207_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C876E850207_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Shrink

procedure TPrimPictureOptionsForm.ActualSize;
//#UC START# *4C876EA202FF_4C8768010125_var*
//#UC END# *4C876EA202FF_4C8768010125_var*
begin
//#UC START# *4C876EA202FF_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C876EA202FF_4C8768010125_impl*
end;//TPrimPictureOptionsForm.ActualSize

procedure TPrimPictureOptionsForm.FitInWIndow;
//#UC START# *4C876EB40188_4C8768010125_var*
//#UC END# *4C876EB40188_4C8768010125_var*
begin
//#UC START# *4C876EB40188_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C876EB40188_4C8768010125_impl*
end;//TPrimPictureOptionsForm.FitInWIndow

function TPrimPictureOptionsForm.pm_GetBitmapForPrint: Graphics_Bitmap;
//#UC START# *4CDACD8302DD_4C8768010125get_var*
//#UC END# *4CDACD8302DD_4C8768010125get_var*
begin
//#UC START# *4CDACD8302DD_4C8768010125get_impl*
 Result := ieViewer.IEBitmap.VclBitmap;
//#UC END# *4CDACD8302DD_4C8768010125get_impl*
end;//TPrimPictureOptionsForm.pm_GetBitmapForPrint

function TPrimPictureOptionsForm.Name: Il3CString;
//#UC START# *4CDAD282005F_4C8768010125_var*
//#UC END# *4CDAD282005F_4C8768010125_var*
begin
//#UC START# *4CDAD282005F_4C8768010125_impl*
 Result := f_Info.Name;
//#UC END# *4CDAD282005F_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Name

function TPrimPictureOptionsForm.ShortName: Il3CString;
//#UC START# *4CDAD29D0169_4C8768010125_var*
//#UC END# *4CDAD29D0169_4C8768010125_var*
begin
//#UC START# *4CDAD29D0169_4C8768010125_impl*
 Result := f_Info.ShortName;
//#UC END# *4CDAD29D0169_4C8768010125_impl*
end;//TPrimPictureOptionsForm.ShortName

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_4C8768010125_var*
//#UC END# *49521D8E0295_4C8768010125_var*
begin
//#UC START# *49521D8E0295_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4C8768010125_var*
//#UC END# *495220DE0298_4C8768010125_var*
begin
//#UC START# *495220DE0298_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C8768010125_impl*
end;//TPrimPictureOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C8768010125_var*
//#UC END# *495220F2033A_4C8768010125_var*
begin
//#UC START# *495220F2033A_4C8768010125_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C8768010125_impl*
end;//TPrimPictureOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPictureOptionsForm);
 {* Регистрация PrimPictureOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
