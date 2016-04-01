unit PrimListInfo_Form;
 {* Информация о списке }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListInfo_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimListInfo" MUID: (497DEC900012)
// Имя типа: "TPrimListInfoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , WorkWithListInterfaces
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , afwInterfaces
 , nevTools
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , l3StringIDEx
 , nsLogEvent
 , DynamicDocListUnit
;

type
 TnsListReferenceActivateEvent = class(TnsLogEvent)
  private
   class procedure Log(const aList: IDynList); virtual;
 end;//TnsListReferenceActivateEvent

 _ListInfoUserTypes_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes.imp.pas}
 _PageControlNotification_Parent_ = _ListInfoUserTypes_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}
 TPrimListInfoForm = class(_PageControlNotification_)
  {* Информация о списке }
  private
   f_ListInfoViewer: TnscEditor;
    {* Поле для свойства ListInfoViewer }
   f_TextSource: TnscTextSource;
    {* Поле для свойства TextSource }
  protected
   dsListInfo: IdsListInfo;
   sdsListPrim: IsdsListPrim;
  private
   procedure TextSourceMakeDocumentContainer(Sender: TObject;
    var aMade: InevDocumentContainer);
  protected
   function MakePreview: IafwComplexDocumentPreview; virtual;
   procedure DoTabActivate; override;
    {* Реакция на переключение вкладки }
   procedure liListInfoQueryClose(aSender: TObject); override;
    {* Обработчик события liListInfo.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure ListInfo_BecomeActive_Execute;
   procedure ListInfo_BecomeActive(const aParams: IvcmExecuteParamsPrim);
   constructor Create(AOwner: TComponent); override;
  public
   property ListInfoViewer: TnscEditor
    read f_ListInfoViewer;
   property TextSource: TnscTextSource
    read f_TextSource;
 end;//TPrimListInfoForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , F1Like_InternalOperations_Controls
 , k2Prim
 , l3Memory
 , l3String
 , evTypes
 , l3Base
 , Document_Const
 , Windows
 , Messages
 , nsListHAFMacroReplacer
 , nevInterfaces
 , DataAdapter
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , TextPara_Const
 , evFormatHAFMacroReplacer
 , l3Variant
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , nsManagers
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
;

{$If NOT Defined(NoVCM)}
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

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListInfoUserTypes.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}

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

procedure TPrimListInfoForm.DoTabActivate;
 {* Реакция на переключение вкладки }
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

procedure TPrimListInfoForm.ListInfo_BecomeActive(const aParams: IvcmExecuteParamsPrim);
begin
 Self.ListInfo_BecomeActive_Execute;
end;//TPrimListInfoForm.ListInfo_BecomeActive

procedure TPrimListInfoForm.liListInfoQueryClose(aSender: TObject);
 {* Обработчик события liListInfo.OnQueryClose }
//#UC START# *E4208250FA5A_497DEC900012_var*
//#UC END# *E4208250FA5A_497DEC900012_var*
begin
//#UC START# *E4208250FA5A_497DEC900012_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *E4208250FA5A_497DEC900012_impl*
end;//TPrimListInfoForm.liListInfoQueryClose

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

procedure TPrimListInfoForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_497DEC900012_var*
//#UC END# *497469C90140_497DEC900012_var*
begin
//#UC START# *497469C90140_497DEC900012_impl*
 if (dsListInfo <> nil) then
  TextSource.DocumentContainer := nil;
//#UC END# *497469C90140_497DEC900012_impl*
end;//TPrimListInfoForm.NotifyDataSourceChanged

procedure TPrimListInfoForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimListInfoForm);
 {* Регистрация PrimListInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
