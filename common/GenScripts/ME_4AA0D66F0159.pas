unit Inpharm_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Inpharm_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimPrimListInterfaces
 , CommonDictionInterfaces
 , nsLogEvent
 , DocumentUnit
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

 TInpharmModule = class
  protected
   procedure OpenMedicDictionPrim(const aSDS: IsdsCommonDiction;
    const aContainer: IvcmContainer);
   procedure MedicDiction;
    {* Словарь медицинских терминов }
   procedure MedicFirms; overload;
    {* Фармацевтические фирмы }
   procedure DrugList;
    {* Список выпускаемых препаратов }
   procedure MedicMainMenu;
    {* Основное меню ИнФарм }
  public
   procedure OpenMedicDiction(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenDrugDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenDrugList(const aList: IdeList;
    const aContainer: IvcmContainer);
   procedure MedicFirms(const aContainer: IvcmContainer); overload;
   procedure OpenInpharmMainMenu(const aContainer: IvcmContainer);
   procedure OpenDrugListIfNeeded(const aContainer: IvcmContainer);
 end;//TInpharmModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , InpharmMainMenu_ut_mmmMain_UserType
 , PrimMedicFirmList_mflMain_UserType
 , PrimCommonDiction_utMedicDiction_UserType
 , Common_FormDefinitions_Controls
 , sdsInpharmMainMenu
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , sdsMedicDiction
 , sdsMedicFirmDocument
 , sdsDrugDocument
 , sdsDrugList
 , DataAdapter
 , deListSet
 , DynamicDocListUnit
 , sdsMedicFirmList
 , LoggingUnit
;

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

procedure TInpharmModule.OpenMedicDiction(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
//#UC START# *4AA11B7A0009_4AA0D66F0159_var*
//#UC END# *4AA11B7A0009_4AA0D66F0159_var*
begin
//#UC START# *4AA11B7A0009_4AA0D66F0159_impl*
 OpenMedicDictionPrim(TsdsMedicDiction.Make(aDocInfo), aContainer);
//#UC END# *4AA11B7A0009_4AA0D66F0159_impl*
end;//TInpharmModule.OpenMedicDiction

procedure TInpharmModule.OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
//#UC START# *4AA11BE70139_4AA0D66F0159_var*
//#UC END# *4AA11BE70139_4AA0D66F0159_var*
begin
//#UC START# *4AA11BE70139_4AA0D66F0159_impl*
 TnsOpenPharmFirmDocumentEvent.Log(aDocInfo.Doc);
 Tfs_MedicFirmDocument.Make(TsdsMedicFirmDocument.Make(aDocInfo),
                            aContainer);
//#UC END# *4AA11BE70139_4AA0D66F0159_impl*
end;//TInpharmModule.OpenMedicFirmDocument

procedure TInpharmModule.OpenDrugDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
//#UC START# *4AA11CE70112_4AA0D66F0159_var*
//#UC END# *4AA11CE70112_4AA0D66F0159_var*
begin
//#UC START# *4AA11CE70112_4AA0D66F0159_impl*
 TnsOpenPharmDocumentEvent.Log(aDocInfo.Doc);
 Tfs_DrugDocument.Make(TsdsDrugDocument.Make(aDocInfo), aContainer);
//#UC END# *4AA11CE70112_4AA0D66F0159_impl*
end;//TInpharmModule.OpenDrugDocument

procedure TInpharmModule.OpenDrugList(const aList: IdeList;
 const aContainer: IvcmContainer);
//#UC START# *4AA4D413008C_4AA0D66F0159_var*
//#UC END# *4AA4D413008C_4AA0D66F0159_var*
begin
//#UC START# *4AA4D413008C_4AA0D66F0159_impl*
 Tfs_DrugList.Make(TsdsDrugList.Make(aList), aContainer);
//#UC END# *4AA4D413008C_4AA0D66F0159_impl*
end;//TInpharmModule.OpenDrugList

procedure TInpharmModule.OpenMedicDictionPrim(const aSDS: IsdsCommonDiction;
 const aContainer: IvcmContainer);
//#UC START# *4AA52C670101_4AA0D66F0159_var*
//#UC END# *4AA52C670101_4AA0D66F0159_var*
begin
//#UC START# *4AA52C670101_4AA0D66F0159_impl*
 TnsOpenMedicDictionaryEvent.Log;
 Tfs_MedicDiction.Make(aSDS, aContainer);
//#UC END# *4AA52C670101_4AA0D66F0159_impl*
end;//TInpharmModule.OpenMedicDictionPrim

procedure TInpharmModule.MedicDiction;
 {* Словарь медицинских терминов }
//#UC START# *4AB9FC8F027A_4AA0D66F0159_var*
//#UC END# *4AB9FC8F027A_4AA0D66F0159_var*
begin
//#UC START# *4AB9FC8F027A_4AA0D66F0159_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9FC8F027A_4AA0D66F0159_impl*
end;//TInpharmModule.MedicDiction

procedure TInpharmModule.MedicFirms;
 {* Фармацевтические фирмы }
//#UC START# *4AB9FCE902EC_4AA0D66F0159_var*
//#UC END# *4AB9FCE902EC_4AA0D66F0159_var*
begin
//#UC START# *4AB9FCE902EC_4AA0D66F0159_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9FCE902EC_4AA0D66F0159_impl*
end;//TInpharmModule.MedicFirms

procedure TInpharmModule.DrugList;
 {* Список выпускаемых препаратов }
//#UC START# *4AB9FD0601CF_4AA0D66F0159_var*
//#UC END# *4AB9FD0601CF_4AA0D66F0159_var*
begin
//#UC START# *4AB9FD0601CF_4AA0D66F0159_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9FD0601CF_4AA0D66F0159_impl*
end;//TInpharmModule.DrugList

procedure TInpharmModule.MedicMainMenu;
 {* Основное меню ИнФарм }
//#UC START# *4AB9FD6F017A_4AA0D66F0159_var*
//#UC END# *4AB9FD6F017A_4AA0D66F0159_var*
begin
//#UC START# *4AB9FD6F017A_4AA0D66F0159_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9FD6F017A_4AA0D66F0159_impl*
end;//TInpharmModule.MedicMainMenu

procedure TInpharmModule.MedicFirms(const aContainer: IvcmContainer);
//#UC START# *4AC0F93D01AB_4AA0D66F0159_var*
//#UC END# *4AC0F93D01AB_4AA0D66F0159_var*
begin
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
end;//TInpharmModule.MedicFirms

procedure TInpharmModule.OpenInpharmMainMenu(const aContainer: IvcmContainer);
var l_FormId: TvcmFormID;
//#UC START# *530340E702A3_4AA0D66F0159_var*
//#UC END# *530340E702A3_4AA0D66F0159_var*
begin
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
end;//TInpharmModule.OpenInpharmMainMenu

procedure TInpharmModule.OpenDrugListIfNeeded(const aContainer: IvcmContainer);
//#UC START# *530513060354_4AA0D66F0159_var*
//#UC END# *530513060354_4AA0D66F0159_var*
begin
//#UC START# *530513060354_4AA0D66F0159_impl*
 TdmStdRes.OpenList(TdeListSet.Make(defDataAdapter.NativeAdapter.MakeDynList(SLK_ALL_ALLOWED_DRUGS)), aContainer);
//#UC END# *530513060354_4AA0D66F0159_impl*
end;//TInpharmModule.OpenDrugListIfNeeded
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
