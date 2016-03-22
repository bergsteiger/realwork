unit dsTipsDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\DayTips\dsTipsDocument.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsTipsDocument" MUID: (491D56370182)

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
 TdsTipsDocument = class(_dsBaseDocument_)
  protected
   function GetIsReadOnly: Boolean; override;
   function GetTimeMachineOff: Boolean; override;
    {* при получении источника данных машину времени нужно выключить }
   function MakeContainer: InevDocumentContainer; override;
    {* Конструирует контейнер документа }
 end;//TdsTipsDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsTipsDocumentContainer
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

type _Instance_R_ = TdsTipsDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas}

function TdsTipsDocument.GetIsReadOnly: Boolean;
//#UC START# *491C263E03AF_491D56370182_var*
//#UC END# *491C263E03AF_491D56370182_var*
begin
//#UC START# *491C263E03AF_491D56370182_impl*
 Result := true;
//#UC END# *491C263E03AF_491D56370182_impl*
end;//TdsTipsDocument.GetIsReadOnly

function TdsTipsDocument.GetTimeMachineOff: Boolean;
 {* при получении источника данных машину времени нужно выключить }
//#UC START# *491C264C02C2_491D56370182_var*
//#UC END# *491C264C02C2_491D56370182_var*
begin
//#UC START# *491C264C02C2_491D56370182_impl*
 Result := true;
//#UC END# *491C264C02C2_491D56370182_impl*
end;//TdsTipsDocument.GetTimeMachineOff

function TdsTipsDocument.MakeContainer: InevDocumentContainer;
 {* Конструирует контейнер документа }
//#UC START# *4C6AB38800F3_491D56370182_var*
//#UC END# *4C6AB38800F3_491D56370182_var*
begin
//#UC START# *4C6AB38800F3_491D56370182_impl*
 Result := TnsTipsDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D56370182_impl*
end;//TdsTipsDocument.MakeContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
