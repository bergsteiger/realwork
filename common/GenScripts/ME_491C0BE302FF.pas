unit deDocInfo;
 {* Интерфейс обмена данными для бизнес объекта "TextForm" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\deDocInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeDocInfo" MUID: (491C0BE302FF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , deBase
 , l3Interfaces
 , DocumentInterfaces
 , bsTypesNew
 , bsTypes
 , DynamicDocListUnit
 , DynamicTreeUnit
 , nsRootManager
 , PrimPrimListInterfaces
 , DocumentUnit
 , l3IID
 , nsTypes
 , AdapterFacade
;

type
 TnsListInfo = object
  public
   rList: IDynList;
   rListNode: INodeBase;
   rListRoot: INodeBase;
   rCorrectByTimeMachine: Boolean;
   rSearchInfo: IdeSearchInfo;
 end;//TnsListInfo

 TdeDocInfo = class(TdeBase, Il3ItemNotifyRecipient, IdeDocInfo)
  {* Интерфейс обмена данными для бизнес объекта "TextForm" }
  private
   f_Pos: TbsDocPos;
   f_Language: TbsLanguage;
   f_List: IDynList;
   f_ListNode: INodeBase;
   f_CorrectByTimeMachine: Boolean;
   f_DocInited: Boolean;
   f_QueryInfo: IdeSearchInfo;
   f_DocContainer: IbsDocumentContainer;
   f_RootManager: TnsRootManager;
  private
   procedure ResetListChildrenCount;
   procedure MakeCurrentState;
    {* устанавливаем состояние документа }
  protected
   function pm_GetDocContainer: IbsDocumentContainer;
   function pm_GetRootManager: TnsRootManager;
   function DefaultDocType: TDocumentType; virtual;
   procedure AssignFromClone(const aData: IdeDocInfo); virtual;
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   function IsSame(const aDocInfo: IdeDocInfo;
    aView: Boolean = True;
    aPosition: Boolean = True): Boolean;
    {* сравнить документы.
           - aView: возвращает равенство документов с учетом их состояния (в
                    отличии от is_same_entity, который возвращает равенство без
                    учета состояния). Состоянием документа является суперпозиция
                    номера редакции, языка и списка извлечений.
           - aPosition: сравнивать с учетом позиций. }
   procedure SetPosition(const aPos: TbsDocPos);
   function ChangeRedaction(aChangeType: TnsChangeRedactionType;
    aRedaction: TRedactionID = 0): Boolean; overload;
   function ChangeRedaction(const aDate: AdapterDate): Boolean; overload;
   function ChangeRedaction(const aDocument: IDocument): Boolean; overload;
   procedure InitListNode(const aRoot: INodeBase;
    const aListNode: INodeBase);
    {* документ открывается из списка }
   procedure CorrectLanguage(aLanguage: TbsLanguage);
   function Clone: IdeDocInfo;
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
   procedure ClearListNode;
    {* http://mdp.garant.ru/pages/viewpage.action?pageId=124453871&focusedCommentId=173507098#comment-173507098 }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure ClearFields; override;
  public
   constructor CreateCloned(const aDocInfo: IdeDocInfo); reintroduce;
   constructor Create(const aDoc: IbsDocumentContainer;
    const aList: TnsListInfo;
    const aPos: TbsDocPos;
    aLanguage: TbsLanguage); reintroduce; overload;
   constructor Create(const aDoc: IbsDocumentContainer;
    const aPos: TbsDocPos;
    aLanguage: TbsLanguage); reintroduce; overload;
   class function Make(const aDoc: IDocument;
    const aPos: TbsDocPos;
    aLanguage: TbsLanguage = bsTypes.LG_RUSSIAN): IdeDocInfo; overload;
   class function Make: IdeDocInfo; overload;
   class function Make(const aDoc: IbsDocumentContainer;
    const aPos: TbsDocPos;
    aLanguage: TbsLanguage): IdeDocInfo; reintroduce; overload;
   constructor Create(const aDoc: IbsDocumentContainer); reintroduce; overload;
   class function Make(const aDoc: IbsDocumentContainer): IdeDocInfo; reintroduce; overload;
   class function Make(const aDoc: IDocument): IdeDocInfo; overload;
   class function MakeFromList(const aDoc: IbsDocumentContainer;
    const aList: TnsListInfo;
    const aPos: TbsDocPos;
    aLanguage: TbsLanguage): IdeDocInfo; reintroduce;
  protected
   property DocContainer: IbsDocumentContainer
    read pm_GetDocContainer;
   property RootManager: TnsRootManager
    read pm_GetRootManager;
 end;//TdeDocInfo

function TnsListInfo_C(const aList: IDynList;
 const aListNode: INodeBase;
 const aListRoot: INodeBase;
 aCorrectByTimeMachine: Boolean;
 const aSearchInfo: IdeSearchInfo): TnsListInfo;
function TnsListInfo_E: TnsListInfo;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Bits
 , IOUnit
 , bsUtils
 , DataAdapter
 , l3Base
 , afwFacade
 , BaseTypesUnit
 , bsDataContainer
;

function TnsListInfo_C(const aList: IDynList;
 const aListNode: INodeBase;
 const aListRoot: INodeBase;
 aCorrectByTimeMachine: Boolean;
 const aSearchInfo: IdeSearchInfo): TnsListInfo;
//#UC START# *4BA7913300CB_4BA7907A03C2_var*
//#UC END# *4BA7913300CB_4BA7907A03C2_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4BA7913300CB_4BA7907A03C2_impl*
 Result.rList := aList;
 Result.rListNode := aListNode;
 Result.rListRoot := aListRoot;
 Result.rCorrectByTimeMachine := aCorrectByTimeMachine;
 Result.rSearchInfo := aSearchInfo;
//#UC END# *4BA7913300CB_4BA7907A03C2_impl*
end;//TnsListInfo_C

function TnsListInfo_E: TnsListInfo;
//#UC START# *4BA7923F0214_4BA7907A03C2_var*
//#UC END# *4BA7923F0214_4BA7907A03C2_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4BA7923F0214_4BA7907A03C2_impl*
//#UC END# *4BA7923F0214_4BA7907A03C2_impl*
end;//TnsListInfo_E

function TdeDocInfo.pm_GetDocContainer: IbsDocumentContainer;
//#UC START# *4B1E7334015A_491C0BE302FFget_var*
//#UC END# *4B1E7334015A_491C0BE302FFget_var*
begin
//#UC START# *4B1E7334015A_491C0BE302FFget_impl*
 if (f_DocContainer = nil) then
  f_DocContainer := TbsDocumentContainer.Make(nil);
 Result := f_DocContainer;
//#UC END# *4B1E7334015A_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetDocContainer

function TdeDocInfo.pm_GetRootManager: TnsRootManager;
//#UC START# *4B1E73F20247_491C0BE302FFget_var*
//#UC END# *4B1E73F20247_491C0BE302FFget_var*
begin
//#UC START# *4B1E73F20247_491C0BE302FFget_impl*
 if f_RootManager = nil then
 begin
  f_RootManager := TnsRootManager.Create;
  Il3ChangeNotifier(f_RootManager).Subscribe(Il3ItemNotifyRecipient(Self));
 end;//if f_RootManager = nil then
 Result := f_RootManager;
//#UC END# *4B1E73F20247_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetRootManager

constructor TdeDocInfo.CreateCloned(const aDocInfo: IdeDocInfo);
//#UC START# *4B1E74D10031_491C0BE302FF_var*
var
 l_Source : IbsDocumentContainer;
 l_Dest   : IbsDocumentContainer;
//#UC END# *4B1E74D10031_491C0BE302FF_var*
begin
//#UC START# *4B1E74D10031_491C0BE302FF_impl*
 with aDocInfo do
 begin
  if Supports(aDocInfo, IbsDocumentContainer, l_Source) then
  begin
   l_Dest := l_Source.Clone;
   Assert(l_Dest <> nil);
   Create(l_Dest,
          TnsListInfo_C(List,
                        ListNode,
                        ListRoot,
                        false,
                        SearchInfo),
          Pos,
          Language
          );
   AssignFromClone(aDocInfo);
  end//if Supports(aDocInfo, ...
  else
   Assert(False);
 end//with aDocInfo do
//#UC END# *4B1E74D10031_491C0BE302FF_impl*
end;//TdeDocInfo.CreateCloned

constructor TdeDocInfo.Create(const aDoc: IbsDocumentContainer;
 const aList: TnsListInfo;
 const aPos: TbsDocPos;
 aLanguage: TbsLanguage);
//#UC START# *4B1E75C802B9_491C0BE302FF_var*
//#UC END# *4B1E75C802B9_491C0BE302FF_var*
begin
//#UC START# *4B1E75C802B9_491C0BE302FF_impl*
 inherited Create;
 f_DocInited := False;
 f_DocContainer := aDoc;
 f_List := aList.rList;
 SetPosition(aPos);
 f_Language := aLanguage;
 f_ListNode := aList.rListNode;
 RootManager.RootNode := aList.rListRoot;
 f_CorrectByTimeMachine := aList.rCorrectByTimeMachine;
 f_QueryInfo := aList.rSearchInfo;
//#UC END# *4B1E75C802B9_491C0BE302FF_impl*
end;//TdeDocInfo.Create

constructor TdeDocInfo.Create(const aDoc: IbsDocumentContainer;
 const aPos: TbsDocPos;
 aLanguage: TbsLanguage);
//#UC START# *4B1E8B8B003B_491C0BE302FF_var*
//#UC END# *4B1E8B8B003B_491C0BE302FF_var*
begin
//#UC START# *4B1E8B8B003B_491C0BE302FF_impl*
 Create(aDoc, TnsListInfo_E, aPos, aLanguage);
//#UC END# *4B1E8B8B003B_491C0BE302FF_impl*
end;//TdeDocInfo.Create

class function TdeDocInfo.Make(const aDoc: IDocument;
 const aPos: TbsDocPos;
 aLanguage: TbsLanguage = bsTypes.LG_RUSSIAN): IdeDocInfo;
//#UC START# *4B1E76F30227_491C0BE302FF_var*
//#UC END# *4B1E76F30227_491C0BE302FF_var*
begin
//#UC START# *4B1E76F30227_491C0BE302FF_impl*
 Result := Make(TbsDocumentContainer.Make(aDoc),
                aPos,
                aLanguage);
//#UC END# *4B1E76F30227_491C0BE302FF_impl*
end;//TdeDocInfo.Make

class function TdeDocInfo.Make: IdeDocInfo;
//#UC START# *4B1E772503CC_491C0BE302FF_var*
//#UC END# *4B1E772503CC_491C0BE302FF_var*
begin
//#UC START# *4B1E772503CC_491C0BE302FF_impl*
 Result := Make(TbsDocumentContainer.Make(nil));
//#UC END# *4B1E772503CC_491C0BE302FF_impl*
end;//TdeDocInfo.Make

procedure TdeDocInfo.ResetListChildrenCount;
//#UC START# *4B1E8576014C_491C0BE302FF_var*
//#UC END# *4B1E8576014C_491C0BE302FF_var*
begin
//#UC START# *4B1E8576014C_491C0BE302FF_impl*
 f_ListNode := nil;
//#UC END# *4B1E8576014C_491C0BE302FF_impl*
end;//TdeDocInfo.ResetListChildrenCount

class function TdeDocInfo.Make(const aDoc: IbsDocumentContainer;
 const aPos: TbsDocPos;
 aLanguage: TbsLanguage): IdeDocInfo;
var
 l_Inst : TdeDocInfo;
begin
 l_Inst := Create(aDoc, aPos, aLanguage);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeDocInfo.Make

procedure TdeDocInfo.MakeCurrentState;
 {* устанавливаем состояние документа }
//#UC START# *4B1E8E050028_491C0BE302FF_var*
var
 l_State : IDocumentState;
 l_Doc   : IDocument;
//#UC END# *4B1E8E050028_491C0BE302FF_var*
begin
//#UC START# *4B1E8E050028_491C0BE302FF_impl*
 if DocContainer.Document <> nil then
 begin
  DocContainer.Document.GetCurrentState(l_State);
  l_State.SetLanguage(f_Language);
  DocContainer.Document.CreateView(l_State, l_Doc);
  if l_Doc <> nil then // документ поменялся
   DocContainer.Document := l_Doc;
 end;//if Document <> nil then
//#UC END# *4B1E8E050028_491C0BE302FF_impl*
end;//TdeDocInfo.MakeCurrentState

constructor TdeDocInfo.Create(const aDoc: IbsDocumentContainer);
//#UC START# *4BA755510355_491C0BE302FF_var*
//#UC END# *4BA755510355_491C0BE302FF_var*
begin
//#UC START# *4BA755510355_491C0BE302FF_impl*
 Create(aDoc, TbsDocPos_E, LG_RUSSIAN);
//#UC END# *4BA755510355_491C0BE302FF_impl*
end;//TdeDocInfo.Create

class function TdeDocInfo.Make(const aDoc: IbsDocumentContainer): IdeDocInfo;
var
 l_Inst : TdeDocInfo;
begin
 l_Inst := Create(aDoc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeDocInfo.Make

class function TdeDocInfo.Make(const aDoc: IDocument): IdeDocInfo;
//#UC START# *4BA78A8E027E_491C0BE302FF_var*
//#UC END# *4BA78A8E027E_491C0BE302FF_var*
begin
//#UC START# *4BA78A8E027E_491C0BE302FF_impl*
 Result := Make(aDoc, TbsDocPos_E);
//#UC END# *4BA78A8E027E_491C0BE302FF_impl*
end;//TdeDocInfo.Make

class function TdeDocInfo.MakeFromList(const aDoc: IbsDocumentContainer;
 const aList: TnsListInfo;
 const aPos: TbsDocPos;
 aLanguage: TbsLanguage): IdeDocInfo;
var
 l_Inst : TdeDocInfo;
begin
 l_Inst := Create(aDoc, aList, aPos, aLanguage);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeDocInfo.MakeFromList

function TdeDocInfo.DefaultDocType: TDocumentType;
//#UC START# *4B1E714A0125_491C0BE302FF_var*
//#UC END# *4B1E714A0125_491C0BE302FF_var*
begin
//#UC START# *4B1E714A0125_491C0BE302FF_impl*
 Result := DT_DOCUMENT;
//#UC END# *4B1E714A0125_491C0BE302FF_impl*
end;//TdeDocInfo.DefaultDocType

procedure TdeDocInfo.AssignFromClone(const aData: IdeDocInfo);
//#UC START# *4B1E749D033C_491C0BE302FF_var*
//#UC END# *4B1E749D033C_491C0BE302FF_var*
begin
//#UC START# *4B1E749D033C_491C0BE302FF_impl*
 InitListNode(aData.ListRoot, aData.ListNode);
//#UC END# *4B1E749D033C_491C0BE302FF_impl*
end;//TdeDocInfo.AssignFromClone

procedure TdeDocInfo.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_491C0BE302FF_var*
//#UC END# *46A4504B03C4_491C0BE302FF_var*
begin
//#UC START# *46A4504B03C4_491C0BE302FF_impl*
 if (aOperation = nne_ResetChildrenCount) then
  ResetListChildrenCount;
//#UC END# *46A4504B03C4_491C0BE302FF_impl*
end;//TdeDocInfo.Notify

function TdeDocInfo.IsSame(const aDocInfo: IdeDocInfo;
 aView: Boolean = True;
 aPosition: Boolean = True): Boolean;
 {* сравнить документы.
           - aView: возвращает равенство документов с учетом их состояния (в
                    отличии от is_same_entity, который возвращает равенство без
                    учета состояния). Состоянием документа является суперпозиция
                    номера редакции, языка и списка извлечений.
           - aPosition: сравнивать с учетом позиций. }
//#UC START# *4B1D118000EA_491C0BE302FF_var*
var
 l_DC: IbsDocumentContainer;

  function lp_CheckView: Boolean;
  begin
   Result := l_DC.IsSame(DocContainer, aView) and
            (not aPosition or f_Pos.EQ(aDocInfo.Pos));
  end;//lp_CheckView

//#UC END# *4B1D118000EA_491C0BE302FF_var*
begin
//#UC START# *4B1D118000EA_491C0BE302FF_impl*
 Result := Assigned(aDocInfo) and
           Supports(aDocInfo, IbsDocumentContainer, l_DC) and
           l_DC.IsSame(DocContainer) and ((aView and lp_CheckView) or
           (not aView and l_DC.IsSame(DocContainer, aView)));
//#UC END# *4B1D118000EA_491C0BE302FF_impl*
end;//TdeDocInfo.IsSame

procedure TdeDocInfo.SetPosition(const aPos: TbsDocPos);
//#UC START# *4B1D11B00164_491C0BE302FF_var*
//#UC END# *4B1D11B00164_491C0BE302FF_var*
begin
//#UC START# *4B1D11B00164_491C0BE302FF_impl*
 f_Pos := aPos;
 if (f_Pos.rRefType = dptSub) then
 begin
  if (f_Pos.rPos AND POSITION_TYPE_MASK = POSITION_TYPE_PARA_ID) then
  begin
   Assert(false, 'Это должно делаться в базовом объекте');
   f_Pos.rRefType := dptPara;
  end;//f_Pos.rPos AND POSITION_TYPE_MASK = POSITION_TYPE_PARA_ID
  l3ClearMask(Integer(f_Pos.rPos), Integer(POSITION_TYPE_MASK));
 end;//fRefType = dptSub
//#UC END# *4B1D11B00164_491C0BE302FF_impl*
end;//TdeDocInfo.SetPosition

function TdeDocInfo.ChangeRedaction(aChangeType: TnsChangeRedactionType;
 aRedaction: TRedactionID = 0): Boolean;
//#UC START# *4B1D11CF0265_491C0BE302FF_var*
var
 l_State : IDocumentState;
 l_Doc   : IDocument;
//#UC END# *4B1D11CF0265_491C0BE302FF_var*
begin
//#UC START# *4B1D11CF0265_491C0BE302FF_impl*
 Result := False;
 if pm_GetDoc <> nil then
 begin
  pm_GetDoc.GetCurrentState(l_State);
  try
   case aChangeType of
    crtActual:
     l_State.SetActualRedaction;
    crtPrevious:
     l_State.SetPrevRedaction;
    crtNext:
     l_State.SetNextRedaction;
    crtID:
     l_State.SetRedactionOnId(aRedaction);
   end;//case aChangeType of
   pm_GetDoc.CreateView(l_State, l_Doc);
   // документ поменялся
   if Assigned(l_Doc) then
   begin
    DocContainer.Document := l_Doc;
    Result := True;
   end;
  except
   on ERedactionNotFound do
  end;{try..except}
 end;//if pm_GetDoc <> nil then
//#UC END# *4B1D11CF0265_491C0BE302FF_impl*
end;//TdeDocInfo.ChangeRedaction

function TdeDocInfo.ChangeRedaction(const aDate: AdapterDate): Boolean;
//#UC START# *4B1D11E00385_491C0BE302FF_var*
var
 l_State : IDocumentState;
 l_Doc   : IDocument;
//#UC END# *4B1D11E00385_491C0BE302FF_var*
begin
//#UC START# *4B1D11E00385_491C0BE302FF_impl*
 Result := False;
 if (pm_GetDoc <> nil) then
 begin
  pm_GetDoc.GetCurrentState(l_State);
  try
   try
    l_State.SetRedactionOnDate(aDate);
    pm_GetDoc.CreateView(l_State, l_Doc);
    // документ поменялся
    if Assigned(l_Doc) then
    begin
     DocContainer.Document := l_Doc;
     Result := True;
    end;
   except
    on ERedactionNotFound do
   end;{try..except}
  finally
   l_State := nil;
  end;{try..finally}
 end;//if pm_GetDoc <> nil then
//#UC END# *4B1D11E00385_491C0BE302FF_impl*
end;//TdeDocInfo.ChangeRedaction

function TdeDocInfo.ChangeRedaction(const aDocument: IDocument): Boolean;
//#UC START# *4B1D11F0033E_491C0BE302FF_var*
//#UC END# *4B1D11F0033E_491C0BE302FF_var*
begin
//#UC START# *4B1D11F0033E_491C0BE302FF_impl*
 if (pm_GetDoc = nil) or pm_GetDoc.IsSameDocument(aDocument) then
 begin
  DocContainer.Document := aDocument;
  Result := True;
 end//if not Assigned(f_DocContainer)
 else
  Result := False;
//#UC END# *4B1D11F0033E_491C0BE302FF_impl*
end;//TdeDocInfo.ChangeRedaction

procedure TdeDocInfo.InitListNode(const aRoot: INodeBase;
 const aListNode: INodeBase);
 {* документ открывается из списка }
//#UC START# *4B1D11FE0117_491C0BE302FF_var*
//#UC END# *4B1D11FE0117_491C0BE302FF_var*
begin
//#UC START# *4B1D11FE0117_491C0BE302FF_impl*
 RootManager.RootNode := aRoot;
 f_ListNode := aListNode;
//#UC END# *4B1D11FE0117_491C0BE302FF_impl*
end;//TdeDocInfo.InitListNode

procedure TdeDocInfo.CorrectLanguage(aLanguage: TbsLanguage);
//#UC START# *4B1D121B03D0_491C0BE302FF_var*
//#UC END# *4B1D121B03D0_491C0BE302FF_var*
begin
//#UC START# *4B1D121B03D0_491C0BE302FF_impl*
 f_Language := aLanguage;
//#UC END# *4B1D121B03D0_491C0BE302FF_impl*
end;//TdeDocInfo.CorrectLanguage

function TdeDocInfo.Clone: IdeDocInfo;
//#UC START# *4B1D12260038_491C0BE302FF_var*
type
 RdeDocInfo = class of TdeDocInfo;
var
 l_Temp: TdeDocInfo;
//#UC END# *4B1D12260038_491C0BE302FF_var*
begin
//#UC START# *4B1D12260038_491C0BE302FF_impl*
 if Self = nil then
  Result := nil
 else
 begin
  l_Temp := RdeDocInfo(ClassType).CreateCloned(Self);
  try
   Result := l_Temp;
  finally
   FreeAndNil(l_Temp);
  end;
 end;
//#UC END# *4B1D12260038_491C0BE302FF_impl*
end;//TdeDocInfo.Clone

function TdeDocInfo.pm_GetDoc: IDocument;
//#UC START# *4B1D126203E6_491C0BE302FFget_var*
//#UC END# *4B1D126203E6_491C0BE302FFget_var*
begin
//#UC START# *4B1D126203E6_491C0BE302FFget_impl*
 if not f_DocInited then
 begin
  f_DocInited := True;
   // - установим флаг, чтобы дальнейшие вызовы pm_GetDoc не привели к
   //   зацикливанию;
  if (DocContainer.Document <> nil) and f_CorrectByTimeMachine then
   DocContainer.Document := DefDataAdapter.TimeMachine.
    CorrectDocumentEdition(DocContainer.Document);
  MakeCurrentState;
 end;//not f_DocInited
 Result := DocContainer.Document;
//#UC END# *4B1D126203E6_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetDoc

procedure TdeDocInfo.pm_SetDoc(const aValue: IDocument);
//#UC START# *4B1D126203E6_491C0BE302FFset_var*
//#UC END# *4B1D126203E6_491C0BE302FFset_var*
begin
//#UC START# *4B1D126203E6_491C0BE302FFset_impl*
 DocContainer.Document := aValue;
 MakeCurrentState;
//#UC END# *4B1D126203E6_491C0BE302FFset_impl*
end;//TdeDocInfo.pm_SetDoc

function TdeDocInfo.pm_GetDocumentState: IDocumentState;
//#UC START# *4B1D127600DC_491C0BE302FFget_var*
//#UC END# *4B1D127600DC_491C0BE302FFget_var*
begin
//#UC START# *4B1D127600DC_491C0BE302FFget_impl*
 if pm_GetDoc <> nil then
  pm_GetDoc.GetCurrentState(Result)
 else
  Result := nil;
//#UC END# *4B1D127600DC_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetDocumentState

function TdeDocInfo.pm_GetPos: TbsDocPos;
//#UC START# *4B1D12A30083_491C0BE302FFget_var*
//#UC END# *4B1D12A30083_491C0BE302FFget_var*
begin
//#UC START# *4B1D12A30083_491C0BE302FFget_impl*
 Result := f_Pos;
//#UC END# *4B1D12A30083_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetPos

procedure TdeDocInfo.pm_SetPos(const aValue: TbsDocPos);
//#UC START# *4B1D12A30083_491C0BE302FFset_var*
//#UC END# *4B1D12A30083_491C0BE302FFset_var*
begin
//#UC START# *4B1D12A30083_491C0BE302FFset_impl*
 SetPosition(aValue);
//#UC END# *4B1D12A30083_491C0BE302FFset_impl*
end;//TdeDocInfo.pm_SetPos

function TdeDocInfo.pm_GetLanguage: TbsLanguage;
//#UC START# *4B1D12C103CC_491C0BE302FFget_var*
var
 l_State: IDocumentState;
//#UC END# *4B1D12C103CC_491C0BE302FFget_var*
begin
//#UC START# *4B1D12C103CC_491C0BE302FFget_impl*
 if pm_GetDoc <> nil then
 begin
  pm_GetDoc.GetCurrentState(l_State);
  try
   Result := l_State.GetLanguage;
  finally
   l_State:= nil;
  end;{try..finally}
 end//if pm_GetDoc <> nil then
 else
  Result := LG_RUSSIAN;
//#UC END# *4B1D12C103CC_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetLanguage

function TdeDocInfo.pm_GetList: IDynList;
//#UC START# *4B1D12F10074_491C0BE302FFget_var*
//#UC END# *4B1D12F10074_491C0BE302FFget_var*
begin
//#UC START# *4B1D12F10074_491C0BE302FFget_impl*
 Result := f_List;
//#UC END# *4B1D12F10074_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetList

function TdeDocInfo.pm_GetListNode: INodeBase;
//#UC START# *4B1D13200333_491C0BE302FFget_var*
//#UC END# *4B1D13200333_491C0BE302FFget_var*
begin
//#UC START# *4B1D13200333_491C0BE302FFget_impl*
 Result := f_ListNode;
//#UC END# *4B1D13200333_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetListNode

function TdeDocInfo.pm_GetDocName: Il3CString;
//#UC START# *4B1D137202D9_491C0BE302FFget_var*
var
 l_String: IString;
//#UC END# *4B1D137202D9_491C0BE302FFget_var*
begin
//#UC START# *4B1D137202D9_491C0BE302FFget_impl*
 if pm_GetDoc <> nil then
  pm_GetDoc.GetName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
//#UC END# *4B1D137202D9_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetDocName

function TdeDocInfo.pm_GetDocShortName: Il3CString;
//#UC START# *4B1D13AF006C_491C0BE302FFget_var*
var
 l_String: IString;
//#UC END# *4B1D13AF006C_491C0BE302FFget_var*
begin
//#UC START# *4B1D13AF006C_491C0BE302FFget_impl*
 if pm_GetDoc <> nil then
  pm_GetDoc.GetShortName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
//#UC END# *4B1D13AF006C_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetDocShortName

function TdeDocInfo.pm_GetCurEditionName: Il3CString;
//#UC START# *4B1D13C500CA_491C0BE302FFget_var*
var
 l_State : IDocumentState;
 l_Info  : TRedactionInfo;
//#UC END# *4B1D13C500CA_491C0BE302FFget_var*
begin
//#UC START# *4B1D13C500CA_491C0BE302FFget_impl*
 if pm_GetDoc <> nil then
 begin
  pm_GetDoc.GetCurrentState(l_State);
  try
   l3FillChar(l_Info, SizeOf(l_Info), 0);
   l_State.GetCurrentRedaction(l_Info);
   Result := nsCStr(l_Info.rName);
  finally
   l_State := nil;
  end;//try..finally
 end//if pm_GetDoc <> nil then
 else
  Result := nsCStr('');
//#UC END# *4B1D13C500CA_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetCurEditionName

function TdeDocInfo.pm_GetDataSize: Il3CString;
//#UC START# *4B1D13D501CF_491C0BE302FFget_var*
//#UC END# *4B1D13D501CF_491C0BE302FFget_var*
begin
//#UC START# *4B1D13D501CF_491C0BE302FFget_impl*
 if pm_GetDoc <> nil then
 try
  Result := nsCStr(IntToStr(pm_GetDoc.GetSize));
 except
  on ECanNotFindData do
   Result := nsCStr('');
 end//try..except
 else
  Result := nsCStr('');
//#UC END# *4B1D13D501CF_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetDataSize

function TdeDocInfo.pm_GetInternalNumber: Il3CString;
//#UC START# *4B1D13E30017_491C0BE302FFget_var*
//#UC END# *4B1D13E30017_491C0BE302FFget_var*
begin
//#UC START# *4B1D13E30017_491C0BE302FFget_impl*
 if (pm_GetDoc <> nil) and afw.Application.IsInternal then
  try
   Result := nsCStr(IntToStr(pm_GetDoc.GetInternalId));
  except
   on ECanNotFindData do
    Result := nsCStr('');
  end//try..except
 else
  Result := nsCStr('');
//#UC END# *4B1D13E30017_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetInternalNumber

function TdeDocInfo.pm_GetListRoot: INodeBase;
//#UC START# *4B1D142201E3_491C0BE302FFget_var*
//#UC END# *4B1D142201E3_491C0BE302FFget_var*
begin
//#UC START# *4B1D142201E3_491C0BE302FFget_impl*
 Result := RootManager.RootNode;
//#UC END# *4B1D142201E3_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetListRoot

function TdeDocInfo.Get_DocType: TDocumentType;
//#UC START# *4B1D144802C3_491C0BE302FFget_var*
var
 l_Doc: IDocument;
//#UC END# *4B1D144802C3_491C0BE302FFget_var*
begin
//#UC START# *4B1D144802C3_491C0BE302FFget_impl*
 l_Doc := pm_GetDoc;
 if Assigned(l_Doc) then
  Result := l_Doc.GetDocType
 else
  Result := DefaultDocType;
//#UC END# *4B1D144802C3_491C0BE302FFget_impl*
end;//TdeDocInfo.Get_DocType

function TdeDocInfo.pm_GetSearchInfo: IdeSearchInfo;
//#UC START# *4B1D14B701DF_491C0BE302FFget_var*
//#UC END# *4B1D14B701DF_491C0BE302FFget_var*
begin
//#UC START# *4B1D14B701DF_491C0BE302FFget_impl*
 Result := f_QueryInfo;
//#UC END# *4B1D14B701DF_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetSearchInfo

procedure TdeDocInfo.pm_SetSearchInfo(const aValue: IdeSearchInfo);
//#UC START# *4B1D14B701DF_491C0BE302FFset_var*
//#UC END# *4B1D14B701DF_491C0BE302FFset_var*
begin
//#UC START# *4B1D14B701DF_491C0BE302FFset_impl*
 f_QueryInfo := aValue;
//#UC END# *4B1D14B701DF_491C0BE302FFset_impl*
end;//TdeDocInfo.pm_SetSearchInfo

function TdeDocInfo.pm_GetFilePosition: Il3CString;
//#UC START# *4B1D14CE0062_491C0BE302FFget_var*
var
 l_String: IString;
//#UC END# *4B1D14CE0062_491C0BE302FFget_var*
begin
//#UC START# *4B1D14CE0062_491C0BE302FFget_impl*
 if (pm_GetDoc <> nil) and afw.Application.IsInternal then
  try
   pm_GetDoc.GetFilePosition(l_String);
   Result := nsCStr(l_String);
  except
   on ECanNotFindData do
    Result := nsCStr('');
  end//try..except
 else
  Result := nsCStr('');
//#UC END# *4B1D14CE0062_491C0BE302FFget_impl*
end;//TdeDocInfo.pm_GetFilePosition

procedure TdeDocInfo.ClearListNode;
 {* http://mdp.garant.ru/pages/viewpage.action?pageId=124453871&focusedCommentId=173507098#comment-173507098 }
//#UC START# *4B1FA0B003E1_491C0BE302FF_var*
//#UC END# *4B1FA0B003E1_491C0BE302FF_var*
begin
//#UC START# *4B1FA0B003E1_491C0BE302FF_impl*
 f_ListNode := nil;
//#UC END# *4B1FA0B003E1_491C0BE302FF_impl*
end;//TdeDocInfo.ClearListNode

procedure TdeDocInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_491C0BE302FF_var*
//#UC END# *479731C50290_491C0BE302FF_var*
begin
//#UC START# *479731C50290_491C0BE302FF_impl*
 Finalize(f_Pos);
 f_DocContainer := nil;
 f_ListNode := nil;
 if (f_RootManager <> nil) then
  Il3ChangeNotifier(f_RootManager).Unsubscribe(Il3ItemNotifyRecipient(Self));
 FreeAndNil(f_RootManager);
 f_List := nil;
 inherited;
//#UC END# *479731C50290_491C0BE302FF_impl*
end;//TdeDocInfo.Cleanup

function TdeDocInfo.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_491C0BE302FF_var*
//#UC END# *4A60B23E00C3_491C0BE302FF_var*
begin
//#UC START# *4A60B23E00C3_491C0BE302FF_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IbsDocumentContainer) then
  begin
   IbsDocumentContainer(Obj) := DocContainer;
   Result.SetOK;
  end;//if IID.EQ(IbsDocumentContainer) then
//#UC END# *4A60B23E00C3_491C0BE302FF_impl*
end;//TdeDocInfo.COMQueryInterface

procedure TdeDocInfo.ClearFields;
begin
 f_List := nil;
 f_ListNode := nil;
 f_QueryInfo := nil;
 f_DocContainer := nil;
 inherited;
end;//TdeDocInfo.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
