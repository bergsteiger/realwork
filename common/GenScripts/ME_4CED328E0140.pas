unit nsCommentStorer;

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsCommentStorer.pas"
// —тереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , evCommentPara_Wrap
 , nevTools
 , l3Variant
;

type
 TnsCommentStorer = class(TevCommentStorer)
  protected
   class procedure NotifyOtherTexts(const anObj: InevObject);
   class procedure ForceStore(aTag: Tl3Variant); override;
 end;//TnsCommentStorer

implementation

uses
 l3ImplUses
 , nsTagNodePrim
 , nsCommentMemoryStream
 , SysUtils
 , k2Tags
 , evdInterfaces
 , Classes
 , evTypes
 , l3Memory
 , F1TagDataProviderInterface
 , LegalDomain_DocumentNotifications_Controls
 , evDocumentsCache
 , l3Base
 , l3Types
 , l3InterfacesMisc
 , nsNativeCommentPara
;

class procedure TnsCommentStorer.NotifyOtherTexts(const anObj: InevObject);
//#UC START# *4CED3A7F0099_4CED328E0140_var*

var
 l_ID   : Integer;
 l_Cont : InevObjectHolder;

  // ¬роде бы уже успешно сообщаем другим контейнерам, когда что-то происходит
  // с комментарием, по-другому. ј здесь - ассерт
  // http://mdp.garant.ru/pages/viewpage.action?pageId=474153528
  // http://mdp.garant.ru/pages/viewpage.action?pageId=296619114
(* function DoContainer(aDoc: PIUnknown; anIndex: Integer): Boolean;
 var
  l_Other : InevDocumentContainer;
  l_Para  : InevObject;
  l_Obj   : TObject;
  l_PID   : Integer;
  l_List  : InevObjectList;
 begin//DoContainer
  Result := true;
  l_Other := InevDocumentContainer(aDoc^);
  if not l3IEQ(l_Other, l_Cont) AND l_Other.IsSameText(l_Cont) then
  begin
   // - это "тот же самый текст" - надо ему сообщить, что комментарий изменилс€
   if l_Other.FindObjByID(l_ID, l_Para) then
   begin
    l_PID := l_Para.PID;
    l_List := l_Para.OwnerObj;
    if (l_PID + 1 < l_List.Count) then
    begin
     l_Obj := l_List[l_PID + 1].AsObject;
(*     if (l_Obj Is TnsCommentNode) then
     begin
      TnsTagNodePrim(l_Obj).ResetStyle;
      if (l_Other.TextSource <> nil) then
       l_Other.TextSource.ViewArea.Invalidate;
     end//l_Obj Is TnsCommentNode
     else*)
(*     if (l_Obj Is TnsNativeCommentPara) then
     begin
      Assert(false);
      // - здесь надо что-нибудь поделать
     end;//l_Obj Is TnsNativeCommentPara
    end;//l_PID + 1 < l_List.Count
   end;//l_Other.FindObjByID(l_ID, l_Para)
  end;//not l3IEQ(InevDocumentContainer(aDoc^), aContainer)..
 end;//DoContainer *)


var
 l_PID : Integer;
//#UC END# *4CED3A7F0099_4CED328E0140_var*
begin
//#UC START# *4CED3A7F0099_4CED328E0140_impl*
(* l_Cont := anObj.Holder;
 if (l_Cont <> nil) then
 begin
  l_PID := anObj.PID;
  if (l_PID > 0) then
  begin
   l_ID := anObj.OwnerObj[l_PID - 1].IntA[k2_tiHandle];
   TevDocumentsCache.IterateF(l3L2IA(@DoContainer));
  end;//l_PID > 0
 end;//l_Cont <> nil *)
//#UC END# *4CED3A7F0099_4CED328E0140_impl*
end;//TnsCommentStorer.NotifyOtherTexts

class procedure TnsCommentStorer.ForceStore(aTag: Tl3Variant);
//#UC START# *4CED30D901C7_4CED328E0140_var*
var
 l_Obj   : InevObject;
 l_Range : InevRange;
 l_Mem   : Tl3MemoryStream;
 l_Sink  : If1CommentSink;
//#UC END# *4CED30D901C7_4CED328E0140_var*
begin
//#UC START# *4CED30D901C7_4CED328E0140_impl*
 inherited;
 if aTag.QI(If1CommentSink, l_Sink) then
  try
   if not (ns_nsInParse in l_Sink.State) AND
      (ns_nsChanged in l_Sink.State) then
   begin
    l_Sink.State := l_Sink.State - [ns_nsChanged];
    if aTag.QT(InevObject, l_Obj) then
     try
      l_Range := l_Obj.Range;
      l_Mem := TnsCommentMemoryStream.Make;
      try
       //l_Range.Data.Store(cf_EverestBinForce, Tl3FileStream.Make('c:\1.evd', l3_fmWrite), nil, [evd_sfInternal, evd_sfChildrenOnly]);
       l_Range.Data.Store(cf_EverestBinForce, l_Mem, nil, [evd_sfInternal, evd_sfChildrenOnly]);
       l_Mem.Seek(0, soBeginning);
       l_Sink.Store(l_Mem);
      finally
       FreeAndNil(l_Mem);
      end;//try..finally
      (*NotifyOtherTexts(l_Obj);*)
     finally
      l_Obj := nil;
     end//try..finally
    else
     Assert(false);
    Op_Comment_Changed.Broadcast; 
    // http://mdp.garant.ru/pages/viewpage.action?pageId=254939822
   end;//Node <> nil
  finally
   l_Sink := nil;
  end;//try..finally
//#UC END# *4CED30D901C7_4CED328E0140_impl*
end;//TnsCommentStorer.ForceStore

initialization
//#UC START# *4CED32FD0118*
 evCommentPara_Wrap.g_CommentStorer := TnsCommentStorer;
//#UC END# *4CED32FD0118*

end.
