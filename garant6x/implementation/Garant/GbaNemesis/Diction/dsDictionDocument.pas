unit dsDictionDocument;
 {* ƒокумент толкового словар€ }

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\dsDictionDocument.pas"
// —тереотип: "ViewAreaControllerImp"
// Ёлемент модели: "TdsDictionDocument" MUID: (491D5BE30111)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionInterfacesPrim
 , DictionInterfaces
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentAndListInterfaces
 , l3Types
 , DocumentInterfaces
 , WorkWithListInterfaces
 , nsDocumentLikeStateHolder
 , afwInterfaces
 , l3Interfaces
 , bsTypes
 , FoldersDomainInterfaces
 , UnderControlUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , bsTypesNew
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , UnderControlInterfaces
;

type
 _FormDataSourceType_ = IdsDictionDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 TdsDictionDocument = {final} class(_dsBaseDocumentPrim_, IdsDictionDocument)
  {* ƒокумент толкового словар€ }
  private
   ucc_Diction: IsdsDiction;
  protected
   procedure OpenLiteratureList;
    {* открыть список литературы дл€ толкового словар€ }
   function pm_GetIsMainDiction: Boolean;
   function GetTimeMachineOff: Boolean; override;
    {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
    {*  онструирует контейнер документа }
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* »нициализирует ссылки на различные представлени€ прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* ќчищает ссылки на различные представлени€ прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsDictionDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , nsDictionDocumentContainer
 , bsConst
 , nsConst
 , nsF1DocumentContainer
 , l3Base
 , bsUtils
 , BaseTypesUnit
 , bsConvert
 , l3Utils
 , deDocInfo
 , nsTypes
 , nsDocInfoHAFMacroReplacer
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsFolderFilterInfo
 , Common_F1CommonServices_Contracts
 , l3InterfacesMisc
 , SysUtils
 , afwFacade
 , IOUnit
 //#UC START# *491D5BE30111impl_uses*
 //#UC END# *491D5BE30111impl_uses*
;

type _Instance_R_ = TdsDictionDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}

procedure TdsDictionDocument.OpenLiteratureList;
 {* открыть список литературы дл€ толкового словар€ }
//#UC START# *491D58670154_491D5BE30111_var*
//#UC END# *491D58670154_491D5BE30111_var*
begin
//#UC START# *491D58670154_491D5BE30111_impl*
 if (ucc_Diction <> nil) then
  ucc_Diction.OpenLiteratureList;
//#UC END# *491D58670154_491D5BE30111_impl*
end;//TdsDictionDocument.OpenLiteratureList

function TdsDictionDocument.pm_GetIsMainDiction: Boolean;
//#UC START# *491D58890177_491D5BE30111get_var*
//#UC END# *491D58890177_491D5BE30111get_var*
begin
//#UC START# *491D58890177_491D5BE30111get_impl*
 Result := Assigned(DocInfo) and
  (DocInfo.Language = DefDataAdapter.DocDefaultLang);
//#UC END# *491D58890177_491D5BE30111get_impl*
end;//TdsDictionDocument.pm_GetIsMainDiction

function TdsDictionDocument.GetTimeMachineOff: Boolean;
 {* при получении источника данных машину времени нужно выключить }
//#UC START# *491C264C02C2_491D5BE30111_var*
//#UC END# *491C264C02C2_491D5BE30111_var*
begin
//#UC START# *491C264C02C2_491D5BE30111_impl*
 Result := true;
//#UC END# *491C264C02C2_491D5BE30111_impl*
end;//TdsDictionDocument.GetTimeMachineOff

function TdsDictionDocument.MakeContainer: InevDocumentContainer;
 {*  онструирует контейнер документа }
//#UC START# *4C6AB38800F3_491D5BE30111_var*
//#UC END# *4C6AB38800F3_491D5BE30111_var*
begin
//#UC START# *4C6AB38800F3_491D5BE30111_impl*
 if (DocInfo.Doc.GetInternalId + c_InternalDocShift =
      c_LiteratureListForDictionary) then
  Result := TnsF1DocumentContainer.Make(DocInfo)
 else
  Result := TnsDictionDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D5BE30111_impl*
end;//TdsDictionDocument.MakeContainer

{$If NOT Defined(NoVCM)}
procedure TdsDictionDocument.InitRefs(const aDS: IvcmFormSetDataSource);
 {* »нициализирует ссылки на различные представлени€ прецедента }
begin
 inherited;
 Supports(aDS, IsdsDiction, ucc_Diction);
end;//TdsDictionDocument.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsDictionDocument.ClearRefs;
 {* ќчищает ссылки на различные представлени€ прецедента }
begin
 inherited;
 ucc_Diction := nil;
end;//TdsDictionDocument.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
