{$IfNDef BlockSelector_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BlockSelector.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::BlockSelector
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BlockSelector_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BlockSelector_ = {abstract form} class(_BlockSelector_Parent_)
 private
 // private fields
   f_NotFoundBlocks : Tl3LongintList;
    {* Не найденные блоки}
   f_FoundBlocks : TnsFoundBlocksList;
    {* Найденные блоки}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure ClearBlocksInfo;
     {* Очищает информацию о найденных и ненайденных блоках }
   function NeedGotoNeighbours: Boolean; virtual; abstract;
     {* Надо ли переходить на соседей блока }
 public
 // public methods
   function GotoBlock(const aBlock: IevDocumentPart): Boolean;
     {* Переходит на ближайший возможный блок }
   function GotoSub(const aPara: IeePara): Boolean;
     {* Переход на Sub принадлежащий параграфу }
 end;//_BlockSelector_
{$Else}

 _BlockSelector_ = _BlockSelector_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BlockSelector_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _BlockSelector_

function _BlockSelector_.GotoBlock(const aBlock: IevDocumentPart): Boolean;
//#UC START# *4C06874C0070_4C0686B8005B_var*

 function IsActive(const aBlock : IevDocumentPart): Boolean;
 var
  l_P : InevBasePoint;
 begin
  Result := false;
  if (Text.View <> nil) then
  begin
   l_P := Text.View.TopAnchor;
   while (l_P <> nil) do
   begin
    if l_P.Obj.AsObject.IsKindOf(k2_typBlock) then
     if (l_P.Obj.AsObject.IntA[k2_tiHandle] = aBlock.ID) AND
        (l_P.Obj.AsObject.IntA[k2_tiLayerID] = aBlock.LayerID) then
     begin
      Result := true;
      Exit;
     end;//l_P.Obj.IntA[k2_tiHandle] = aBlock.ID
    l_P := l_P.Inner;
   end;//while (l_P <> nil)
  end;//Text.View <> nil
 end;

 function GotoNeighbours(const aBlock : IevDocumentPart): Boolean;

  procedure AddNotFoundBlock(anID : Integer);
  begin
   if (f_NotFoundBlocks = nil) then
    f_NotFoundBlocks := Tl3LongintList.MakeSorted;
   f_NotFoundBlocks.Add(anID); 
  end;

  function IsNotFoundBlock(anID : Integer): Boolean;
  var
   l_Index : Integer;
  begin
   if (f_NotFoundBlocks = nil) then
    Result := false
   else
    Result := f_NotFoundBlocks.FindData(anID, l_Index);
  end;

  procedure AddFoundBlock(anID : Integer; const aPoint : InevBasePoint);
  begin
   if (f_FoundBlocks = nil) then
   begin
    f_FoundBlocks := TnsFoundBlocksList.Create;
    f_FoundBlocks.Sorted := true;
   end;//f_FoundBlocks = nil
   f_FoundBlocks.Add(TnsFoundBlockInfo_C(anID, aPoint));
  end;

  function IsFoundBlock(aFindID : Integer; aAddID : Integer): Boolean;
  var
   l_Index : Integer;
  begin
   if (f_FoundBlocks = nil) then
    Result := false
   else
   begin
    Result := f_FoundBlocks.FindData(TnsFoundBlockInfo_C(aFindID), l_Index);
    if Result then
    begin
     with f_FoundBlocks.Items[l_Index] do
     begin
      InevSelection(Text.Selection).SelectPoint(rPoint, true);
      if (aFindID <> aAddID) then
       f_FoundBlocks.Add(TnsFoundBlockInfo_C(aAddID, rPoint));
     end;//with f_FoundBlocks.Items[l_Index]
    end;//Result
   end;//f_FoundBlocks = nil
  end;

  function GotoPrev: Boolean;
  var
   l_Para  : InevPara;
   l_Point : InevBasePoint;
   l_Sub   : IevSub;
   l_ID    : Integer;
   l_First : Boolean;
   l_Parent : IevDocumentPart;
   l_Total  : Integer;
  begin//GotoPrev
   Result := false;
   aBlock.Exists;
   // - это чтобы CheckExists дёрнуть
   // http://mdp.garant.ru/pages/viewpage.action?pageId=217693836&focusedCommentId=218464911#comment-218464911
   Assert(aBlock.Para <> nil);
   if not aBlock.Para.IsValid then
   // - заплатка для ААК
   // http://mdp.garant.ru/pages/viewpage.action?pageId=398276192
    Exit;
   Assert(aBlock.Para.IsValid);
   if not aBlock.Para.QT(InevPara, l_Para) then
    Assert(false);
   l_Total := 0; 
   l_First := true; 
   l_Para := l_Para.Prev;
   while true do
   begin
    while (l_Para <> nil) AND l_Para.AsObject.IsValid do
    begin
     Inc(l_Total);
     if (l_Total > 1000) then
      Exit;
     if l_Para.AsObject.IsKindOf(k2_typBlock) AND
        (l_Para.AsObject.IntA[k2_tiLayerID] = Ord(ev_sbtSub)) then
     begin
      l_ID := l_Para.AsObject.IntA[k2_tiHandle];
      if IsFoundBlock(l_ID, aBlock.ID) then
      begin
       Result := true;
       Exit;
      end;//IsFoundBlock(l_ID, aBlock.ID)
      if IsNotFoundBlock(l_ID) then
       Exit;
      l_Sub := TextSource.DocumentContainer.SubList.Sub[l_ID];
      if l_Sub.Select(Text.Selection) then
      begin
       Result := true;
       // Тут ещё надо на конец сместиться
       if not l_Sub.Para.QT(InevPara, l_Para) then
        Assert(false);
       l_Point := l_Para.MakePoint;
       l_Point.Move(Text.View, ev_ocBottomRight);
       l_Point := l_Point.PointToParentByLevel(MaxInt);
       InevSelection(Text.Selection).SelectPoint(l_Point, true);
       AddFoundBlock(aBlock.ID, l_Point);
       Exit;
      end;//TextSource.DocumentContainer.SubList...
     end;//l_Para.IsKindOf(k2_typBlock)
     l_Para := l_Para.Prev;
    end;//while (l_Para <> nil) AND l_Para.IsValid
    if l_First then
    begin
     // - а тут пытаемся сместиться на предыдущего родителя
     // http://mdp.garant.ru/pages/viewpage.action?pageId=177144278&focusedCommentId=185205414#comment-185205414
     l_Parent := aBlock.ParentDocumentPart;
     if (l_Parent = nil) OR not l_Parent.Para.IsValid then
      Exit;
     if l_Parent.Para.IsKindOf(k2_typDocument) then
      Exit; 
     if not l_Parent.Para.QT(InevPara, l_Para) then
      Exit;
     l_Para := l_Para.Prev;
     if (l_Para = nil) OR not l_Para.AsObject.IsValid then
      Exit; 
     if not l_Para.IsList then
      Exit;
     with l_Para.AsList do
      if (ParaCount = 0) then
       Exit
      else
       l_Para := Para[ParaCount - 1]; 
     l_First := false;
    end//l_First
    else
     Exit;
   end;//while l_First
  end;//GotoPrev

 begin//GotoNeighbours
  Result := false;
  if not NeedGotoNeighbours then
   Exit;
  if IsFoundBlock(aBlock.ID, aBlock.ID) then
  begin
   Result := true;
   Exit;
  end;//IsFoundBlock(aBlock.ID..
  if IsNotFoundBlock(aBlock.ID) then
   Exit;
  if GotoPrev then
   Result := true;
  if not Result then
   AddNotFoundBlock(aBlock.ID);
 end;//GotoNeighbours

var
 l_FirstIteration : Boolean;
 l_Block          : IevDocumentPart;
//#UC END# *4C06874C0070_4C0686B8005B_var*
begin
//#UC START# *4C06874C0070_4C0686B8005B_impl*
 Result := true;
 // - будем оптимистами
 l_FirstIteration := true;
 l_Block := aBlock;
 while (l_Block <> nil) do
 begin
  if IsActive(l_Block) then
   break;
  if (l_Block.ID > 0) OR TextSource.HasDocument then
   if TextSource.DocumentContainer.SubList.Sub[l_Block.ID].Select(Text.Selection) then
    Exit;
  if l_FirstIteration then
  begin
   //l_FirstIteration := false;
   if GotoNeighbours(l_Block) then
    Exit;
  end;//l_FirstIteration
  l_Block := l_Block.ParentDocumentPart;
 end;//l_Block <> nil
 Result := false;
//#UC END# *4C06874C0070_4C0686B8005B_impl*
end;//_BlockSelector_.GotoBlock

procedure _BlockSelector_.ClearBlocksInfo;
//#UC START# *4C0688930095_4C0686B8005B_var*
//#UC END# *4C0688930095_4C0686B8005B_var*
begin
//#UC START# *4C0688930095_4C0686B8005B_impl*
 FreeAndNil(f_FoundBlocks);
 FreeAndNil(f_NotFoundBlocks);
//#UC END# *4C0688930095_4C0686B8005B_impl*
end;//_BlockSelector_.ClearBlocksInfo

function _BlockSelector_.GotoSub(const aPara: IeePara): Boolean;
//#UC START# *4C0691370291_4C0686B8005B_var*
//#UC END# *4C0691370291_4C0686B8005B_var*
var
 l_SubList : IeeSubList;
begin
//#UC START# *4C0691370291_4C0686B8005B_impl*
 Result := true;
 // - будем оптимистами
 l_SubList := aPara.Subs;
 if (l_SubList <> nil) AND (l_SubList.Count = 1) then
  if TextSource.DocumentContainer.SubList.Sub[l_SubList.Subs[0].ID].Select(Text.Selection) then
   Exit;
 Result := false;
//#UC END# *4C0691370291_4C0686B8005B_impl*
end;//_BlockSelector_.GotoSub

procedure _BlockSelector_.Cleanup;
//#UC START# *479731C50290_4C0686B8005B_var*
//#UC END# *479731C50290_4C0686B8005B_var*
begin
//#UC START# *479731C50290_4C0686B8005B_impl*
 ClearBlocksInfo;
 inherited;
//#UC END# *479731C50290_4C0686B8005B_impl*
end;//_BlockSelector_.Cleanup

{$If not defined(NoVCM)}
procedure _BlockSelector_.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4C0686B8005B_var*
//#UC END# *497469C90140_4C0686B8005B_var*
begin
//#UC START# *497469C90140_4C0686B8005B_impl*
 inherited;
 ClearBlocksInfo;
//#UC END# *497469C90140_4C0686B8005B_impl*
end;//_BlockSelector_.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

{$EndIf BlockSelector_imp}
