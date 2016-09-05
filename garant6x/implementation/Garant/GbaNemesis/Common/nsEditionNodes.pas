unit nsEditionNodes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsEditionNodes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsEditionNodes" MUID: (4909F71E02EA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , nsNodes
 , l3TreeInterfaces
 , l3Tree_TLB
 , l3IID
 , l3VirtualNode
 , l3Types
 , l3Variant
;

type
 InsDocument = interface
  ['{EF6DC964-DC92-4144-9F95-376CD6936E90}']
  procedure pm_SetDocument(const aValue: IDocument);
  property Document: IDocument
   write pm_SetDocument;
 end;//InsDocument

 TnsEditionNodeCheckType = (
  ns_enctUnchecked
   {* Не выбрана }
  , ns_enctMain
   {* Ведущая }
  , ns_enctAdditional
   {* Дополнительная }
 );//TnsEditionNodeCheckType

 InsEditionsTree = Il3SimpleTree;

 TnsEditionNodeGroupBeginType = (
  {* Тип группы дерева, которую начинает нода }
  ns_gbtNew
   {* Новые редакции }
  , ns_gbtActual
   {* Актуальная редакция }
  , ns_gbtOld
   {* Старые редакции }
  , ns_gbtNone
   {* Нода находится внутри группы }
 );//TnsEditionNodeGroupBeginType

 InsEditionNode = interface
  ['{FD80E9DF-AB62-4C73-AA84-E6AE0274DDA3}']
  function pm_GetEditionID: Integer;
  function pm_GetEditionType: TRedactionType;
  function Get_CheckType: TnsEditionNodeCheckType;
  procedure Set_CheckType(aValue: TnsEditionNodeCheckType);
  function Get_GroupBeginType: TnsEditionNodeGroupBeginType;
  procedure TryMarkAsMain(const aTree: InsEditionsTree);
   {* Пытается пометить ноду, как Ведущую, если ведущих выбрано не было }
  function ReadyForCompare(const aTree: InsEditionsTree): Boolean;
  procedure GetDocumentsForCompare(const aTree: InsEditionsTree;
   out aLeft: IDocument;
   out aRight: IDocument);
  procedure ChangeCheckTypeViaClick(const aTree: InsEditionsTree);
  function IsSameID(aID: Integer): Boolean;
  property EditionID: Integer
   read pm_GetEditionID;
  property EditionType: TRedactionType
   read pm_GetEditionType;
  property CheckType: TnsEditionNodeCheckType
   read Get_CheckType
   write Set_CheckType;
  property GroupBeginType: TnsEditionNodeGroupBeginType
   read Get_GroupBeginType;
 end;//InsEditionNode

 TnsEditionsTreeKind = (
  ns_etkAll
  , ns_etkPrev
  , ns_etkNext
 );//TnsEditionsTreeKind

 TnsEditionsRoot = class(TnsCacheableNode, Il3Wake, InsDocument)
  private
   f_Document: IDocument;
   f_Sleep: Boolean;
   f_OnlyPrevEditions: TnsEditionsTreeKind;
  protected
   function Wake: Boolean;
   function Get_IsSleep: Boolean;
   procedure pm_SetDocument(const aValue: IDocument);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   function ChildNodeClass: Rl3CustomVirtualNode; override;
   procedure ClearFields; override;
  public
   class function Make(const aDocument: IDocument;
    aOnlyPrevEditions: TnsEditionsTreeKind = ns_etkAll): Il3Node; reintroduce;
   class function MakeForPrevEditions(const aDocument: IDocument): Il3Node;
   class function MakeForNextEditions(const aDocument: IDocument): Il3Node;
   constructor Create(const aDocument: IDocument;
    aOnlyPrevEditions: TnsEditionsTreeKind); reintroduce; overload;
   constructor Create(const aDocument: IDocument); reintroduce; overload;
   class function MakeAsSimpleRoot(const aDocument: IDocument): Il3SimpleRootNode; reintroduce;
 end;//TnsEditionsRoot

 TnsEditionNode = class(TnsCacheableNode, InsEditionNode)
  private
   f_Handle: Integer;
   f_EType: TRedactionType;
   f_Presentation: Tl3Tag;
    {* Представление ноды }
   f_CheckType: TnsEditionNodeCheckType;
  private
   function Presentation: Tl3Tag;
   function EditionNumber: Integer;
    {* Номер редакции в списке редакций }
   function HasMainChecked(const aTree: InsEditionsTree): Boolean;
    {* Есть ли уже отмеченная Ведущая редакция }
   procedure UncheckAllAdditional(const aTree: InsEditionsTree);
    {* Снимает выделение со всех Дополнительных редакций (на самом деле - она одна такая) }
   function HasAdditionalChecked(const aTree: InsEditionsTree): Boolean;
  protected
   function IsSameID(aID: Integer): Boolean;
   function pm_GetEditionID: Integer;
   function pm_GetEditionType: TRedactionType;
   function Get_CheckType: TnsEditionNodeCheckType;
   procedure Set_CheckType(aValue: TnsEditionNodeCheckType);
   procedure ChangeCheckTypeViaClick(const aTree: InsEditionsTree);
   procedure TryMarkAsMain(const aTree: InsEditionsTree);
    {* Пытается пометить ноду, как Ведущую, если ведущих выбрано не было }
   function ReadyForCompare(const aTree: InsEditionsTree): Boolean;
   procedure GetDocumentsForCompare(const aTree: InsEditionsTree;
    out aLeft: IDocument;
    out aRight: IDocument);
   function Get_GroupBeginType: TnsEditionNodeGroupBeginType;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   function GetIsSame(const aNode: Il3SimpleNode): Boolean; override;
  public
   constructor Create(aHandle: Integer;
    aEType: TRedactionType); reintroduce;
   class function Make(aHandle: Integer;
    aEType: TRedactionType): Il3Node; reintroduce;
 end;//TnsEditionNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3Base
 , nsTypes
 , SysUtils
 , evNodePainter
 , l3InternalInterfaces
 , TextPara_Const
 , k2Tags
 , evCustomWikiReader
 , l3String
 , evdTypes
 , ControlsBlock_Const
 {$If Defined(Nemesis)}
 , f1TextStyle_Const
 {$IfEnd} // Defined(Nemesis)
 , TextSegment_Const
 , l3Interfaces
 , NodeGroup_Const
 , l3Nodes
 //#UC START# *4909F71E02EAimpl_uses*
 //#UC END# *4909F71E02EAimpl_uses*
;

const
 {* Локализуемые строки EditionNodeGroupCaptions }
 str_engcNew: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'engcNew'; rValue : 'Не вступившие в силу');
  {* 'Не вступившие в силу' }
 str_engcActual: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'engcActual'; rValue : 'Актуальная');
  {* 'Актуальная' }
 str_engcOld: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'engcOld'; rValue : 'Недействующие');
  {* 'Недействующие' }

class function TnsEditionsRoot.Make(const aDocument: IDocument;
 aOnlyPrevEditions: TnsEditionsTreeKind = ns_etkAll): Il3Node;
var
 l_Inst : TnsEditionsRoot;
begin
 l_Inst := Create(aDocument, aOnlyPrevEditions);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsEditionsRoot.Make

class function TnsEditionsRoot.MakeForPrevEditions(const aDocument: IDocument): Il3Node;
//#UC START# *4B1CEAD7018E_492182D60225_var*
//#UC END# *4B1CEAD7018E_492182D60225_var*
begin
//#UC START# *4B1CEAD7018E_492182D60225_impl*
 Result := Make(aDocument, ns_etkPrev);
//#UC END# *4B1CEAD7018E_492182D60225_impl*
end;//TnsEditionsRoot.MakeForPrevEditions

class function TnsEditionsRoot.MakeForNextEditions(const aDocument: IDocument): Il3Node;
//#UC START# *4B55B38301EE_492182D60225_var*
//#UC END# *4B55B38301EE_492182D60225_var*
begin
//#UC START# *4B55B38301EE_492182D60225_impl*
 Result := Make(aDocument, ns_etkNext);
//#UC END# *4B55B38301EE_492182D60225_impl*
end;//TnsEditionsRoot.MakeForNextEditions

constructor TnsEditionsRoot.Create(const aDocument: IDocument;
 aOnlyPrevEditions: TnsEditionsTreeKind);
//#UC START# *4B1CEA1701AC_492182D60225_var*
//#UC END# *4B1CEA1701AC_492182D60225_var*
begin
//#UC START# *4B1CEA1701AC_492182D60225_impl*
 inherited Create(nil, -1, -1);
 f_Document := aDocument;
 f_Sleep := true;
 f_OnlyPrevEditions := aOnlyPrevEditions;
//#UC END# *4B1CEA1701AC_492182D60225_impl*
end;//TnsEditionsRoot.Create

constructor TnsEditionsRoot.Create(const aDocument: IDocument);
//#UC START# *4EC3ED650369_492182D60225_var*
//#UC END# *4EC3ED650369_492182D60225_var*
begin
//#UC START# *4EC3ED650369_492182D60225_impl*
 Create(aDocument, ns_etkAll);
//#UC END# *4EC3ED650369_492182D60225_impl*
end;//TnsEditionsRoot.Create

class function TnsEditionsRoot.MakeAsSimpleRoot(const aDocument: IDocument): Il3SimpleRootNode;
var
 l_Inst : TnsEditionsRoot;
begin
 l_Inst := Create(aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsEditionsRoot.MakeAsSimpleRoot

function TnsEditionsRoot.Wake: Boolean;
//#UC START# *477252760154_492182D60225_var*

 procedure LoadEditionTree(const aRoot: Il3Node; const aDocument: IDocument);
 var
  l_RedactionsList : IRedactionInfoList;
  I                : LongInt;
  l_Child          : Il3Node;
  l_Info           : TRedactionInfo;
  l_State          : IDocumentState;
 begin
  if (aDocument <> nil) then
  begin
   aRoot.Changing;
   try
    Case f_OnlyPrevEditions of
     ns_etkPrev:
     begin
      aDocument.GetCurrentState(l_State);
      l_State.GetPrevRedactionsList(l_RedactionsList);
     end;//ns_etkPrev
     ns_etkNext:
     begin
      aDocument.GetCurrentState(l_State);
      l_State.GetCurAndNextRedactionsList(l_RedactionsList);
     end;//ns_etkNext
     else
      aDocument.GetRedactionsList(l_RedactionsList);
    end;//Case f_OnlyPrevEditions
    if (l_RedactionsList <> nil) then
    // - такого вроде быть не должно, но на всякий случай - проверим
     try
      for I := 0 to Pred(l_RedactionsList.Count) do
      begin
       l_RedactionsList.pm_GetItem(I, l_Info);
       l_Child := aRoot.InsertChild(TnsEditionNode.Make(l_Info.rId, l_Info.rActualType));
       l_Child.Text := nsWStr(l_Info.rName);
      end;//for I
     finally
      l_RedactionsList := nil;
     end;//try..finally
   finally
    aRoot.Changed;
   end;
  end;//aDocument <> nil
 end;

//#UC END# *477252760154_492182D60225_var*
begin
//#UC START# *477252760154_492182D60225_impl*
 if f_Sleep then
 begin
  f_Sleep := false;
  LoadEditionTree(self, f_Document);
  Result := true;
 end//f_Sleep
 else
  Result := false;
//#UC END# *477252760154_492182D60225_impl*
end;//TnsEditionsRoot.Wake

function TnsEditionsRoot.Get_IsSleep: Boolean;
//#UC START# *4772528102DF_492182D60225get_var*
//#UC END# *4772528102DF_492182D60225get_var*
begin
//#UC START# *4772528102DF_492182D60225get_impl*
 Result := f_Sleep;
//#UC END# *4772528102DF_492182D60225get_impl*
end;//TnsEditionsRoot.Get_IsSleep

procedure TnsEditionsRoot.pm_SetDocument(const aValue: IDocument);
//#UC START# *4B1CE65700FD_492182D60225set_var*
//#UC END# *4B1CE65700FD_492182D60225set_var*
begin
//#UC START# *4B1CE65700FD_492182D60225set_impl*
 if (aValue <> nil) then
 begin
  if aValue.IsSameDocument(f_Document) then
   f_Document := aValue
  else
   Assert(false,
          'А когда такое может быть? ' +
          'http://mdp.garant.ru/pages/viewpage.action?pageId=316113759&focusedCommentId=321990712#comment-321990712');
 end//aValue <> nil
 else
  Assert(false,
         'А когда такое может быть? ' +
         'http://mdp.garant.ru/pages/viewpage.action?pageId=316113759&focusedCommentId=321990716&#comment-321990716');
//#UC END# *4B1CE65700FD_492182D60225set_impl*
end;//TnsEditionsRoot.pm_SetDocument

procedure TnsEditionsRoot.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_492182D60225_var*
//#UC END# *479731C50290_492182D60225_var*
begin
//#UC START# *479731C50290_492182D60225_impl*
 f_Document := nil;
 f_Sleep := true;
 inherited;
//#UC END# *479731C50290_492182D60225_impl*
end;//TnsEditionsRoot.Cleanup

procedure TnsEditionsRoot.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_492182D60225_var*
//#UC END# *47A869D10074_492182D60225_var*
begin
//#UC START# *47A869D10074_492182D60225_impl*
 l3Set(f_Caption, Value);
//#UC END# *47A869D10074_492182D60225_impl*
end;//TnsEditionsRoot.DoSetAsPCharLen

function TnsEditionsRoot.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_492182D60225_var*
//#UC END# *4A60B23E00C3_492182D60225_var*
begin
//#UC START# *4A60B23E00C3_492182D60225_impl*
 if IID.EQ(IDocument) then
 begin
  if (f_Document = nil) then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   IDocument(Obj) := f_Document;
  end;//f_Document = nil
 end//IID.EQ(IDocument)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_492182D60225_impl*
end;//TnsEditionsRoot.COMQueryInterface

function TnsEditionsRoot.ChildNodeClass: Rl3CustomVirtualNode;
//#UC START# *4B1CE7F6012A_492182D60225_var*
//#UC END# *4B1CE7F6012A_492182D60225_var*
begin
//#UC START# *4B1CE7F6012A_492182D60225_impl*
 Result := TnsEditionNode;
//#UC END# *4B1CE7F6012A_492182D60225_impl*
end;//TnsEditionsRoot.ChildNodeClass

procedure TnsEditionsRoot.ClearFields;
begin
 f_Document := nil;
 inherited;
end;//TnsEditionsRoot.ClearFields

constructor TnsEditionNode.Create(aHandle: Integer;
 aEType: TRedactionType);
//#UC START# *4B1CE99E0212_4B1CE8B50207_var*
//#UC END# *4B1CE99E0212_4B1CE8B50207_var*
begin
//#UC START# *4B1CE99E0212_4B1CE8B50207_impl*
 inherited Create(nil, -1, -1);
 f_Handle := aHandle;
 f_EType := aEType;
//#UC END# *4B1CE99E0212_4B1CE8B50207_impl*
end;//TnsEditionNode.Create

class function TnsEditionNode.Make(aHandle: Integer;
 aEType: TRedactionType): Il3Node;
var
 l_Inst : TnsEditionNode;
begin
 l_Inst := Create(aHandle, aEType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsEditionNode.Make

function TnsEditionNode.Presentation: Tl3Tag;
//#UC START# *4EC25E6B006A_4B1CE8B50207_var*

 function CutPrefix(const aPref : String; const aStr : Tl3PCharLen): Tl3PCharLen;
 var
  l_Len : Integer;
 begin//CutPrefix
  if l3Starts(aPref, aStr) then
  begin
   l_Len := Length(aPref);
   Result.S := aStr.S + l_Len;
   Result.SLen := aStr.SLen - l_Len;
   Result.SCodePage := aStr.SCodePage;
  end//l3Starts(aPref, aStr)
  else
   Result := aStr;
 end;//CutPrefix

var
 l_CT : Il3CString;
 l_T : Tl3PCharLen;
 l_N : AnsiString;
 l_S : Tl3Variant;
 l_Segs : Tl3Variant;
 l_BracketStr : Tl3PCharLen;
 l_Rest : Tl3PCharLen;
 l_GroupBeginType : TnsEditionNodeGroupBeginType;
 l_Block : Tl3Variant;
//#UC END# *4EC25E6B006A_4B1CE8B50207_var*
begin
//#UC START# *4EC25E6B006A_4B1CE8B50207_impl*
 if (f_Presentation = nil) then
 begin
  l_GroupBeginType := Get_GroupBeginType;
  k2_typTextPara.MakeTag.AsObject.SetRef(f_Presentation);
  l_N := ev_psFixLen(IntToStr(EditionNumber), 3, ' ') + ' ';
  l_T := Self.AsPCharLen;
  l_T := CutPrefix('с ', l_T);
  l_CT := l3Trim(l3CStr(l_T));
  l_CT := l3StringReplace(l_CT, l3PCharLen(' по '), l3PCharLen(' - '), []{[rfReplaceAll]});
  l_BracketStr := l3PCharLen(l_CT);
  l_Rest := l3FindChar('(', l_BracketStr);
  f_Presentation.PCharLenA[k2_tiText] := l3PCharLen(l3Cat(l_N, l_CT));
  f_Presentation.IntA[k2_tiStyle] := f1_saEdition;
  l_Segs := f_Presentation.cAtomEx([k2_tiSegments,
                                    k2_tiChildren, k2_tiHandle, Ord(ev_slView)],
                                    nil);
  l_S := k2_typTextSegment.MakeTag.AsObject;
  l_S.IntA[k2_tiStyle] := f1_saEditionNumber;
  l_S.IntA[k2_tiStart] := 1;
  l_S.IntA[k2_tiFinish] := l_S.IntA[k2_tiStart] + Length(l_N) - 1;
  l_Segs.AddChild(l_S.AsObject);
  if not l3IsNil(l_BracketStr) then
  begin
   l_S := k2_typTextSegment.MakeTag.AsObject;
   l_S.IntA[k2_tiStyle] := f1_saEditionInterval;
   l_S.IntA[k2_tiStart] := Length(l_N) + 1;
   if l3IsNil(l_Rest) then
    l_S.IntA[k2_tiFinish] := l_S.IntA[k2_tiStart] + l_BracketStr.SLen - 1
   else
    l_S.IntA[k2_tiFinish] := l_S.IntA[k2_tiStart] + l_BracketStr.SLen - 2;
   l_Segs.AddChild(l_S.AsObject);
  end;//not l3IsNil(l_BracketStr)
  if (l_GroupBeginType <> ns_gbtNone) then
  // - здесь формируем группу
  begin
   l_Block := k2_typNodeGroup.MakeTag.AsObject;
   try
    l_Block.AddChild(f_Presentation);
    Case l_GroupBeginType of
     ns_gbtNew:
      l_Block.PCharLenA[k2_tiShortName] := str_engcNew.AsWStr;
     ns_gbtActual:
      l_Block.PCharLenA[k2_tiShortName] := str_engcActual.AsWStr;
     ns_gbtOld:
      l_Block.PCharLenA[k2_tiShortName] := str_engcOld.AsWStr;
     else
      Assert(false);
    end;//Case l_GroupBeginType
    l_Block.SetRef(f_Presentation);
   finally
    l_Block := nil;
   end;//try..finally
  end;//l_GroupBeginType <> ns_gbtNone
(*  f_Presentation.IntA[k2_tiFirstIndent] := 0;
  f_Presentation.IntA[k2_tiLeftIndent] := 0;
  f_Presentation.IntA[k2_tiJustification] := Ord(ev_itLeft);*)
 end;//f_Presentation = nil
 Result := f_Presentation; 
//#UC END# *4EC25E6B006A_4B1CE8B50207_impl*
end;//TnsEditionNode.Presentation

function TnsEditionNode.EditionNumber: Integer;
 {* Номер редакции в списке редакций }
//#UC START# *4EC28EB6019F_4B1CE8B50207_var*
//#UC END# *4EC28EB6019F_4B1CE8B50207_var*
begin
//#UC START# *4EC28EB6019F_4B1CE8B50207_impl*
 Result := (ParentNode.ThisChildrenCount - Self.pm_GetIndexInParent){ + 1};
//#UC END# *4EC28EB6019F_4B1CE8B50207_impl*
end;//TnsEditionNode.EditionNumber

function TnsEditionNode.HasMainChecked(const aTree: InsEditionsTree): Boolean;
 {* Есть ли уже отмеченная Ведущая редакция }
//#UC START# *4EC3CA120205_4B1CE8B50207_var*

 function DoFind(const anIntf: Il3SimpleNode) : Boolean;
 var
  l_Node : InsEditionNode;
 begin//DoFind
  Result := false;
  if Supports(anIntf, InsEditionNode, l_Node) then
   try
    if (l_Node.CheckType = ns_enctMain) then
    begin
     Result := true;
     HasMainChecked := true;
    end;//l_Node.CheckType = ns_enctMain
   finally
    l_Node := nil;
   end;//try..finally
 end;//DoFind

//#UC END# *4EC3CA120205_4B1CE8B50207_var*
begin
//#UC START# *4EC3CA120205_4B1CE8B50207_impl*
 Result := false;
 aTree.SimpleIterateF(l3L2SNA(@DoFind), imCheckResult);
//#UC END# *4EC3CA120205_4B1CE8B50207_impl*
end;//TnsEditionNode.HasMainChecked

procedure TnsEditionNode.UncheckAllAdditional(const aTree: InsEditionsTree);
 {* Снимает выделение со всех Дополнительных редакций (на самом деле - она одна такая) }
//#UC START# *4EC3D2720139_4B1CE8B50207_var*

 procedure DoUncheck(const anIntf: Il3SimpleNode);
 var
  l_Node : InsEditionNode;
 begin//DoUncheck
  if Supports(anIntf, InsEditionNode, l_Node) then
   try
    if (l_Node.CheckType = ns_enctAdditional) then
     l_Node.CheckType := ns_enctUnchecked;
   finally
    l_Node := nil;
   end;//try..finally
 end;//DoUncheck

//#UC END# *4EC3D2720139_4B1CE8B50207_var*
begin
//#UC START# *4EC3D2720139_4B1CE8B50207_impl*
 aTree.SimpleIterateF(l3L2SNA(@DoUncheck), 0{imCheckResult});
//#UC END# *4EC3D2720139_4B1CE8B50207_impl*
end;//TnsEditionNode.UncheckAllAdditional

function TnsEditionNode.HasAdditionalChecked(const aTree: InsEditionsTree): Boolean;
//#UC START# *4EC3D6300158_4B1CE8B50207_var*

 function DoFind(const anIntf: Il3SimpleNode) : Boolean;
 var
  l_Node : InsEditionNode;
 begin//DoFind
  Result := false;
  if Supports(anIntf, InsEditionNode, l_Node) then
   try
    if (l_Node.CheckType = ns_enctAdditional) then
    begin
     Result := true;
     HasAdditionalChecked := true;
    end;//l_Node.CheckType = ns_enctMain
   finally
    l_Node := nil;
   end;//try..finally
 end;//DoFind

//#UC END# *4EC3D6300158_4B1CE8B50207_var*
begin
//#UC START# *4EC3D6300158_4B1CE8B50207_impl*
 Result := false;
 aTree.SimpleIterateF(l3L2SNA(@DoFind), imCheckResult);
//#UC END# *4EC3D6300158_4B1CE8B50207_impl*
end;//TnsEditionNode.HasAdditionalChecked

function TnsEditionNode.IsSameID(aID: Integer): Boolean;
//#UC START# *4B1CE85D0167_4B1CE8B50207_var*
//#UC END# *4B1CE85D0167_4B1CE8B50207_var*
begin
//#UC START# *4B1CE85D0167_4B1CE8B50207_impl*
 Result := f_Handle = aID;
//#UC END# *4B1CE85D0167_4B1CE8B50207_impl*
end;//TnsEditionNode.IsSameID

function TnsEditionNode.pm_GetEditionID: Integer;
//#UC START# *4B1CE87602C2_4B1CE8B50207get_var*
//#UC END# *4B1CE87602C2_4B1CE8B50207get_var*
begin
//#UC START# *4B1CE87602C2_4B1CE8B50207get_impl*
 Result := f_Handle;
//#UC END# *4B1CE87602C2_4B1CE8B50207get_impl*
end;//TnsEditionNode.pm_GetEditionID

function TnsEditionNode.pm_GetEditionType: TRedactionType;
//#UC START# *4B1CE8A00198_4B1CE8B50207get_var*
//#UC END# *4B1CE8A00198_4B1CE8B50207get_var*
begin
//#UC START# *4B1CE8A00198_4B1CE8B50207get_impl*
 Result := f_EType;
//#UC END# *4B1CE8A00198_4B1CE8B50207get_impl*
end;//TnsEditionNode.pm_GetEditionType

function TnsEditionNode.Get_CheckType: TnsEditionNodeCheckType;
//#UC START# *4EC3AD4E008E_4B1CE8B50207get_var*
//#UC END# *4EC3AD4E008E_4B1CE8B50207get_var*
begin
//#UC START# *4EC3AD4E008E_4B1CE8B50207get_impl*
 Result := f_CheckType;
//#UC END# *4EC3AD4E008E_4B1CE8B50207get_impl*
end;//TnsEditionNode.Get_CheckType

procedure TnsEditionNode.Set_CheckType(aValue: TnsEditionNodeCheckType);
//#UC START# *4EC3AD4E008E_4B1CE8B50207set_var*
//#UC END# *4EC3AD4E008E_4B1CE8B50207set_var*
begin
//#UC START# *4EC3AD4E008E_4B1CE8B50207set_impl*
 f_CheckType := aValue;
//#UC END# *4EC3AD4E008E_4B1CE8B50207set_impl*
end;//TnsEditionNode.Set_CheckType

procedure TnsEditionNode.ChangeCheckTypeViaClick(const aTree: InsEditionsTree);
//#UC START# *4EC3B6EC02BB_4B1CE8B50207_var*
var
 l_D : IDocument;
 l_State : IDocumentState;
//#UC END# *4EC3B6EC02BB_4B1CE8B50207_var*
begin
//#UC START# *4EC3B6EC02BB_4B1CE8B50207_impl*
 // - тут надо проверить хитрую логику с "Ведущей" и "Дополнительной"
 aTree.Changing;
 try
  if (f_CheckType = ns_enctUnchecked) then
  begin
   if not Supports(Self.Get_Parent, IDocument, l_D) then
    Assert(false);
   l_D.GetCurrentState(l_State);
   if l_State.CanCompareWithAnyOtherRedaction then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=318374263
   begin
    if not HasMainChecked(aTree) then
     f_CheckType := ns_enctMain
    else
    begin
     UncheckAllAdditional(aTree);
     f_CheckType := ns_enctAdditional;
    end;//not HasMainChecked(aTree)
   end;//l_State.CanCompareWithAnyOtherRedaction
  end//f_CheckType = ns_enctUnchecked
  else
  if (f_CheckType = ns_enctMain) then
   f_CheckType := ns_enctUnchecked
  else
   f_CheckType := ns_enctUnchecked;
 finally
  aTree.Changed;
 end;//try..finally
//#UC END# *4EC3B6EC02BB_4B1CE8B50207_impl*
end;//TnsEditionNode.ChangeCheckTypeViaClick

procedure TnsEditionNode.TryMarkAsMain(const aTree: InsEditionsTree);
 {* Пытается пометить ноду, как Ведущую, если ведущих выбрано не было }
//#UC START# *4EC3C9D20140_4B1CE8B50207_var*
var
 l_D : IDocument;
 l_State : IDocumentState;
//#UC END# *4EC3C9D20140_4B1CE8B50207_var*
begin
//#UC START# *4EC3C9D20140_4B1CE8B50207_impl*
 if (f_CheckType <> ns_enctMain) then
 begin
  if not Supports(Self.Get_Parent, IDocument, l_D) then
   Assert(false);
  l_D.GetCurrentState(l_State);
  if l_State.CanCompareWithAnyOtherRedaction then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=318374263
   if not HasMainChecked(aTree) then
   begin
    aTree.Changing;
    try
     Assert(f_CheckType <> ns_enctAdditional);
     // - если вдруг сломается, то надо думать над UncheckAllAdditional(aTree) что ли
     f_CheckType := ns_enctMain;
    finally
     aTree.Changed;
    end;//try..finally
   end;//not HasMainChecked(aTree)
 end;//f_CheckType <> ns_enctMain
//#UC END# *4EC3C9D20140_4B1CE8B50207_impl*
end;//TnsEditionNode.TryMarkAsMain

function TnsEditionNode.ReadyForCompare(const aTree: InsEditionsTree): Boolean;
//#UC START# *4EC3D5F002E1_4B1CE8B50207_var*
//#UC END# *4EC3D5F002E1_4B1CE8B50207_var*
begin
//#UC START# *4EC3D5F002E1_4B1CE8B50207_impl*
 Result := HasMainChecked(aTree) AND HasAdditionalChecked(aTree);
//#UC END# *4EC3D5F002E1_4B1CE8B50207_impl*
end;//TnsEditionNode.ReadyForCompare

procedure TnsEditionNode.GetDocumentsForCompare(const aTree: InsEditionsTree;
 out aLeft: IDocument;
 out aRight: IDocument);
//#UC START# *4EC4E7BF029B_4B1CE8B50207_var*
var
 l_Main : Il3SimpleNode;
 l_Additional : Il3SimpleNode;
 l_MainE : InsEditionNode;
 l_AdditionalE : InsEditionNode;

 function DoFind(const anIntf: Il3SimpleNode) : Boolean;
 var
  l_Node : InsEditionNode;
 begin//DoFind
  Result := false;
  if Supports(anIntf, InsEditionNode, l_Node) then
   try
    if (l_Node.CheckType = ns_enctMain) then
    begin
     l_Main := anIntf;
     l_MainE := l_Node;
    end//l_Node.CheckType = ns_enctMain
    else
    if (l_Node.CheckType = ns_enctAdditional) then
    begin
     l_Additional := anIntf;
     l_AdditionalE := l_Node;
    end//l_Node.CheckType = ns_enctAdditional
    else
     Exit;
    Result := (l_MainE <> nil) AND (l_AdditionalE <> nil);
   finally
    l_Node := nil;
   end;//try..finally
 end;//DoFind

var
 l_D : IDocument;
 l_State : IDocumentState;
 l_LeftState : IDocumentState;
 l_RightState : IDocumentState;
//#UC END# *4EC4E7BF029B_4B1CE8B50207_var*
begin
//#UC START# *4EC4E7BF029B_4B1CE8B50207_impl*
 l_Main := nil;
 l_Additional := nil;
 l_MainE := nil;
 l_AdditionalE := nil;
 aTree.SimpleIterateF(l3L2SNA(@DoFind), imCheckResult);
 if (l_MainE <> nil) AND (l_AdditionalE <> nil) then
 begin
  if (l_Main.IndexInParent > l_Additional.IndexInParent) then
  begin
   l3Swap(Pointer(l_Main), Pointer(l_Additional));
   l3Swap(Pointer(l_MainE), Pointer(l_AdditionalE));
  end;//l_Main.IndexInParent > l_Additional.IndexInParent
  if not Supports(l_Main.Parent, IDocument, l_D) then
   Assert(false);
  l_D.GetCurrentState(l_State);
  l_State.Clone(l_LeftState);
  l_State.Clone(l_RightState);
  l_LeftState.SetRedactionOnId(l_AdditionalE.EditionID);
  l_RightState.SetRedactionOnId(l_MainE.EditionID);
  l_D.CreateView(l_LeftState, aLeft);
  if (aLeft = nil) then
   aLeft := l_D;
  l_D.CreateView(l_RightState, aRight);
  if (aRight = nil) then
   aRight := l_D;
 end;//l_MainE <> nil
//#UC END# *4EC4E7BF029B_4B1CE8B50207_impl*
end;//TnsEditionNode.GetDocumentsForCompare

function TnsEditionNode.Get_GroupBeginType: TnsEditionNodeGroupBeginType;
//#UC START# *4ED4B9680283_4B1CE8B50207get_var*
var
 l_Prev : Il3Node;

 function PrevGroupBeginType: TnsEditionNodeGroupBeginType;
 var
  l_Node : InsEditionNode;
 begin//PrevGroupBeginType
  if not Supports(l_Prev, InsEditionNode, l_Node) then
   Assert(false)
  else
   try
(*    Result := l_Node.GroupBeginType;*)
    Case l_Node.EditionType of
     RT_ACTUAL,
     RT_ACTUAL_ABOLISHED,
     RT_ACTUAL_PREACTIVE:
      Result := ns_gbtActual;
     RT_OLD:
      Result := ns_gbtOld;
     RT_NEW,
     RT_NEW_ABOLISHED,
     RT_NEW_PREACTIVE:
      Result := ns_gbtNew;
     else
     begin
      Assert(false);
      Result := ns_gbtNone;
     end;//else
    end;//Case l_Node.EditionType
   finally
    l_Node := nil;
   end;//try..finally
 end;//PrevGroupBeginType

//#UC END# *4ED4B9680283_4B1CE8B50207get_var*
begin
//#UC START# *4ED4B9680283_4B1CE8B50207get_impl*
 Result := ns_gbtNone;
 if Self.IsFirst then
 // - т.к. ноды у Вована - закольцованы
  l_Prev := nil
 else
  l_Prev := Self.PrevNode;
 Case f_EType of
  RT_ACTUAL,
  RT_ACTUAL_ABOLISHED,
  RT_ACTUAL_PREACTIVE:
   if (l_Prev = nil) OR (PrevGroupBeginType <> ns_gbtActual) then
    Result := ns_gbtActual;
  RT_OLD:
   if (l_Prev = nil) OR (PrevGroupBeginType <> ns_gbtOld) then
    Result := ns_gbtOld;
  RT_NEW,
  RT_NEW_ABOLISHED,
  RT_NEW_PREACTIVE:
   if (l_Prev = nil) OR (PrevGroupBeginType <> ns_gbtNew) then
    Result := ns_gbtNew;
  else
   Assert(false);
 end;//f_EType
//#UC END# *4ED4B9680283_4B1CE8B50207get_impl*
end;//TnsEditionNode.Get_GroupBeginType

procedure TnsEditionNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B1CE8B50207_var*
//#UC END# *479731C50290_4B1CE8B50207_var*
begin
//#UC START# *479731C50290_4B1CE8B50207_impl*
 f_Handle := -1;
 f_CheckType := Low(f_CheckType);
 FreeAndNil(f_Presentation);
 inherited;
//#UC END# *479731C50290_4B1CE8B50207_impl*
end;//TnsEditionNode.Cleanup

procedure TnsEditionNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_4B1CE8B50207_var*
//#UC END# *47A869D10074_4B1CE8B50207_var*
begin
//#UC START# *47A869D10074_4B1CE8B50207_impl*
 l3Set(f_Caption, Value);
//#UC END# *47A869D10074_4B1CE8B50207_impl*
end;//TnsEditionNode.DoSetAsPCharLen

function TnsEditionNode.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4B1CE8B50207_var*
var
 l_P : Tl3Tag;
//#UC END# *4A60B23E00C3_4B1CE8B50207_var*
begin
//#UC START# *4A60B23E00C3_4B1CE8B50207_impl*
 if IID.EQ(Il3NodePainter) then
 begin
  l_P := Presentation;
  if (l_P = nil) OR not l_P.IsValid then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   Il3NodePainter(Obj) := TevNodePainter.Make(l_P.AsObject);
  end;//l_P = nil.. 
 end//IID.EQ(Il3NodePainter)
 else
 if IID.EQ(Il3TagRef) then
 begin
  l_P := Presentation;
  if (l_P = nil) OR not l_P.IsValid then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   Il3TagRef(Obj) := l_P.AsRef;
  end;//l_P = nil.. 
 end//Il3TagRef
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4B1CE8B50207_impl*
end;//TnsEditionNode.COMQueryInterface

function TnsEditionNode.GetIsSame(const aNode: Il3SimpleNode): Boolean;
//#UC START# *54C78D9201B9_4B1CE8B50207_var*
var
 l_EditionNode: InsEditionNode;
//#UC END# *54C78D9201B9_4B1CE8B50207_var*
begin
//#UC START# *54C78D9201B9_4B1CE8B50207_impl*
 Result := inherited GetIsSame(aNode);
 if not Result then begin
  if Supports(aNode, InsEditionNode, l_EditionNode) then
   try
    Result := l_EditionNode.IsSameID(f_Handle);
   finally
    l_EditionNode := nil;
   end;//try..finally
 end;//not Result
//#UC END# *54C78D9201B9_4B1CE8B50207_impl*
end;//TnsEditionNode.GetIsSame

initialization
 str_engcNew.Init;
 {* Инициализация str_engcNew }
 str_engcActual.Init;
 {* Инициализация str_engcActual }
 str_engcOld.Init;
 {* Инициализация str_engcOld }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
