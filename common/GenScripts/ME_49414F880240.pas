unit sdsMedicFirmDocument;
 {* Документ-фирма }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmDocument.pas"
// Стереотип: "UseCaseControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 , DocumentInterfaces
 , DocumentAndListInterfaces
 , BaseDocumentWithAttributesInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3IID
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _SetDataType_ = IdMedicFirmDocument;
 _SetType_ = IsdsMedicFirmDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmDocument.imp.pas}
 TsdsMedicFirmDocument = class(_sdsMedicFirmDocument_, IsdsMedicFirmDocument)
  {* Документ-фирма }
  protected
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsMedicFirmDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dMedicFirmDocument
 , dsMedicFirmDocument
 , dsDrugList
 , SysUtils
 , DynamicDocListUnit
 , afwFacade
 , DynamicTreeUnit
 , BaseTypesUnit
 , deList
 , bsUtils
 , dsAttributes
 , l3Types
 , l3Utils
 , deDocInfo
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
;

{$If not Declared(_InitDataType_)}type _InitDataType_ = IdeDocInfo;{$IfEnd}

type _Instance_R_ = TsdsMedicFirmDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\sdsMedicFirmDocument.imp.pas}

{$If NOT Defined(NoVCM)}
function TsdsMedicFirmDocument.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_49414F880240_var*
//#UC END# *47F3778403D9_49414F880240_var*
begin
//#UC START# *47F3778403D9_49414F880240_impl*
 Result := TdMedicFirmDocument.Make;
 Result.dsDrugListRef.NeedMake := vcm_nmYes;
//#UC END# *47F3778403D9_49414F880240_impl*
end;//TsdsMedicFirmDocument.MakeData
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
