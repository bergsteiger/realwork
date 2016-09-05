unit Inpharm_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Inpharm_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Inpharm" MUID: (4AA0D66F0159)
// Имя типа: "TInpharmModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , CommonDictionInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLogEvent
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsOpenPharmFirmDocumentEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsOpenPharmFirmDocumentEvent

 TnsOpenPharmDocumentEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsOpenPharmDocumentEvent

 TnsOpenMedicDictionaryEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenMedicDictionaryEvent

 TnsOpenMedicFirmsEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenMedicFirmsEvent

 TInpharmModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   class procedure OpenMedicDictionPrim(const aSDS: IsdsCommonDiction;
    const aContainer: IvcmContainer);
   procedure opDrugListTest(const aParams: IvcmTestParamsPrim);
    {* Список выпускаемых препаратов }
   procedure opDrugListExecute(const aParams: IvcmExecuteParamsPrim);
    {* Список выпускаемых препаратов }
   procedure opMedicDictionTest(const aParams: IvcmTestParamsPrim);
    {* Словарь медицинских терминов }
   procedure opMedicDictionExecute(const aParams: IvcmExecuteParamsPrim);
    {* Словарь медицинских терминов }
   procedure opMedicFirmsTest(const aParams: IvcmTestParamsPrim);
    {* Фармацевтические фирмы }
   procedure opMedicFirmsExecute(const aParams: IvcmExecuteParamsPrim);
    {* Фармацевтические фирмы }
   procedure opMedicMainMenuExecute(const aParams: IvcmExecuteParamsPrim);
    {* Основное меню ИнФарм }
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TInpharmModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , DocumentInterfaces
 , PrimPrimListInterfaces
 , Common_F1CommonServices_Contracts
 , InpharmMainMenu_ut_mmmMain_UserType
 , PrimMedicFirmList_mflMain_UserType
 , PrimCommonDiction_utMedicDiction_UserType
 , Common_FormDefinitions_Controls
 , sdsInpharmMainMenu
 , sdsMedicFirmList
 , sdsDrugDocument
 , sdsDrugList
 , sdsMedicDiction
 , sdsMedicFirmDocument
 , deListSet
 , DynamicDocListUnit
 , DataAdapter
 , LoggingUnit
 , SysUtils
 , l3Base
 , fsMedicDiction
 , fsMedicFirmDocument
 , fsDrugDocument
 , fsDrugList
 , fsMedicFirmList
 , MedicMainMenu_Form
 , MedicFirmList_Form
 , MedicListSynchroView_Form
 , fsInpharmMainMenu
 //#UC START# *4AA0D66F0159impl_uses*
 , StdRes
 //#UC END# *4AA0D66F0159impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TInpharmServiceImpl = {final} class(TvcmModuleContractImplementation, IInpharmService)
  public
   procedure OpenDrugListIfNeeded(const aContainer: IvcmContainer);
   procedure OpenInpharmMainMenu(const aContainer: IvcmContainer);
   procedure MedicFirms(const aContainer: IvcmContainer);
   procedure OpenDrugDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenDrugList(const aList: IdeList;
    const aContainer: IvcmContainer);
   procedure OpenMedicDiction(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   class function Instance: TInpharmServiceImpl;
    {* Метод получения экземпляра синглетона TInpharmServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TInpharmServiceImpl

 TInpharmOperationsImpl = {final} class(TvcmModuleContractImplementation, IInpharmOperations)
  public
   class function Instance: TInpharmOperationsImpl;
    {* Метод получения экземпляра синглетона TInpharmOperationsImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TInpharmOperationsImpl

var g_TInpharmServiceImpl: TInpharmServiceImpl = nil;
 {* Экземпляр синглетона TInpharmServiceImpl }
var g_TInpharmOperationsImpl: TInpharmOperationsImpl = nil;
 {* Экземпляр синглетона TInpharmOperationsImpl }

procedure TInpharmServiceImplFree;
 {* Метод освобождения экземпляра синглетона TInpharmServiceImpl }
begin
 l3Free(g_TInpharmServiceImpl);
end;//TInpharmServiceImplFree

procedure TInpharmOperationsImplFree;
 {* Метод освобождения экземпляра синглетона TInpharmOperationsImpl }
begin
 l3Free(g_TInpharmOperationsImpl);
end;//TInpharmOperationsImplFree

class procedure TnsOpenPharmFirmDocumentEvent.Log(const aDoc: IDocument);
//#UC START# *4B14D8D10222_4B14D8AE00D4_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B14D8D10222_4B14D8AE00D4_var*
begin
//#UC START# *4B14D8D10222_4B14D8AE00D4_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_OPEN_PHARM_FIRM_DOCUMENT, l_Data);
//#UC END# *4B14D8D10222_4B14D8AE00D4_impl*
end;//TnsOpenPharmFirmDocumentEvent.Log

class procedure TnsOpenPharmDocumentEvent.Log(const aDoc: IDocument);
//#UC START# *4B14D98900BD_4B14D96C038A_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B14D98900BD_4B14D96C038A_var*
begin
//#UC START# *4B14D98900BD_4B14D96C038A_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_OPEN_PHARM_DOCUMENT, l_Data);
//#UC END# *4B14D98900BD_4B14D96C038A_impl*
end;//TnsOpenPharmDocumentEvent.Log

class procedure TnsOpenMedicDictionaryEvent.Log;
//#UC START# *4B14DA27026F_4B14DA170298_var*
//#UC END# *4B14DA27026F_4B14DA170298_var*
begin
//#UC START# *4B14DA27026F_4B14DA170298_impl*
 GetLogger.AddEvent(LE_OPEN_MEDIC_DICTIONARY, MakeParamsList);
//#UC END# *4B14DA27026F_4B14DA170298_impl*
end;//TnsOpenMedicDictionaryEvent.Log

class procedure TnsOpenMedicFirmsEvent.Log;
//#UC START# *4B14DA6B00F9_4B14DA6101E3_var*
//#UC END# *4B14DA6B00F9_4B14DA6101E3_var*
begin
//#UC START# *4B14DA6B00F9_4B14DA6101E3_impl*
 GetLogger.AddEvent(LE_OPEN_MEDIC_FIRMS, MakeParamsList);
//#UC END# *4B14DA6B00F9_4B14DA6101E3_impl*
end;//TnsOpenMedicFirmsEvent.Log

procedure TInpharmServiceImpl.OpenDrugListIfNeeded(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *530513060354_4AA0D66F0159_var*
//#UC END# *530513060354_4AA0D66F0159_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *530513060354_4AA0D66F0159_impl*
 TListService.Instance.OpenList(TdeListSet.Make(defDataAdapter.NativeAdapter.MakeDynList(SLK_ALL_ALLOWED_DRUGS)), aContainer);
//#UC END# *530513060354_4AA0D66F0159_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TInpharmServiceImpl.OpenDrugListIfNeeded

procedure TInpharmServiceImpl.OpenInpharmMainMenu(const aContainer: IvcmContainer);
var l_FormId: TvcmFormID;
var
 __WasEnter : Boolean;
//#UC START# *530340E702A3_4AA0D66F0159_var*
//#UC END# *530340E702A3_4AA0D66F0159_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *530340E702A3_4AA0D66F0159_impl*
  if defDataAdapter.IsInpharmExists then
  begin
   l_FormId := fm_en_MedicMainMenu.rFormID;
   if CheckContainer(aContainer).NativeMainForm.HasForm(l_FormId, vcm_ztParent) then
    Exit;
   //Ten_MedicMainMenu.Make(vcmMakeParams(nil, CheckContainer(aContainer)), vcm_ztParent, Ord(ut_mmmMain));
   Tfs_InpharmMainMenu.Make(TsdsInpharmMainMenu.Make, CheckContainer(aContainer));
  end;//defDataAdapter.IsInpharmExists
//#UC END# *530340E702A3_4AA0D66F0159_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TInpharmServiceImpl.OpenInpharmMainMenu

procedure TInpharmServiceImpl.MedicFirms(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AC0F93D01AB_4AA0D66F0159_var*
//#UC END# *4AC0F93D01AB_4AA0D66F0159_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC0F93D01AB_4AA0D66F0159_impl*
 if defDataAdapter.IsInpharmExists AND
    not CheckContainer(aContainer).HasForm(fm_en_MedicFirmList.rFormID,
                                           vcm_ztMain,
                                           True,
                                           nil,
                                           Ord(mflMain)) then
 begin
  TnsOpenMedicFirmsEvent.Log;
  Tfs_MedicFirmList.Make(TsdsMedicFirmList.Make(nil),
                         CheckContainer(aContainer));
 end;//not lp_HasListForm
//#UC END# *4AC0F93D01AB_4AA0D66F0159_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TInpharmServiceImpl.MedicFirms

procedure TInpharmServiceImpl.OpenDrugDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA11CE70112_4AA0D66F0159_var*
//#UC END# *4AA11CE70112_4AA0D66F0159_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA11CE70112_4AA0D66F0159_impl*
 TnsOpenPharmDocumentEvent.Log(aDocInfo.Doc);
 Tfs_DrugDocument.Make(TsdsDrugDocument.Make(aDocInfo), aContainer);
//#UC END# *4AA11CE70112_4AA0D66F0159_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TInpharmServiceImpl.OpenDrugDocument

procedure TInpharmServiceImpl.OpenDrugList(const aList: IdeList;
 const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA4D413008C_4AA0D66F0159_var*
//#UC END# *4AA4D413008C_4AA0D66F0159_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4D413008C_4AA0D66F0159_impl*
 Tfs_DrugList.Make(TsdsDrugList.Make(aList), aContainer);
//#UC END# *4AA4D413008C_4AA0D66F0159_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TInpharmServiceImpl.OpenDrugList

procedure TInpharmServiceImpl.OpenMedicDiction(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA11B7A0009_4AA0D66F0159_var*
//#UC END# *4AA11B7A0009_4AA0D66F0159_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA11B7A0009_4AA0D66F0159_impl*
 TInpharmModule.OpenMedicDictionPrim(TsdsMedicDiction.Make(aDocInfo), aContainer);
//#UC END# *4AA11B7A0009_4AA0D66F0159_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TInpharmServiceImpl.OpenMedicDiction

procedure TInpharmServiceImpl.OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA11BE70139_4AA0D66F0159_var*
//#UC END# *4AA11BE70139_4AA0D66F0159_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA11BE70139_4AA0D66F0159_impl*
 TnsOpenPharmFirmDocumentEvent.Log(aDocInfo.Doc);
 Tfs_MedicFirmDocument.Make(TsdsMedicFirmDocument.Make(aDocInfo),
                            aContainer);
//#UC END# *4AA11BE70139_4AA0D66F0159_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TInpharmServiceImpl.OpenMedicFirmDocument

class function TInpharmServiceImpl.Instance: TInpharmServiceImpl;
 {* Метод получения экземпляра синглетона TInpharmServiceImpl }
begin
 if (g_TInpharmServiceImpl = nil) then
 begin
  l3System.AddExitProc(TInpharmServiceImplFree);
  g_TInpharmServiceImpl := Create;
 end;
 Result := g_TInpharmServiceImpl;
end;//TInpharmServiceImpl.Instance

class function TInpharmServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TInpharmServiceImpl <> nil;
end;//TInpharmServiceImpl.Exists

class function TInpharmOperationsImpl.Instance: TInpharmOperationsImpl;
 {* Метод получения экземпляра синглетона TInpharmOperationsImpl }
begin
 if (g_TInpharmOperationsImpl = nil) then
 begin
  l3System.AddExitProc(TInpharmOperationsImplFree);
  g_TInpharmOperationsImpl := Create;
 end;
 Result := g_TInpharmOperationsImpl;
end;//TInpharmOperationsImpl.Instance

class function TInpharmOperationsImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TInpharmOperationsImpl <> nil;
end;//TInpharmOperationsImpl.Exists

class procedure TInpharmModule.OpenMedicDictionPrim(const aSDS: IsdsCommonDiction;
 const aContainer: IvcmContainer);
//#UC START# *4AA52C670101_4AA0D66F0159_var*
//#UC END# *4AA52C670101_4AA0D66F0159_var*
begin
//#UC START# *4AA52C670101_4AA0D66F0159_impl*
 TnsOpenMedicDictionaryEvent.Log;
 Tfs_MedicDiction.Make(aSDS, aContainer);
//#UC END# *4AA52C670101_4AA0D66F0159_impl*
end;//TInpharmModule.OpenMedicDictionPrim

procedure TInpharmModule.opDrugListTest(const aParams: IvcmTestParamsPrim);
 {* Список выпускаемых препаратов }
//#UC START# *4AB9FD0601CF_4AA0D66F0159test_var*
//#UC END# *4AB9FD0601CF_4AA0D66F0159test_var*
begin
//#UC START# *4AB9FD0601CF_4AA0D66F0159test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsInpharmExists;
//#UC END# *4AB9FD0601CF_4AA0D66F0159test_impl*
end;//TInpharmModule.opDrugListTest

procedure TInpharmModule.opDrugListExecute(const aParams: IvcmExecuteParamsPrim);
 {* Список выпускаемых препаратов }
//#UC START# *4AB9FD0601CF_4AA0D66F0159exec_var*
//#UC END# *4AB9FD0601CF_4AA0D66F0159exec_var*
begin
//#UC START# *4AB9FD0601CF_4AA0D66F0159exec_impl*
 TListService.Instance.OpenList(
  TdeListSet.Make(
   defDataAdapter.NativeAdapter.MakeDynList(SLK_ALL_ALLOWED_DRUGS)), nil);
//#UC END# *4AB9FD0601CF_4AA0D66F0159exec_impl*
end;//TInpharmModule.opDrugListExecute

procedure TInpharmModule.opMedicDictionTest(const aParams: IvcmTestParamsPrim);
 {* Словарь медицинских терминов }
//#UC START# *4AB9FC8F027A_4AA0D66F0159test_var*
//#UC END# *4AB9FC8F027A_4AA0D66F0159test_var*
begin
//#UC START# *4AB9FC8F027A_4AA0D66F0159test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsInpharmExists;
//#UC END# *4AB9FC8F027A_4AA0D66F0159test_impl*
end;//TInpharmModule.opMedicDictionTest

procedure TInpharmModule.opMedicDictionExecute(const aParams: IvcmExecuteParamsPrim);
 {* Словарь медицинских терминов }
//#UC START# *4AB9FC8F027A_4AA0D66F0159exec_var*
  
 function lp_HasDictionForm: Boolean;
 begin
  Result := CheckContainer(nil).HasForm(fm_en_CommonDiction.rFormID,
                                        vcm_ztNavigator,
                                        True, nil, Ord(utMedicDiction));
 end;//lp_HasTipsForm

//#UC END# *4AB9FC8F027A_4AA0D66F0159exec_var*
begin
//#UC START# *4AB9FC8F027A_4AA0D66F0159exec_impl*
 Assert(((aParams As IvcmExecuteParams).Data = nil),
        'Пользуйтесь фабрикой OpenMedicDictionPrim');
 if not lp_HasDictionForm then
  TInpharmService.Instance.OpenMedicDiction(nil, CheckContainer(nil));
//#UC END# *4AB9FC8F027A_4AA0D66F0159exec_impl*
end;//TInpharmModule.opMedicDictionExecute

procedure TInpharmModule.opMedicFirmsTest(const aParams: IvcmTestParamsPrim);
 {* Фармацевтические фирмы }
//#UC START# *4AB9FCE902EC_4AA0D66F0159test_var*
//#UC END# *4AB9FCE902EC_4AA0D66F0159test_var*
begin
//#UC START# *4AB9FCE902EC_4AA0D66F0159test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsInpharmExists;
//#UC END# *4AB9FCE902EC_4AA0D66F0159test_impl*
end;//TInpharmModule.opMedicFirmsTest

procedure TInpharmModule.opMedicFirmsExecute(const aParams: IvcmExecuteParamsPrim);
 {* Фармацевтические фирмы }
//#UC START# *4AB9FCE902EC_4AA0D66F0159exec_var*
//#UC END# *4AB9FCE902EC_4AA0D66F0159exec_var*
begin
//#UC START# *4AB9FCE902EC_4AA0D66F0159exec_impl*
 TInpharmService.Instance.MedicFirms(nil);
//#UC END# *4AB9FCE902EC_4AA0D66F0159exec_impl*
end;//TInpharmModule.opMedicFirmsExecute

procedure TInpharmModule.opMedicMainMenuExecute(const aParams: IvcmExecuteParamsPrim);
 {* Основное меню ИнФарм }
//#UC START# *4AB9FD6F017A_4AA0D66F0159exec_var*
//#UC END# *4AB9FD6F017A_4AA0D66F0159exec_var*
begin
//#UC START# *4AB9FD6F017A_4AA0D66F0159exec_impl*
 TInpharmService.Instance.OpenInpharmMainMenu(nil);
//#UC END# *4AB9FD6F017A_4AA0D66F0159exec_impl*
end;//TInpharmModule.opMedicMainMenuExecute

procedure TInpharmModule.Loaded;
begin
 inherited;
 PublishOp('opDrugList', opDrugListExecute, opDrugListTest);
 PublishOp('opMedicDiction', opMedicDictionExecute, opMedicDictionTest);
 PublishOp('opMedicFirms', opMedicFirmsExecute, opMedicFirmsTest);
 PublishOp('opMedicMainMenu', opMedicMainMenuExecute, nil);
end;//TInpharmModule.Loaded

class procedure TInpharmModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(Ten_MedicMainMenu);
 aList.Add(Ten_MedicFirmList);
 aList.Add(Ten_MedicListSynchroView);
end;//TInpharmModule.GetEntityForms

initialization
 TInpharmService.Instance.Alien := TInpharmServiceImpl.Instance;
 {* Регистрация TInpharmServiceImpl }
 TInpharmOperations.Instance.Alien := TInpharmOperationsImpl.Instance;
 {* Регистрация TInpharmOperationsImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
