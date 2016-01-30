unit NavigationInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NavigationInterfaces.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentInterfaces
 , ExternalOperationUnit
 , nevNavigation
 , DocumentUnit
;

type
 TbsProcessHyperLinkBehaviour = (
  phbInSameContainer
  , phbInNewTabNoActivate
  , phbInNewTabActivate
  , phbInNewWindow
 );//TbsProcessHyperLinkBehaviour

 InsOpenDocOnNumberData = interface
  {* Данные для открытия документа по номеру }
  ['{2892E567-2A20-435A-92CB-E234BAF0E258}']
  function Get_DocID: Integer;
  procedure Set_DocID(aValue: Integer);
  function Get_PosID: Integer;
  procedure Set_PosID(aValue: Integer);
  function Get_Internal: Boolean;
  procedure Set_Internal(aValue: Boolean);
  function Get_History: Il3CString;
  procedure Set_History(const aValue: Il3CString);
  function Get_Done: Boolean;
  procedure Set_Done(aValue: Boolean);
  function Get_PosType: TDocumentPositionType;
  procedure Set_PosType(aValue: TDocumentPositionType);
  property DocID: Integer
   read Get_DocID
   write Set_DocID;
  property PosID: Integer
   read Get_PosID
   write Set_PosID;
  property Internal: Boolean
   read Get_Internal
   write Set_Internal;
  property History: Il3CString
   read Get_History
   write Set_History;
  property Done: Boolean
   read Get_Done
   write Set_Done;
  property PosType: TDocumentPositionType
   read Get_PosType
   write Set_PosType;
 end;//InsOpenDocOnNumberData

 IbsHyperLinkProcessorHelper = interface
  ['{61BEA4A9-16C3-4533-93D0-67B0AD286DCF}']
  function MakeContainer: IvcmContainer;
   {* Создать параметры на которых будут делаться вызовы операций }
  function MakeNewMainWindow: IvcmContainer;
   {* Открыть новое главное окно и вернуть параметры для него }
  function ProcessExternalOperation(const anOperation: IExternalOperation): Boolean;
  procedure CheckLinkInfo(const aLink: IevHyperlink);
  function MakeLinkDocInfo(const aDocument: IDocument;
   aPointType: TDocumentPositionType;
   aSub: Cardinal): IdeDocInfo;
  function ProcessLocalLink(const aDocument: IDocument;
   aPointType: TDocumentPositionType;
   aSub: Cardinal;
   aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
  function ProcessGlobalLink(const aDocument: IDocument;
   aPointType: TDocumentPositionType;
   aSub: Cardinal;
   aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
  function MakeTabbedContainer(aNeedActivate: Boolean): IvcmContainer;
 end;//IbsHyperLinkProcessorHelper
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
