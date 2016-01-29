{$IfNDef dsBaseContents_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsBaseContents.imp.pas"
// Начат: 2008/04/03 10:35:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::BaseDocument::dsBaseContents
//
// Простое оглавление
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsBaseContents_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _InitDataType_ = IdeSimpleTree;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 _nsContextFilter_Parent_ = _dsSimpleTree_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\nsContextFilter.imp.pas}
 _dsBaseContents_ = {abstract vac} class(_nsContextFilter_, IdsBaseContents)
  {* Простое оглавление }
 private
 // private fields
   SDS : IsdsBaseDocument;
 protected
  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   function pm_GetDocInfo: IdeDocInfo;
   function Get_Bookmarks: IBookmarkList;
   function Get_Comments: ICommentsParaList;
   function Get_ExternalObjects: IExternalObjectDataList;
   function Get_Adornments: InsDocumentAdornments;
   function Get_ContentsListCount(aListType: TnsContentsListType): Integer;
   function Get_ContentsListItem(const anIndex: TnsContentsListIndex): TnsStringPair;
   function Get_ContentsListParaID(const anIndex: TnsContentsListIndex): Integer;
   function Get_Empty: Boolean;
 protected
 // overridden protected methods
   function MakeImageList: Il3ImageList; override;
     {* - создать иконки дерева. }
   {$If not defined(NoVCM)}
   procedure GotData; override;
     {* - данные изменились. }
   {$IfEnd} //not NoVCM
 end;//_dsBaseContents_
{$Else}

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 _nsContextFilter_Parent_ = _dsSimpleTree_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\nsContextFilter.imp.pas}
 _dsBaseContents_ = _nsContextFilter_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dsBaseContents_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\nsContextFilter.imp.pas}

// start class _dsBaseContents_

function _dsBaseContents_.pm_GetDocInfo: IdeDocInfo;
//#UC START# *492566F7019F_49256B3903E4get_var*
//#UC END# *492566F7019F_49256B3903E4get_var*
begin
//#UC START# *492566F7019F_49256B3903E4get_impl*
 Assert(Assigned(SDS));
 Result := SDS.DocInfo;
//#UC END# *492566F7019F_49256B3903E4get_impl*
end;//_dsBaseContents_.pm_GetDocInfo

function _dsBaseContents_.Get_Bookmarks: IBookmarkList;
//#UC START# *4D2DEA3B0176_49256B3903E4get_var*
//#UC END# *4D2DEA3B0176_49256B3903E4get_var*
begin
//#UC START# *4D2DEA3B0176_49256B3903E4get_impl*
 if (PartData = nil) then
  Result := nil
 else
  Result := PartData.Bookmarks;
//#UC END# *4D2DEA3B0176_49256B3903E4get_impl*
end;//_dsBaseContents_.Get_Bookmarks

function _dsBaseContents_.Get_Comments: ICommentsParaList;
//#UC START# *4D2DEA3F012E_49256B3903E4get_var*
//#UC END# *4D2DEA3F012E_49256B3903E4get_var*
begin
//#UC START# *4D2DEA3F012E_49256B3903E4get_impl*
 if (PartData = nil) then
  Result := nil
 else
  Result := PartData.Comments;
//#UC END# *4D2DEA3F012E_49256B3903E4get_impl*
end;//_dsBaseContents_.Get_Comments

function _dsBaseContents_.Get_ExternalObjects: IExternalObjectDataList;
//#UC START# *4D2DEA430044_49256B3903E4get_var*
//#UC END# *4D2DEA430044_49256B3903E4get_var*
begin
//#UC START# *4D2DEA430044_49256B3903E4get_impl*
 if (PartData = nil) then
  Result := nil
 else
  Result := PartData.ExternalObjects;
//#UC END# *4D2DEA430044_49256B3903E4get_impl*
end;//_dsBaseContents_.Get_ExternalObjects

function _dsBaseContents_.Get_Adornments: InsDocumentAdornments;
//#UC START# *4D3089A80114_49256B3903E4get_var*
//#UC END# *4D3089A80114_49256B3903E4get_var*
begin
//#UC START# *4D3089A80114_49256B3903E4get_impl*
 if (PartData = nil) then
  Result := nil
 else
  Result := PartData.Adornments;
//#UC END# *4D3089A80114_49256B3903E4get_impl*
end;//_dsBaseContents_.Get_Adornments

function _dsBaseContents_.Get_ContentsListCount(aListType: TnsContentsListType): Integer;
//#UC START# *4D404C490215_49256B3903E4get_var*
//#UC END# *4D404C490215_49256B3903E4get_var*
begin
//#UC START# *4D404C490215_49256B3903E4get_impl*
 Case aListType of
  ns_cltBookmarks:
   if (Get_Bookmarks = nil) then
    Result := 0
   else
    Result := Get_Bookmarks.Count;
  ns_cltComments:
   if (Get_Comments = nil) OR
      (Get_Adornments = nil) then
    Result := 0
   else
    Result := Get_Comments.Count;
  ns_cltExternalObjects:
   if (Get_ExternalObjects = nil) then
    Result := 0
   else
    Result := Get_ExternalObjects.Count;
  else
  begin
   Result := 0;
   Assert(false);
  end;//else
 end;//Case aListType
//#UC END# *4D404C490215_49256B3903E4get_impl*
end;//_dsBaseContents_.Get_ContentsListCount

function _dsBaseContents_.Get_ContentsListItem(const anIndex: TnsContentsListIndex): TnsStringPair;
//#UC START# *4D416629016B_49256B3903E4get_var*
var
 l_BM : TBookmark2;
 l_EO : TExternalObjectData;
 l_ID : Integer;
//#UC END# *4D416629016B_49256B3903E4get_var*
begin
//#UC START# *4D416629016B_49256B3903E4get_impl*
 Result.rIString := nil;
 Result.rIl3CString := nil;
 Case anIndex.rListType of
  ns_cltBookmarks:
  begin
   if (Get_Bookmarks.Count > anIndex.rIndex) then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=290953453
   begin
    Get_Bookmarks.pm_GetItem(anIndex.rIndex, l_BM);
    Result.rIString := l_BM.rName;
   end;//Get_Bookmarks.Count > anIndex.rIndex
  end;//ns_cltBookmarks
  ns_cltComments:
  begin
   l_ID := Get_Comments.Items[anIndex.rIndex];
   if (Get_Adornments = nil) then
    Result.rIl3CString := vcmFmt(str_CommentStub, [anIndex.rIndex, l_ID])
   else
   begin
    Result.rIl3CString :=
     Get_Adornments.As_InevCommentTextProvider.
      GetCommentTextByParaID(l_ID);
    if l3IsNil(Result.rIl3CString) then
     Result.rIl3CString := vcmFmt(str_CommentStub, [anIndex.rIndex, l_ID]);
   end;//Get_Adornments = nil
  end;//ns_cltComments
  ns_cltExternalObjects:
  begin
   Get_ExternalObjects.pm_GetItem(anIndex.rIndex, l_EO);
   Result.rIString := l_EO.rName;
  end;//ns_cltExternalObjects
  else
   Assert(false);
 end;//Case anIndex.rListType
//#UC END# *4D416629016B_49256B3903E4get_impl*
end;//_dsBaseContents_.Get_ContentsListItem

function _dsBaseContents_.Get_ContentsListParaID(const anIndex: TnsContentsListIndex): Integer;
//#UC START# *4D4173FE02CC_49256B3903E4get_var*
var
 l_BM : TBookmark2;
 l_EO : TExternalObjectData;
//#UC END# *4D4173FE02CC_49256B3903E4get_var*
begin
//#UC START# *4D4173FE02CC_49256B3903E4get_impl*
 Result := 0;
 Case anIndex.rListType of
  ns_cltBookmarks:
  begin
   Get_Bookmarks.pm_GetItem(anIndex.rIndex, l_BM);
   Result := l_BM.rParaID;
  end;//ns_cltBookmarks
  ns_cltComments:
  begin
   Result := Get_Comments.Items[anIndex.rIndex];
  end;//ns_cltComments
  ns_cltExternalObjects:
  begin
   Get_ExternalObjects.pm_GetItem(anIndex.rIndex, l_EO);
   Result := l_EO.rParaID;
  end;//ns_cltExternalObjects
  else
   Assert(false);
 end;//Case anIndex.rListType
//#UC END# *4D4173FE02CC_49256B3903E4get_impl*
end;//_dsBaseContents_.Get_ContentsListParaID

function _dsBaseContents_.Get_Empty: Boolean;
//#UC START# *4E7B5DED03A2_49256B3903E4get_var*
//#UC END# *4E7B5DED03A2_49256B3903E4get_var*
begin
//#UC START# *4E7B5DED03A2_49256B3903E4get_impl*
 Result := (PartData = nil) OR PartData.Empty; 
//#UC END# *4E7B5DED03A2_49256B3903E4get_impl*
end;//_dsBaseContents_.Get_Empty

function _dsBaseContents_.MakeImageList: Il3ImageList;
//#UC START# *47F465F80149_49256B3903E4_var*
//#UC END# *47F465F80149_49256B3903E4_var*
begin
//#UC START# *47F465F80149_49256B3903E4_impl*
 Result := vtMakeImageListWrapper(nsDocumentRes.DocumentItemsImageList);
//#UC END# *47F465F80149_49256B3903E4_impl*
end;//_dsBaseContents_.MakeImageList

{$If not defined(NoVCM)}
procedure _dsBaseContents_.GotData;
//#UC START# *492ACF630072_49256B3903E4_var*
//#UC END# *492ACF630072_49256B3903E4_var*
begin
//#UC START# *492ACF630072_49256B3903E4_impl*
 inherited;
 pm_SetSimpleTree(PartData.Contents);
//#UC END# *492ACF630072_49256B3903E4_impl*
end;//_dsBaseContents_.GotData
{$IfEnd} //not NoVCM

procedure _dsBaseContents_.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 SDS := aDS As IsdsBaseDocument;
end;

procedure _dsBaseContents_.ClearRefs;
begin
 inherited;
 SDS := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dsBaseContents_imp}
