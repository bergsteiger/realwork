unit PrimAttributes_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimAttributes_Form.pas"
// Начат: 23.01.2009 18:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Attributes::PrimAttributes
//
// Атрибуты документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  nsLogEvent
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  nscTreeViewWithAdapterDragDrop,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmControllers {a}
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  AttributesUserTypes_fDocAttribute_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  AttributesUserTypes_fAttributeSynchroView_UserType,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _BaseDocumentForDocumentModule_Parent_ = TvcmEntityForm;
 {$Include ..\View\BaseDocumentForDocumentModule.imp.pas}
 _PageControlNotification_Parent_ = _BaseDocumentForDocumentModule_;
 {$Include ..\View\PageControlNotification.imp.pas}
 _AttributesUserTypes_Parent_ = _PageControlNotification_;
 {$Include ..\View\AttributesUserTypes.imp.pas}
 TPrimAttributesForm = {form} class(_AttributesUserTypes_)
  {* Атрибуты документа }
 private
 // private fields
   f_tvAttributes : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvAttributes}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   procedure FDocAttributeQueryClose(aSender: TObject); override;
     {* Обработчик события fDocAttribute.OnQueryClose }
   procedure DoTabActivate; override;
     {* Реакция на переключение вкладки }
 protected
 // protected fields
   CoDS : IdsAttributes;
 public
 // public properties
   property tvAttributes: TnscTreeViewWithAdapterDragDrop
     read f_tvAttributes;
 end;//TPrimAttributesForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  nsSingleAttributeData,
  F1Like_InternalOperations_Controls,
  Common_Strange_Controls
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils {a},
  nsManagers
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimAttributesForm;

{$Include ..\View\BaseDocumentForDocumentModule.imp.pas}

{$Include ..\View\PageControlNotification.imp.pas}

{$Include ..\View\AttributesUserTypes.imp.pas}

type
  TnsViewDocumentAttributesEvent = {final} class(TnsLogEvent)
  public
  // public methods
   class procedure Log(const aDoc: IDocument);
  end;//TnsViewDocumentAttributesEvent

// start class TnsViewDocumentAttributesEvent

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

procedure TPrimAttributesForm.FDocAttributeQueryClose(aSender: TObject);
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
//#UC START# *497F16AC015A_4979DA14019A_var*
//#UC END# *497F16AC015A_4979DA14019A_var*
begin
//#UC START# *497F16AC015A_4979DA14019A_impl*
 if (sdsBaseDocument <> nil) then
  TnsViewDocumentAttributesEvent.Log(sdsBaseDocument.DocInfo.Doc);
//#UC END# *497F16AC015A_4979DA14019A_impl*
end;//TPrimAttributesForm.DoTabActivate

procedure TPrimAttributesForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  CoDS := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsAttributes, CoDS);
 end;//aDsNew = nil
end;

procedure TPrimAttributesForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  MakeEntitySupportedByControl(en_Edit, tvAttributes);
  PublishFormEntity(en_Tree, nil);
  MakeEntitySupportedByControl(en_Tree, tvAttributes);
 end;//with Entities.Entities
end;

procedure TPrimAttributesForm.MakeControls;
begin
 inherited;
 f_tvAttributes := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvAttributes.Name := 'tvAttributes';
 f_tvAttributes.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include ..\View\AttributesUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimAttributes
 TtfwClassRef.Register(TPrimAttributesForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.