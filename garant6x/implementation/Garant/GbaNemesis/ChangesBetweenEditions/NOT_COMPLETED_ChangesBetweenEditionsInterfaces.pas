unit NOT_COMPLETED_ChangesBetweenEditionsInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\NOT_COMPLETED_ChangesBetweenEditionsInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "ChangesBetweenEditionsInterfaces" MUID: (4DDCD71E027C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , DocumentAndListInterfaces
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MnsEditionsHolder = interface
  function Get_RightEdition: IDocument;
  function Get_LeftEdition: IDocument;
  property RightEdition: IDocument
   read Get_RightEdition;
   {* Правая редакция }
  property LeftEdition: IDocument
   read Get_LeftEdition;
   {* Левая редакция }
 end;//MnsEditionsHolder
 *)

type
 IdsChangesBetweenEditions = interface(IvcmViewAreaController)
  ['{2D74CBC5-124E-4777-A6CA-891E3037761E}']
  function Get_DocumentContainer: InevDocumentContainer;
  function pm_GetDocInfo: IdeDocInfo;
  function Get_RightEdition: IDocument;
  function Get_LeftEdition: IDocument;
  property DocumentContainer: InevDocumentContainer
   read Get_DocumentContainer;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
  property RightEdition: IDocument
   read Get_RightEdition;
   {* Правая редакция }
  property LeftEdition: IDocument
   read Get_LeftEdition;
   {* Левая редакция }
 end;//IdsChangesBetweenEditions

 InsChangesBetweenEditionsInfo = interface
  ['{66611345-5B71-4A0D-863D-C2903B8296A9}']
  function Get_DiffProvider: IDiffDocDataProvider;
  function Get_RightEdition: IDocument;
  function Get_LeftEdition: IDocument;
  property DiffProvider: IDiffDocDataProvider
   read Get_DiffProvider;
  property RightEdition: IDocument
   read Get_RightEdition;
   {* Правая редакция }
  property LeftEdition: IDocument
   read Get_LeftEdition;
   {* Левая редакция }
 end;//InsChangesBetweenEditionsInfo

 IsdsChangesBetweenEditionsData = interface(IvcmData)
  ['{840AD10B-834F-49F5-B4BC-521EE38DB3AA}']
  function Get_Info: InsChangesBetweenEditionsInfo;
  property Info: InsChangesBetweenEditionsInfo
   read Get_Info;
 end;//IsdsChangesBetweenEditionsData

 IsdsChangesBetweenEditions = interface(IvcmUseCaseController)
  {* Прецедент ОИД }
  ['{CEB84047-C17B-48F3-BEA2-191D90F3BBE6}']
  function pm_GetChanges: IdsChangesBetweenEditions;
  function As_IsdsPrimDocument: IsdsPrimDocument;
   {* Метод приведения нашего интерфейса к IsdsPrimDocument }
  function As_IsdsEditionsHolder: IsdsEditionsHolder;
   {* Метод приведения нашего интерфейса к IsdsEditionsHolder }
  property Changes: IdsChangesBetweenEditions
   read pm_GetChanges;
 end;//IsdsChangesBetweenEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
