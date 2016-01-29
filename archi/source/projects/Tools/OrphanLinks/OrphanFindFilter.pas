unit OrphanFindFilter;

{ $Id: OrphanFindFilter.pas,v 1.1 2015/04/20 12:02:06 fireton Exp $ }

interface

uses
 l3Types,
 l3Variant,
 l3Interfaces,
 l3LongintList,
 k2Types,
 k2TagGen,
 evdBufferedFilter,
 dtIntf,
 Dt_ReNum;

type
 TOnReportOrphan = procedure (aDocID, aAddrDocID: Integer) of object;

 TOrphanFindFilter = class(TevdChildBufferedFilter, Il3DocIDSource)
 private
  f_CurDocHLHandles: Tl3LongintList;
  f_CurInSab: Longint;
  f_DocID: Integer;
  f_HLCursor: ISabCursor;
  f_OnReportOrphan: TOnReportOrphan;
  f_Renum: TReNumTbl;
  procedure FillHLHandlesList;
  function IsHyperlinkHandleExists(aHandle: Long): Boolean;
  procedure ReportOrphan(aDocID: Integer; aAddrDocID: Integer);
 protected
  procedure Cleanup; override;
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
  // Il3DocIDSource
  function pm_GetDocID: Integer;
  procedure pm_SetDocID(aValue: Integer);
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner);
  class function SetTo(var theGenerator: Tk2TagGenerator): Pointer; overload;
  property OnReportOrphan: TOnReportOrphan read f_OnReportOrphan write f_OnReportOrphan;
 end;

implementation
uses
 SysUtils,
 l3Base,
 k2Tags,
 dt_LinkServ,
 dt_Types,
 dt_Const,
 dt_Sab,
 dt_Hyper,
 Address_Const,
 Document_Const,
 Hyperlink_Const, l3LongintListPrim;

type
 PHLPairRec = ^THLPairRec;
 THLPairRec = packed record
  rDocID: TDocID;
  rHLID : Longint;
 end;

constructor TOrphanFindFilter.Create(aOwner: Tk2TagGeneratorOwner);
var
 l_HLinkSab: ISab;
begin
 inherited Create(k2_idHyperlink, aOwner);
 f_Renum := LinkServer(CurrentFamily).Renum;
 l_HLinkSab := MakeAllRecords(LinkServer(CurrentFamily).HLinkTbl);
 l_HLinkSab.Sort([hlSourD_fld]);
 f_HLCursor := l_HLinkSab.MakeSabCursor([hlSourD_fld, hlID_fld]);
 f_CurInSab := 0;
 f_CurDocHLHandles := Tl3LongintList.MakeSorted;
end;

procedure TOrphanFindFilter.Cleanup;
begin
 FreeAndNil(f_CurDocHLHandles);
 f_HLCursor := nil;
 inherited;
end;

procedure TOrphanFindFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
 I: Integer;
 l_Handle   : Long;
 l_AddrDocID: Long;
begin
 if not aLeaf.CAtom(k2_tiHandle).IsNull then
  l_Handle := aLeaf.CAtom(k2_tiHandle).AsLong
 else
  l_Handle := 0;

 if not IsHyperlinkHandleExists(l_Handle) then
 begin
  for I := 0 to aLeaf.ChildrenCount-1 do
  begin
   l_AddrDocID := aLeaf.Child[I].cAtom(k2_tiDocID).AsLong;
   if (l_AddrDocID = 0) or (f_Renum.GetExtDocID(l_AddrDocID) = cUndefDocID) then
    ReportOrphan(f_DocID, l_AddrDocID);
  end;
 end;
 inherited;
end;

procedure TOrphanFindFilter.FillHLHandlesList;
var
 l_Rec: PHLPairRec;

 procedure GetHLRec;
 begin
  l_Rec := PHLPairRec(f_HLCursor.GetItem(f_CurInSab));
 end;

 function IsOutOfData: Boolean;
 begin
  Result := f_CurInSab >= f_HLCursor.Count;
 end;

begin
 f_CurDocHLHandles.Clear;
 if IsOutOfData then
  Exit;
 GetHLRec;
 while l_Rec.rDocID < f_DocID do
 begin
  Inc(f_CurInSab);
  if IsOutOfData then
   Exit;
  GetHLRec;
 end;
 if l_Rec.rDocID = f_DocID then
 begin
  repeat
   f_CurDocHLHandles.Add(l_Rec.rHLID);
   Inc(f_CurInSab);
   if not IsOutOfData then
    GetHLRec;
  until IsOutOfData or (l_Rec.rDocID <> f_DocID);
 end;
end;

function TOrphanFindFilter.IsHyperlinkHandleExists(aHandle: Long): Boolean;
begin
 Result := f_CurDocHLHandles.IndexOf(aHandle) <> -1;
end;

function TOrphanFindFilter.pm_GetDocID: Integer;
begin
 Result := f_DocID;
end;

procedure TOrphanFindFilter.pm_SetDocID(aValue: Integer);
begin
 f_DocID := aValue;
 FillHLHandlesList;
end;

procedure TOrphanFindFilter.ReportOrphan(aDocID: Integer; aAddrDocID: Integer);
begin
 if Assigned(f_OnReportOrphan) then
  f_OnReportOrphan(aDocID, aAddrDocID);
end;

class function TOrphanFindFilter.SetTo(var theGenerator: Tk2TagGenerator): Pointer;
  {-}
var
 l_Filter : TOrphanFindFilter;
begin
 l_Filter := Create(nil);
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.