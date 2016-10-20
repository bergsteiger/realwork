unit ddDefDocLinkFinder;

{ $Id: ddDefDocLinkFinder.pas,v 1.3 2016/10/14 15:25:08 fireton Exp $ }

interface
uses
 l3Interfaces,
 l3Date,
 dt_Types,
 ddAutolinkTypes,
 ddCustomLinkFinder,
 ddEntryCollector,
 ddDocStruct;

type
 TddDocCacheType = (dctBasic, dctFile);

 TddDefDocLinkFinder = class(TddCustomLinkFinder)
 private
  f_TargetExtDocID: TDocID;
  f_EntryCollector: TddEntryCollector;
  f_StructCache: TddProtoStructCache;
  f_TargetIntDocID: TDocID;
  procedure pm_SetTargetExtDocID(const Value: TDocID);
 protected
  procedure Cleanup; override;
 public
  constructor Create(aCacheType: TddDocCacheType);
  procedure Done; override;
  procedure FindLinks(const aText     : Tl3WString;  // text from master doc
                      aDocID          : TDocID;      // master doc id
                      aDocDate        : TStDate;     // master doc date
                      const aCaseCode : Il3CString;  // casecode
                      aLinkProc       : TddLinkSetRoutine); override;
  procedure Init; override;
  property StructCache: TddProtoStructCache read f_StructCache;
  property TargetExtDocID: TDocID read f_TargetExtDocID write pm_SetTargetExtDocID;
 end;

implementation
uses
 SysUtils,

 l3RecList,

 ddAutolinkCache,

 daSchemeConsts,
 daDataProvider,

 dt_LinkServ
 , Dt_ReNum;

constructor TddDefDocLinkFinder.Create(aCacheType: TddDocCacheType);
begin
 inherited Create;
 case aCacheType of
  dctBasic: f_StructCache := TddProtoStructCache.Create;
  dctFile : f_StructCache := TddDocStructCache.Create(GetAutolinkStructCacheFilePath(dsLocal), GlobalDataProvider.TextBase[CurrentFamily], True);
 else
  Assert(False);
 end;
end;

procedure TddDefDocLinkFinder.Cleanup;
begin
 FreeAndNil(f_StructCache);
 inherited;
end;

procedure TddDefDocLinkFinder.Done;
begin
 FreeAndNil(f_EntryCollector);
end;

procedure TddDefDocLinkFinder.FindLinks(const aText     : Tl3WString;    // text from master doc
                                        aDocID          : TDocID;    // master doc id
                                        aDocDate        : TStDate;   // master doc date
                                        const aCaseCode : Il3CString; // casecode
                                        aLinkProc       : TddLinkSetRoutine);
var
 I: Integer;
 l_List: Tl3RecList;
 l_Pos: Integer;
 l_SubNo: Longint;
 l_PLinkItem: PLinkPrimRec;
begin
 l_Pos := 0;
 l_List := TddEntryCollector.MakeEntryList;
 try
  while True do
  begin
   if not f_EntryCollector.CollectEntries(aText.S, l_Pos, aText.SLen - 1, l_List) then
    Break;
   for I := 0 to l_List.Hi do
   begin
    l_PLinkItem  := PLinkPrimRec(l_List.ItemSlot(I));
    l_SubNo := f_StructCache.FindBlockSmart(f_TargetExtDocID, l_PLinkItem.rAddress);
    if l_SubNo >= 0 then
     aLinkProc(l_PLinkItem.rStart, l_PLinkItem.rEnd, f_TargetIntDocID, l_SubNo, '');
    if l_Pos < l_PLinkItem.rEnd then
     l_Pos := l_PLinkItem.rEnd + 1;
   end;
  end;
 finally
  FreeAndNil(l_List);
 end;
end;

procedure TddDefDocLinkFinder.Init;
begin
 if (f_TargetExtDocID = 0) then
  raise EddAutolinkError.Create('Не определён целевой документ!');
 f_EntryCollector := TddEntryCollector.Create(False{not right-aligned});
end;

procedure TddDefDocLinkFinder.pm_SetTargetExtDocID(const Value: TDocID);
begin
 f_TargetExtDocID := Value; 
 f_TargetIntDocID := LinkServer(CurrentFamily).Renum.ConvertExternalDocNumberToInternal(f_TargetExtDocID);
end;

end.