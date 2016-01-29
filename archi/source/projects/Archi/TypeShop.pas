Unit TypeShop;

interface

 uses
  SysUtils,
  l3Base, l3Except,
  l3LongintList,
  Dt_Types,
  evInternalInterfaces,
  nevTools,
  afwNavigation,
  m4DocumentAddress;

 type //exception

  EarSetHyperLinkError = class(El3NoLoggedException); //ошибка установки гиперлинка

 type
  TDocPointAddr = Dt_Types.TGlobalCoordinateRec;

  TDocAddrList = record
   rFamilyID : TFamilyID;
   rDocID  : TDocID;
   rSubIDList : Tl3LongintList;
  end;

  TDocJumpType = (djNone, djSub, djSubList, djFoundWord, djReferences, djTextSearch, djBlockRef);
  TDocJumpRec  = record
                  JumpOnLoad : Boolean;
                  JumpOnce   : Boolean;
                  Case DocJumpType : TDocJumpType of
                    //djNone       :;
                    djSub        : (DocPointAddr : TDocPointAddr);
                    djReferences : (DocAddrList  : TDocAddrList);
                    djFoundWord  : (TextSrchBuf  : Tm4Addresses);
                    djSubList    : (FindSubList  : Tl3LongintList);
                    djTextSearch : (SearchString : ShortString);
                    djBlockRef   : (AnchorID: Longint;
                                    Positions: Tl3LongintList);
                 end;

 function MakeDocJumpData(aDocJumpType : TDocJumpType; var Data;
                          aJumpOnLoad : Boolean = false{;
                          aJumpOnce : Boolean = False}) : TDocJumpRec;
 function DocPointAddr2evAddress(aDocPointAddr : TDocPointAddr): TevAddress;
 function MakeDocPointAddr(aFamilyID : TFamilyID; aDocID : TDocID; aSubID : TSubID): TDocPointAddr;
 function MakeDocAddrList(aFamilyID : TFamilyID; aDocID : TDocID; aSubIDList : Tl3LongintList): TDocAddrList;

 function MakeBlockRefJumpData(aAnchor: Longint; aPositions: Tl3LongintList): TDocJumpRec;

 const
  EmptyDocJumpRec : TDocJumpRec = (DocJumpType : djNone);

implementation

function MakeDocPointAddr(aFamilyID : TFamilyID; aDocID : TDocID; aSubID : TSubID): TDocPointAddr;
begin
 With Result do
  begin
   Family := aFamilyID;
   Doc    := aDocID;
   Sub    := aSubID;
  end;
end;

function MakeDocAddrList(aFamilyID : TFamilyID; aDocID : TDocID; aSubIDList : Tl3LongintList): TDocAddrList;
begin
 With Result do
  begin
   rFamilyID  := aFamilyID;
   rDocID     := aDocID;
   rSubIDList := aSubIDList;
  end;
end;

function DocPointAddr2evAddress(aDocPointAddr : TDocPointAddr): TevAddress;
begin
 With aDocPointAddr do Result := TevAddress_C(Doc, Sub);
end;

function MakeDocJumpData(aDocJumpType : TDocJumpType;
                         var Data;
                         aJumpOnLoad : Boolean = false) : TDocJumpRec;
 begin
  Result.DocJumpType := aDocJumpType;
  Result.JumpOnLoad  := aJumpOnLoad;
  Result.JumpOnce    := (aDocJumpType in [djNone, djSub]);

  case aDocJumpType of
   djNone       : begin // на всякий случай
                   Result.TextSrchBuf := nil;
                   Result.JumpOnLoad  := false;
                  end;

   djSub        : Result.DocPointAddr := TDocPointAddr(Data);
   djFoundWord  : Result.TextSrchBuf  := Tm4Addresses(Data);
   djSubList    : Result.FindSubList  := Tl3LongintList(Data);
   djReferences : Result.DocAddrList  := TDocAddrList(Data);
   djTextSearch : Result.SearchString := ShortString(Data);
  end;
 end;

function MakeBlockRefJumpData(aAnchor: Longint; aPositions: Tl3LongintList): TDocJumpRec;
begin
 Result.JumpOnLoad := True;
 Result.JumpOnce := True;
 Result.DocJumpType := djBlockRef;
 Result.AnchorID := aAnchor;
 Result.Positions := aPositions;
end;

end.