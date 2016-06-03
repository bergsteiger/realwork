unit DocumentInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessingInterfaces\DocumentInterfaces.pas"
// ���������: "ControllerInterfaces"
// ������� ������: "DocumentInterfaces" MUID: (4B1FC2FF03CD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseTypesUnit
 , DynamicDocListUnit
 , DocumentUnit
 , DynamicTreeUnit
 , l3Interfaces
 , k2Interfaces
 , nevBase
 , l3TreeInterfaces
 , bsTypes
 , AdapterFacade
 , PrimPrimListInterfaces
 , bsTypesNew
 , nsTypes
 , l3Variant
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IdeDocInfo = interface
  {* ��������� ������ ������� ��� ����� "TextForm" }
  ['{C3CFEB22-87D2-4A74-AA0F-A1F93B2D22D4}']
  function pm_GetDoc: IDocument;
  procedure pm_SetDoc(const aValue: IDocument);
  function pm_GetDocumentState: IDocumentState;
  function pm_GetPos: TbsDocPos;
  procedure pm_SetPos(const aValue: TbsDocPos);
  function pm_GetLanguage: TbsLanguage;
  function pm_GetList: IDynList;
  function pm_GetListNode: INodeBase;
  function pm_GetDocName: Il3CString;
  function pm_GetDocShortName: Il3CString;
  function pm_GetCurEditionName: Il3CString;
  function pm_GetDataSize: Il3CString;
  function pm_GetInternalNumber: Il3CString;
  function pm_GetListRoot: INodeBase;
  function Get_DocType: TDocumentType;
  function pm_GetSearchInfo: IdeSearchInfo;
  procedure pm_SetSearchInfo(const aValue: IdeSearchInfo);
  function pm_GetFilePosition: Il3CString;
  function IsSame(const aDocInfo: IdeDocInfo;
   aView: Boolean = True;
   aPosition: Boolean = True): Boolean;
   {* �������� ���������.
           - aView: ���������� ��������� ���������� � ������ �� ��������� (�
                    ������� �� is_same_entity, ������� ���������� ��������� ���
                    ����� ���������). ���������� ��������� �������� ������������
                    ������ ��������, ����� � ������ ����������.
           - aPosition: ���������� � ������ �������. }
  procedure SetPosition(const aPos: TbsDocPos);
  function ChangeRedaction(aChangeType: TnsChangeRedactionType;
   aRedaction: TRedactionID = 0): Boolean; overload;
  function ChangeRedaction(const aDate: AdapterDate): Boolean; overload;
  function ChangeRedaction(const aDocument: IDocument): Boolean; overload;
  procedure InitListNode(const aRoot: INodeBase;
   const aListNode: INodeBase);
   {* �������� ����������� �� ������ }
  procedure CorrectLanguage(aLanguage: TbsLanguage);
  function Clone: IdeDocInfo;
  procedure ClearListNode;
   {* http://mdp.garant.ru/pages/viewpage.action?pageId=124453871&focusedCommentId=173507098#comment-173507098 }
  property Doc: IDocument
   read pm_GetDoc
   write pm_SetDoc;
   {* �������� }
  property DocumentState: IDocumentState
   read pm_GetDocumentState;
   {* ��������� ��������� }
  property Pos: TbsDocPos
   read pm_GetPos
   write pm_SetPos;
   {* ������� � ��������� }
  property Language: TbsLanguage
   read pm_GetLanguage;
   {* ������������ ���� }
  property List: IDynList
   read pm_GetList;
   {* ������ �� �������� ��� ������ �������� }
  property ListNode: INodeBase
   read pm_GetListNode;
   {* ��� ��������� �� �����������/���������� }
  property DocName: Il3CString
   read pm_GetDocName;
   {* ��� �������� ��������� }
  property DocShortName: Il3CString
   read pm_GetDocShortName;
   {* �������� ��� �������� ��������� }
  property CurEditionName: Il3CString
   read pm_GetCurEditionName;
   {* ��� ������� �������� ��������� }
  property DataSize: Il3CString
   read pm_GetDataSize;
   {* ������ ��������� � ������ }
  property InternalNumber: Il3CString
   read pm_GetInternalNumber;
   {* ���������� ����� ��������� }
  property ListRoot: INodeBase
   read pm_GetListRoot;
   {* root ������ �� �������� ������� �������� }
  property DocType: TDocumentType
   read Get_DocType;
   {* ��� ��������� }
  property SearchInfo: IdeSearchInfo
   read pm_GetSearchInfo
   write pm_SetSearchInfo;
   {* ���������� � �������, �� �������� ��� �������� �������� }
  property FilePosition: Il3CString
   read pm_GetFilePosition;
   {* ������� ��������� � �������� NSRC }
 end;//IdeDocInfo

 IbsDocumentContainer = interface
  {* ��������� ���������. ������������ ���������� ��������� ��������� }
  ['{0B1937A7-9897-4E21-93D0-D63A5745AEB9}']
  function pm_GetDocument: IDocument;
  procedure pm_SetDocument(const aValue: IDocument);
  function pm_GetIsInited: Boolean;
  function Clone: IbsDocumentContainer;
  function IsSame(const aContainer: IbsDocumentContainer;
   aView: Boolean = True): Boolean;
  property Document: IDocument
   read pm_GetDocument
   write pm_SetDocument;
  property IsInited: Boolean
   read pm_GetIsInited;
 end;//IbsDocumentContainer

 InsContentsTree = interface
  ['{FB0904B7-EA27-46A0-8545-7507EC8AD1F0}']
  function FindBlock(aBlockID: Integer): Il3SimpleNode;
  function NeedResetRoot: Boolean;
  procedure ResetRoot(aDocument: Tl3Tag;
   const aRoot: Il3SimpleRootNode);
  function RootResetted: Boolean;
  procedure DataReceived;
 end;//InsContentsTree

 (*
 MdeDocInfoProvider = interface
  function pm_GetDocInfo: IdeDocInfo;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
 end;//MdeDocInfoProvider
 *)

 IdeDocInfoProvider = interface
  {* ��������� IdeDocInfo }
  ['{38058CC5-F414-43B6-9002-7804C1555544}']
  function pm_GetDocInfo: IdeDocInfo;
  property DocInfo: IdeDocInfo
   read pm_GetDocInfo;
 end;//IdeDocInfoProvider
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
