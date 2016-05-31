unit nsTagNodeToolsNew;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagNodeToolsNew.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsTagNodeToolsNew" MUID: (4C99DF8C0241)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , DynamicTreeUnit
 , DocumentUnit
 , k2Base
;

function nsFindTagByID(aTag: Tl3Tag;
 aType: Tk2Type;
 anID: Integer): Tl3Tag;
function nsTagByPath(aDocument: Tl3Tag;
 const aPath: INodeIndexPath;
 aNewSchool: Boolean): Tl3Tag;

implementation

uses
 l3ImplUses
 , SysUtils
 , nsTagNodeTools
 , Block_Const
 , ParaList_Const
 , LeafPara_Const
 , Sub_Const
 , k2Facade
 , BaseTypesUnit
 , Bookmark_Const
 , k2Tags
 , evdTypes
 , CommentPara_Const
 , DecorTextPara_Const
 , LeafParaDecorationsHolder_Const
;

function nsFindTagByID(aTag: Tl3Tag;
 aType: Tk2Type;
 anID: Integer): Tl3Tag;
var l_Path: INodeIndexPath;
var l_List: IFilterList;
var l_Provider: IDocumentTextProvider;
var l_Type: Tk2Type;
//#UC START# *4C99D9AF02E2_4C99DF8C0241_var*
var
 l_NeedCheckBookmark : Boolean;
 l_ProviderPrim : IDocumentTextProvider;
 l_AACLike : Boolean;
//#UC END# *4C99D9AF02E2_4C99DF8C0241_var*
begin
//#UC START# *4C99D9AF02E2_4C99DF8C0241_impl*
 Result := nil;
 l_AACLike := false;
 l_ProviderPrim := nil;
 try
  if aTag.QI(IDocumentTextProvider, l_ProviderPrim) then
   l_Provider := l_ProviderPrim
  else
  if aTag.Child[0].QI(IDocumentTextProvider, l_ProviderPrim) then
  begin
   l_AACLike := true;
   l_Provider := l_ProviderPrim;
  end;//Supports(aTag.Child[0], IDocumentTextProvider, l_Provider)
 finally
  l_ProviderPrim := nil;
 end;//try..finally
 if (l_Provider <> nil) then
  try
   l_NeedCheckBookmark := false;
   l_Type := aType;
   if l_Type.IsKindOf(k2_typLeafPara) then
   begin
    try
     l_Provider.FindPara(anID, l_Path);
    except
     on ECannotFindData do
      Exit;
      // - ну нету такого параграфа, это не повод падать
    end;//try..except
   end//l_Type.IsKindOf(k2_typLeafPara)
   else
   if l_Type.IsKindOf(k2_typBlock) then
   begin
    if not l_Type.IsKindOf(k2_typCommentPara) then
    begin
     if (anID = 0) then
     begin
      Result := aTag;
      Exit;
     end//anID = 0
     else
     try
      l_Provider.FindBlockOrSub(anID, l_Path);
     except
      on ECannotFindData do
       l_Path := nil;
       // - ну нету такого блока, это не повод падать
     end;//try..except
    end;//not l_Type.IsKindOf(k2_typCommentPara)
   end//l_Type.IsKindOf(k2_typBlock)
   else
   if l_Type.IsKindOf(k2_typBookmark) then
   begin
    try
     l_Provider.FindPara(anID, l_Path);
    except
     on ECannotFindData do
      l_Path := nil;
      // - ну нету такого параграфа, это не повод падать
    end;//try..except
    l_NeedCheckBookmark := (l_Path <> nil);
   end//l_Type.IsKindOf(k2_typBookmark)
   else
   if l_Type.IsKindOf(k2_typSub) then
   begin
    try
     l_Provider.FindBlockOrSub(anID, l_Path);
    except
     on ECannotFindData do
      l_Path := nil;
      // - ну нету такого блока, это не повод падать
    end;//try..except
   end//l_Type.IsKindOf(k2_typSub)
   else
   begin
    Assert(false);
    Exit;
   end;//l_Type.IsKindOf(k2_typBlock)
   if l_AACLike then
    if (l_Path <> nil) then
    begin
     if (l_Path.Items[0] = aTag.Child[0].IntA[k2_tiExternalHandle]) then
      l_Path.Items[0] := 0
     else
     begin
      Result := nil;
      Exit;
     end;//l_Path.Items[0] = aTag.Child[0].IntA[k2_tiExternalHandle]
    end;//l_Path <> nil
   Result := nsTagByPath(aTag, l_Path, true);
   if l_NeedCheckBookmark then
   // - надо проверить, что такая закладка на параграфе действительно есть
   begin
(*    if not Result.rAtomEx([k2_tiSubs,
                       k2_tiChildren, k2_tiHandle, ev_sbtBookmark,
                       k2_tiChildren, k2_tiHandle, anID]).IsValid then
    // - на параграфе нет такой закладки
    begin
     Result := nil;
     Assert(false);
    end;//not Result.rAtomEx*)
    // - закомментировано, иначе падает при попытке удаления несуществующей закладки 
   end//l_NeedCheckBookmark
   else
   if (Result <> nil) AND
      not Result.IsKindOf(aType) then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=254945157&focusedCommentId=255492359#comment-255492359
   begin
    if l_Type.IsKindOf(k2_typBlock) AND
       Result.IsKindOf(k2_typLeafPara) then
    // - тут проверим, что блок превратился в Sub
    // http://mdp.garant.ru/pages/viewpage.action?pageId=254945157&focusedCommentId=255492365#comment-255492365
    begin
     if Result.rAtomEx([k2_tiSubs,
                        k2_tiChildren, k2_tiHandle, Ord(ev_sbtSub),
                        k2_tiChildren, k2_tiHandle, anID]).IsValid then
     // - действительно на параграфе есть такой саб                   
      Exit;                  
    end;//aType.IsKindOf(k2_typBlock)
    //if not l_AACLike then
     Assert(false, Result.TagType.AsString + ' несовместим с ' + l_Type.AsString);
    Result := nil;
   end;//..not Result.IsKindOf(aType)
  finally
   l_Provider := nil;
  end;//try..finally
//#UC END# *4C99D9AF02E2_4C99DF8C0241_impl*
end;//nsFindTagByID

function nsTagByPath(aDocument: Tl3Tag;
 const aPath: INodeIndexPath;
 aNewSchool: Boolean): Tl3Tag;
var l_Index: Integer;
var l_Child: Tl3Tag;
//#UC START# *4C72558F00BC_4C99DF8C0241_var*
var
 l_J : Integer;
//#UC END# *4C72558F00BC_4C99DF8C0241_var*
begin
//#UC START# *4C72558F00BC_4C99DF8C0241_impl*
 if (aPath <> nil) AND (aPath.Count > 0) then
 begin
  Result := aDocument;
  if aNewSchool then
  begin
   for l_Index := 0 to Pred(aPath.Count) do
   begin
    l_Child := Result.Child[aPath[l_Index]];
    if l_Child.IsValid then
    begin
     Result := l_Child;
     if Result.IsKindOf(k2_typLeafParaDecorationsHolder) then
     begin
      Assert(l_Index = Pred(aPath.Count));
      for l_J := 0 to Pred(Result.ChildrenCount) do
      begin
       l_Child := Result.Child[l_J];
       if not l_Child.IsKindOf(k2_typDecorTextPara) then
       begin
        Result := l_Child;
        break;
       end;//not l_Child.IsKindOf(k2_typDecorTextPara)
      end;//for l_J
     end;//Result.IsKindOf(k2_typLeafParaDecorationsHolder)
    end//l_Child.IsValid
    else
     break;
   end;//for l_Index
  end//aNewSchool
  else
  begin
   for l_Index := Pred(aPath.Count) - 2 downto 0 do
   begin
    l_Child := Result.Child[aPath[l_Index]];
    if l_Child.IsValid then
     Result := l_Child
    else
     break;
   end;//for l_Index
  end;//aNewSchool
 end//aPath <> nil
 else
  Result := nil;
//#UC END# *4C72558F00BC_4C99DF8C0241_impl*
end;//nsTagByPath

end.
