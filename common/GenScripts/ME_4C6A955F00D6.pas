{$IfNDef nsDocumentContainer_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas"
// ���������: "Impurity"

{$Define nsDocumentContainer_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _afwApplicationDataUpdate_Parent_ = _nsDocumentContainer_Parent_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _nsDocumentContainer_ = class(_afwApplicationDataUpdate_, InsDocumentAdornments, IdeDocInfoProvider, InevCommentTextProvider)
  {* ��������� ���������, ���������� � IdeDocInfo }
  private
   f_Bookmarks: IBookmarkList;
   f_Comments: ICommentsParaList;
   f_ExternalObjects: IExternalObjectDataList;
  protected
   f_DocumentInfo: IdeDocInfo;
  protected
   procedure AfterCreate(const aDocInfo: IdeDocInfo); virtual;
   function As_InevCommentTextProvider: InevCommentTextProvider;
    {* ����� ���������� ������ ���������� � InevCommentTextProvider }
   function Get_Bookmarks: IBookmarkList;
   function Get_Comments: ICommentsParaList;
   function Get_ExternalObjects: IExternalObjectDataList;
   function pm_GetDocInfo: IdeDocInfo;
   procedure FinishDataUpdate; override;
   function ReplaceContainerInOwner(const aDocumentContainer: InevDocumentContainer): Boolean; override;
   function CanBePlacedInDocumentsCache: Boolean; override;
   function MakeDocumentPreview(const aKey: TevPreviewCacheKey;
    const aMacroReplacer: IafwHAFMacroReplacer;
    const aRange: InevRange = nil): IafwDocumentPreview; override;
   function MakeInfoPreview(const aKey: TevPreviewCacheKey;
    const aMacroReplacer: IafwHAFMacroReplacer): IafwDocumentPreview; override;
   function GetIsSame(const aContainer: InevDocumentContainer): Boolean; override;
   function GetIsSameText(const aContainer: InevDocumentContainer): Boolean; override;
   function GetIsSameText(const aTextSource: IUnknown): Boolean; override;
   function HAFPainterClass: RevHAFPainter; override;
   function DocumentPreviewClass: RevDocumentPreview; override;
   function Info: InevStorable; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* ���������� ������� ���������� }
   procedure NotifySubReallyAdded(aParaID: Integer;
    aSubID: Integer;
    aLayerID: Integer;
    const aSubName: Tl3WString;
    aFlags: Integer); override;
   procedure NotifySubReallyDeleted(aParaID: Integer;
    aSubID: Integer;
    aLayerID: Integer); override;
   procedure ClearFields; override;
  public
   constructor Create(const aDocInfo: IdeDocInfo); reintroduce;
   class function Make(const aDocInfo: IdeDocInfo): InevDocumentContainer; reintroduce;
 end;//_nsDocumentContainer_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_afwApplicationDataUpdate_Parent_ = _nsDocumentContainer_Parent_;
{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
_nsDocumentContainer_ = _afwApplicationDataUpdate_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else nsDocumentContainer_imp}

{$IfNDef nsDocumentContainer_imp_impl}

{$Define nsDocumentContainer_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

procedure _nsDocumentContainer_.AfterCreate(const aDocInfo: IdeDocInfo);
//#UC START# *4B1FBF87020C_4C6A955F00D6_var*
//#UC END# *4B1FBF87020C_4C6A955F00D6_var*
begin
//#UC START# *4B1FBF87020C_4C6A955F00D6_impl*
 if Assigned(aDocInfo) then
 begin
  f_DocumentInfo := aDocInfo;
  NeedProcessMessages := true;
 end//Assigned(aDocInfo)
 else
  f_DocumentInfo := TdeDocInfo.Make;
//#UC END# *4B1FBF87020C_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.AfterCreate

constructor _nsDocumentContainer_.Create(const aDocInfo: IdeDocInfo);
//#UC START# *4B1FBFB301BF_4C6A955F00D6_var*
//#UC END# *4B1FBFB301BF_4C6A955F00D6_var*
begin
//#UC START# *4B1FBFB301BF_4C6A955F00D6_impl*
 inherited Create;
 AfterCreate(aDocInfo);
//#UC END# *4B1FBFB301BF_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.Create

class function _nsDocumentContainer_.Make(const aDocInfo: IdeDocInfo): InevDocumentContainer;
var
 l_Inst : _nsDocumentContainer_;
begin
 l_Inst := Create(aDocInfo);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_nsDocumentContainer_.Make

function _nsDocumentContainer_.As_InevCommentTextProvider: InevCommentTextProvider;
 {* ����� ���������� ������ ���������� � InevCommentTextProvider }
begin
 Result := Self;
end;//_nsDocumentContainer_.As_InevCommentTextProvider

function _nsDocumentContainer_.Get_Bookmarks: IBookmarkList;
//#UC START# *4D2F11DC0208_4C6A955F00D6get_var*
var
 l_BM    : TBookmark2;
 l_Index : Integer;
 l_Sub   : Tl3Variant;
 l_S     : TnsTagString;
 l_O     : InevObject;
 l_P     : InevBasePoint;
 l_Para  : InevObject;
//#UC END# *4D2F11DC0208_4C6A955F00D6get_var*
begin
//#UC START# *4D2F11DC0208_4C6A955F00D6get_impl*
 if (f_Bookmarks = nil) then
 begin
  try
   f_DocumentInfo.Doc.GetBookmarkList(f_Bookmarks);
  except
   f_Bookmarks := nil;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=264897751&focusedCommentId=264900317#comment-264900317
  end;//try..except
  if (f_Bookmarks <> nil) then
   for l_Index := 0 to Pred(f_Bookmarks.Count) do
   begin
    f_Bookmarks.pm_GetItem(l_Index, l_BM);
    if (l_BM.rParaID = 0) then
    begin
     if (l_Para = nil) then
     begin
      if not Document.QT(InevObject, l_O) then
       Assert(false);
      l_P := l_O.MakePoint.ToBottomChild(nil);
      l_Para := l_P.Obj^;
      if l_Para.AsObject.IsKindOf(k2_typLeafPara) then
      begin
       if (l_Para.AsObject.IntA[k2_tiHandle] = 0) then
        l_Para := evFindNumberedPara(l_Para);
      end//l_Para.IsKindOf(k2_typLeafPara)
      else
       break;
      if (l_Para = nil) OR not l_Para.AsObject.IsValid then
       break;
     end;//l_Para = nil
     l_BM.rParaID := l_Para.AsObject.IntA[k2_tiHandle];
     Assert(l_BM.rParaID <> 0);
     l_Sub := l_Para.AsObject.cAtomEx([k2_tiSubs,
                              k2_tiChildren, k2_tiHandle, Ord(ev_sbtBookmark),
                              k2_tiChildren, k2_tiHandle, {l_BM.rParaID}Integer(l_BM.rEId)], nil);
     l_S := TnsTagString.Create(l_BM.rName);
     try
      l_Sub.AttrW[k2_tiShortName, nil] := l_S;
     finally
      FreeAndNil(l_S);
     end;//try..finally
     l_Sub.IntA[k2_tiFlags] := 4;
     // - ����� ������ �����������
     RealizeSub(Ord(ev_sbtBookmark), l_Sub.AsObject, l_Para.AsObject);
     f_Bookmarks.pm_SetItem(l_Index, l_BM);
    end;//l_BM.rParaID = 0
   end;//for l_Index
 end;//f_Bookmarks = nil
 Result := f_Bookmarks;
//#UC END# *4D2F11DC0208_4C6A955F00D6get_impl*
end;//_nsDocumentContainer_.Get_Bookmarks

function _nsDocumentContainer_.Get_Comments: ICommentsParaList;
//#UC START# *4D2F11EA019F_4C6A955F00D6get_var*
//#UC END# *4D2F11EA019F_4C6A955F00D6get_var*
begin
//#UC START# *4D2F11EA019F_4C6A955F00D6get_impl*
 if (f_Comments = nil) then
  try
   f_DocumentInfo.Doc.GetCommentsParaList(f_Comments);
  except
   f_Comments := nil;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=264897751&focusedCommentId=264900335&#comment-264900335
  end;//try..except
 Result := f_Comments;
//#UC END# *4D2F11EA019F_4C6A955F00D6get_impl*
end;//_nsDocumentContainer_.Get_Comments

function _nsDocumentContainer_.Get_ExternalObjects: IExternalObjectDataList;
//#UC START# *4D2F11FA00E6_4C6A955F00D6get_var*
//#UC END# *4D2F11FA00E6_4C6A955F00D6get_var*
begin
//#UC START# *4D2F11FA00E6_4C6A955F00D6get_impl*
 if (f_ExternalObjects = nil) then
  try
   f_DocumentInfo.Doc.GetExternalObjectDataList(f_ExternalObjects);
  except
   f_ExternalObjects := nil;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=264897751&focusedCommentId=264900359&#comment-264900359
  end;//try..ecept
 Result := f_ExternalObjects; 
//#UC END# *4D2F11FA00E6_4C6A955F00D6get_impl*
end;//_nsDocumentContainer_.Get_ExternalObjects

function _nsDocumentContainer_.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_4C6A955F00D6get_var*
//#UC END# *4DF9D63B0360_4C6A955F00D6get_var*
begin
//#UC START# *4DF9D63B0360_4C6A955F00D6get_impl*
 Result := f_DocumentInfo;
//#UC END# *4DF9D63B0360_4C6A955F00D6get_impl*
end;//_nsDocumentContainer_.pm_GetDocInfo

procedure _nsDocumentContainer_.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4C6A955F00D6_var*
//#UC END# *47EA4E9002C6_4C6A955F00D6_var*
begin
//#UC START# *47EA4E9002C6_4C6A955F00D6_impl*
 inherited;
 Document := nil;
//#UC END# *47EA4E9002C6_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.FinishDataUpdate

function _nsDocumentContainer_.ReplaceContainerInOwner(const aDocumentContainer: InevDocumentContainer): Boolean;
//#UC START# *47F1024C0150_4C6A955F00D6_var*
var
 lDocInfo: IdeDocInfo;
//#UC END# *47F1024C0150_4C6A955F00D6_var*
begin
//#UC START# *47F1024C0150_4C6A955F00D6_impl*
 if Supports(aDocumentContainer, IdeDocInfo, lDocInfo) then
 try
  lDocInfo.Pos := f_DocumentInfo.Pos;
 finally
  lDocInfo := nil;
 end;//try..finally
 Result := inherited ReplaceContainerInOwner(aDocumentContainer);
//#UC END# *47F1024C0150_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.ReplaceContainerInOwner

function _nsDocumentContainer_.CanBePlacedInDocumentsCache: Boolean;
//#UC START# *47F10C6E0240_4C6A955F00D6_var*
//#UC END# *47F10C6E0240_4C6A955F00D6_var*
begin
//#UC START# *47F10C6E0240_4C6A955F00D6_impl*
 Result := HasDocument AND Assigned(f_DocumentInfo.Doc);
//#UC END# *47F10C6E0240_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.CanBePlacedInDocumentsCache

function _nsDocumentContainer_.MakeDocumentPreview(const aKey: TevPreviewCacheKey;
 const aMacroReplacer: IafwHAFMacroReplacer;
 const aRange: InevRange = nil): IafwDocumentPreview;
//#UC START# *47F1112A0183_4C6A955F00D6_var*
var
 l_Event: InsEventHolder;
//#UC END# *47F1112A0183_4C6A955F00D6_var*
begin
//#UC START# *47F1112A0183_4C6A955F00D6_impl*
 Result := inherited MakeDocumentPreview(aKey, aMacroReplacer, aRange);
 if Assigned(f_DocumentInfo.Doc) AND Supports(Result, InsEventHolder, l_Event) then
  l_Event.SetEvent(TnsDocumentPrintEvent.Make(f_DocumentInfo.Doc, Assigned(aRange)));
//#UC END# *47F1112A0183_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.MakeDocumentPreview

function _nsDocumentContainer_.MakeInfoPreview(const aKey: TevPreviewCacheKey;
 const aMacroReplacer: IafwHAFMacroReplacer): IafwDocumentPreview;
//#UC START# *47F111500241_4C6A955F00D6_var*
var
 l_Event: InsEventHolder;
 l_Rel : IDocument;
//#UC END# *47F111500241_4C6A955F00D6_var*
begin
//#UC START# *47F111500241_4C6A955F00D6_impl*
 Result := inherited MakeInfoPreview(aKey, aMacroReplacer);
 if Assigned(f_DocumentInfo.Doc) AND f_DocumentInfo.Doc.HasRelatedDoc AND
    Supports(Result, InsEventHolder, l_Event) then
 begin
  f_DocumentInfo.Doc.GetRelatedDoc(l_Rel);
  l_Event.SetEvent(TnsDocumentPrintEvent.Make(l_Rel, False));
 end;
//#UC END# *47F111500241_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.MakeInfoPreview

function _nsDocumentContainer_.GetIsSame(const aContainer: InevDocumentContainer): Boolean;
//#UC START# *47F279E9037A_4C6A955F00D6_var*
var
 l_Doc : IDocument;
//#UC END# *47F279E9037A_4C6A955F00D6_var*
begin
//#UC START# *47F279E9037A_4C6A955F00D6_impl*
 Result := inherited GetIsSame(aContainer);
 if not Result AND Assigned(f_DocumentInfo.Doc) then
 begin
  if Supports(aContainer, IDocument, l_Doc) then
   Result := f_DocumentInfo.Doc.IsSameView(l_Doc);
 end;//not Result AND Assigned(f_DocumentInfo.Doc)
//#UC END# *47F279E9037A_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.GetIsSame

function _nsDocumentContainer_.GetIsSameText(const aContainer: InevDocumentContainer): Boolean;
//#UC START# *47F279FE02A1_4C6A955F00D6_var*
var
 l_Doc : IDocument;
//#UC END# *47F279FE02A1_4C6A955F00D6_var*
begin
//#UC START# *47F279FE02A1_4C6A955F00D6_impl*
 Result := inherited GetIsSameText(aContainer);
 if not Result AND Assigned(f_DocumentInfo.Doc) then
 begin
  if Supports(aContainer, IDocument, l_Doc) then
   Result := f_DocumentInfo.Doc.IsSameRedaction(l_Doc);
 end;//not Result AND Assigned(f_DocumentInfo.Doc)
//#UC END# *47F279FE02A1_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.GetIsSameText

function _nsDocumentContainer_.GetIsSameText(const aTextSource: IUnknown): Boolean;
//#UC START# *47F27A1103B9_4C6A955F00D6_var*
var
 l_Bookmark : IBookMark;
//#UC END# *47F27A1103B9_4C6A955F00D6_var*
begin
//#UC START# *47F27A1103B9_4C6A955F00D6_impl*
 Result := inherited GetIsSameText(aTextSource);
 if not Result AND Assigned(f_DocumentInfo.Doc) AND
    Supports(aTextSource, IBookmark, l_Bookmark) then
  try
   Result := f_DocumentInfo.Doc.IsMyBookmark(l_Bookmark);
  finally
   l_BookMark := nil;
  end;//try..finally
//#UC END# *47F27A1103B9_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.GetIsSameText

function _nsDocumentContainer_.HAFPainterClass: RevHAFPainter;
//#UC START# *47F35CAC00E4_4C6A955F00D6_var*
//#UC END# *47F35CAC00E4_4C6A955F00D6_var*
begin
//#UC START# *47F35CAC00E4_4C6A955F00D6_impl*
 Result := TnsHAFPainter;
//#UC END# *47F35CAC00E4_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.HAFPainterClass

function _nsDocumentContainer_.DocumentPreviewClass: RevDocumentPreview;
//#UC START# *47F35CBA00C1_4C6A955F00D6_var*
//#UC END# *47F35CBA00C1_4C6A955F00D6_var*
begin
//#UC START# *47F35CBA00C1_4C6A955F00D6_impl*
 Result := TnsDocumentPreview;
//#UC END# *47F35CBA00C1_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.DocumentPreviewClass

function _nsDocumentContainer_.Info: InevStorable;
//#UC START# *47F35CD9002F_4C6A955F00D6_var*
var
 l_Rel : IDocument;
//#UC END# *47F35CD9002F_4C6A955F00D6_var*
begin
//#UC START# *47F35CD9002F_4C6A955F00D6_impl*
 if Assigned(f_DocumentInfo.Doc) AND f_DocumentInfo.Doc.HasRelatedDoc then
 begin
  f_DocumentInfo.Doc.GetRelatedDoc(l_Rel);
  try
   Result := TnsIDocumentDataObject.Make(l_Rel);
  finally
   l_Rel := nil;
  end;//try..finally
 end//Assigned(f_DocumentInfo.Doc) AND f_DocumentInfo.Doc.HasRelatedDoc
 else
  Result := nil;
//#UC END# *47F35CD9002F_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.Info

function _nsDocumentContainer_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* ���������� ������� ���������� }
//#UC START# *4A60B23E00C3_4C6A955F00D6_var*
//#UC END# *4A60B23E00C3_4C6A955F00D6_var*
begin
//#UC START# *4A60B23E00C3_4C6A955F00D6_impl*
 if IID.EQ(IdeDocInfo) then
 begin
  if (f_DocumentInfo = nil) then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   IdeDocInfo(Obj) := f_DocumentInfo;
  end;//f_DocumentInfo = nil
 end//IID.EQ(IdeDocInfo)
 else
 if IID.EQ(IDocument) then
 begin
  if (f_DocumentInfo = nil) OR (f_DocumentInfo.Doc = nil) then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   IDocument(Obj) := f_DocumentInfo.Doc;
  end;//f_DocumentInfo.Doc = nil
 end//IID.EQ(IDocument)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.COMQueryInterface

procedure _nsDocumentContainer_.NotifySubReallyAdded(aParaID: Integer;
 aSubID: Integer;
 aLayerID: Integer;
 const aSubName: Tl3WString;
 aFlags: Integer);
//#UC START# *4D2F0B29034E_4C6A955F00D6_var*
var
 l_BM : TBookmark2;
 l_Index : Integer;
(* l_O : InevObject;
 l_P : InevBasePoint;*)
//#UC END# *4D2F0B29034E_4C6A955F00D6_var*
begin
//#UC START# *4D2F0B29034E_4C6A955F00D6_impl*
 inherited;
(* if (aParaID = 0) then
 begin
  if not Document.QT(InevObject, l_O) then
   Assert(false);
  l_P := l_O.MakePoint.ToBottomChild(nil);
  if l_P.Obj.IsKindOf(k2_typLeafPara) then
   aParaID := l_P.Obj.IntA[k2_tiHandle];
 end;//aParaID = 0*)
 //if (aParaID <> 0) then
  Case aLayerID of
   Ord(ev_sbtBookmark):
   // - ��� ���� ���������������� �� ������� ��������
   begin
    if (f_Bookmarks = nil) then
     f_Bookmarks := defDataAdapter.NativeAdapter.MakeBookmarkList;
    for l_Index := 0 to Pred(f_Bookmarks.Count) do
    begin
     f_Bookmarks.pm_GetItem(l_Index, l_BM);
     if (l_BM.rParaID = aParaID) AND (l_BM.rEid = aSubID) then
      Exit;
      // - ����� ���� ��� ���� ����� ��� ����������������� ��� ��������, ���� �� ����� ��������
    end;//for l_Index
    l_BM.rParaId := aParaID;
    l_BM.rEid := aSubID;
    l_BM.rName := nsIStr(aSubName);
    f_Bookmarks.Add(l_BM);
    SendTOCCreatedNotify;
   end;//aLayerID = ev_sbtBookmark
   Ord(ev_sbtMark):
   begin
    if (aParaID = 0) then
     Exit;
    if (f_Comments = nil) then
    begin
      try
       f_DocumentInfo.Doc.GetCommentsParaList(f_Comments);
      except
       f_Comments := nil;
      end;//try..except
     if (f_Comments = nil) then
      f_Comments := defDataAdapter.NativeAdapter.MakeCommentsParaList;
    end;
    for l_Index := 0 to Pred(f_Comments.Count) do
     if (f_Comments.Items[l_Index] = aParaID) then
      Exit;
    f_Comments.Add(aParaID);
    SendTOCCreatedNotify;
   end;//ev_sbtMark
  end;//Case aLayerID
//#UC END# *4D2F0B29034E_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.NotifySubReallyAdded

procedure _nsDocumentContainer_.NotifySubReallyDeleted(aParaID: Integer;
 aSubID: Integer;
 aLayerID: Integer);
//#UC START# *4D3071570355_4C6A955F00D6_var*
var
 l_Index : Integer;
 l_BM : TBookmark2;
//#UC END# *4D3071570355_4C6A955F00D6_var*
begin
//#UC START# *4D3071570355_4C6A955F00D6_impl*
 inherited;
 Case aLayerID of
  Ord(ev_sbtBookmark):
  // - ��� ���� ���������������� �� ������� ��������
  begin
   if (f_Bookmarks <> nil) then
   begin
    l_Index := 0;
    while (l_Index < f_Bookmarks.Count) do
    begin
     f_Bookmarks.pm_GetItem(l_Index, l_BM);
     if (l_BM.rParaId = aParaID) then
     begin
      f_Bookmarks.Delete(l_Index);
      SendTOCCreatedNotify;
      Exit;
     end//l_BM.rParaId = aParaID
     else
      Inc(l_Index);
    end;//while (l_Index < f_Bookmarks.Count)
   end;//f_Bookmarks <> nil
  end;//ev_sbtBookmark
  Ord(ev_sbtMark):
  begin
   if (f_Comments <> nil) then
   begin
    l_Index := 0;
    while (l_Index < f_Comments.Count) do
    begin
     if (f_Comments.Items[l_Index] = aParaID) then
     begin
      f_Comments.Delete(l_Index);
      SendTOCCreatedNotify;
      Exit;
     end//f_Comments.Items[l_Index] = aParaID
     else
      Inc(l_Index);
    end;//while (l_Index < f_Bookmarks.Count)
   end;//f_Comments <> nil
  end;//ev_sbtMark
 end;//Case aLayerID
//#UC END# *4D3071570355_4C6A955F00D6_impl*
end;//_nsDocumentContainer_.NotifySubReallyDeleted

procedure _nsDocumentContainer_.ClearFields;
begin
 Finalize(f_Bookmarks);
 Finalize(f_Comments);
 Finalize(f_ExternalObjects);
 f_DocumentInfo := nil;
 inherited;
end;//_nsDocumentContainer_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf nsDocumentContainer_imp_impl}

{$EndIf nsDocumentContainer_imp}

