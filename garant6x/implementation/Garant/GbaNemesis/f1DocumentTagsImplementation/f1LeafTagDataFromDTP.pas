unit f1LeafTagDataFromDTP;
 {* Поставщик данных о листьевом параграфе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1LeafTagDataFromDTP.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tf1LeafTagDataFromDTP" MUID: (4C727C300081)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , f1TagDataFromDTP
 , l3Interfaces
 , k2Base
 , F1TagDataProviderInterface
 , DocumentUnit
;

type
 _nsParentedTagData_Parent_ = Tf1TagDataFromDTP;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParentedTagData.imp.pas}
 Tf1LeafTagDataFromDTP = class(_nsParentedTagData_)
  {* Поставщик данных о листьевом параграфе }
  protected
   procedure DoSetWStyle(const aValue: IStream); override;
   procedure DoBuildSubs(aProp: Tk2CustomProperty;
    const aChecker: If1AtomChecker); override;
 end;//Tf1LeafTagDataFromDTP

implementation

uses
 l3ImplUses
 , evdTypes
 , nevTools
 , k2Tags
 , BaseTypesUnit
 , nsTagString
 , SysUtils
 , l3Variant
 , l3Base
 //#UC START# *4C727C300081impl_uses*
 //#UC END# *4C727C300081impl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsParentedTagData.imp.pas}

procedure Tf1LeafTagDataFromDTP.DoSetWStyle(const aValue: IStream);
//#UC START# *4C6EAFC9029B_4C727C300081_var*
//#UC END# *4C6EAFC9029B_4C727C300081_var*
begin
//#UC START# *4C6EAFC9029B_4C727C300081_impl*
 if (aValue = nil) then
 begin
  if (Self.Get_Comment <> nil) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=280009251
  // http://mdp.garant.ru/pages/viewpage.action?pageId=280009251&focusedCommentId=281526643#comment-281526643
  // http://mdp.garant.ru/pages/viewpage.action?pageId=280009251&focusedCommentId=281526656#comment-281526656
   f_Provider.RemoveChildComment(Self.EntryPoint)
 end//aValue = nil
 else
  f_Provider.SetChildComment(Self.EntryPoint, aValue);
//#UC END# *4C6EAFC9029B_4C727C300081_impl*
end;//Tf1LeafTagDataFromDTP.DoSetWStyle

procedure Tf1LeafTagDataFromDTP.DoBuildSubs(aProp: Tk2CustomProperty;
 const aChecker: If1AtomChecker);
//#UC START# *4C722FFF0364_4C727C300081_var*

var
 l_Para  : InevPara;
 l_Cont  : InevDocumentContainer;
 
 procedure RealizeSub(aLayer : Integer; aSub: Tl3Variant);
 begin//RealizeSub
  if (l_Para = nil) then
   if aChecker.Tag.QT(InevPara, l_Para) then
    l_Cont := l_Para.DocumentContainer
   else
    Assert(false);
  if (l_Cont <> nil) then
   // - может оказаться, что параграф не привязан к документу, или документ
   //   не привязан к контейнеру.
   l_Cont.RealizeSub(aLayer, aSub, aChecker.Tag.AsObject);
 end;//RealizeSub

var
 l_List   : ISubList;
 l_Index  : Integer;
 l_ID     : Longword;
 l_Subs   : Tl3Variant;
 l_Sub    : Tl3Variant;
 l_Layer  : Integer;
 l_BMList : IBookmarkList;
 l_BM     : TBookmark2;
 l_S      : TnsTagString;
//#UC END# *4C722FFF0364_4C727C300081_var*
begin
//#UC START# *4C722FFF0364_4C727C300081_impl*
 l_Subs := nil;
 f_Provider.GetSubList(Self.EntryPoint, l_List);
 if (l_List <> nil) AND (l_List.Count > 0) then
 begin
  for l_Index := 0 to Pred(l_List.Count) do
  begin
   l_ID := l_List[l_Index];
   Assert(l_ID <= High(Integer));
   l_Layer := Ord(ev_sbtSub);
   if (l_Subs = nil) then
    l_Subs := aChecker.CheckAtom(aProp);
   l_Sub := l_Subs.cAtomEx([k2_tiChildren, k2_tiHandle, l_Layer,
                            k2_tiChildren, k2_tiHandle, l_ID], nil);
   RealizeSub(l_Layer, l_Sub);
  end;//for l_Index
 end;//l_List <> nil

 if (aChecker.Tag.IntA[k2_tiHandle] <> 0) then
 // - иначем Дима зачем-то присылает мне закладки от документа
 try
  f_Provider.GetChildBookmarks(Self.EntryPoint, l_BMList);
  if (l_BMList <> nil) AND (l_BMList.Count > 0) then
  begin
   for l_Index := 0 to Pred(l_BMList.Count) do
   begin
    l_BMList.pm_GetItem(l_Index, l_BM);
    l_Layer := Ord(ev_sbtBookmark);
    if (l_Subs = nil) then
     l_Subs := aChecker.CheckAtom(aProp);
    l_Sub := l_Subs.cAtomEx([k2_tiChildren, k2_tiHandle, l_Layer,
                             k2_tiChildren, k2_tiHandle, Integer(l_BM.rParaId)], nil);
    l_S := TnsTagString.Create(l_BM.rName);
    try
     l_Sub.AttrW[k2_tiShortName, nil] := l_S;
    finally
     FreeAndNil(l_S);
    end;//try..finally
    l_Sub.IntA[k2_tiFlags] := 4;
    // - чтобы флажок нарисовался
    RealizeSub(l_Layer, l_Sub);
   end;//for l_Index
  end;//l_BMList <> nil
 except
  on EEmptyResult do;
 end;//try..except
//#UC END# *4C722FFF0364_4C727C300081_impl*
end;//Tf1LeafTagDataFromDTP.DoBuildSubs

end.
