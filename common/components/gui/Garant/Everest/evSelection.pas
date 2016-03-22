unit evSelection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evSelection.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Cursors::evSelection
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  l3Interfaces,
  k2Interfaces,
  l3Types,
  nevBase,
  nevTools,
  evdInterfaces,
  nevRangePrim,
  l3Core,
  l3Variant,
  k2ToolPrim,
  evTypes
  ;

type
 TevRange = class(TnevRangePrim, InevRange, InevStorable, IevdDataObject, InevDataObjectPrim2, InevRangeModify, InevRangeFactory, IevRange)
 private
 // private fields
   f_Sharp : Boolean;
    {* Поле для свойства Sharp}
 protected
 // realized methods
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload; 
     {* сохраняет выделение в G. }
   function Store(aFormat: TevdClipboardFormat;
    const aPool: IStream;
    const aFilters: TevdTagGenerator;
    aFlags: TevdStoreFlags = [evd_sfStoreParaEnd]): Boolean; overload; 
     {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
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
   procedure Init(const aStart: InevBasePoint;
     const aFinish: InevBasePoint;
     aSharp: Boolean = false);
   function Solid(const aView: InevView): Boolean;
   function ContainsEnd(const aView: InevView): Boolean;
   function Collapsed(const aView: InevView): Boolean;
   procedure AssignSel(const aView: InevView;
    const aSource: InevRange);
     {* присваивает одно выделение другому }
   function GetBlock: InevRange;
     {* получить текущий объект выделения }
   procedure SetToStart;
     {* установить выделение в начало }
   function Unselect(const aView: InevView): Boolean;
     {* снять выделение }
   function AsStorable: InevDataObjectPrim2;
   procedure SetToFinish(aMoveUpInLines: Integer);
   procedure RefreshBorders;
     {* Обновляет границы блока. http://mdp.garant.ru/pages/viewpage.action?pageId=409750147 }
 public
 // realized methods
   function SearchReplace(const aSearcher: IevSearcher;
     const aReplacer: IevReplacer;
     const aConfirm: InevConfirm;
     const aCursor: InevBasePoint = nil;
     const anOpPack: InevOp = nil;
     aNeedProgress: Boolean = true): Boolean;
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
 // overridden protected methods
   function GetRange: InevRange; override;
   function GetAsPoint: InevBasePoint; override;
   function DoGetStyle(Stop: PInteger): Tl3Variant; override;
   function DoGetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger): InevFontPrim; override;
   function DoInsertStream(const aView: InevView;
    const aStream: IStream;
    aFormat: TnevFormat;
    const anOp: InevOp;
    aFlags: TevLoadFlags;
    aCodePage: Integer): Boolean; override;
 public
 // overridden public methods
   procedure Assign(Source: Tk2ToolPrim); override;
 protected
 // protected methods
   procedure DoStore(const aView: InevView;
     const G: Ik2TagGenerator;
     aFlags: TevStoreFlags); virtual;
    {$If defined(evNeedEditableCursors) AND defined(evUseVisibleCursors)}
   function DoDelete(const aView: InevView;
     const anOpPack: InevOp = nil;
     aMode: TevClearMode = ev_cmAll;
     const aPara: InevPara = nil): Boolean; virtual;
    {$IfEnd} //evNeedEditableCursors AND evUseVisibleCursors
   function DoGetChildSel(const aView: InevView;
     aChildIndex: LongInt;
     aForDrawing: Boolean): InevRange; virtual;
   procedure DoRefreshBorders; virtual;
     {* Сигнатура метода DoRefreshBorders }
   procedure DeleteBeforeInsert(const aView: InevView;
     const anOp: InevOp); virtual;
   function SearchPrim(const aView: InevView;
     const aSearcher: IevSearcher;
     const Progress: Il3Progress;
     const aStart: InevBasePoint;
     out cFStart: InevBasePoint;
     out cFFinish: InevBasePoint): Boolean; virtual;
     {* ищет подстроку и возвращает найденную позицию в (cFStart, cFFinish) }
   function IsSolid(const aView: InevView): Boolean; virtual; abstract;
   function IsCollapsed(const aView: InevView): Boolean; virtual;
   function GetContainsEnd(const aView: InevView): Boolean; virtual;
   function TagReader: InevTagReader; virtual;
   function DoBottomChildBlock(const aView: InevView): InevRange; virtual;
   function DoGetBorders: TevPair; virtual;
   procedure DoGetBorderPoints(out theStart: InevBasePoint;
     out theFinish: InevBasePoint); virtual;
   function DoSearchReplace(const aSearcher: IevSearcher;
     const aReplacer: IevReplacer;
     const aConfirm: InevConfirm;
     const Cursor: InevBasePoint = nil;
     const anOpPack: InevOp = nil;
     aNeedProgress: Boolean = True): Boolean; virtual;
 public
 // public methods
   procedure DoInit(const aStart: InevBasePoint;
     const aFinish: InevBasePoint;
     aSharp: Boolean); virtual;
   procedure DoIterate(anAction: InevRangePrim_Iterate_Action;
     const Progress: Il3Progress = nil;
     const aMessage: Il3CString = nil;
     aStart: LongInt = l3MinIndex);
     {* перебирает подтеги, входящие в выделение и вызывает anAction для каждого }
   procedure DoIterateBack(anAction: InevRangePrim_Iterate_Action;
     const Progress: Il3Progress = nil;
     const aMessage: Il3CString = nil);
     {* перебирает подтеги, входящие в выделение и вызывает anAction для каждого }
   procedure DoIterateF(anAction: InevRangePrim_Iterate_Action;
     const Progress: Il3Progress = nil;
     const aMessage: Il3CString = nil;
     aStart: LongInt = l3MinIndex);
     {* перебирает подтеги, входящие в выделение и вызывает anAction для каждого }
   procedure DoIterateBackF(anAction: InevRangePrim_Iterate_Action;
     const Progress: Il3Progress = nil;
     const aMessage: Il3CString = nil);
     {* перебирает подтеги, входящие в выделение и вызывает anAction для каждого }
 public
 // public properties
   property Sharp: Boolean
     read f_Sharp
     write f_Sharp;
   property Borders: TevPair
     read pm_GetBorders;
 end;//TevRange
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  Classes,
  ParaList_Const,
  l3Stream,
  SysUtils,
  l3String,
  l3Base,
  nevInterfaces,
  nevFacade,
  Para_Const,
  evSelectConst,
  k2Tags,
  k2Base
  ;

// start class TevRange

procedure TevRange.DoInit(const aStart: InevBasePoint;
  const aFinish: InevBasePoint;
  aSharp: Boolean);
//#UC START# *5108D53B0312_4A2D2D4300BE_var*
//#UC END# *5108D53B0312_4A2D2D4300BE_var*
begin
//#UC START# *5108D53B0312_4A2D2D4300BE_impl*
 Sharp := aSharp; 
//#UC END# *5108D53B0312_4A2D2D4300BE_impl*
end;//TevRange.DoInit

procedure TevRange.DoStore(const aView: InevView;
  const G: Ik2TagGenerator;
  aFlags: TevStoreFlags);
//#UC START# *5108D5CB0048_4A2D2D4300BE_var*
//#UC END# *5108D5CB0048_4A2D2D4300BE_var*
begin
//#UC START# *5108D5CB0048_4A2D2D4300BE_impl*
 if not (evd_sfChildrenOnly in aFlags) then
 begin
  G.StartChild(GetRedirect.TagType);
  try
   GetRedirect.WriteTag(G)
  finally
   G.Finish;
  end;//try..finally
 end;//not (evd_sfChildrenOnly in aFlags)
//#UC END# *5108D5CB0048_4A2D2D4300BE_impl*
end;//TevRange.DoStore

{$If defined(evNeedEditableCursors) AND defined(evUseVisibleCursors)}
function TevRange.DoDelete(const aView: InevView;
  const anOpPack: InevOp = nil;
  aMode: TevClearMode = ev_cmAll;
  const aPara: InevPara = nil): Boolean;
//#UC START# *5108D66900C9_4A2D2D4300BE_var*
//#UC END# *5108D66900C9_4A2D2D4300BE_var*
begin
//#UC START# *5108D66900C9_4A2D2D4300BE_impl*
 Result := False;
//#UC END# *5108D66900C9_4A2D2D4300BE_impl*
end;//TevRange.DoDelete
{$IfEnd} //evNeedEditableCursors AND evUseVisibleCursors

function TevRange.DoGetChildSel(const aView: InevView;
  aChildIndex: LongInt;
  aForDrawing: Boolean): InevRange;
//#UC START# *52D79DFC0347_4A2D2D4300BE_var*
//#UC END# *52D79DFC0347_4A2D2D4300BE_var*
begin
//#UC START# *52D79DFC0347_4A2D2D4300BE_impl*
 Result := nil;
//#UC END# *52D79DFC0347_4A2D2D4300BE_impl*
end;//TevRange.DoGetChildSel

procedure TevRange.DoRefreshBorders;
//#UC START# *52D79E610203_4A2D2D4300BE_var*
//#UC END# *52D79E610203_4A2D2D4300BE_var*
begin
//#UC START# *52D79E610203_4A2D2D4300BE_impl*
 
//#UC END# *52D79E610203_4A2D2D4300BE_impl*
end;//TevRange.DoRefreshBorders

procedure TevRange.DeleteBeforeInsert(const aView: InevView;
  const anOp: InevOp);
//#UC START# *52D79E97007C_4A2D2D4300BE_var*
//#UC END# *52D79E97007C_4A2D2D4300BE_var*
begin
//#UC START# *52D79E97007C_4A2D2D4300BE_impl*
 Delete(aView, anOp, ev_cmForceKeepOne);
                  // ^ http://mdp.garant.ru/pages/viewpage.action?pageId=228693150
                  // чтобы не удалить ОБА идущих подряд пустых параграфа
//#UC END# *52D79E97007C_4A2D2D4300BE_impl*
end;//TevRange.DeleteBeforeInsert

function TevRange.SearchPrim(const aView: InevView;
  const aSearcher: IevSearcher;
  const Progress: Il3Progress;
  const aStart: InevBasePoint;
  out cFStart: InevBasePoint;
  out cFFinish: InevBasePoint): Boolean;
//#UC START# *52D79F3B0081_4A2D2D4300BE_var*
//#UC END# *52D79F3B0081_4A2D2D4300BE_var*
begin
//#UC START# *52D79F3B0081_4A2D2D4300BE_impl*
 Result := False;
 cFStart := nil;
 cFFinish := nil;
//#UC END# *52D79F3B0081_4A2D2D4300BE_impl*
end;//TevRange.SearchPrim

function TevRange.IsCollapsed(const aView: InevView): Boolean;
//#UC START# *52D79FB703C9_4A2D2D4300BE_var*
//#UC END# *52D79FB703C9_4A2D2D4300BE_var*
begin
//#UC START# *52D79FB703C9_4A2D2D4300BE_impl*
 Result := True;
//#UC END# *52D79FB703C9_4A2D2D4300BE_impl*
end;//TevRange.IsCollapsed

function TevRange.GetContainsEnd(const aView: InevView): Boolean;
//#UC START# *52D79FDF010B_4A2D2D4300BE_var*
//#UC END# *52D79FDF010B_4A2D2D4300BE_var*
begin
//#UC START# *52D79FDF010B_4A2D2D4300BE_impl*
 Result := False;
//#UC END# *52D79FDF010B_4A2D2D4300BE_impl*
end;//TevRange.GetContainsEnd

function TevRange.TagReader: InevTagReader;
//#UC START# *52D79FFA012A_4A2D2D4300BE_var*
//#UC END# *52D79FFA012A_4A2D2D4300BE_var*
begin
//#UC START# *52D79FFA012A_4A2D2D4300BE_impl*
 Result := nil;
//#UC END# *52D79FFA012A_4A2D2D4300BE_impl*
end;//TevRange.TagReader

function TevRange.DoBottomChildBlock(const aView: InevView): InevRange;
//#UC START# *52D7A3F100E0_4A2D2D4300BE_var*
//#UC END# *52D7A3F100E0_4A2D2D4300BE_var*
begin
//#UC START# *52D7A3F100E0_4A2D2D4300BE_impl*
 Result := Self; // - мы и есть блок самого нижнего уровня
//#UC END# *52D7A3F100E0_4A2D2D4300BE_impl*
end;//TevRange.DoBottomChildBlock

function TevRange.DoGetBorders: TevPair;
//#UC START# *52D7A46B016F_4A2D2D4300BE_var*
//#UC END# *52D7A46B016F_4A2D2D4300BE_var*
begin
//#UC START# *52D7A46B016F_4A2D2D4300BE_impl*
 l3FillChar(Result, SizeOf(Result), 0);
//#UC END# *52D7A46B016F_4A2D2D4300BE_impl*
end;//TevRange.DoGetBorders

procedure TevRange.DoGetBorderPoints(out theStart: InevBasePoint;
  out theFinish: InevBasePoint);
//#UC START# *52D7A56B029E_4A2D2D4300BE_var*
//#UC END# *52D7A56B029E_4A2D2D4300BE_var*
begin
//#UC START# *52D7A56B029E_4A2D2D4300BE_impl*
 
//#UC END# *52D7A56B029E_4A2D2D4300BE_impl*
end;//TevRange.DoGetBorderPoints

procedure TevRange.DoIterate(anAction: InevRangePrim_Iterate_Action;
  const Progress: Il3Progress = nil;
  const aMessage: Il3CString = nil;
  aStart: LongInt = l3MinIndex);
//#UC START# *52D7C54903BD_4A2D2D4300BE_var*

  function ChildFunc(Child: Tl3Variant; Index: Long): Boolean;
  var
   l_Range: InevRange;
  begin
   l_Range := GetChildSel(nil, Index, False);
   try
    if l_Range = nil then
     Result := True
    else
     Result := anAction(l_Range, Index);
   finally
    l_Range := nil;
   end;
  end;

  function ChildFuncProgress(Child: Tl3Variant; Index: Long): Boolean; 
  begin
   Result := anAction(GetChildSel(nil, Index, False), Index);
   Progress.Progress(Succ(Index));
  end;

var
 l_B: TevPair;
//#UC END# *52D7C54903BD_4A2D2D4300BE_var*
begin
//#UC START# *52D7C54903BD_4A2D2D4300BE_impl*
 if (Self <> nil) and Assigned(anAction) then
 begin
  l_B := Borders;
  if {(l_B.rFinish  - l_B.rStart >= 200) and} Assigned(Progress) then
  begin
   if l3IsNil(aMessage) then
    Progress.Start(l_B.rFinish - l_B.rStart, str_nevmmLongOperation.AsCStr)
   else
    Progress.Start(l_B.rFinish - l_B.rStart, aMessage);
   try
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ChildFuncProgress), aStart);
   finally
    Progress.Finish;
   end;{try..finally}
  end//Assigned(Progress)
  else
   IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@ChildFunc), aStart);
 end;{Self <> nil}
//#UC END# *52D7C54903BD_4A2D2D4300BE_impl*
end;//TevRange.DoIterate

procedure TevRange.DoIterateBack(anAction: InevRangePrim_Iterate_Action;
  const Progress: Il3Progress = nil;
  const aMessage: Il3CString = nil);
//#UC START# *52D7CB7B01EE_4A2D2D4300BE_var*

  function ChildFunc(Child: Tl3Variant; Index: Long): Boolean;
  var
   l_Range: InevRange;
  begin
   l_Range := GetChildSel(nil, Index, False);
   try
    if l_Range = nil then
     Result := True
    else
     Result := anAction(l_Range, Index);
   finally
    l_Range := nil;
   end;
  end;

  function ChildFuncProgress(Child: Tl3Variant; Index: Long): Boolean; 
  begin
   Result := anAction(GetChildSel(nil, Index, False), Index);
   Progress.Progress(Succ(Index));
  end;

var
 l_B: TevPair;
//#UC END# *52D7CB7B01EE_4A2D2D4300BE_var*
begin
//#UC START# *52D7CB7B01EE_4A2D2D4300BE_impl*
 if (Self <> nil) and Assigned(anAction) then
 begin
  l_B := Borders;
  if {(l_B.rFinish  - l_B.rStart >= 200) and} Assigned(Progress) then
  begin
   if l3IsNil(aMessage) then
    Progress.Start(l_B.rFinish - l_B.rStart, str_nevmmLongOperation.AsCStr)
   else
    Progress.Start(l_B.rFinish - l_B.rStart, aMessage);
   try
    IterateChildrenBackF(L2Mk2ChildrenIterateChildrenFAction(@ChildFuncProgress));
   finally
    Progress.Finish;
   end;{try..finally}
  end//Assigned(Progress)
  else
   IterateChildrenBackF(L2Mk2ChildrenIterateChildrenFAction(@ChildFunc));
 end;{Self <> nil}
//#UC END# *52D7CB7B01EE_4A2D2D4300BE_impl*
end;//TevRange.DoIterateBack

procedure TevRange.DoIterateF(anAction: InevRangePrim_Iterate_Action;
  const Progress: Il3Progress = nil;
  const aMessage: Il3CString = nil;
  aStart: LongInt = l3MinIndex);
//#UC START# *52D7CBD0020F_4A2D2D4300BE_var*
//#UC END# *52D7CBD0020F_4A2D2D4300BE_var*
begin
//#UC START# *52D7CBD0020F_4A2D2D4300BE_impl*
 try
  DoIterate(anAction, Progress, aMessage, aStart);
 finally
  evFreeTSA(anAction);
 end;//try..finally
//#UC END# *52D7CBD0020F_4A2D2D4300BE_impl*
end;//TevRange.DoIterateF

procedure TevRange.DoIterateBackF(anAction: InevRangePrim_Iterate_Action;
  const Progress: Il3Progress = nil;
  const aMessage: Il3CString = nil);
//#UC START# *52D7CC2F036B_4A2D2D4300BE_var*
//#UC END# *52D7CC2F036B_4A2D2D4300BE_var*
begin
//#UC START# *52D7CC2F036B_4A2D2D4300BE_impl*
 try
  DoIterateBack(anAction, Progress, aMessage);
 finally
  evFreeTSA(anAction);
 end;//try..finally
//#UC END# *52D7CC2F036B_4A2D2D4300BE_impl*
end;//TevRange.DoIterateBackF

function TevRange.DoSearchReplace(const aSearcher: IevSearcher;
  const aReplacer: IevReplacer;
  const aConfirm: InevConfirm;
  const Cursor: InevBasePoint = nil;
  const anOpPack: InevOp = nil;
  aNeedProgress: Boolean = True): Boolean;
//#UC START# *52D7CCD70340_4A2D2D4300BE_var*
//#UC END# *52D7CCD70340_4A2D2D4300BE_var*
begin
//#UC START# *52D7CCD70340_4A2D2D4300BE_impl*
 Result := False;
//#UC END# *52D7CCD70340_4A2D2D4300BE_impl*
end;//TevRange.DoSearchReplace

procedure TevRange.Store(const aView: InevView;
  const G: InevTagGenerator;
  aFlags: TevdStoreFlags = evDefaultStoreFlags);
//#UC START# *47C68BFD011C_4A2D2D4300BE_var*
//#UC END# *47C68BFD011C_4A2D2D4300BE_var*
begin
//#UC START# *47C68BFD011C_4A2D2D4300BE_impl*
 if (Self <> nil) then
  DoStore(aView, G, aFlags);
//#UC END# *47C68BFD011C_4A2D2D4300BE_impl*
end;//TevRange.Store

function TevRange.Store(aFormat: TevdClipboardFormat;
  const aPool: IStream;
  const aFilters: TevdTagGenerator;
  aFlags: TevdStoreFlags = [evd_sfStoreParaEnd]): Boolean;
//#UC START# *47C68C6701AF_4A2D2D4300BE_var*
var
 l_TSR: InevTagReader;
//#UC END# *47C68C6701AF_4A2D2D4300BE_var*
begin
//#UC START# *47C68C6701AF_4A2D2D4300BE_impl*
 if (Self <> nil) then
 begin
  l_TSR := TagReader;
  if (l_TSR <> nil) then
  try
   Result := (l_TSR.ReadTag(aFormat, aPool, aFilters, Self, aFlags) > 0);
  finally
   l_TSR := nil;
  end//try..finally
  else
   Result := False;
 end//Self <> nil
 else
  Result := False;
//#UC END# *47C68C6701AF_4A2D2D4300BE_impl*
end;//TevRange.Store

function TevRange.SolidBottomChildBlock(const aView: InevView): InevRange;
//#UC START# *47C690AB02EE_4A2D2D4300BE_var*
//#UC END# *47C690AB02EE_4A2D2D4300BE_var*
begin
//#UC START# *47C690AB02EE_4A2D2D4300BE_impl*
 Result := BottomChildBlock(aView).Obj.SubRange(aView, 0, High(Long));
//#UC END# *47C690AB02EE_4A2D2D4300BE_impl*
end;//TevRange.SolidBottomChildBlock

function TevRange.GetChildSel(const aView: InevView;
  aChildIndex: Integer;
  aForDrawing: Boolean): InevRange;
//#UC START# *47C691F0012A_4A2D2D4300BE_var*
//#UC END# *47C691F0012A_4A2D2D4300BE_var*
begin
//#UC START# *47C691F0012A_4A2D2D4300BE_impl*
 Result := DoGetChildSel(aView, aChildIndex, aForDrawing);
//#UC END# *47C691F0012A_4A2D2D4300BE_impl*
end;//TevRange.GetChildSel

procedure TevRange.GetBorderPoints(out BS: InevBasePoint;
  out BF: InevBasePoint);
//#UC START# *47C691FB0055_4A2D2D4300BE_var*
//#UC END# *47C691FB0055_4A2D2D4300BE_var*
begin
//#UC START# *47C691FB0055_4A2D2D4300BE_impl*
 DoGetBorderPoints(BS, BF);
//#UC END# *47C691FB0055_4A2D2D4300BE_impl*
end;//TevRange.GetBorderPoints

function TevRange.BottomChildBlock(const aView: InevView): InevRange;
//#UC START# *47C6920B01B2_4A2D2D4300BE_var*
//#UC END# *47C6920B01B2_4A2D2D4300BE_var*
begin
//#UC START# *47C6920B01B2_4A2D2D4300BE_impl*
 Result := DoBottomChildBlock(aView);
//#UC END# *47C6920B01B2_4A2D2D4300BE_impl*
end;//TevRange.BottomChildBlock

function TevRange.CloneSel(const aView: InevView): InevRange;
//#UC START# *47C6924201FA_4A2D2D4300BE_var*
type
 RevRange = class of TevRange;  
var
 l_Sel: TevRange;
//#UC END# *47C6924201FA_4A2D2D4300BE_var*
begin
//#UC START# *47C6924201FA_4A2D2D4300BE_impl*
 l_Sel := RevRange(ClassType).Create(GetRedirect);
 try
  l_Sel.AssignSel(aView, Self);
  Result := l_Sel;
 finally
  l3Free(l_Sel);
 end;//try..finally
//#UC END# *47C6924201FA_4A2D2D4300BE_impl*
end;//TevRange.CloneSel

function TevRange.Delete(const aView: InevView;
  const anOp: InevOp = nil;
  aMode: TevClearMode = ev_cmAll;
  const aPara: InevPara = nil): Boolean;
//#UC START# *47C6928C0243_4A2D2D4300BE_var*
//#UC END# *47C6928C0243_4A2D2D4300BE_var*
begin
//#UC START# *47C6928C0243_4A2D2D4300BE_impl*
 Result := DoDelete(aView, anOp, aMode, aPara);
//#UC END# *47C6928C0243_4A2D2D4300BE_impl*
end;//TevRange.Delete

function TevRange.Modify: InevRangeModify;
//#UC START# *47C692B301BF_4A2D2D4300BE_var*
//#UC END# *47C692B301BF_4A2D2D4300BE_var*
begin
//#UC START# *47C692B301BF_4A2D2D4300BE_impl*
 Result := Self;
//#UC END# *47C692B301BF_4A2D2D4300BE_impl*
end;//TevRange.Modify

function TevRange.ParentRange(aLevel: Integer = 0): InevRange;
//#UC START# *47C692C10136_4A2D2D4300BE_var*
var
 l_Obj: InevObject;
 l_Owner: InevObject;
 l_Index: Integer;
 l_Start,
 l_Finish: InevPoint;
 l_cStart,
 l_cFinish: InevBasePoint;
//#UC END# *47C692C10136_4A2D2D4300BE_var*
begin
//#UC START# *47C692C10136_4A2D2D4300BE_impl*
 Result := Self;
 l_Obj := Get_Obj^;
 while (aLevel >= 0) do
 begin
  l_Owner := l_Obj.OwnerObj;
  if (l_Owner = nil) or
     not l_Owner.AsObject.IsValid or
     not l_Owner.AsObject.IsKindOf(k2_typPara) then
   Break;

  l_Index := l_Obj.PID;
  Assert(l_Index >= 0);
  Inc(l_Index);
  Result.GetBorderPoints(l_cStart, l_cFinish);
  with l_Owner do
  begin
   l_Start := MakePoint;
   try
    l_Start.PositionW := l_Index;
    l_Start.Inner := l_cStart;
    l_Finish := MakePoint;
    try
     l_Finish.PositionW := l_Index;
     l_Finish.Inner := l_cFinish;
     Result := Range(l_Start, l_Finish);
    finally
     l_Finish := nil;
    end;//try..finally
   finally
    l_Start := nil;
   end;//try..finally
  end;//with l_Owner
  l_Obj := l_Owner;
  Dec(aLevel);
 end;//while (aLevel >= 0)
//#UC END# *47C692C10136_4A2D2D4300BE_impl*
end;//TevRange.ParentRange

function TevRange.Contains(const aView: InevView;
  const aPoint: InevBasePoint): Boolean;
//#UC START# *47C692CC024C_4A2D2D4300BE_var*
var
 l_S,
 l_F: InevBasePoint;
 l_A: Integer;
 l_B: Integer;
//#UC END# *47C692CC024C_4A2D2D4300BE_var*
begin
//#UC START# *47C692CC024C_4A2D2D4300BE_impl*
 GetBorderPoints(l_S, l_F);
 if (l_S = nil) then
  l_A := +1
 else
  l_A := aPoint.Compare(l_S);
 if (l_F = nil) then
  l_B := -1
 else
  l_B := aPoint.Compare(l_F);
 Result := ((l_A >= 0) and (l_B <= 0));
//#UC END# *47C692CC024C_4A2D2D4300BE_impl*
end;//TevRange.Contains

procedure TevRange.Select(const aView: InevView;
  const C: InevBasePoint;
  aTarget: TevSelectTarget;
  const Ctx: InevOp = nil);
//#UC START# *47C6960502ED_4A2D2D4300BE_var*
//#UC END# *47C6960502ED_4A2D2D4300BE_var*
begin
//#UC START# *47C6960502ED_4A2D2D4300BE_impl*
 with evSelectBrackets[aTarget] do
  Select(aView, C, Open, Close, Ctx);
//#UC END# *47C6960502ED_4A2D2D4300BE_impl*
end;//TevRange.Select

procedure TevRange.Select(const aView: InevView;
  const C: InevBasePoint;
  aOpen: Integer;
  aClose: Integer;
  const Ctx: InevOp = nil);
//#UC START# *47C696160251_4A2D2D4300BE_var*
var
 Start,
 Finish: InevBasePoint;
//#UC END# *47C696160251_4A2D2D4300BE_var*
begin
//#UC START# *47C696160251_4A2D2D4300BE_impl*
 GetBorderPoints(Start, Finish);
 if (Ctx <> nil) then
  with Ctx as IevCursorContext do
  begin
   RecordCursor(Start);
   RecordCursor(Finish);
  end;//with Ctx as IevCursorContext
 if (Start = nil) then
 begin
  if (C = nil) then
   Start := Get_Obj.MakePoint
  else
   Start := C.ClonePoint(aView);
 end;//Start = nil
 try
  if (Finish = nil) then
  begin
   if (C = nil) then
    Finish := Get_Obj.MakePoint
   else
    Finish := C.ClonePoint(aView);
  end;//Finish = nil
  try
   if (aOpen <> -1) then
    Start.Move(aView, aOpen);
   if (aClose <> -1) then
    Finish.Move(aView, aClose);
   Init(Start, Finish);
  finally
   Finish := nil;
  end;{try..finally}
 finally
  Start := nil;
 end;//try..finally
//#UC END# *47C696160251_4A2D2D4300BE_impl*
end;//TevRange.Select

function TevRange.pm_GetBorders: TevPair;
//#UC START# *47C6962E028E_4A2D2D4300BEget_var*
//#UC END# *47C6962E028E_4A2D2D4300BEget_var*
begin
//#UC START# *47C6962E028E_4A2D2D4300BEget_impl*
 Result := DoGetBorders;
//#UC END# *47C6962E028E_4A2D2D4300BEget_impl*
end;//TevRange.pm_GetBorders

function TevRange.pm_GetData: IevdDataObject;
//#UC START# *47C696B603E7_4A2D2D4300BEget_var*
//#UC END# *47C696B603E7_4A2D2D4300BEget_var*
begin
//#UC START# *47C696B603E7_4A2D2D4300BEget_impl*
 Result := Self;
//#UC END# *47C696B603E7_4A2D2D4300BEget_impl*
end;//TevRange.pm_GetData

procedure TevRange.Init(const aStart: InevBasePoint;
  const aFinish: InevBasePoint;
  aSharp: Boolean = false);
//#UC START# *47C696E302FE_4A2D2D4300BE_var*
//#UC END# *47C696E302FE_4A2D2D4300BE_var*
begin
//#UC START# *47C696E302FE_4A2D2D4300BE_impl*
 DoInit(aStart, aFinish, aSharp);
//#UC END# *47C696E302FE_4A2D2D4300BE_impl*
end;//TevRange.Init

function TevRange.Solid(const aView: InevView): Boolean;
//#UC START# *47FF53790028_4A2D2D4300BE_var*
//#UC END# *47FF53790028_4A2D2D4300BE_var*
begin
//#UC START# *47FF53790028_4A2D2D4300BE_impl*
 Result := (Self <> nil) and IsSolid(aView);
//#UC END# *47FF53790028_4A2D2D4300BE_impl*
end;//TevRange.Solid

function TevRange.ContainsEnd(const aView: InevView): Boolean;
//#UC START# *47FF5C3D017E_4A2D2D4300BE_var*
//#UC END# *47FF5C3D017E_4A2D2D4300BE_var*
begin
//#UC START# *47FF5C3D017E_4A2D2D4300BE_impl*
 Result := (Self <> nil) and GetContainsEnd(aView);
//#UC END# *47FF5C3D017E_4A2D2D4300BE_impl*
end;//TevRange.ContainsEnd

function TevRange.Collapsed(const aView: InevView): Boolean;
//#UC START# *47FF5F3702F6_4A2D2D4300BE_var*
//#UC END# *47FF5F3702F6_4A2D2D4300BE_var*
begin
//#UC START# *47FF5F3702F6_4A2D2D4300BE_impl*
 Result := (Self = nil) or IsCollapsed(aView);
//#UC END# *47FF5F3702F6_4A2D2D4300BE_impl*
end;//TevRange.Collapsed

procedure TevRange.AssignSel(const aView: InevView;
  const aSource: InevRange);
//#UC START# *48E25C7E0366_4A2D2D4300BE_var*
var
 l_S, l_F: InevBasePoint;  
//#UC END# *48E25C7E0366_4A2D2D4300BE_var*
begin
//#UC START# *48E25C7E0366_4A2D2D4300BE_impl*
 Target := aSource.Obj^.AsObject;
 aSource.GetBorderPoints(l_S, l_F);
 if (l_S <> nil) then
  l_S := l_S.ClonePoint(aView);
 if (l_F <> nil) then
  l_F := l_F.ClonePoint(aView);
 Init(l_S, l_F);
//#UC END# *48E25C7E0366_4A2D2D4300BE_impl*
end;//TevRange.AssignSel

function TevRange.GetBlock: InevRange;
//#UC START# *48E25C980073_4A2D2D4300BE_var*
//#UC END# *48E25C980073_4A2D2D4300BE_var*
begin
//#UC START# *48E25C980073_4A2D2D4300BE_impl*
 Result := Self;
//#UC END# *48E25C980073_4A2D2D4300BE_impl*
end;//TevRange.GetBlock

procedure TevRange.SetToStart;
//#UC START# *48E25CA5027C_4A2D2D4300BE_var*
//#UC END# *48E25CA5027C_4A2D2D4300BE_var*
begin
//#UC START# *48E25CA5027C_4A2D2D4300BE_impl*
//#UC END# *48E25CA5027C_4A2D2D4300BE_impl*
end;//TevRange.SetToStart

function TevRange.Unselect(const aView: InevView): Boolean;
//#UC START# *48E25CB3032B_4A2D2D4300BE_var*
var
 l_Start,
 l_Finish: InevBasePoint;
//#UC END# *48E25CB3032B_4A2D2D4300BE_var*
begin
//#UC START# *48E25CB3032B_4A2D2D4300BE_impl*
 Result := False;
 {XXX_Parent}
(* if Supports(Parent, IevRange, l_Range) then
  try
   Result := l_Range.Unselect;
  finally
   l_Range := nil;
  end;//try..finally*)
 if not Result then
 begin
  Result := True;
  GetBorderPoints(l_Start, l_Finish);
  if (l_Start <> nil) and (l_Finish <> nil) then
  begin
   l_Finish.AssignPoint(aView, l_Start);
   Init(l_Start, l_Finish);
  end;//l_Start <> nil
 end;//not Result
//#UC END# *48E25CB3032B_4A2D2D4300BE_impl*
end;//TevRange.Unselect

function TevRange.AsStorable: InevDataObjectPrim2;
//#UC START# *48EC8339027A_4A2D2D4300BE_var*
//#UC END# *48EC8339027A_4A2D2D4300BE_var*
begin
//#UC START# *48EC8339027A_4A2D2D4300BE_impl*
 Result := Self;
//#UC END# *48EC8339027A_4A2D2D4300BE_impl*
end;//TevRange.AsStorable

function TevRange.SearchReplace(const aSearcher: IevSearcher;
  const aReplacer: IevReplacer;
  const aConfirm: InevConfirm;
  const aCursor: InevBasePoint = nil;
  const anOpPack: InevOp = nil;
  aNeedProgress: Boolean = true): Boolean;
//#UC START# *49E83F480351_4A2D2D4300BE_var*
//#UC END# *49E83F480351_4A2D2D4300BE_var*
begin
//#UC START# *49E83F480351_4A2D2D4300BE_impl*
 Result := DoSearchReplace(aSearcher, aReplacer, aConfirm, aCursor, anOpPack, aNeedProgress);
//#UC END# *49E83F480351_4A2D2D4300BE_impl*
end;//TevRange.SearchReplace

function TevRange.Search(const aView: InevView;
  const aSearcher: IevSearcher;
  const Progress: Il3Progress;
  const aStart: InevBasePoint;
  out cFStart: InevBasePoint;
  out cFFinish: InevBasePoint): Boolean;
//#UC START# *49E843B10236_4A2D2D4300BE_var*
//#UC END# *49E843B10236_4A2D2D4300BE_var*
begin
//#UC START# *49E843B10236_4A2D2D4300BE_impl*
 if (Self = nil) then
 begin
  Result := False;
  cFStart := nil;
  cFFinish := nil;
 end//Self = nil
 else
  Result := SearchPrim(aView, aSearcher, Progress, aStart, cFStart, cFFinish);
//#UC END# *49E843B10236_4A2D2D4300BE_impl*
end;//TevRange.Search

procedure TevRange.SetToFinish(aMoveUpInLines: Integer);
//#UC START# *50AF18AD03DD_4A2D2D4300BE_var*
//#UC END# *50AF18AD03DD_4A2D2D4300BE_var*
begin
//#UC START# *50AF18AD03DD_4A2D2D4300BE_impl*
//#UC END# *50AF18AD03DD_4A2D2D4300BE_impl*
end;//TevRange.SetToFinish

procedure TevRange.RefreshBorders;
//#UC START# *50B727F00221_4A2D2D4300BE_var*
//#UC END# *50B727F00221_4A2D2D4300BE_var*
begin
//#UC START# *50B727F00221_4A2D2D4300BE_impl*
 DoRefreshBorders;
//#UC END# *50B727F00221_4A2D2D4300BE_impl*
end;//TevRange.RefreshBorders

function TevRange.GetRange: InevRange;
//#UC START# *49DF62920242_4A2D2D4300BE_var*
//#UC END# *49DF62920242_4A2D2D4300BE_var*
begin
//#UC START# *49DF62920242_4A2D2D4300BE_impl*
 Result := Self;
//#UC END# *49DF62920242_4A2D2D4300BE_impl*
end;//TevRange.GetRange

function TevRange.GetAsPoint: InevBasePoint;
//#UC START# *49DF62A201EB_4A2D2D4300BE_var*
//#UC END# *49DF62A201EB_4A2D2D4300BE_var*
begin
//#UC START# *49DF62A201EB_4A2D2D4300BE_impl*
 Result := nil;
//#UC END# *49DF62A201EB_4A2D2D4300BE_impl*
end;//TevRange.GetAsPoint

function TevRange.DoGetStyle(Stop: PInteger): Tl3Variant;
//#UC START# *4A2945060101_4A2D2D4300BE_var*
//#UC END# *4A2945060101_4A2D2D4300BE_var*
begin
//#UC START# *4A2945060101_4A2D2D4300BE_impl*
{$IfDef evNeedGetBlockStyle}
 Result := GetRedirect.Attr[k2_tiStyle];
{$else}
 Result := inherited DoGetStyle(Stop);
{$EndIf evNeedGetBlockStyle}
//#UC END# *4A2945060101_4A2D2D4300BE_impl*
end;//TevRange.DoGetStyle

function TevRange.DoGetFont(const aView: InevView;
  aMap: TnevFormatInfoPrim;
  Stop: PInteger): InevFontPrim;
//#UC START# *4A29477801BF_4A2D2D4300BE_var*
//#UC END# *4A29477801BF_4A2D2D4300BE_var*
begin
//#UC START# *4A29477801BF_4A2D2D4300BE_impl*
{$IfDef evNeedGetBlockFont}
 Result := nil;
{$else}
 Result := inherited DoGetFont(aView, aMap, Stop);
{$EndIf evNeedGetBlockFont}
//#UC END# *4A29477801BF_4A2D2D4300BE_impl*
end;//TevRange.DoGetFont

function TevRange.DoInsertStream(const aView: InevView;
  const aStream: IStream;
  aFormat: TnevFormat;
  const anOp: InevOp;
  aFlags: TevLoadFlags;
  aCodePage: Integer): Boolean;
//#UC START# *4A3A8BEE029F_4A2D2D4300BE_var*
const
 cLen = 2;  
var
 l_Start: InevBasePoint;
 l_Finish: InevBasePoint;
 l_Stream: TStream;
 l_Word: Word;
 l_IStream: IStream;
 l_Size: Integer;
//#UC END# *4A3A8BEE029F_4A2D2D4300BE_var*
begin
//#UC START# *4A3A8BEE029F_4A2D2D4300BE_impl*
 l_IStream := aStream;
 if (aFormat = CF_Text) or (aFormat = CF_OEMText) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=228691360
 // Тут хитрим и если вставляется просто перевод строки и выделено более одного
 // параграфа, то удаляем этот перевод строки
 begin
  if ParaX.AsObject.IsKindOf(k2_typParaList) then
  begin
   GetBorderPoints(l_Start, l_Finish);
   if (l_Start <> nil) and (l_Finish <> nil) then
    if not l_Start.MostInner.Obj.AsObject.IsSame(l_Finish.MostInner.Obj^.AsObject) then
    begin
     l3IStream2Stream(aStream, l_Stream);
     try
      l_Size := l_Stream.Size - l_Stream.Position;
      if (l_Size = cLen) then
      begin
       l_Stream.Read(l_Word, SizeOf(l_Word));
       if (Lo(l_Word) = 13) and (Hi(l_Word) = 10) then
        l_IStream := nil
       else
        l_Stream.Seek(-cLen, soCurrent);
      end;//l_Size = cLen
     finally
      FreeAndNil(l_Stream);
     end;//try..finally
    end;//l_Start.MostInner.Obj.IsSame(l_Finish.MostInner.Obj)
  end;//ParaX.IsKindOf(k2_typParaList)
 end;//aFormat = CF_Text
 DeleteBeforeInsert(aView, anOp);
 Result := inherited DoInsertStream(aView, l_IStream, aFormat, anOp, aFlags, aCodePage);
 GetBorderPoints(l_Start, l_Finish);
 if (l_Finish <> nil) then
  l_Finish.AssignPoint(aView, l_Start);
//#UC END# *4A3A8BEE029F_4A2D2D4300BE_impl*
end;//TevRange.DoInsertStream

procedure TevRange.Assign(Source: Tk2ToolPrim);
//#UC START# *52BC1DD60298_4A2D2D4300BE_var*
//#UC END# *52BC1DD60298_4A2D2D4300BE_var*
begin
//#UC START# *52BC1DD60298_4A2D2D4300BE_impl*
 Assert(False);
 if (Self = Source) then
  Exit
 else
 if (Source is TevRange) then
  AssignSel(nil, TevRange(Source))
 else
  inherited; 
//#UC END# *52BC1DD60298_4A2D2D4300BE_impl*
end;//TevRange.Assign
{$IfEnd} //evUseVisibleCursors

end.