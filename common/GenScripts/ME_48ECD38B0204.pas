unit evMultiSelectionRange;

// Модуль: "w:\common\components\gui\Garant\Everest\evMultiSelectionRange.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evMultiSelectionLocation
 , nevTools
 , nevRangeList
 , evdInterfaces
 , l3Variant
 , nevBase
 , evTypes
 , l3Interfaces
 , l3IID
;

type
 TevMultiSelectionRange = class(TevMultiSelectionLocation, InevRange, InevRangeModify)
  private
   f_Blocks: TnevRangeList;
    {* Поле для свойства Blocks }
  protected
   function GetData: IevdDataObject; virtual; abstract;
   function GetAsStorable: InevDataObjectPrim2; virtual; abstract;
   function SolidBottomChildBlock(const aView: InevView): InevRange;
   function GetChildSel(const aView: InevView;
    aChildIndex: Integer;
    aForDrawing: Boolean): InevRange;
   procedure GetBorderPoints(out BS: InevBasePoint;
    out BF: InevBasePoint);
   function BottomChildBlock(const aView: InevView): InevRange;
   function CloneSel(const aView: InevView): InevRange;
   function Delete(const aView: InevView;
    const anOp: InevOp = nil;
    aMode: TevClearMode = ev_cmAll;
    const aPara: InevPara = nil): Boolean;
   function Modify: InevRangeModify;
   function ParentRange(aLevel: Integer = 0): InevRange;
   function Contains(const aView: InevView;
    const aPoint: InevBasePoint): Boolean;
   procedure Select(const aView: InevView;
    const C: InevBasePoint;
    aTarget: TevSelectTarget;
    const Ctx: InevOp = nil); overload;
   procedure Select(const aView: InevView;
    const C: InevBasePoint;
    aOpen: Integer;
    aClose: Integer;
    const Ctx: InevOp = nil); overload;
   function pm_GetBorders: TevPair;
   function pm_GetData: IevdDataObject;
   function Solid(const aView: InevView): Boolean;
   function ContainsEnd(const aView: InevView): Boolean;
   function Collapsed(const aView: InevView): Boolean;
   function AsStorable: InevDataObjectPrim2;
   function GetRange: InevRange; override;
   procedure RefreshBorders;
    {* Обновляет границы блока. http://mdp.garant.ru/pages/viewpage.action?pageId=409750147 }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  public
   constructor Create(aTagWrap: Tl3Variant;
    aBlocks: TnevRangeList); reintroduce;
   class function Make(aTagWrap: Tl3Variant;
    aBlocks: TnevRangeList): InevRange;
   class function MakePrim(aTagWrap: Tl3Variant;
    aBlocks: TnevRangeList): InevRange; reintroduce;
   function SearchReplace(const aSearcher: IevSearcher;
    const aReplacer: IevReplacer;
    const aConfirm: InevConfirm;
    const aCursor: InevBasePoint = nil;
    const anOpPack: InevOp = nil;
    aNeedProgress: Boolean = True): Boolean;
    {* процесс поиска/замены. Возвращает - была ли отмена замены. }
   function Search(const aView: InevView;
    const aSearcher: IevSearcher;
    const Progress: Il3Progress;
    const aStart: InevBasePoint;
    out cFStart: InevBasePoint;
    out cFFinish: InevBasePoint): Boolean;
    {* ищет в выделении критерий ОnSearch
             и возвращает начало и конец найденного фрагмента в (cFStart, cFFinish). }
  protected
   property Blocks: TnevRangeList
    read f_Blocks;
    {* список блоков выделения }
 end;//TevMultiSelectionRange

implementation

uses
 l3ImplUses
 , l3Base
 , k2Tags
 , evLeafParaMultiSelectionBlock
 , evTextParaMultiSelectionBlock
 , nevNavigation
 , evExcept
 , evMultiSelectionBlock
 , nevFacade
 , SysUtils
 , LeafPara_Const
 , TextPara_Const
;

constructor TevMultiSelectionRange.Create(aTagWrap: Tl3Variant;
 aBlocks: TnevRangeList);
//#UC START# *48ECD4B70275_48ECD38B0204_var*
//#UC END# *48ECD4B70275_48ECD38B0204_var*
begin
//#UC START# *48ECD4B70275_48ECD38B0204_impl*
 inherited Create(aTagWrap);
 l3Set(f_Blocks, aBlocks);
//#UC END# *48ECD4B70275_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Create

class function TevMultiSelectionRange.Make(aTagWrap: Tl3Variant;
 aBlocks: TnevRangeList): InevRange;
//#UC START# *48ECD60002E0_48ECD38B0204_var*
//#UC END# *48ECD60002E0_48ECD38B0204_var*
begin
//#UC START# *48ECD60002E0_48ECD38B0204_impl*
 if (aBlocks <> nil) AND (aBlocks.Count = 1) then
  // - нефига создавать мультивыделение, если кусок выделения один
  Result := aBlocks.First
 else
 begin
  if aTagWrap.IsKindOf(k2_typTextPara) then
   Result := TevTextParaMultiSelectionBlock.Make(aTagWrap, aBlocks)
  else
  if aTagWrap.IsKindOf(k2_typLeafPara) then
   Result := TevLeafParaMultiSelectionBlock.Make(aTagWrap, aBlocks)
  else
   Result := MakePrim(aTagWrap, aBlocks);
 end;//(aBlocks <> nil) AND (aBlocks.Count = 1)
//#UC END# *48ECD60002E0_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Make

class function TevMultiSelectionRange.MakePrim(aTagWrap: Tl3Variant;
 aBlocks: TnevRangeList): InevRange;
var
 l_Inst : TevMultiSelectionRange;
begin
 l_Inst := Create(aTagWrap, aBlocks);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevMultiSelectionRange.MakePrim

function TevMultiSelectionRange.SolidBottomChildBlock(const aView: InevView): InevRange;
//#UC START# *47C690AB02EE_48ECD38B0204_var*
//#UC END# *47C690AB02EE_48ECD38B0204_var*
begin
//#UC START# *47C690AB02EE_48ECD38B0204_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C690AB02EE_48ECD38B0204_impl*
end;//TevMultiSelectionRange.SolidBottomChildBlock

function TevMultiSelectionRange.GetChildSel(const aView: InevView;
 aChildIndex: Integer;
 aForDrawing: Boolean): InevRange;
//#UC START# *47C691F0012A_48ECD38B0204_var*

var
 l_WasChildBlock : Boolean;
 l_List          : TnevRangeList;

 function l_AddBlock(aBlock: PIUnknown; anIndex: Long): Boolean;
 var
  l_ChildBlock : InevRange;
 begin//l_AddBlock
  Result := true;
  l_ChildBlock := InevRange(aBlock^).GetChildSel(aView, aChildIndex, aForDrawing);
  try
   if (l_ChildBlock = nil) then
   begin
    if l_WasChildBlock then
     // - был уже такой ребенок, а сейчас нету - надо прекращать итератор
     Result := false;
   end
   else
   begin
    l_List.Add(l_ChildBlock);
   end;//l_ChildBlock = nil
  finally
   l_ChildBlock := nil;
  end;//try..finally
 end;//l_AddBlock

var
 l_Para : InevPara;
//#UC END# *47C691F0012A_48ECD38B0204_var*
begin
//#UC START# *47C691F0012A_48ECD38B0204_impl*
 if GetRedirect.Child[aChildIndex].QT(InevPara, l_Para) then
  try
   if Solid(aView) then
    Result := l_Para.Range
   else
   begin
    l_WasChildBlock := false;
    l_List := TnevRangeList.Make;
    try
     f_Blocks.IterateAllF(l3L2IA(@l_AddBlock));
     if l_List.Empty then
      Result := nil
     else
      Result := TevMultiSelectionBlock.Make(l_Para.AsObject, l_List);
    finally
     l3Free(l_List);
    end;//try..finally
   end;//Solid
  finally
   l_Para := nil;
  end//try..finally
 else
  Assert(false);
//#UC END# *47C691F0012A_48ECD38B0204_impl*
end;//TevMultiSelectionRange.GetChildSel

procedure TevMultiSelectionRange.GetBorderPoints(out BS: InevBasePoint;
 out BF: InevBasePoint);
//#UC START# *47C691FB0055_48ECD38B0204_var*
var
 l_Start  : InevBasePoint;
 l_Finish : InevBasePoint;
//#UC END# *47C691FB0055_48ECD38B0204_var*
begin
//#UC START# *47C691FB0055_48ECD38B0204_impl*
 if (f_Blocks = nil) OR f_Blocks.Empty then
 begin
  BS := nil;
  BF := nil;
 end//f_Blocks = nil..
 else
 begin
  if (f_Blocks.Count = 1) then
   f_Blocks.First.GetBorderPoints(BS, BF)
  else
  begin
   f_Blocks.First.GetBorderPoints(BS, l_Finish);
   f_Blocks.Last.GetBorderPoints(l_Start, BF);
  end;//f_Blocks.Count = 1
 end;//f_Blocks = nil..
//#UC END# *47C691FB0055_48ECD38B0204_impl*
end;//TevMultiSelectionRange.GetBorderPoints

function TevMultiSelectionRange.BottomChildBlock(const aView: InevView): InevRange;
//#UC START# *47C6920B01B2_48ECD38B0204_var*
//#UC END# *47C6920B01B2_48ECD38B0204_var*
begin
//#UC START# *47C6920B01B2_48ECD38B0204_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C6920B01B2_48ECD38B0204_impl*
end;//TevMultiSelectionRange.BottomChildBlock

function TevMultiSelectionRange.CloneSel(const aView: InevView): InevRange;
//#UC START# *47C6924201FA_48ECD38B0204_var*
var
 l_List : TnevRangeList;
//#UC END# *47C6924201FA_48ECD38B0204_var*
begin
//#UC START# *47C6924201FA_48ECD38B0204_impl*
 l_List := f_Blocks.Clone;
 try
  Result := Make(GetRedirect, l_List);
 finally
  l3Free(l_List);
 end;//try..finally
//#UC END# *47C6924201FA_48ECD38B0204_impl*
end;//TevMultiSelectionRange.CloneSel

function TevMultiSelectionRange.Delete(const aView: InevView;
 const anOp: InevOp = nil;
 aMode: TevClearMode = ev_cmAll;
 const aPara: InevPara = nil): Boolean;
//#UC START# *47C6928C0243_48ECD38B0204_var*

 function lp_Delete(const aRef : PIUnknown; anIndex: Integer): Boolean;
 begin
  Result := True;
  if InevRange(aRef^).Modify.Delete(aView, anOp, aMode, aPara) then
   Delete := True;
 end;

//#UC END# *47C6928C0243_48ECD38B0204_var*
begin
//#UC START# *47C6928C0243_48ECD38B0204_impl*
 Result := False;
 Blocks.IterateAllF(l3L2IA(@lp_Delete));
 if Result then
  Blocks.Clear;
//#UC END# *47C6928C0243_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Delete

function TevMultiSelectionRange.Modify: InevRangeModify;
//#UC START# *47C692B301BF_48ECD38B0204_var*
//#UC END# *47C692B301BF_48ECD38B0204_var*
begin
//#UC START# *47C692B301BF_48ECD38B0204_impl*
 Result := Self;
//#UC END# *47C692B301BF_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Modify

function TevMultiSelectionRange.ParentRange(aLevel: Integer = 0): InevRange;
//#UC START# *47C692C10136_48ECD38B0204_var*
//#UC END# *47C692C10136_48ECD38B0204_var*
begin
//#UC START# *47C692C10136_48ECD38B0204_impl*
 Result := Self;
//#UC END# *47C692C10136_48ECD38B0204_impl*
end;//TevMultiSelectionRange.ParentRange

function TevMultiSelectionRange.Contains(const aView: InevView;
 const aPoint: InevBasePoint): Boolean;
//#UC START# *47C692CC024C_48ECD38B0204_var*

 function _DoChild(aBlock: PIUnknown; anIndex: Long): Boolean;
 begin//_DoChild
  Result := not InevRange(aBlock^).Contains(aView, aPoint);
  if not Result then
   Contains := True;
 end;//_DoChild

//#UC END# *47C692CC024C_48ECD38B0204_var*
begin
//#UC START# *47C692CC024C_48ECD38B0204_impl*
 Result := False;
 if Assigned(f_Blocks) and not f_Blocks.Empty then
  f_Blocks.IterateAllF(l3L2IA(@_DoChild));
//#UC END# *47C692CC024C_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Contains

procedure TevMultiSelectionRange.Select(const aView: InevView;
 const C: InevBasePoint;
 aTarget: TevSelectTarget;
 const Ctx: InevOp = nil);
//#UC START# *47C6960502ED_48ECD38B0204_var*
//#UC END# *47C6960502ED_48ECD38B0204_var*
begin
//#UC START# *47C6960502ED_48ECD38B0204_impl*
 if (Blocks <> nil) AND (Blocks.Count = 1) then
  Blocks.First.Select(aView, C, aTarget, Ctx);
//#UC END# *47C6960502ED_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Select

procedure TevMultiSelectionRange.Select(const aView: InevView;
 const C: InevBasePoint;
 aOpen: Integer;
 aClose: Integer;
 const Ctx: InevOp = nil);
//#UC START# *47C696160251_48ECD38B0204_var*
//#UC END# *47C696160251_48ECD38B0204_var*
begin
//#UC START# *47C696160251_48ECD38B0204_impl*
 if (Blocks <> nil) AND (Blocks.Count = 1) then
  Blocks.First.Select(aView, C, aOpen, aClose, Ctx);
//#UC END# *47C696160251_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Select

function TevMultiSelectionRange.pm_GetBorders: TevPair;
//#UC START# *47C6962E028E_48ECD38B0204get_var*
var
 l_Start  : InevBasePoint;
 l_Finish : InevBasePoint;
//#UC END# *47C6962E028E_48ECD38B0204get_var*
begin
//#UC START# *47C6962E028E_48ECD38B0204get_impl*
 GetBorderPoints(l_Start, l_Finish);
 if (l_Start = nil) then
  Result.rStart := 0
 else
  Result.rStart := l_Start.Position;
 if (l_Finish = nil) then
  Result.rFinish := High(Long)
 else
  Result.rFinish := l_Finish.Position;
//#UC END# *47C6962E028E_48ECD38B0204get_impl*
end;//TevMultiSelectionRange.pm_GetBorders

function TevMultiSelectionRange.pm_GetData: IevdDataObject;
//#UC START# *47C696B603E7_48ECD38B0204get_var*
//#UC END# *47C696B603E7_48ECD38B0204get_var*
begin
//#UC START# *47C696B603E7_48ECD38B0204get_impl*
 Result := GetData;
//#UC END# *47C696B603E7_48ECD38B0204get_impl*
end;//TevMultiSelectionRange.pm_GetData

function TevMultiSelectionRange.Solid(const aView: InevView): Boolean;
//#UC START# *47FF53790028_48ECD38B0204_var*
//#UC END# *47FF53790028_48ECD38B0204_var*
begin
//#UC START# *47FF53790028_48ECD38B0204_impl*
 if (f_Blocks = nil) OR f_Blocks.Empty then
  // - если нет, то считаем, что выделен объект целиком
  Result := true
 else
 if (f_Blocks.Count = 1) then
  // - если в выделении 1 блок
  Result := f_Blocks.First.Solid(aView)
  //   то смотрим, он целиковый или нет
 else
  Result := false;
  // - если несколько кусков выделения, то выделение "нецельное"
//#UC END# *47FF53790028_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Solid

function TevMultiSelectionRange.ContainsEnd(const aView: InevView): Boolean;
//#UC START# *47FF5C3D017E_48ECD38B0204_var*
//#UC END# *47FF5C3D017E_48ECD38B0204_var*
begin
//#UC START# *47FF5C3D017E_48ECD38B0204_impl*
 if Solid(aView) then
  Result := true
 else
  Result := f_Blocks.Last.ContainsEnd(aView);
//#UC END# *47FF5C3D017E_48ECD38B0204_impl*
end;//TevMultiSelectionRange.ContainsEnd

function TevMultiSelectionRange.Collapsed(const aView: InevView): Boolean;
//#UC START# *47FF5F3702F6_48ECD38B0204_var*

 function _DoChild(aBlock: PIUnknown; anIndex: Long): Boolean;
 begin//_DoChild
  Result := InevRange(aBlock^).Collapsed(aView);
  if not Result then
   Collapsed := False;
 end;//_DoChild

//#UC END# *47FF5F3702F6_48ECD38B0204_var*
begin
//#UC START# *47FF5F3702F6_48ECD38B0204_impl*
 Result := True;
 if Assigned(f_Blocks) and not f_Blocks.Empty then
  f_Blocks.IterateAllF(l3L2IA(@_DoChild))
//#UC END# *47FF5F3702F6_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Collapsed

function TevMultiSelectionRange.AsStorable: InevDataObjectPrim2;
//#UC START# *48EC8339027A_48ECD38B0204_var*
//#UC END# *48EC8339027A_48ECD38B0204_var*
begin
//#UC START# *48EC8339027A_48ECD38B0204_impl*
 Result := GetAsStorable;
//#UC END# *48EC8339027A_48ECD38B0204_impl*
end;//TevMultiSelectionRange.AsStorable

function TevMultiSelectionRange.GetRange: InevRange;
//#UC START# *48ECD1D903A1_48ECD38B0204_var*
//#UC END# *48ECD1D903A1_48ECD38B0204_var*
begin
//#UC START# *48ECD1D903A1_48ECD38B0204_impl*
 Result := Self;
//#UC END# *48ECD1D903A1_48ECD38B0204_impl*
end;//TevMultiSelectionRange.GetRange

function TevMultiSelectionRange.SearchReplace(const aSearcher: IevSearcher;
 const aReplacer: IevReplacer;
 const aConfirm: InevConfirm;
 const aCursor: InevBasePoint = nil;
 const anOpPack: InevOp = nil;
 aNeedProgress: Boolean = True): Boolean;
 {* процесс поиска/замены. Возвращает - была ли отмена замены. }
//#UC START# *49E83F480351_48ECD38B0204_var*
var
 i,
 l_Count : Integer;
 l_S,
 l_F     : InevBasePoint;
 l_Block : InevRange;
//#UC END# *49E83F480351_48ECD38B0204_var*
begin
//#UC START# *49E83F480351_48ECD38B0204_impl*
 Result := false;
 if (Blocks.Count > 0) then
 begin
  if Assigned(anOpPack) then
   anOpPack.Lock;
  try
   l_Count := Blocks.Count - 1;
   for i := 0 to l_Count do
   begin
    l_Block := Blocks[i];
    l_Block.GetBorderPoints(l_S, l_F);
    if aCursor.Compare(l_F) < 0 then
     try
      Result := l_Block.SearchReplace(aSearcher, aReplacer, aConfirm, aCursor, anOpPack, aNeedProgress);
      if Result then
       break;
     except
      on EevSearchFailed do
       if i = l_Count then
        raise;
     end;
   end;
   if i > l_Count then
    raise EevSearchFailed.Create(ev_warSearchFailed);
  finally
   if Assigned(anOpPack) then
    anOpPack.Unlock;
  end;//try..finally
 end;//Blocks.Count > 0
//#UC END# *49E83F480351_48ECD38B0204_impl*
end;//TevMultiSelectionRange.SearchReplace

function TevMultiSelectionRange.Search(const aView: InevView;
 const aSearcher: IevSearcher;
 const Progress: Il3Progress;
 const aStart: InevBasePoint;
 out cFStart: InevBasePoint;
 out cFFinish: InevBasePoint): Boolean;
 {* ищет в выделении критерий ОnSearch
             и возвращает начало и конец найденного фрагмента в (cFStart, cFFinish). }
//#UC START# *49E843B10236_48ECD38B0204_var*
//#UC END# *49E843B10236_48ECD38B0204_var*
begin
//#UC START# *49E843B10236_48ECD38B0204_impl*
 Result := false;
 Assert(false);
//#UC END# *49E843B10236_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Search

procedure TevMultiSelectionRange.RefreshBorders;
 {* Обновляет границы блока. http://mdp.garant.ru/pages/viewpage.action?pageId=409750147 }
//#UC START# *50B727F00221_48ECD38B0204_var*
//#UC END# *50B727F00221_48ECD38B0204_var*
begin
//#UC START# *50B727F00221_48ECD38B0204_impl*
 
//#UC END# *50B727F00221_48ECD38B0204_impl*
end;//TevMultiSelectionRange.RefreshBorders

procedure TevMultiSelectionRange.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48ECD38B0204_var*
//#UC END# *479731C50290_48ECD38B0204_var*
begin
//#UC START# *479731C50290_48ECD38B0204_impl*
 l3Free(f_Blocks);
 inherited;
//#UC END# *479731C50290_48ECD38B0204_impl*
end;//TevMultiSelectionRange.Cleanup

function TevMultiSelectionRange.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_48ECD38B0204_var*
var
 l_HyperLink : IevHyperLink;

 function lp_SearchPara(const aRef : PIUnknown; anIndex: Integer): Boolean;
 var
  l_Selection: InevRange;
  l_TempHyperLink: IevHyperLink;
 begin
  l_Selection := InevRange(aRef^);
  Result := True;
  if Supports(l_Selection, IevHyperLink, l_TempHyperLink) and l_TempHyperLink.Exists then
  begin
   if Assigned(l_HyperLink) then
   begin
    Result := l_HyperLink.ID = l_TempHyperLink.ID;
    if not Result then
     l_HyperLink := nil;
   end
   else
    l_HyperLink := l_TempHyperLink;
  end;
 end;

//#UC END# *4A60B23E00C3_48ECD38B0204_var*
begin
//#UC START# *4A60B23E00C3_48ECD38B0204_impl*
 Result.SetOk;
 if IID.EQ(IevHyperlink) then
 begin
  l_HyperLink := nil;
  Blocks.IterateAllF(l3L2IA(@lp_SearchPara));
  if not Assigned(l_HyperLink) then
   Result := inherited COMQueryInterface(IID, Obj)
  else
   IevHyperlink(Obj) := l_HyperLink;
 end//IID.EQ(IevHyperlink)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_48ECD38B0204_impl*
end;//TevMultiSelectionRange.COMQueryInterface

end.
