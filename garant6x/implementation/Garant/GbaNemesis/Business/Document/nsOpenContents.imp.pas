{$IfNDef nsOpenContents_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsOpenContents.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Common::Business::BaseDocument::nsOpenContents
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsOpenContents_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _nsOpenContents_ = {mixin} class(_nsOpenContents_Parent_)
 public
 // realized methods
   procedure OpenContents(const aTree: IdeSimpleTree;
    anForceOpen: TnsContentsOpenMode;
    const aContainerOfDocument: InevDocumentContainer);
 protected
 // overridden protected methods
   procedure ClearAllDS; override;
   procedure FillState; override;
 protected
 // protected fields
   f_MustKepContentsTree : Boolean;
 end;//_nsOpenContents_
{$Else}

 _nsOpenContents_ = _nsOpenContents_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else nsOpenContents_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _nsOpenContents_

procedure _nsOpenContents_.OpenContents(const aTree: IdeSimpleTree;
  anForceOpen: TnsContentsOpenMode;
  const aContainerOfDocument: InevDocumentContainer);
//#UC START# *4953D3B20211_4DF9B9980075_var*
var
 l_NeedMake: TvcmNeedMakeDS;
 l_P : IdeDocInfoProvider;
//#UC END# *4953D3B20211_4DF9B9980075_var*
begin
//#UC START# *4953D3B20211_4DF9B9980075_impl*
 Assert(aContainerOfDocument <> nil);
 if not Supports(aContainerOfDocument, IdeDocInfoProvider, l_P) then
  Assert(false);
 Assert(l_P.DocInfo <> nil);
 Assert(l_P.DocInfo.Doc <> nil);
 if (anForceOpen = ns_comNotForce) then
  if (SetData.ContentsTree <> aTree) then
   anForceOpen := ns_comForce;
 SetData.ContentsTree := aTree;
 f_MustKepContentsTree := afw.Application.Data.InUpdate;
 // Закрываем дерева нет
 if not Assigned(aTree) OR aTree.Empty then
 begin
  // Для того чтобы исправить такую проблему -
  //   если автопоказ оглавления включен и не было изначально оглавления
  //   то при вставке первого комментария оно не самооткроется.
  l_NeedMake := SetData.dsContentsRef.NeedMake;
  SetData.dsContentsRef.Clear;
  SetData.dsContentsRef.NeedMake := l_NeedMake
 end//not Assigned(aTree)
 else
 // Пользователь открыл руками, вперед
 if (anForceOpen = ns_comForce) OR
    (_Instance_R_(Self).pm_GetDsContents.SimpleTree <> aTree.Contents) then
 begin
  SetData.dsContentsRef.Clear;
  SetData.dsContentsRef.NeedMake := vcm_nmYes;
 end;//anForceOpen..
(* if (SetData.dsContentsRef.NeedMake <> vcm_nmNo) then
 // - запил напильником.. очередной
 //   ибо сборки и историю надо переделывать с чистого листа.
 //   Проект Морозова - не прошёл.
 //   http://mdp.garant.ru/pages/viewpage.action?pageId=267324195&focusedCommentId=269070590#comment-269070590
 begin
  SetData.dsAnnotationRef.Referred := nil;
  SetData.dsRelatedDocRef.Referred := nil;
 end;//SetData.dsContentsRef.NeedMake <> vcm_nmNo*)
 // - ХУЙ ВАМ.. номер не прошёл, там SetData остаётся от ГК, а не Конституции
 if l_P.DocInfo.Doc.IsSameRedaction(SetData.DocInfo.Doc) then
 //if not g_Dispatcher.History.InBF then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=267324195
 // Иначе DocumentWithContents оказывается от ГК, а не от Конституции
  Refresh;
//#UC END# *4953D3B20211_4DF9B9980075_impl*
end;//_nsOpenContents_.OpenContents

procedure _nsOpenContents_.ClearAllDS;
//#UC START# *4925B7F00156_4DF9B9980075_var*
//#UC END# *4925B7F00156_4DF9B9980075_var*
begin
//#UC START# *4925B7F00156_4DF9B9980075_impl*
 inherited;
 SetData.dsContentsRef.Referred := nil;
 if not f_MustKepContentsTree then
  SetData.ContentsTree := nil;
 f_MustKepContentsTree := False;
//#UC END# *4925B7F00156_4DF9B9980075_impl*
end;//_nsOpenContents_.ClearAllDS

procedure _nsOpenContents_.FillState;
//#UC START# *493D51ED0329_4DF9B9980075_var*
//#UC END# *493D51ED0329_4DF9B9980075_var*
begin
//#UC START# *493D51ED0329_4DF9B9980075_impl*
 inherited;
 // Авто открытие "Структура документа"
 with SetData.dsContentsRef do
  if NeedMake <> vcm_nmForce then
   NeedMake := vcm_nmYes;
//#UC END# *493D51ED0329_4DF9B9980075_impl*
end;//_nsOpenContents_.FillState

{$IfEnd} //not Admin AND not Monitorings

{$EndIf nsOpenContents_imp}
