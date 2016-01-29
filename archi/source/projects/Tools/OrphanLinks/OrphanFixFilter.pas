unit OrphanFixFilter;

{ $Id: OrphanFixFilter.pas,v 1.1 2015/04/20 12:02:06 fireton Exp $ }

interface

uses
 l3Types,
 l3Variant,
 l3Interfaces,
 l3LongintList,
 l3ProtoObject,
 l3FieldSortRecList,
 k2Types,
 k2TagGen,
 evdBufferedFilter,
 dtIntf,
 dt_Types,
 Dt_ReNum;

type
 POrphanedPairRec = ^TOrphanedPairRec;
 TOrphanedPairRec = packed record
  rBadDocID   : TDocID;
  rRightDocID : TDocID;
 end;

 TOrphanedPairList = class(Tl3ProtoObject)
 private
  f_Data: Tl3FieldSortRecList;
  function pm_GetCount: Integer;
  function pm_GetItems(aIndex: Integer): POrphanedPairRec;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure AddPair(const aBadID, aRightID: TDocID);
  function FindRightByBad(aBadID: TDocID; out theRightID: TDocID): Boolean;
  property Count: Integer read pm_GetCount;
  property Items[aIndex: Integer]: POrphanedPairRec read pm_GetItems;
 end;

 TOnReplaceOrphanedLink = procedure (const aCurDocID, aBadDocID, aRightDocID: TDocID) of object;

 TOrphanFixFilter = class(TevdChildBufferedFilter, Il3DocIDSource)
 private
  f_PairList: TOrphanedPairList;
  f_DocID: Integer;
  f_OnReplace: TOnReplaceOrphanedLink;
  procedure ReportReplace(aDocID: TDocID; aBadDocID: TDocID; aRightDocID: TDocID);
 protected
  procedure Cleanup; override;
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
  // Il3DocIDSource
  function pm_GetDocID: Integer;
  procedure pm_SetDocID(aValue: Integer);
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner);
  class function SetTo(var theGenerator: Tk2TagGenerator; const aPairList: TOrphanedPairList): Pointer; overload;
  property OnReplace: TOnReplaceOrphanedLink read f_OnReplace write f_OnReplace;
 end;

implementation
uses
 SysUtils,
 l3Base,
 k2Tags,
 dt_LinkServ,
 dt_Const,
 dt_Sab,
 dt_Hyper,
 Address_Const,
 Document_Const,
 Hyperlink_Const, l3LongintListPrim, l3ProtoPtrRecListPrim;

type
 PHLPairRec = ^THLPairRec;
 THLPairRec = packed record
  rDocID: TDocID;
  rHLID : Longint;
 end;

constructor TOrphanFixFilter.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(k2_idHyperlink, aOwner);
end;

procedure TOrphanFixFilter.Cleanup;
begin
 FreeAndNil(f_PairList);
 inherited;
end;

procedure TOrphanFixFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
 I: Integer;
 l_AddrDocID: Long;
 l_ReplaceID: TDocID;
begin
 for I := 0 to aLeaf.ChildrenCount-1 do
 begin
  l_AddrDocID := aLeaf.Child[I].cAtom(k2_tiDocID).AsLong;
  if f_PairList.FindRightByBad(l_AddrDocID, l_ReplaceID) then
  begin
   aLeaf.Child[I].IntW[k2_tiDocID, Context] := l_ReplaceID;
   ReportReplace(f_DocID, l_AddrDocID, l_ReplaceID);
  end;
 end;
 inherited;
end;

function TOrphanFixFilter.pm_GetDocID: Integer;
begin
 Result := f_DocID;
end;

procedure TOrphanFixFilter.pm_SetDocID(aValue: Integer);
begin
 f_DocID := aValue;
end;

procedure TOrphanFixFilter.ReportReplace(aDocID: TDocID; aBadDocID: TDocID; aRightDocID: TDocID);
begin
 if Assigned(f_OnReplace) then
  f_OnReplace(aDocID, aBadDocID, aRightDocID);
end;

class function TOrphanFixFilter.SetTo(var theGenerator: Tk2TagGenerator; const aPairList: TOrphanedPairList): Pointer;
  {-}
var
 l_Filter : TOrphanFixFilter;
begin
 l_Filter := Create(nil);
 try
  l_Filter.Generator := theGenerator;
  l_Filter.f_PairList := aPairList.Use;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

constructor TOrphanedPairList.Create;
begin
 inherited Create;
 f_Data := Tl3FieldSortRecList.Create(SizeOf(TOrphanedPairRec), [SizeOf(TDocID), SizeOf(TDocID)], [1]);
end;

procedure TOrphanedPairList.AddPair(const aBadID, aRightID: TDocID);
var
 l_Rec: TOrphanedPairRec;
begin
 l_Rec.rBadDocID := aBadID;
 l_Rec.rRightDocID := aRightID;
 f_Data.Add(l_Rec);
end;

procedure TOrphanedPairList.Cleanup;
begin
 FreeAndNil(f_Data);
 inherited;
end;

function TOrphanedPairList.FindRightByBad(aBadID: TDocID; out theRightID: TDocID): Boolean;
var
 l_Idx: Integer;
begin
 Result := False;
 if f_Data.Find(aBadId, l_Idx) then
 begin
  theRightID := POrphanedPairRec(f_Data.ItemSlot(l_Idx))^.rRightDocID;
  Result := True;
 end;
end;

function TOrphanedPairList.pm_GetCount: Integer;
begin
 Result := f_Data.Count; 
end;

function TOrphanedPairList.pm_GetItems(aIndex: Integer): POrphanedPairRec;
begin
 Result := POrphanedPairRec(f_Data.ItemSlot(aIndex));
end;

end.