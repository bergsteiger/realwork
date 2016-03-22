unit sdsDocument;
 {* Контроллер прецедента "Просмотр документа" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\sdsDocument.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsDocument" MUID: (5010180C0356)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkWithDocumentInterfaces
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicTreeUnit
 , bsTypes
 , DocumentAndListInterfaces
 , nsTypes
 , DocumentUnit
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , DocInfoInterfaces
 , PrimListInterfaces
 , DynamicDocListUnit
 , ExternalObjectUnit
 , BaseDocumentWithAttributesInterfaces
 , l3IID
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
 , afwInterfaces
 , bsInterfaces
 , nevTools
;

type
 _SetType_ = IsdsDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Document\sdsDocument.imp.pas}
 TsdsDocument = class(_sdsDocument_)
  {* Контроллер прецедента "Просмотр документа" }
 end;//TsdsDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dDocument
 , SysUtils
 , dsDocument
 , dsDocumentListCRToPart
 , deDocumentListCR
 , dsWarning
 , dsContents
 , dsEditions
 {$If NOT Defined(NoVCM)}
 , vcmForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmGUI
 {$IfEnd} // NOT Defined(NoVCM)
 , IOUnit
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseTypesUnit
 , DataAdapter
 , k2Tags
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefreshParams
 {$IfEnd} // NOT Defined(NoVCM)
 , bsUtils
 , l3String
 , l3Core
 , nsDocumentTools
 , afwFacade
 , Graphics
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , nsConst
 , Document_Const
 , TextPara_Const
 , UnderControlInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , ControlStatusUtils
 , nsDocumentWarningGenerator
 , dsTranslationWarning
 , dsCRWarning
 , nsTabbedInterfaceTypes
 , dsDocumentListCR
 , dsDocumentList
 , dsAnnotation
 , dsDocumentWithFlash
 , bsFrozenNode
 , deDocInfo
 , bsDataContainer
 , deDocumentList
 , bsUserCRListInfo
 , l3Types
 , DebugStr
 , l3Utils
 , nsUtils
 , dsTranslation
 , dsRelatedDoc
 , dsChronology
 , dsAttributes
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwSettingsChangePublisher
;

type _Instance_R_ = TsdsDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Document\sdsDocument.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
