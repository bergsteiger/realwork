unit nevParaList;
 {* Реализация инструмента InevParaList }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevParaList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevParaList" MUID: (48CE0B85029C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevPara
 , nevTools
 , nevBase
 , l3Variant
 , l3Interfaces
;

type
 TnevParaList = class(TnevPara, InevObjectList, InevParaList, InevParaListModify)
  {* Реализация инструмента InevParaList }
  protected
   function GetParaCount: TnevParaIndex; virtual;
   function GetPara(anIndex: TnevParaIndex): InevPara; virtual;
   function GetIndexOfObj(const aPara: InevObject): TnevParaIndex; virtual;
   function GetModify: InevParaListModify; virtual;
   procedure CheckPrev(const anOp: InevOp;
    aPara: Tl3Variant;
    aPID: Integer); virtual;
   function IndexOfObj(const aPara: InevObject): TnevParaIndex;
   function pm_GetCount: TnevParaIndex;
   function pm_GetLeafShapeCount: Integer;
   function pm_GetObj(anIndex: TnevParaIndex): InevObject;
   function pm_GetAlmostLinear: Boolean;
   function GetParas(aFrom: TnevParaIndex = nev_piFirst;
    aTo: TnevParaIndex = nev_piLast): InevParas;
    {* возвращает список параграфов. }
   function Modify: InevParaListModify;
   function pm_GetParaCount: TnevParaIndex;
   function pm_GetPara(anIndex: TnevParaIndex): InevPara;
   function InsertPara(aPID: TnevParaIndex;
    aPara: Tl3Variant;
    const anOp: InevOp;
    aFlags: TevInsertParaFlags = [ev_ipfNeedFire]): Boolean;
    {* вставляет параграф в указанную позицию. }
   function InsertDefaultPara(aPID: TnevParaIndex;
    const anOp: InevOp;
    aNeedFire: Boolean = True): Boolean;
    {* вставляет параграф с типом по-умолчанию в указанную позицию. }
   function IteratePara(anAction: InevParaList_IteratePara_Action;
    aLo: TnevParaIndex = nev_piFirst;
    aHi: TnevParaIndex = nev_piLast;
    aLoadedOnly: Boolean = False): Integer; virtual;
   function IterateParaF(anAction: InevParaList_IteratePara_Action;
    aLo: TnevParaIndex = nev_piFirst;
    aHi: TnevParaIndex = nev_piLast;
    aLoadedOnly: Boolean = False): Integer;
   function GetIsList: Boolean; override;
   function GetToList: InevObjectList; override;
   function GetAsList: InevParaList; override;
   function DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
    aLo: Tl3Index;
    aHi: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   function GetIsVertical: Boolean; override;
   function GetIsEmpty: Boolean; override;
  public
   class function Make(aTag: Tl3Variant): InevParaList; reintroduce;
 end;//TnevParaList
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , k2Tags
 , l3Math
 , nevParas
 , nevFacade
 , l3Base
 , l3MinMax
 , k2Base
 , k2Const
 , SysUtils
 , evCursorTools
 , evMsgCode
 , k2Facade
 , k2OpMisc
 , Para_Const
 , k2Interfaces
;

class function TnevParaList.Make(aTag: Tl3Variant): InevParaList;
var
 l_Inst : TnevParaList;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevParaList.Make

function TnevParaList.GetParaCount: TnevParaIndex;
//#UC START# *48CFA8770265_48CE0B85029C_var*
//#UC END# *48CFA8770265_48CE0B85029C_var*
begin
//#UC START# *48CFA8770265_48CE0B85029C_impl*
 Result := TagInst.ChildrenCount;
//#UC END# *48CFA8770265_48CE0B85029C_impl*
end;//TnevParaList.GetParaCount

function TnevParaList.GetPara(anIndex: TnevParaIndex): InevPara;
//#UC START# *48CFA8920170_48CE0B85029C_var*
var
 l_Child : Tl3Variant;
 l_Para  : InevParaInternal;
//#UC END# *48CFA8920170_48CE0B85029C_var*
begin
//#UC START# *48CFA8920170_48CE0B85029C_impl*
 l_Child := TagInst.Child[anIndex];
 if not l_Child.QT(InevParaInternal, l_Para) then
 begin
  if l_Child.IsKindOf(k2_typPara) then
   l_Para := TnevPara.Make(l_Child)
  else
  begin
   Result := nev.NullPara;
   Exit;
  end;//l_Child.IsKindOf(k2_typPara)
 end;//l_Child.QT(InevParaInternal, l_Para)
 l_Para.SignalPID(anIndex);
 Result := l_Para;
 Result.ParentTool := Self;
//#UC END# *48CFA8920170_48CE0B85029C_impl*
end;//TnevParaList.GetPara

function TnevParaList.GetIndexOfObj(const aPara: InevObject): TnevParaIndex;
//#UC START# *48CFA8C301F4_48CE0B85029C_var*
//#UC END# *48CFA8C301F4_48CE0B85029C_var*
begin
//#UC START# *48CFA8C301F4_48CE0B85029C_impl*
 Result := TagInst.IndexOfChild(aPara.AsObject.Box);
//#UC END# *48CFA8C301F4_48CE0B85029C_impl*
end;//TnevParaList.GetIndexOfObj

function TnevParaList.GetModify: InevParaListModify;
//#UC START# *48CFA8E10140_48CE0B85029C_var*
//#UC END# *48CFA8E10140_48CE0B85029C_var*
begin
//#UC START# *48CFA8E10140_48CE0B85029C_impl*
 Result := Self;
//#UC END# *48CFA8E10140_48CE0B85029C_impl*
end;//TnevParaList.GetModify

procedure TnevParaList.CheckPrev(const anOp: InevOp;
 aPara: Tl3Variant;
 aPID: Integer);
//#UC START# *4C8DE3B00073_48CE0B85029C_var*
//#UC END# *4C8DE3B00073_48CE0B85029C_var*
begin
//#UC START# *4C8DE3B00073_48CE0B85029C_impl*
//#UC END# *4C8DE3B00073_48CE0B85029C_impl*
end;//TnevParaList.CheckPrev

function TnevParaList.IndexOfObj(const aPara: InevObject): TnevParaIndex;
//#UC START# *47C6A568017D_48CE0B85029C_var*
//#UC END# *47C6A568017D_48CE0B85029C_var*
begin
//#UC START# *47C6A568017D_48CE0B85029C_impl*
 Result := GetIndexOfObj(aPara);
//#UC END# *47C6A568017D_48CE0B85029C_impl*
end;//TnevParaList.IndexOfObj

function TnevParaList.pm_GetCount: TnevParaIndex;
//#UC START# *47C6A5770114_48CE0B85029Cget_var*
//#UC END# *47C6A5770114_48CE0B85029Cget_var*
begin
//#UC START# *47C6A5770114_48CE0B85029Cget_impl*
 Result := TagInst.ChildrenCount;
//#UC END# *47C6A5770114_48CE0B85029Cget_impl*
end;//TnevParaList.pm_GetCount

function TnevParaList.pm_GetLeafShapeCount: Integer;
//#UC START# *47C6A58A02B6_48CE0B85029Cget_var*
//#UC END# *47C6A58A02B6_48CE0B85029Cget_var*
begin
//#UC START# *47C6A58A02B6_48CE0B85029Cget_impl*
 Result := IntA[k2_tiAllChildrenCount];
//#UC END# *47C6A58A02B6_48CE0B85029Cget_impl*
end;//TnevParaList.pm_GetLeafShapeCount

function TnevParaList.pm_GetObj(anIndex: TnevParaIndex): InevObject;
//#UC START# *47C6A596031E_48CE0B85029Cget_var*
//#UC END# *47C6A596031E_48CE0B85029Cget_var*
begin
//#UC START# *47C6A596031E_48CE0B85029Cget_impl*
 Result := pm_GetPara(anIndex);
//#UC END# *47C6A596031E_48CE0B85029Cget_impl*
end;//TnevParaList.pm_GetObj

function TnevParaList.pm_GetAlmostLinear: Boolean;
//#UC START# *47C6A5C6002E_48CE0B85029Cget_var*
var
 l_PC                : Integer;
 l_LeafChildrenCount : Integer;
//#UC END# *47C6A5C6002E_48CE0B85029Cget_var*
begin
//#UC START# *47C6A5C6002E_48CE0B85029Cget_impl*
 l_PC := pm_GetParaCount;
 l_LeafChildrenCount := pm_GetLeafShapeCount;
 if (l_PC <> l_LeafChildrenCount) then
 begin
  if (l_LeafChildrenCount = 0) then
   Result := false
  else
   Result := l3MulDiv(Abs(l_LeafChildrenCount - l_PC), 100, l_LeafChildrenCount) < 5;
 end//l_PC <> l_LeafChildrenCount
 else
  Result := true;
//#UC END# *47C6A5C6002E_48CE0B85029Cget_impl*
end;//TnevParaList.pm_GetAlmostLinear

function TnevParaList.GetParas(aFrom: TnevParaIndex = nev_piFirst;
 aTo: TnevParaIndex = nev_piLast): InevParas;
 {* возвращает список параграфов. }
//#UC START# *47C6AC130151_48CE0B85029C_var*

var
 l_List : TnevParas;

 function DoChild(const aChild: InevPara; anIndex: Integer): Boolean;
 begin//DoChild
  Result := true;
  l_List.Add(aChild);
 end;//DoChild

//#UC END# *47C6AC130151_48CE0B85029C_var*
begin
//#UC START# *47C6AC130151_48CE0B85029C_impl*
 l_List := TnevParas.Make;
 try
  Result := l_List;
  IterateParaF(nevL2PIA(@DoChild), aFrom, aTo);
 finally
  l3Free(l_List);
 end;//try..finally
//#UC END# *47C6AC130151_48CE0B85029C_impl*
end;//TnevParaList.GetParas

function TnevParaList.Modify: InevParaListModify;
//#UC START# *47C6AC79001C_48CE0B85029C_var*
//#UC END# *47C6AC79001C_48CE0B85029C_var*
begin
//#UC START# *47C6AC79001C_48CE0B85029C_impl*
 Result := GetModify;
//#UC END# *47C6AC79001C_48CE0B85029C_impl*
end;//TnevParaList.Modify

function TnevParaList.pm_GetParaCount: TnevParaIndex;
//#UC START# *47C6AC870058_48CE0B85029Cget_var*
//#UC END# *47C6AC870058_48CE0B85029Cget_var*
begin
//#UC START# *47C6AC870058_48CE0B85029Cget_impl*
 Result := GetParaCount;
//#UC END# *47C6AC870058_48CE0B85029Cget_impl*
end;//TnevParaList.pm_GetParaCount

function TnevParaList.pm_GetPara(anIndex: TnevParaIndex): InevPara;
//#UC START# *47C6AC9F01DF_48CE0B85029Cget_var*
//#UC END# *47C6AC9F01DF_48CE0B85029Cget_var*
begin
//#UC START# *47C6AC9F01DF_48CE0B85029Cget_impl*
 Result := GetPara(anIndex); 
//#UC END# *47C6AC9F01DF_48CE0B85029Cget_impl*
end;//TnevParaList.pm_GetPara

function TnevParaList.InsertPara(aPID: TnevParaIndex;
 aPara: Tl3Variant;
 const anOp: InevOp;
 aFlags: TevInsertParaFlags = [ev_ipfNeedFire]): Boolean;
 {* вставляет параграф в указанную позицию. }
//#UC START# *47C6ACC90087_48CE0B85029C_var*

var
 l_ParaList : Tl3Variant;
 l_InsPara  : InevPara;

 function CheckParaInAnotherList: Boolean;
 var
  l_Flags    : TevDeleteParaFlags;
  l_Point    : InevBasePoint;
  l_TagOwner : Tl3Variant;
  l_Tag      : Tl3Variant;
  l_Para     : InevPara;
 begin//CheckParaInAnotherList
  if (anOp = nil) OR not anOp.InUndo then
  // - в случае Undo не надо ничего проверять, т.к. в Undo буфере должна
  //   лежать правильная структура.
  begin
   Result := false;
   l_TagOwner := l_InsPara.AsObject.Owner;
   if (l_TagOwner <> nil) AND l_TagOwner.IsValid then
   begin
    // - сначала надо удалить параграф из его родителя
    if not l_InsPara.AsObject.QT(InevPara, l_Para) then
     Assert(false);
    l_Point := l_Para.MakePoint.PointToParent;
    try
     if l_TagOwner.IsSame(l_ParaList) then
     begin
      if (l_Point.Position = Succ(aPID)) then
      // - параграф уже вставлен в правильное место
      begin
       InsertPara := true;
       Exit;
      end;//l_Point.Position = Succ(aPID)
     end;//l_TagOwner.IsSame(l_ParaList)
     l_Tag := l_ParaList;
     while l_Tag.IsValid do
     // - проверяем - а не являемся ли мы дочерним параграфом, вставляемого параграфа 
     begin
      if l_Tag.IsSame(l_InsPara.AsObject) then
      begin
       InsertPara := false;
       Exit;
      end;//l_Tag.EQ(l_InsPara)
      l_Tag := l_Tag.Owner;
     end;//while l_Tag.IsValid
     l_Flags := [ev_dpfInternal];
     if ev_ipfForce in aFlags then
      l_Flags := l_Flags + [ev_dpfForce]; 
     if not evDeletePara(anOp, l_Point, l_Flags) then
     begin
      InsertPara := false;
      Exit;
     end;//not evDeletePara..
    finally
     l_Point := nil;
    end;//try..finally
   end;//l_TagOwner.IsValid
  end;//(anOp = nil) OR not anOp.InUndo
  Result := true;
 end;//CheckParaInAnotherList

 procedure FireInsertion;
 begin//FireInsertion
  if ev_ipfNeedFire in aFlags then
   k2.SignalEvent(Self, k2_eidChildrenInserted, l_ParaList, anOp, aPID, 1, pm_GetParaCount);
 end;//FireInsertion

var
 l_PID  : TnevParaIndex;
 l_Para : Tl3Tag;
//#UC END# *47C6ACC90087_48CE0B85029C_var*
begin
//#UC START# *47C6ACC90087_48CE0B85029C_impl*
 Result := false;
 if not aPara.QT(InevPara, l_InsPara) then
  Assert(false);
 if not l_InsPara.AsObject.IsValid then Exit;
 l_ParaList := TagInst;
 if (aPID = nev_piLast) then
  l_PID := pm_GetParaCount
 else
  l_PID := aPID;
 if not CheckParaInAnotherList then
  // - не удалось удалить параграф из прежнего родителя
  Exit;
 l_Para := l_InsPara.AsObject;
 if (ev_ipfCheckPrev in aFlags) and (l_PID < pm_GetParaCount) then
  CheckPrev(anOp, l_Para, l_PID);
 l_ParaList.InsertChildTag(l_PID, l_Para.Box, anOp);
 FireInsertion;
 // - сообщаем заинтересованным лицам, что произошла вставка параграфа
 Result := true;
 // - сигнализируем об успехе
//#UC END# *47C6ACC90087_48CE0B85029C_impl*
end;//TnevParaList.InsertPara

function TnevParaList.InsertDefaultPara(aPID: TnevParaIndex;
 const anOp: InevOp;
 aNeedFire: Boolean = True): Boolean;
 {* вставляет параграф с типом по-умолчанию в указанную позицию. }
//#UC START# *47C6ACE6026E_48CE0B85029C_var*
var
 l_Para : Tl3Variant;
//#UC END# *47C6ACE6026E_48CE0B85029C_var*
begin
//#UC START# *47C6ACE6026E_48CE0B85029C_impl*
 l_Para := Tk2Type(TagInst.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
 try
  if aNeedFire then
   Result := InsertPara(aPID, l_Para, anOp, [ev_ipfNeedFire])
  else
   Result := InsertPara(aPID, l_Para, anOp, []);
 finally
  l_Para := nil;
 end;//try..finally
//#UC END# *47C6ACE6026E_48CE0B85029C_impl*
end;//TnevParaList.InsertDefaultPara

function TnevParaList.IteratePara(anAction: InevParaList_IteratePara_Action;
 aLo: TnevParaIndex = nev_piFirst;
 aHi: TnevParaIndex = nev_piLast;
 aLoadedOnly: Boolean = False): Integer;
//#UC START# *4BB0751F00A4_48CE0B85029C_var*

 function DoChild(aChild: Tl3Variant; anIndex: Integer): Boolean;
 var
  l_Para : InevParaInternal;
 begin//DoChild
  if not aChild.QT(InevParaInternal, l_Para) then
   if aChild.IsKindOf(k2_typPara) then
    l_Para := TnevPara.Make(aChild)
   else
   begin
    Result := true;
    Exit;
   end;//aChild.IsKindOf(k2_typPara)
  l_Para.SignalPID(anIndex);
  l_Para.ParentTool := Self;
  Result := anAction(l_Para, anIndex);
 end;//DoChild

//#UC END# *4BB0751F00A4_48CE0B85029C_var*
begin
//#UC START# *4BB0751F00A4_48CE0B85029C_impl*
 aLo := Max(0, aLo);
 Result := TagInst.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DoChild), aLo, aHi, aLoadedOnly);
//#UC END# *4BB0751F00A4_48CE0B85029C_impl*
end;//TnevParaList.IteratePara

function TnevParaList.IterateParaF(anAction: InevParaList_IteratePara_Action;
 aLo: TnevParaIndex = nev_piFirst;
 aHi: TnevParaIndex = nev_piLast;
 aLoadedOnly: Boolean = False): Integer;
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := IteratePara(anAction, aLo, aHi, aLoadedOnly);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;//TnevParaList.IterateParaF

function TnevParaList.GetIsList: Boolean;
//#UC START# *48CE681402F4_48CE0B85029C_var*
//#UC END# *48CE681402F4_48CE0B85029C_var*
begin
//#UC START# *48CE681402F4_48CE0B85029C_impl*
 Result := true;
//#UC END# *48CE681402F4_48CE0B85029C_impl*
end;//TnevParaList.GetIsList

function TnevParaList.GetToList: InevObjectList;
//#UC START# *48CE699100FE_48CE0B85029C_var*
//#UC END# *48CE699100FE_48CE0B85029C_var*
begin
//#UC START# *48CE699100FE_48CE0B85029C_impl*
 Result := Self;
//#UC END# *48CE699100FE_48CE0B85029C_impl*
end;//TnevParaList.GetToList

function TnevParaList.GetAsList: InevParaList;
//#UC START# *48CE69D3015A_48CE0B85029C_var*
//#UC END# *48CE69D3015A_48CE0B85029C_var*
begin
//#UC START# *48CE69D3015A_48CE0B85029C_impl*
 Result := Self;
//#UC END# *48CE69D3015A_48CE0B85029C_impl*
end;//TnevParaList.GetAsList

function TnevParaList.DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index;
 aHi: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *48CF96D80241_48CE0B85029C_var*

 function DoChild(const aPara: InevPara; anIndex: TnevParaIndex): Boolean;
 begin//DoChild
  Result := Action(aPara.AsObject, anIndex);
 end;//DoChild

//#UC END# *48CF96D80241_48CE0B85029C_var*
begin
//#UC START# *48CF96D80241_48CE0B85029C_impl*
 try
  Result := IterateParaF(nevL2PIA(@DoChild), aLo, aHi, aLoadedOnly);
 finally
  k2FreeTIA(Action);
 end;//try..finally 
//#UC END# *48CF96D80241_48CE0B85029C_impl*
end;//TnevParaList.DoIterateChildrenF

function TnevParaList.GetIsVertical: Boolean;
//#UC START# *48CF9EB2030B_48CE0B85029C_var*
//#UC END# *48CF9EB2030B_48CE0B85029C_var*
begin
//#UC START# *48CF9EB2030B_48CE0B85029C_impl*
 Result := (TagInst.IntA[k2_tiOrientation] = Ord(ev_orVertical));
//#UC END# *48CF9EB2030B_48CE0B85029C_impl*
end;//TnevParaList.GetIsVertical

function TnevParaList.GetIsEmpty: Boolean;
//#UC START# *48CF9F4F01D0_48CE0B85029C_var*
//#UC END# *48CF9F4F01D0_48CE0B85029C_var*
begin
//#UC START# *48CF9F4F01D0_48CE0B85029C_impl*
 Result := (pm_GetParaCount <= 0);
//#UC END# *48CF9F4F01D0_48CE0B85029C_impl*
end;//TnevParaList.GetIsEmpty
{$IfEnd} // Defined(k2ForEditor)

end.
