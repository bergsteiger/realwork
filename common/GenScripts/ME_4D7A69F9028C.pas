unit PrimDictionContainer_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDictionContainer_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSaveLoadOptions_Form
 , F1Like_InternalOperations_Controls
 , vtProportionalPanel
 , vtSizeablePanel
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DictionContainerUserTypes_slqtDiction_UserType
 , DictionContainerUserTypes_slqtMedicDiction_UserType
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , PrimPrimListInterfaces
 , bsTypes
;

type
 // Navigator

 // Child

 _DictionContainerUserTypes_Parent_ = TPrimSaveLoadOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes.imp.pas}
 TPrimDictionContainerForm = class(_DictionContainerUserTypes_)
  private
   f_pnBackground: TvtProportionalPanel;
    {* Поле для свойства pnBackground }
   f_NavigatorZone: TvtSizeablePanel;
    {* Поле для свойства NavigatorZone }
   f_pnWorkArea: TvtProportionalPanel;
    {* Поле для свойства pnWorkArea }
   f_ChildZone: TvtSizeablePanel;
    {* Поле для свойства ChildZone }
  private
   procedure ChildZoneQueryResize(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer;
    var aCanResize: Boolean);
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   class function IsDictionLike: Boolean; override;
    {* Определяет, что форма похожа на "словарь" }
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure ShowSplitter; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function AcceptForm(const aForm: IvcmEntityForm;
    aControl: TComponent): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property pnBackground: TvtProportionalPanel
    read f_pnBackground;
 end;//TPrimDictionContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3StringIDEx
 , l3MessageID
;

type
 // ExcludeAll

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes.imp.pas}

procedure TPrimDictionContainerForm.ChildZoneQueryResize(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer;
 var aCanResize: Boolean);
//#UC START# *4D7F8B4A0214_4D7A69F9028C_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4D7F8B4A0214_4D7A69F9028C_var*
begin
//#UC START# *4D7F8B4A0214_4D7A69F9028C_impl*
 if aCanResize then
 begin
  aCanResize := HasForm(vcm_ztChild, false, @l_Form);
  if aCanResize then
   aCanResize := l_Form.AsContainer.HasForm;
 end;//aCanResize
//#UC END# *4D7F8B4A0214_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.ChildZoneQueryResize

procedure TPrimDictionContainerForm.ShowSplitter;
//#UC START# *4AE8744002F3_4D7A69F9028C_var*
//#UC END# *4AE8744002F3_4D7A69F9028C_var*
begin
//#UC START# *4AE8744002F3_4D7A69F9028C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE8744002F3_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.ShowSplitter

{$If NOT Defined(NoVCM)}
procedure TPrimDictionContainerForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4D7A69F9028C_var*
//#UC END# *4A8E8F2E0195_4D7A69F9028C_var*
begin
//#UC START# *4A8E8F2E0195_4D7A69F9028C_impl*
 inherited;
 pnBackground.Align := alClient;
 NavigatorZone.Align := alLeft;
 NavigatorZone.Width := 100;
 NavigatorZone.SizeableSides := [szRight];
 NavigatorZone.BevelOuter := bvNone;
 NavigatorZone.BevelInner := bvNone;
 pnWorkArea.Align := alClient;
 pnWorkArea.BevelOuter := bvNone;
 pnWorkArea.BevelInner := bvNone;
 ChildZone.Align := alBottom;
 ChildZone.Height := 200;
 ChildZone.SizeableSides := [szTop];
 ChildZone.BevelOuter := bvNone;
 ChildZone.BevelInner := bvNone;
 ChildZone.OnQueryResize := ChildZoneQueryResize;
//#UC END# *4A8E8F2E0195_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDictionContainerForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_4D7A69F9028C_var*
//#UC END# *4D78E2BB0211_4D7A69F9028C_var*
begin
//#UC START# *4D78E2BB0211_4D7A69F9028C_impl*
 inherited;
 NavigatorZone.Color := ParentZone.Color;
 ChildZone.Color := ParentZone.Color;
 pnWorkArea.Color := ParentZone.Color;
//#UC END# *4D78E2BB0211_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.NotifyUserTypeSet
{$IfEnd} // NOT Defined(NoVCM)

class function TPrimDictionContainerForm.IsDictionLike: Boolean;
 {* Определяет, что форма похожа на "словарь" }
//#UC START# *4F5DB2320323_4D7A69F9028C_var*
//#UC END# *4F5DB2320323_4D7A69F9028C_var*
begin
//#UC START# *4F5DB2320323_4D7A69F9028C_impl*
 Result := true;
//#UC END# *4F5DB2320323_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.IsDictionLike

{$If NOT Defined(NoVCM)}
function TPrimDictionContainerForm.AcceptForm(const aForm: IvcmEntityForm;
 aControl: TComponent): Boolean;
//#UC START# *52F2254D0058_4D7A69F9028C_var*
//#UC END# *52F2254D0058_4D7A69F9028C_var*
begin
//#UC START# *52F2254D0058_4D7A69F9028C_impl*
 //Не надо сюда ничего придочивать, во избежание AV.
 //http://mdp.garant.ru/pages/viewpage.action?pageId=370384532
 Result := false;
//#UC END# *52F2254D0058_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.AcceptForm
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimDictionContainerForm.DoGetFormSetImageIndex: Integer;
//#UC START# *53B649F600A3_4D7A69F9028C_var*
//#UC END# *53B649F600A3_4D7A69F9028C_var*
begin
//#UC START# *53B649F600A3_4D7A69F9028C_impl*
 if (DataSource <> nil) and (DataSource.UseCaseController <> nil) then
  Result := DataSource.UseCaseController.FormSetImageIndex
 else
  Result := 0;
//#UC END# *53B649F600A3_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM)}
function TPrimDictionContainerForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4D7A69F9028C_var*
//#UC END# *53F1C6EF02C9_4D7A69F9028C_var*
begin
//#UC START# *53F1C6EF02C9_4D7A69F9028C_impl*
 Result := nil;
//#UC END# *53F1C6EF02C9_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDictionContainerForm);
 {* Регистрация PrimDictionContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
