unit arSearch;

{$Include l3Define.inc}

{ $Id: arSearch.pas,v 1.46 2013/05/31 07:20:24 lulin Exp $ }

interface

{$INCLUDE ProjectDefine.inc}

uses
 WinTypes,
 Classes,

 l3RegEx,
 l3Types, 
 l3Base, 
 l3Interfaces,
 l3LongintList,
      
 k2Base,
      
 evTypes, 
 evIntf, 
 evSearch,
 evInternalInterfaces,

 nevTools,
 nevNavigation,

 DT_Types, 
 DT_Hyper,

 DocIntf,
 EditWin;

type
 TarMultiHyperlinkSearcher = class(TevCustomHyperlinkSearcher)
  { - для поиска ссылок вида DocID + SubID in SubIDList, используется для перехода из списка корреспондентов}
  private
   fDocID  : TDocID;
   fSubIDList  : Tl3LongintList;
   procedure SetSubIDList(aList : Tl3LongintList);
  protected
   procedure Cleanup; override;

   function DoHyperlinkSearch(const aHLink : IevHyperLink): Bool; override;
  public
   property HLDocID  : TDocID read fDocID write fDocID;
   property HLSubIDList  : Tl3LongintList read fSubIDList write SetSubIDList;
 end;

 TarHyperlinkSearcher = class(TevHyperlinkSearcher)
  private
   fCurrentDoc  : TDocAddr;
   fSearchAddr : TDestHLinkRec;
  protected
   procedure DoSetText(const Value: AnsiString);
    override;
  public
   property CurrentDoc : TDocAddr read fCurrentDoc write fCurrentDoc;
   property SearchAddr : TDestHLinkRec read fSearchAddr write fSearchAddr;
 end;

 TarHyperLinkReplacer = class(TevHyperlinkReplacer)
  private
   fCurrentDoc  : TDocAddr;
   fReplaceAddr : TDestHLinkRec;
   fAbsentDoc   : Boolean;
   fEnableAbsentDoc : Boolean;
  protected
   procedure DoSetText(const Value: AnsiString);
    override;
  public
   property CurrentDoc  : TDocAddr read fCurrentDoc write fCurrentDoc;
   property ReplaceAddr : TDestHLinkRec read fReplaceAddr write fReplaceAddr;
   property AbsentDoc   : Boolean read fAbsentDoc;
   property EnableAbsentDoc : Boolean read fEnableAbsentDoc write fEnableAbsentDoc;

 end;

 TarSubReplacer = class(TevSubReplacer)
  protected
   function  pm_GetDefaultText: AnsiString;
    override;
        {-}
 end;{TarSubReplacer}

 (*
 TarRegularExpressionSearcher = class(TevTextSearcher)
   {* Класс инструментов для поиска регулярного выражения. }
    private
      f_SrchMashine : Tl3RegularSearch;
    protected
      procedure DoSetText(const Value: AnsiString);
        override;
        {-}
      //function CheckError(aError : Integer) : Bool;
        {-}
      procedure Release;
        override;
        {-}
    public
      constructor Create(aOwner: TComponent);
       override;
      function Search(const Sender : Tk2AtomR;
                      S            : Tl3CustomString;
                      Start,
                      Finish       : Long;
                      var SP, FP   : Long): Bool;
        override;
        {-}
  end;{TevNormalWordSearcher}
*)

 TarHLinkTNVEDSearcher = class(TevRegularExpressionSearcher)
  public
   constructor Create(aOwner: TComponent); override;

 end;{TarHLinkTNVEDSearcher}

 TarHLinkTNVEDReplacer = class(TevBaseReplacer)
  public
   function  ReplaceFunc(const aView : InevView;
                         const Container : InevOp;
                         const aBlock    : InevRange): Bool; override;
 end;{TevTextReplacer}

implementation

uses
 SysUtils, Controls,
 DT_Const, DT_Serv, DT_Doc,
 dt_LinkServ,
 l3MinMax,
 l3String,
 StrShop,
 Dialogs, vtDialogs,
 AddrSup,
 arTypes,
 evParaTools,
 afwNavigation;

{TarMultiHyperlinkSearcher}
procedure TarMultiHyperlinkSearcher.Cleanup;
begin
 l3Free(fSubIDList);
 Inherited;
end;

procedure TarMultiHyperlinkSearcher.SetSubIDList(aList : Tl3LongintList);
begin
 l3Free(fSubIDList);
 if aList <> nil then
  fSubIDList := aList.Use;
end;

function TarMultiHyperlinkSearcher.DoHyperlinkSearch(const aHLink : IevHyperLink): Bool;
  //override;
  {-}
var
 lCurAddr : TevAddress;
 l_Index  : Integer;
begin
 //if Assigned(f_OnHyperlinkSearch) then
 // Result := f_OnHyperlinkSearch(Self, aHLink)
 //else
 //begin
 Result := false;
 if (aHLink.AddressList.Count = 0) then Exit;
 for l_Index := 0 to Pred(aHLink.AddressList.Count) do
 begin
  lCurAddr := aHLink.AddressList[l_Index];
  if ((lCurAddr{$IfDef XE4}.rTafwAddress{$EndIf}.DocID = fDocID) or (fDocID < 0)) and
     ((fSubIDList = nil) or (fSubIDList.IndexOf(lCurAddr{$IfDef XE4}.rTafwAddress{$EndIf}.SubID) >= 0)) then
  begin
   Result := true;
   Break;
  end;//(lCurAddr.DocID = DocID) or (DocID < 0)
 end;//for I
// end;//Assigned(f_OnHyperlinkSearch)
end;

{TarHyperlinkSearcher}
procedure TarHyperlinkSearcher.DoSetText(const Value: AnsiString);
 begin
  If StrToHlinkSpecValue(Value, fSearchAddr.Doc, fSearchAddr.Sub) then
   begin
    //TEditorWindow(GetParentForm(fEditor)).CurDocument.InitWrongHlinkList;
   end
  else
   begin
    StrToDocAddr(Value, fSearchAddr.Doc, fSearchAddr.Sub);
    If fSearchAddr.Doc = 0 then
     fSearchAddr.Doc := fCurrentDoc.DocID
    else
     begin
      fSearchAddr.Doc := LinkServer(fCurrentDoc.FamID).Renum.ConvertToRealNumber(fSearchAddr.Doc);
      If (fSearchAddr.Doc <= 0) then
       raise Exception.Create(Format(sidNoDocPresent,[fSearchAddr.Doc]));
     end;
   end;

  inherited DoSetText(Value);
 end;

{TarHyperLinkReplacer}

procedure TarHyperLinkReplacer.DoSetText(const Value: AnsiString);
 var
  lRelFlag : Boolean;
  lDocID   : TDocID;
  lDocIsPresent : Boolean;

 begin
  fAbsentDoc := false;
  StrToDocAddr(Value, fReplaceAddr.Doc, fReplaceAddr.Sub);
  If fReplaceAddr.Doc = -1 then
  begin
   If fReplaceAddr.Sub = -1 then
    raise Exception.Create(sidEmptyHyperAddress);
  end
  else
   If fReplaceAddr.Doc = 0 then
    fReplaceAddr.Doc := fCurrentDoc.DocID
   else
   begin
    lDocID := LinkServer(fCurrentDoc.FamID).Renum.ConvertToRealNumber(fReplaceAddr.Doc);

    if (lDocID = 0) then
    begin
     fReplaceAddr.Doc := 0;
     raise Exception.Create(Format(sidWrongDocID,[lDocID]));
    end;

    lDocIsPresent := (lDocID > -1) and DocumentServer(fCurrentDoc.FamID).CheckDoc(lDocID, True, lRelFlag);

    if lDocIsPresent or (EnableAbsentDoc and
       (vtMessageDlg(l3Fmt(sidNoDocPresent + ^M + sidQstContinue,
       [fReplaceAddr.Doc]), mtWarning, [mbYes, mbNo]) = mrYes)) then
    begin
     fAbsentDoc := Not lDocIsPresent;
     if (lDocID = -1) then
     begin
      lDocID := fReplaceAddr.Doc;
      LinkServer(fCurrentDoc.FamID).Renum.GetRNumber(lDocID);
     end;
    end
    else
    begin
     fReplaceAddr.Doc := 0;
     if EnableAbsentDoc then
      raise EarSilent.Create(Format(sidNoDocPresent,[fReplaceAddr.Doc]))
     else
      raise Exception.Create(Format(sidNoDocPresent,[fReplaceAddr.Doc]));
    end;

    fReplaceAddr.Doc := lDocID;

    {if (lDocID <= 0) or
       not DocumentServer.CheckDoc(fReplaceAddr.Doc, True, lRelFlag) then
    begin
     fReplaceAddr.Doc := 0;
     raise Exception.Create(Format(sidNoDocPresent,[lDocID]));
    end;}

   end;

  inherited DoSetText(Value);
 end;

{TarSubReplacer}

function TarSubReplacer.pm_GetDefaultText: AnsiString;
begin
 Result := '';
end;

{TarHLinkTNVEDSearcher}

constructor TarHLinkTNVEDSearcher.Create(aOwner: TComponent);
 Begin
  inherited Create(aOwner);
  //Text := '[0-9][0-9]([0-9][0-9](( )?[0-9][0-9]([^0-9][0-9][0-9][0-9])?)?)?';
  Text := '\d\d(\d\d(( )?\d\d([^0-9]\d\d\d)?)?)?';
 end;

{TarHLinkTNVEDReplacer}

function TarHLinkTNVEDReplacer.ReplaceFunc(const aView : InevView;
                                           const Container : InevOp;
                                           const aBlock    : InevRange): Bool;
 var
  FndLen     : Integer;
  SubCoord   :  TGlobalCoordinateRec;
  {FndDoc     : Longint;}
  {FndSub     : Longint;}
  HLId       : Long;
  S          : AnsiString;
  HL         : IevHyperlink;
 begin
  Result := True;
  S := l3Str(evAsString(aBlock.Data, cf_Text));
  FndLen := Length(S);
  SubCoord.Family := TDocEditorWindow(Owner).DocFamily;
  SubCoord.Doc := 650000 + StrToInt(Copy(S, 1, 2));
  SubCoord.Doc := LinkServer(TDocEditorWindow(Owner).DocFamily).Renum.ConvertToRealNumber(SubCoord.Doc);
  //TDocEditorWindow(Owner).DocData.ReNumTbl.ConvertToRealNumber(SubCoord.Doc);
  If SubCoord.Doc = -1 then
   Begin
    Result := False;
    Exit;
   end;

  If FndLen >= 4
   then SubCoord.Sub := StrToInt(Copy(S, 3, 2))
   else SubCoord.Sub := 0;
  Try
   If Supports(aBlock, IevHyperlink, HL) then
    try
     if not HL.Exists then HL.Insert;
     HL.AddressList.Add(TevAddress_C(SubCoord.Doc, SubCoord.Sub));
    finally
     HL := nil;
    end//try..finally
   else
    Raise Exception.Create('');
  except
   Result := False;
  end;
 end;

{TarRegularExpressionSearcher}
(*
constructor TarRegularExpressionSearcher.Create(aOwner: TComponent);
 begin
  inherited Create(aOwner);
  f_SrchMashine := Tl3RegularSearch.Create;
 end;

procedure TarRegularExpressionSearcher.Release;
 begin
  l3Free(f_SrchMashine);
  inherited Release;
 end;

procedure TarRegularExpressionSearcher.DoSetText(const Value: AnsiString);
 begin
  Inherited DoSetText(Value);
  f_SrchMashine.SearchPattern := Value;
 end;

//function TarRegularExpressionSearcher.CheckError(aError : Integer) : Bool;

function TarRegularExpressionSearcher.Search(const Sender : Tk2AtomR;
                                                   S            : Tl3CustomString;
                                                   Start,
                                                   Finish       : Long;
                                               var SP, FP   : Long): Bool;
 var
  REPosition: TMatchPosition;
 begin
  f_SrchMashine.IgnoreCase :=  not (ev_soMatchCase in Options);

  Result := (S <> nil) and
            f_SrchMashine.SearchInString(S.St, Start, Finish, REPosition, S.CodePage);
  with REPosition do
   begin
    SP := StartPos;
    FP := EndPos;
   end;
 end;
*)
end.
