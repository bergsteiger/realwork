unit PrimAttributes_Form;
 {* Атрибуты документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimAttributes_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimAttributes" MUID: (4979DA14019A)
// Имя типа: "TPrimAttributesForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , nscTreeViewWithAdapterDragDrop
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _BaseDocumentForDocumentModule_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseDocumentForDocumentModule.imp.pas}
 _PageControlNotification_Parent_ = _BaseDocumentForDocumentModule_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}
 _AttributesUserTypes_Parent_ = _PageControlNotification_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes.imp.pas}
 TPrimAttributesForm = class(_AttributesUserTypes_)
  {* Атрибуты документа }
  private
   f_tvAttributes: TnscTreeViewWithAdapterDragDrop;
  protected
   CoDS: IdsAttributes;
  protected
   procedure FDocAttributeQueryClose(aSender: TObject); override;
    {* Обработчик события fDocAttribute.OnQueryClose }
   procedure DoTabActivate; override;
    {* Реакция на переключение вкладки }
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property tvAttributes: TnscTreeViewWithAdapterDragDrop
    read f_tvAttributes;
 end;//TPrimAttributesForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsLogEvent
 , DocumentUnit
 , nsSingleAttributeData
 , F1Like_InternalOperations_Controls
 , Common_Strange_Controls
 , SysUtils
 , nsManagers
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
 , AttributesUserTypes_fDocAttribute_UserType
 , AttributesUserTypes_fAttributeSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4979DA14019Aimpl_uses*
 //#UC END# *4979DA14019Aimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TnsViewDocumentAttributesEvent = {final} class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsViewDocumentAttributesEvent

class procedure TnsViewDocumentAttributesEvent.Log(const aDoc: IDocument);
//#UC START# *4B150D310061_4B150CFE01CB_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B150D310061_4B150CFE01CB_var*
begin
//#UC START# *4B150D310061_4B150CFE01CB_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_VIEW_DOCUMENT_ATTRIBUTES, l_Data);
//#UC END# *4B150D310061_4B150CFE01CB_impl*
end;//TnsViewDocumentAttributesEvent.Log

type _Instance_R_ = TPrimAttributesForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseDocumentForDocumentModule.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes.imp.pas}

procedure TPrimAttributesForm.FDocAttributeQueryClose(aSender: TObject);
 {* Обработчик события fDocAttribute.OnQueryClose }
//#UC START# *37BE60CD03ED_4979DA14019A_var*
//#UC END# *37BE60CD03ED_4979DA14019A_var*
begin
//#UC START# *37BE60CD03ED_4979DA14019A_impl*
 if op_Document_AttributesCanBeClosed.Call(Aggregate) then
  SafeClose
 else
  op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *37BE60CD03ED_4979DA14019A_impl*
end;//TPrimAttributesForm.FDocAttributeQueryClose

procedure TPrimAttributesForm.DoTabActivate;
 {* Реакция на переключение вкладки }
//#UC START# *497F16AC015A_4979DA14019A_var*
//#UC END# *497F16AC015A_4979DA14019A_var*
begin
//#UC START# *497F16AC015A_4979DA14019A_impl*
 if (sdsBaseDocument <> nil) then
  TnsViewDocumentAttributesEvent.Log(sdsBaseDocument.DocInfo.Doc);
//#UC END# *497F16AC015A_4979DA14019A_impl*
end;//TPrimAttributesForm.DoTabActivate

procedure TPrimAttributesForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  CoDS := nil;
 end//aNew = nil
 else
 begin
  Supports(aNew, IdsAttributes, CoDS);
 end;//aNew = nil
end;//TPrimAttributesForm.SignalDataSourceChanged

procedure TPrimAttributesForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
end;//TPrimAttributesForm.InitEntities

procedure TPrimAttributesForm.MakeControls;
begin
 inherited;
 f_tvAttributes := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvAttributes.Name := 'tvAttributes';
 f_tvAttributes.Parent := Self;
end;//TPrimAttributesForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributesForm);
 {* Регистрация PrimAttributes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
