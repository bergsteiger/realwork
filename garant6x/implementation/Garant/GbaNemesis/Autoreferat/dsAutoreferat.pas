unit dsAutoreferat;
 {* Автореферат }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\dsAutoreferat.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsAutoreferat" MUID: (491C3B8D00D8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}
 TdsAutoreferat = class(_dsBaseDocument_)
  {* Автореферат }
  protected
   function GetIsReadOnly: Boolean; override;
   function GetTimeMachineOff: Boolean; override;
    {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
    {* Конструирует контейнер документа }
 end;//TdsAutoreferat
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsAutoreferatDocumentContainer
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
 //#UC START# *491C3B8D00D8impl_uses*
 //#UC END# *491C3B8D00D8impl_uses*
;

type _Instance_R_ = TdsAutoreferat;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}

function TdsAutoreferat.GetIsReadOnly: Boolean;
//#UC START# *491C263E03AF_491C3B8D00D8_var*
//#UC END# *491C263E03AF_491C3B8D00D8_var*
begin
//#UC START# *491C263E03AF_491C3B8D00D8_impl*
 Result := true;
//#UC END# *491C263E03AF_491C3B8D00D8_impl*
end;//TdsAutoreferat.GetIsReadOnly

function TdsAutoreferat.GetTimeMachineOff: Boolean;
 {* при получении источника данных машину времени нужно выключить }
//#UC START# *491C264C02C2_491C3B8D00D8_var*
//#UC END# *491C264C02C2_491C3B8D00D8_var*
begin
//#UC START# *491C264C02C2_491C3B8D00D8_impl*
 Result := true;
//#UC END# *491C264C02C2_491C3B8D00D8_impl*
end;//TdsAutoreferat.GetTimeMachineOff

function TdsAutoreferat.MakeContainer: InevDocumentContainer;
 {* Конструирует контейнер документа }
//#UC START# *4C6AB38800F3_491C3B8D00D8_var*
//#UC END# *4C6AB38800F3_491C3B8D00D8_var*
begin
//#UC START# *4C6AB38800F3_491C3B8D00D8_impl*
 Result := TnsAutoreferatDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491C3B8D00D8_impl*
end;//TdsAutoreferat.MakeContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
