unit PrimCreateFilter_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimCreateFilter" MUID: (4CB6D95D003A)
// Имя типа: "TPrimCreateFilterForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , FiltersInterfaces
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimCreateFilterForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   ViewArea: IdsCreateFilter;
   f_NameLabel: TvtLabel;
    {* Поле для свойства NameLabel }
   f_FilterName: TnscEdit;
    {* Поле для свойства FilterName }
  protected
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: IdsCreateFilter); reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property NameLabel: TvtLabel
    read f_NameLabel;
    {* Название фильтра }
   property FilterName: TnscEdit
    read f_FilterName;
 end;//TPrimCreateFilterForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimCreateFilter_cfCreate_UserType
 , PrimCreateFilter_cfRename_UserType
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки cfCreateLocalConstants }
 str_cfCreateCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cfCreateCaption'; rValue : 'Создать фильтр');
  {* Заголовок пользовательского типа "Создать фильтр" }
 {* Локализуемые строки cfRenameLocalConstants }
 str_cfRenameCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cfRenameCaption'; rValue : 'Переименовать фильтр');
  {* Заголовок пользовательского типа "Переименовать фильтр" }

class function TPrimCreateFilterForm.Make(const aData: IdsCreateFilter);
var
 l_Inst : TPrimCreateFilterForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimCreateFilterForm.Make

procedure TPrimCreateFilterForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_4CB6D95D003Aexec_var*
//#UC END# *4C762A1501FC_4CB6D95D003Aexec_var*
begin
//#UC START# *4C762A1501FC_4CB6D95D003Aexec_impl*
 Result_OkExt_Execute(aParams);
//#UC END# *4C762A1501FC_4CB6D95D003Aexec_impl*
end;//TPrimCreateFilterForm.Result_Ok_Execute

procedure TPrimCreateFilterForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4C762C910358_4CB6D95D003Aexec_var*
//#UC END# *4C762C910358_4CB6D95D003Aexec_var*
begin
//#UC START# *4C762C910358_4CB6D95D003Aexec_impl*
 ModalResult := mrCancel;
//#UC END# *4C762C910358_4CB6D95D003Aexec_impl*
end;//TPrimCreateFilterForm.Result_Cancel_Execute

procedure TPrimCreateFilterForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762D9B0224_4CB6D95D003Aexec_var*
//#UC END# *4C762D9B0224_4CB6D95D003Aexec_var*
begin
//#UC START# *4C762D9B0224_4CB6D95D003Aexec_impl*
 if (UserType = cfCreate) then
  ViewArea.CreateFilter(FilterName.Text)
 else
  ViewArea.RenameFilter(FilterName.Text);
 ModalResult := mrOk;
//#UC END# *4C762D9B0224_4CB6D95D003Aexec_impl*
end;//TPrimCreateFilterForm.Result_OkExt_Execute

procedure TPrimCreateFilterForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4CB6D95D003A_var*
//#UC END# *497469C90140_4CB6D95D003A_var*
begin
//#UC START# *497469C90140_4CB6D95D003A_impl*
 inherited;
 if Assigned(ViewArea) then
  FilterName.Text := ViewArea.Name;
//#UC END# *497469C90140_4CB6D95D003A_impl*
end;//TPrimCreateFilterForm.NotifyDataSourceChanged

procedure TPrimCreateFilterForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4CB6D95D003A_var*
//#UC END# *49803F5503AA_4CB6D95D003A_var*
begin
//#UC START# *49803F5503AA_4CB6D95D003A_impl*
 inherited;
 CCaption := l3CStr(CurUserType.Caption);
//#UC END# *49803F5503AA_4CB6D95D003A_impl*
end;//TPrimCreateFilterForm.DoInit

procedure TPrimCreateFilterForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4CB6D95D003A_var*
//#UC END# *4A8E8F2E0195_4CB6D95D003A_var*
begin
//#UC START# *4A8E8F2E0195_4CB6D95D003A_impl*
 inherited;
 BorderStyle := bsDialog;
 NameLabel.Top := 4;
 NameLabel.Left := 4;
 FilterName.Top := NameLabel.Top + NameLabel.Height + 4;
 FilterName.Left := 4;
 FilterName.Width := 300;
 Width := FilterName.Left + FilterName.Width + 4;
 Height := FilterName.Top + FilterName.Height + 4;
 ClientWidth := Width;
 ClientHeight := Height;
 Position := poScreenCenter;
//#UC END# *4A8E8F2E0195_4CB6D95D003A_impl*
end;//TPrimCreateFilterForm.InitControls

initialization
 str_cfCreateCaption.Init;
 {* Инициализация str_cfCreateCaption }
 str_cfRenameCaption.Init;
 {* Инициализация str_cfRenameCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimCreateFilterForm);
 {* Регистрация PrimCreateFilter }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
