unit PrimMedicListSynchroView_Form;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , Inpharm_Strange_Controls
 , SimpleListInterfaces
 , vtPanel
 , l3Interfaces
 , l3StringIDEx
;

type
 // ChildZone

 TPrimMedicListSynchroViewForm = class(TvcmContainerForm)
  {* Синхронный просмотр }
  private
   f_ztChild: TvtPanel;
    {* Поле для свойства ztChild }
  protected
   dsSimpleListSynchroView: IdsSimpleListSynchroView;
  protected
   procedure mlsfDrugListQueryClose(aSender: TObject);
    {* Обработчик события mlsfDrugList.OnQueryClose }
   procedure mlsfMedicFirmQueryClose(aSender: TObject);
    {* Обработчик события mlsfMedicFirm.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PageActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PageInactive; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure BecomeActive; override;
   procedure OpenDocument; override;
   procedure OpenAttributesForm; override;
   procedure OpenList; override;
   procedure OpenDocument; override;
    {* Текст документа }
   procedure OpenList; override;
    {* Список препаратов }
   {$If NOT Defined(NoVCM)}
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; override;
    {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property ztChild: TvtPanel
    read f_ztChild;
 end;//TPrimMedicListSynchroViewForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , F1Like_InternalOperations_Controls
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки mlsfDrugListLocalConstants }
 str_mlsfDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mlsfDrugListCaption'; rValue : 'Синхронный просмотр');
  {* Заголовок пользовательского типа "Синхронный просмотр" }
 {* Локализуемые строки mlsfMedicFirmLocalConstants }
 str_mlsfMedicFirmCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mlsfMedicFirmCaption'; rValue : 'Описание');
  {* Заголовок пользовательского типа "Описание" }

procedure TPrimMedicListSynchroViewForm.mlsfDrugListQueryClose(aSender: TObject);
 {* Обработчик события mlsfDrugList.OnQueryClose }
//#UC START# *65F272629DB8_497EE1F10134_var*
//#UC END# *65F272629DB8_497EE1F10134_var*
begin
//#UC START# *65F272629DB8_497EE1F10134_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *65F272629DB8_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.mlsfDrugListQueryClose

procedure TPrimMedicListSynchroViewForm.mlsfMedicFirmQueryClose(aSender: TObject);
 {* Обработчик события mlsfMedicFirm.OnQueryClose }
//#UC START# *C155D2625A02_497EE1F10134_var*
//#UC END# *C155D2625A02_497EE1F10134_var*
begin
//#UC START# *C155D2625A02_497EE1F10134_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *C155D2625A02_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.mlsfMedicFirmQueryClose

procedure TPrimMedicListSynchroViewForm.BecomeActive;
//#UC START# *4AE9E3CC03C7_497EE1F10134_var*
//#UC END# *4AE9E3CC03C7_497EE1F10134_var*
begin
//#UC START# *4AE9E3CC03C7_497EE1F10134_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE9E3CC03C7_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.BecomeActive

procedure TPrimMedicListSynchroViewForm.OpenDocument;
//#UC START# *4C52E5D702B0_497EE1F10134_var*
//#UC END# *4C52E5D702B0_497EE1F10134_var*
begin
//#UC START# *4C52E5D702B0_497EE1F10134_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52E5D702B0_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.OpenDocument

procedure TPrimMedicListSynchroViewForm.OpenAttributesForm;
//#UC START# *4C52E5F203CC_497EE1F10134_var*
//#UC END# *4C52E5F203CC_497EE1F10134_var*
begin
//#UC START# *4C52E5F203CC_497EE1F10134_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52E5F203CC_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.OpenAttributesForm

procedure TPrimMedicListSynchroViewForm.OpenList;
//#UC START# *4C52E61002B5_497EE1F10134_var*
//#UC END# *4C52E61002B5_497EE1F10134_var*
begin
//#UC START# *4C52E61002B5_497EE1F10134_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52E61002B5_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.OpenList

procedure TPrimMedicListSynchroViewForm.OpenDocument;
 {* Текст документа }
//#UC START# *4C7D373900D0_497EE1F10134_var*
//#UC END# *4C7D373900D0_497EE1F10134_var*
begin
//#UC START# *4C7D373900D0_497EE1F10134_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D373900D0_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.OpenDocument

procedure TPrimMedicListSynchroViewForm.OpenList;
 {* Список препаратов }
//#UC START# *4C7D37C20388_497EE1F10134_var*
//#UC END# *4C7D37C20388_497EE1F10134_var*
begin
//#UC START# *4C7D37C20388_497EE1F10134_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D37C20388_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.OpenList

{$If NOT Defined(NoVCM)}
procedure TPrimMedicListSynchroViewForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_497EE1F10134_var*
//#UC END# *4A8E8F2E0195_497EE1F10134_var*
begin
//#UC START# *4A8E8F2E0195_497EE1F10134_impl*
 with ztChild do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimMedicListSynchroViewForm.DoGetTabInfo(out theCaption: Il3CString;
 out theItemIndex: Integer): Boolean;
 {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
//#UC START# *4AC497FD00A2_497EE1F10134_var*
//#UC END# *4AC497FD00A2_497EE1F10134_var*
begin
//#UC START# *4AC497FD00A2_497EE1F10134_impl*
 if (CurUserType <> nil) then
 begin
  Result := true;
  theCaption := CCaption;
  theItemIndex := CurUserType.ImageIndex;
 end//CurUserType <> nil
 else
  Result := false;
//#UC END# *4AC497FD00A2_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.DoGetTabInfo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMedicListSynchroViewForm.PageActive;
//#UC START# *4C52E8030278_497EE1F10134_var*
//#UC END# *4C52E8030278_497EE1F10134_var*
begin
//#UC START# *4C52E8030278_497EE1F10134_impl*
 op_List_SetCurrentVisible.Call(Aggregate);
//#UC END# *4C52E8030278_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.PageActive
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMedicListSynchroViewForm.PageInactive;
//#UC START# *4C52E81603A9_497EE1F10134_var*
//#UC END# *4C52E81603A9_497EE1F10134_var*
begin
//#UC START# *4C52E81603A9_497EE1F10134_impl*
//#UC END# *4C52E81603A9_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.PageInactive
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_mlsfDrugListCaption.Init;
 {* Инициализация str_mlsfDrugListCaption }
 str_mlsfMedicFirmCaption.Init;
 {* Инициализация str_mlsfMedicFirmCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMedicListSynchroViewForm);
 {* Регистрация PrimMedicListSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
