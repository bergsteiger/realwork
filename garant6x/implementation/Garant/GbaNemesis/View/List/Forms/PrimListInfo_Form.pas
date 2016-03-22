unit PrimListInfo_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/PrimListInfo_Form.pas"
// Начат: 26.01.2009 20:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::PrimListInfo
//
// Информация о списке
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
  DynamicDocListUnit,
  afwInterfaces
  {$If defined(Nemesis)}
  ,
  eeTextSourceExport
  {$IfEnd} //Nemesis
  ,
  nevTools
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  nsLogEvent,
  WorkWithListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  ListInfoUserTypes_liListInfo_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsListReferenceActivateEvent = class(TnsLogEvent)
 private
 // private methods
   class procedure Log(const aList: IDynList); virtual;
 end;//TnsListReferenceActivateEvent

 _ListInfoUserTypes_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes.imp.pas}
 _PageControlNotification_Parent_ = _ListInfoUserTypes_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}
 TPrimListInfoForm = {form} class(_PageControlNotification_)
  {* Информация о списке }
 private
 // private fields
   f_ListInfoViewer : TnscEditor;
    {* Поле для свойства ListInfoViewer}
   f_TextSource : TnscTextSource;
    {* Поле для свойства TextSource}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure TextSourceMakeDocumentContainer(Sender: TObject;
     var aMade: InevDocumentContainer);
 protected
 // realized methods
   procedure DoTabActivate; override;
     {* Реакция на переключение вкладки }
   procedure ListInfo_BecomeActive_Execute;
   procedure ListInfo_BecomeActive(const aParams: IvcmExecuteParams);
   procedure LiListInfoQueryClose(aSender: TObject); override;
     {* Обработчик события liListInfo.OnQueryClose }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected fields
   dsListInfo : IdsListInfo;
   sdsListPrim : IsdsListPrim;
 protected
 // protected methods
   function MakePreview: IafwComplexDocumentPreview; virtual;
 public
 // public properties
   property ListInfoViewer: TnscEditor
     read f_ListInfoViewer;
   property TextSource: TnscTextSource
     read f_TextSource;
 end;//TPrimListInfoForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  F1Like_InternalOperations_Controls,
  k2Prim,
  l3Memory,
  l3String,
  evTypes,
  l3Base,
  Document_Const,
  Windows,
  Messages,
  nsListHAFMacroReplacer,
  nevInterfaces,
  DataAdapter
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  TextPara_Const,
  evFormatHAFMacroReplacer,
  l3Variant
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID,
  nsManagers
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  vcmBase {a},
  SysUtils {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}

// start class TPrimListInfoForm

procedure TPrimListInfoForm.TextSourceMakeDocumentContainer(Sender: TObject;
  var aMade: InevDocumentContainer);
//#UC START# *51C1A3A902F1_497DEC900012_var*
var
 l_eeGenerator: Ik2TagGenerator;
 l_Stream: Tl3StringStream;
//#UC END# *51C1A3A902F1_497DEC900012_var*
begin
//#UC START# *51C1A3A902F1_497DEC900012_impl*
 if (dsListInfo <> nil) and not l3IsNil(dsListInfo.Info) then
 begin
  l_Stream := Tl3StringStream.Create(dsListInfo.Info);
  try
   aMade.TagWriter.WriteTag(nil, cf_HTML, l_Stream);
    //^ иначе бесконечная рекурсия - http://mdp.garant.ru/pages/viewpage.action?pageId=90445071
  finally
   l3Free(l_Stream);
  end;
 end//not l3IsNil(aValue)
 else
 begin
  l_eeGenerator := aMade.GetGenerator(nil, nil);
   //^ иначе бесконечная рекурсия - http://mdp.garant.ru/pages/viewpage.action?pageId=90445071
  try
   l_eeGenerator.Start;
   try
    l_eeGenerator.StartChild(k2_typDocument);
    try
     l_eeGenerator.StartChild(k2_typTextPara);
     l_eeGenerator.Finish;
    finally
     l_eeGenerator.Finish;
    end;
   finally
    l_eeGenerator.Finish;
   end;
  finally
   l_eeGenerator := nil;
  end;//try..finally
 end;//not l3IsNil(aValue)end;
 // А это шаманство для установки текста документа
 // см. обсуждение к К-60293145
 if HandleAllocated then
  PostMessage(ListInfoViewer.Handle, EM_SetReadOnly, WParam(True), 0);
//#UC END# *51C1A3A902F1_497DEC900012_impl*
end;//TPrimListInfoForm.TextSourceMakeDocumentContainer

function TPrimListInfoForm.MakePreview: IafwComplexDocumentPreview;
//#UC START# *4C88CF0C0337_497DEC900012_var*
var
 l_HAF: IafwHAFMacroReplacer;
//#UC END# *4C88CF0C0337_497DEC900012_var*
begin
//#UC START# *4C88CF0C0337_497DEC900012_impl*
 if (sdsListPrim <> nil) then
  l_HAF := TnsListHAFMacroReplacer.Make(nil, sdsListPrim.dsListPrim.List)
 else
  l_HAF := nil;
 Result := ListInfoViewer.Preview(TevFormatHAFMacroReplacer.Make(l_HAF, str_nevmmReference.AsCStr));
//#UC END# *4C88CF0C0337_497DEC900012_impl*
end;//TPrimListInfoForm.MakePreview
// start class TnsListReferenceActivateEvent

class procedure TnsListReferenceActivateEvent.Log(const aList: IDynList);
//#UC START# *4B14E35A0092_4B14E32102A2_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B14E35A0092_4B14E32102A2_var*
begin
//#UC START# *4B14E35A0092_4B14E32102A2_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 GetLogger.AddEvent(LE_LIST_REFERENCE_ACTIVATE, l_Data);
//#UC END# *4B14E35A0092_4B14E32102A2_impl*
end;//TnsListReferenceActivateEvent.Log

procedure TPrimListInfoForm.DoTabActivate;
//#UC START# *497F16AC015A_497DEC900012_var*
//#UC END# *497F16AC015A_497DEC900012_var*
begin
//#UC START# *497F16AC015A_497DEC900012_impl*
 if (sdsListPrim <> nil) then
  TnsListReferenceActivateEvent.Log(sdsListPrim.dsListPrim.List);
//#UC END# *497F16AC015A_497DEC900012_impl*
end;//TPrimListInfoForm.DoTabActivate

procedure TPrimListInfoForm.ListInfo_BecomeActive_Execute;
//#UC START# *4AF858F30202_497DEC900012exec_var*
//#UC END# *4AF858F30202_497DEC900012exec_var*
begin
//#UC START# *4AF858F30202_497DEC900012exec_impl*
 SetActiveInParent;
//#UC END# *4AF858F30202_497DEC900012exec_impl*
end;//TPrimListInfoForm.ListInfo_BecomeActive_Execute

procedure TPrimListInfoForm.ListInfo_BecomeActive(const aParams: IvcmExecuteParams);
begin
 ListInfo_BecomeActive_Execute;
end;

procedure TPrimListInfoForm.LiListInfoQueryClose(aSender: TObject);
//#UC START# *E4208250FA5A_497DEC900012_var*
//#UC END# *E4208250FA5A_497DEC900012_var*
begin
//#UC START# *E4208250FA5A_497DEC900012_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *E4208250FA5A_497DEC900012_impl*
end;//TPrimListInfoForm.LiListInfoQueryClose

constructor TPrimListInfoForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_497DEC900012_var*
//#UC END# *47D1602000C6_497DEC900012_var*
begin
//#UC START# *47D1602000C6_497DEC900012_impl*
 inherited;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=303858773
 // на всякий случай, т.к. ограничение только для оболочки
 {$If not defined(Admin) AND not defined(Monitorings)}
  if (DefDataAdapter <> nil) then
   //ListInfoViewer.DisableDragAndDropSupport := DefDataAdapter.IsTrialMode;
 {$ifend}
//#UC END# *47D1602000C6_497DEC900012_impl*
end;//TPrimListInfoForm.Create

{$If not defined(NoVCM)}
procedure TPrimListInfoForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_497DEC900012_var*
//#UC END# *497469C90140_497DEC900012_var*
begin
//#UC START# *497469C90140_497DEC900012_impl*
 if (dsListInfo <> nil) then
  TextSource.DocumentContainer := nil;
//#UC END# *497469C90140_497DEC900012_impl*
end;//TPrimListInfoForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListInfoForm.InitControls;
//#UC START# *4A8E8F2E0195_497DEC900012_var*
//#UC END# *4A8E8F2E0195_497DEC900012_var*
begin
//#UC START# *4A8E8F2E0195_497DEC900012_impl*
 Width := 549;
 Height := 337;
 Scaled := False;
 
 with ListInfoViewer do
 begin
  Align := alClient;
  TextSource := Self.TextSource;
  IsStaticText := True;
 end;

 with TextSource do
 begin
  OnMakeDocumentContainer := TextSourceMakeDocumentContainer;
 end;
//#UC END# *4A8E8F2E0195_497DEC900012_impl*
end;//TPrimListInfoForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimListInfoForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsListInfo := nil;
  sdsListPrim := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsListInfo, dsListInfo);
  aDsNew.CastUCC(IsdsListPrim, sdsListPrim);
 end;//aDsNew = nil
end;

procedure TPrimListInfoForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_ListInfo, nil);
  PublishOpWithResult(en_ListInfo, op_BecomeActive, ListInfo_BecomeActive, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimListInfoForm.MakeControls;
begin
 inherited;
 f_ListInfoViewer := TnscEditor.Create(Self);
 f_ListInfoViewer.Name := 'ListInfoViewer';
 f_ListInfoViewer.Parent := Self;
 f_TextSource := TnscTextSource.Create(Self);
 f_TextSource.Name := 'TextSource';
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimListInfo
 TtfwClassRef.Register(TPrimListInfoForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.