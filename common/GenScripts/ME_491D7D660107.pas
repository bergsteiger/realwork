unit dsMedicFirmDocument;
 {* ƒокумент описани€ фирмы-производител€ }

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicFirmDocument.pas"
// —тереотип: "ViewAreaControllerImp"
// Ёлемент модели: "TdsMedicFirmDocument" MUID: (491D7D660107)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InpharmInterfaces
 , MedicInterfaces
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
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , bsTypesNew
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
 _FormDataSourceType_ = IdsMedicFirmDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 TdsMedicFirmDocument = class(_dsBaseDocumentPrim_, IdsMedicFirmDocument)
  {* ƒокумент описани€ фирмы-производител€ }
  private
   MedicFirmDocument: IsdsMedicFirmDocumentPrim;
  protected
   procedure OpenDrugList;
    {* открыть список выпускаемых препаратов }
   function GetTimeMachineOff: Boolean; override;
    {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
    {*  онструирует контейнер документа }
 end;//TdsMedicFirmDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
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
 , IOUnit
;

type _Instance_R_ = TdsMedicFirmDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}

procedure TdsMedicFirmDocument.OpenDrugList;
 {* открыть список выпускаемых препаратов }
//#UC START# *491D7D2A02E0_491D7D660107_var*
//#UC END# *491D7D2A02E0_491D7D660107_var*
begin
//#UC START# *491D7D2A02E0_491D7D660107_impl*
 if (ucc_MedicFirmDocument <> nil) then
  ucc_MedicFirmDocument.OpenDrugList;
//#UC END# *491D7D2A02E0_491D7D660107_impl*
end;//TdsMedicFirmDocument.OpenDrugList

function TdsMedicFirmDocument.GetTimeMachineOff: Boolean;
 {* при получении источника данных машину времени нужно выключить }
//#UC START# *491C264C02C2_491D7D660107_var*
//#UC END# *491C264C02C2_491D7D660107_var*
begin
//#UC START# *491C264C02C2_491D7D660107_impl*
 Result := True;
//#UC END# *491C264C02C2_491D7D660107_impl*
end;//TdsMedicFirmDocument.GetTimeMachineOff

function TdsMedicFirmDocument.MakeContainer: InevDocumentContainer;
 {*  онструирует контейнер документа }
//#UC START# *4C6AB38800F3_491D7D660107_var*
//#UC END# *4C6AB38800F3_491D7D660107_var*
begin
//#UC START# *4C6AB38800F3_491D7D660107_impl*
 Result := TnsF1DocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D7D660107_impl*
end;//TdsMedicFirmDocument.MakeContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
