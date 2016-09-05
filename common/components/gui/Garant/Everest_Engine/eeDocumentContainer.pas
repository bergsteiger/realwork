unit eeDocumentContainer;
 {* Контейнер документа. }

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeDocumentContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeDocumentContainer" MUID: (4680E83D00C8)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeDocumentContainerPrim
 , k2TagGen
 , nevTools
 , nevBase
;

type
 TeeDocumentContainer = class(TeeDocumentContainerPrim)
  {* Контейнер документа. }
  protected
   function GetGeneratorPrim(const aView: InevView;
    const aGeneratorTarget: IUnknown): Tk2TagGenerator; override;
   procedure DoGetWriter(aFormat: TnevFormat;
    anInternal: Boolean;
    var theWriter: Tk2TagGenerator;
    aCodePage: Integer); override;
 end;//TeeDocumentContainer
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , evCommentParaDecorator
 , eeProcessor
 , evLeafParaDecorationsHolderEliminator
 , evBlocksEliminator
 , evdPageParamsFilter
 , evOp
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , CommentPara_Const
 , evTypes
 , evGeneratorsInterfaces
 , SysUtils
 , evUserCommentFilter
 , evCommentDecorator
 , evNestedDocumentEliminator
 , afwFacade
 , evCommentParaAdder
 , evPageBreakEliminator
 , evControlParaFilter
 , evTagsListFilter
 , k2Tags
 , LeafPara_Const
 , evBlocksButNotCommentsEliminator
 , evStrictContentsElementEliminator
 , l3Interfaces
 //#UC START# *4680E83D00C8impl_uses*
 //#UC END# *4680E83D00C8impl_uses*
;

function TeeDocumentContainer.GetGeneratorPrim(const aView: InevView;
 const aGeneratorTarget: IUnknown): Tk2TagGenerator;
//#UC START# *47F217080359_4680E83D00C8_var*
var
 l_MI        : InevBasePoint;
 l_Point     : InevBasePoint;
 l_Finish    : InevBasePoint;
 l_InComment : Boolean;
 l_Range     : InevRange;
 l_Next      : InevBasePoint;
 l_InsertToEditor : Boolean;
 l_NJG            : IevJoinGenerator;
//#UC END# *47F217080359_4680E83D00C8_var*
begin
//#UC START# *47F217080359_4680E83D00C8_impl*
 Result := inherited GetGeneratorPrim(aView, aGeneratorTarget);
 if (Result <> nil) then
 begin
  l_InComment := false;
  l_InsertToEditor := false;
  if Supports(aGeneratorTarget, InevRange, l_Range) {AND
     not l_Range.Collapsed}
     // - это проверка на то, что содержимое выделения уже удаляли
     then
   try
    l_InsertToEditor := true;
    l_Range.GetBorderPoints(l_Point, l_Finish);
    if (l_Point <> nil) then
    begin
     if (l_Finish = nil) then
      l_Point := nil
     else
      if not l_Point.MostInner.Obj.AsObject.IsSame(l_Finish.MostInner.Obj^.AsObject) then
      begin
       l_Point := nil;
       if l_Range.Obj.AsObject.IsKindOf(k2_typCommentPara) then // http://mdp.garant.ru/pages/viewpage.action?pageId=517785153
        l_InComment := true;
      end;
    end//l_Point <> nil
    else
    if l_Range.Obj.AsObject.IsKindOf(k2_typCommentPara) then
     l_InComment := true;
   finally
    l_Range := nil;
   end//try..finally
  else//Supports(aGeneratorTarget, InevRange, l_Range)
   l_Point := nil;
  if (l_Point <> nil) OR
     Supports(aGeneratorTarget, InevBasePoint, l_Point) then
   // - если это не курсор, то наверное и дергаться не стоит
   try
    l_InsertToEditor := True;
    l_InComment := evInPara(l_Point.MostInner.Obj^.AsObject, k2_typCommentPara);
    if not l_InComment then
    begin
     l_Next := l_Point.ClonePoint(aView);
     if l_Next.MostInner.Move(aView, ev_ocNextParaTopLeft{ev_ocParaDown}) then
     begin
      if evInPara(l_Next.MostInner.Obj^.AsObject, k2_typCommentPara) then
      begin
       l_InComment := true;
       l_Point.AssignPoint(aView, l_Next);
       FreeAndNil(Result);
       Result := inherited GetGeneratorPrim(aView, l_Point);
       if Supports(Result, IevJoinGenerator, l_NJG) then
        try
         l_NJG.NeedJoin := false;
        finally
         l_NJG := nil;
        end;//try..finally
      end//evInPara(l_Next.MostInner.Target, k2_idCommentPara)
      else
      begin
       l_MI := l_Point.MostInner;
       if l_MI.Obj^.StrA[k2_tiText] = '' then
       begin
        l_Point.AssignPoint(aView, l_Next);
        FreeAndNil(Result);
        Result := inherited GetGeneratorPrim(aView, l_Point);
       end; // if l_MI.Obj^.StrA[k2_tiText] = '' then
      end; 
     end;//l_Next.Move(ev_ocParaDown)
    end;//not l_InComment
   finally
    l_Point := nil;
   end;//try..finally
  if (aGeneratorTarget <> nil) then
  begin
   if l_InsertToEditor then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=274825304
    with TevTagsListFilter do
     Result := SetTo(
                Result,
                MakeAttrList(k2_typLeafPara,
                             [k2_tiHandle
                             , k2_tiSubs
                             // http://mdp.garant.ru/pages/viewpage.action?pageId=274825304&focusedCommentId=288788625#comment-288788625
                             ])
                )
   else
    with TevTagsListFilter do
     Result := SetTo(
                Result,
                MakeAttrList(k2_typLeafPara,
                             [k2_tiHandle
                             {, k2_tiSubs}
                             // http://mdp.garant.ru/pages/viewpage.action?pageId=274825304&focusedCommentId=288788625#comment-288788625
                             ])
                );
    // - фильтр, отрезающий идентификаторы параграфов и прочую хренотень
   //Result := TevParaIDEliminator.SetTo(Result);
    // - фильтр, отрезающий идентификаторы параграфов
   if l_InsertToEditor AND not l_InComment then
    Result := TevCommentParaAdder.SetTo(Self, Result);
    // - фильтр, заворачивающий любой текст в комментарий пользователя
   Result := TevPageBreakEliminator.SetTo(Result);
   // - Фильтр превращающий контролы из КЗ в обычные параграфы
   Result := TevControlParaFilter.SetTo(Result);
   // - фильтр, отрезающий разрывы страниц и разделов
   if l_InsertToEditor then
   begin
    if l_InComment then
     Result := TevBlocksEliminator.SetTo(Result)
     // - фильтр, отрезающий блоки
    else
     Result := TevBlocksButNotCommentsEliminator.SetTo(Result);
     // - фильтр, отрезающий блоки, но не комментарии
    TevStrictContentsElementEliminator.SetTo(Result); 
   end;//l_InsertToEditor
  end;//aGeneratorTarget <> nil
 end;//Result <> nil
//#UC END# *47F217080359_4680E83D00C8_impl*
end;//TeeDocumentContainer.GetGeneratorPrim

procedure TeeDocumentContainer.DoGetWriter(aFormat: TnevFormat;
 anInternal: Boolean;
 var theWriter: Tk2TagGenerator;
 aCodePage: Integer);
//#UC START# *483E6C150277_4680E83D00C8_var*
//#UC END# *483E6C150277_4680E83D00C8_var*
begin
//#UC START# *483E6C150277_4680E83D00C8_impl*
 inherited;
 if not anInternal then
 begin
  //TddSectionRepairFilter.SetTo(theWriter);
  if aFormat <> CF_PDF then
   if (afw.Application <> nil) AND
      (afw.Application.PrintManager <> nil) then
    TevdPageParamsFilter.SetTo(afw.Application.PrintManager.PageSetup,
                               nil, theWriter);
  if (aFormat <> cf_EverestBin) and
     (aFormat <> cf_EverestBinForce) and
     (aFormat <> cf_EverestTxt) then
  begin
(*   TevCommentParaDecorator.SetTo(theWriter);
   TddVersionCommentDecorator.SetTo(theWriter);*)
   if aFormat = CF_TEXT then
    TevCommentParaDecorator.SetTo(theWriter)
   else
    TevCommentDecorator.SetTo(theWriter);
   if aFormat <> CF_PDF then
    TevUserCommentFilter.SetTo(theWriter);
   TevNestedDocumentEliminator.SetTo(theWriter);
  end;//aFormat <> cf_EverestBin..
  TevLeafParaDecorationsHolderEliminator.SetTo(theWriter);
 end;//not anInternal
//#UC END# *483E6C150277_4680E83D00C8_impl*
end;//TeeDocumentContainer.DoGetWriter
{$IfEnd} // Defined(Nemesis)

end.
