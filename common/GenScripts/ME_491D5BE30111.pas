unit dsDictionDocument;
 {* ƒокумент толкового словар€ }

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\dsDictionDocument.pas"
// —тереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionInterfacesPrim
 , DictionInterfaces
 , nevTools
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
 , DocumentUnit
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , UnderControlInterfaces
;

type
 {$Include dsBaseDocumentPrim.imp.pas}
 TdsDictionDocument = {final} class(_dsBaseDocumentPrim_, IdsDictionDocument)
  {* ƒокумент толкового словар€ }
  private
   Diction: IsdsDiction;
  protected
   procedure OpenLiteratureList;
    {* открыть список литературы дл€ толкового словар€ }
   function pm_GetIsMainDiction: Boolean;
   function GetTimeMachineOff: Boolean; override;
    {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
    {*  онструирует контейнер документа }
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
 , l3InterfacesMisc
 , SysUtils
 , afwFacade
;

type _Instance_R_ = TdsDictionDocument;

{$Include dsBaseDocumentPrim.imp.pas}

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
