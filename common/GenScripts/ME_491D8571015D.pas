unit dsMedicDictionDocument;
 {* дл€ словар€ медицинских терминов }

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsMedicDictionDocument.pas"
// —тереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
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
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}
 TdsMedicDictionDocument = class(_dsBaseDocument_)
  {* дл€ словар€ медицинских терминов }
  protected
   function GetTimeMachineOff: Boolean; override;
    {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
    {*  онструирует контейнер документа }
 end;//TdsMedicDictionDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDictionDocumentContainer
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

{$If not Declared(_FormDataSourceType_)}type _FormDataSourceType_ = IdsBaseDocument;{$IfEnd}

{$If not Declared(_InitDataType_)}type _InitDataType_ = IdeDocInfo;{$IfEnd}

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsMedicDictionDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}

function TdsMedicDictionDocument.GetTimeMachineOff: Boolean;
 {* при получении источника данных машину времени нужно выключить }
//#UC START# *491C264C02C2_491D8571015D_var*
//#UC END# *491C264C02C2_491D8571015D_var*
begin
//#UC START# *491C264C02C2_491D8571015D_impl*
 Result := true;
//#UC END# *491C264C02C2_491D8571015D_impl*
end;//TdsMedicDictionDocument.GetTimeMachineOff

function TdsMedicDictionDocument.MakeContainer: InevDocumentContainer;
 {*  онструирует контейнер документа }
//#UC START# *4C6AB38800F3_491D8571015D_var*
//#UC END# *4C6AB38800F3_491D8571015D_var*
begin
//#UC START# *4C6AB38800F3_491D8571015D_impl*
 //Result := TnsDictionDocumentContainer.Make(DocInfo);
 Result := TnsF1DocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D8571015D_impl*
end;//TdsMedicDictionDocument.MakeContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
