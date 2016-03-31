unit NOT_COMPLETED_DictionInterfacesPrim;
 {* Базовые интерфейсы для работы с Толковым словарём }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\NOT_COMPLETED_DictionInterfacesPrim.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "DictionInterfacesPrim" MUID: (4AC238AF03B8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IdsDictionDocument = interface(IdsBaseDocument)
  {* Документ толкового словаря }
  ['{CED6AA8A-309F-467B-9C4C-D6444BBAF67D}']
  function pm_GetIsMainDiction: Boolean;
  procedure OpenLiteratureList;
   {* открыть список литературы для толкового словаря }
  property IsMainDiction: Boolean
   read pm_GetIsMainDiction;
   {* толкование является основным, для языка по умолчанию }
 end;//IdsDictionDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
