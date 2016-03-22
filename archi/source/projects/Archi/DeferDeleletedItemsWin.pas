unit DeferDeleletedItemsWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Dt_Types, dt_AttrSchema,
  l3TreeInterfaces, l3Tree_TLB,
  vtForm, Menus, F_AttrExplorer;

type
  TDeferDelItemsWin = class(TvtForm)
    AttrExplorer: TAttrExplorer;
  private
    function DoOnItemAction(aAttrID : TdtAttribute; aNode : Il3HandleNode; aReadOnly : boolean; aSub : Longint) : Boolean;
    procedure LoadDictItems;
  public
    { Public declarations }
  end;

  procedure RunDeferDeltemsWin;

implementation
{$R *.dfm}
 uses
  l3MinMax,
  l3Base, l3String, l3Nodes,
  l3FieldSortRecList, l3LongintList,
  arAttrNodes,
  daTypes,
  daSchemeConsts,
  dtIntf, dt_Sab,
  dt_Const,
  dt_Dict, dt_Link, dt_LinkServ, dt_Query,
  DocAttrIntf, DocAttrToolsIntf,
  DictsSup,
  Main, SrchWin, dt_DictConst;

function GetDictIDList(aAttrID : TdtAttribute) : ISab;
var
 lDDList : Tl3FieldSortRecList;
 lAddCount : Integer;

function lFillBufferProc(aBuffer: Pointer; aBufSize: Longint): Longint; register;
 var
  lCnt : integer;
  i    : integer;

 begin
  lCnt := min(aBufSize div SizeOf(TDictID), lDDList.Count - lAddCount);
  Inc(lAddCount, lCnt);
  Result := lCnt * SizeOf(TDictID);
  for i := 0 to pred(lCnt) do
   PDictID(PChar(aBuffer) + i * SizeOf(TDictID))^ := PdtDeferDelRec(lDDList.ItemSlot(i))^.rID;
 end;

var
 lFillBufferProcStub : TFillBufferProc;
begin
 lDDList := DictServer(CurrentFamily).Dict[TdaDictionaryType(aAttrID)].DeferDeleletedItems;
 if (lDDList = nil) or (lDDList.Count = 0) then
 begin
  Result := nil;
  Exit;
 end;

 lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
 try
  lAddCount := 0;
  Result := MakeValueSet(LinkServer(CurrentFamily).Links[TdaDictionaryType(aAttrID)], lnkDictIDFld, lFillBufferProcStub);
 finally
  FreeFillBufferProc(lFillBufferProcStub);
 end;
 Result.RecordsByKey;
 Result.ValuesOfKey(lnkDictIDFld);
 if Result.IsEmpty then Result := nil;
end;

procedure TDeferDelItemsWin.LoadDictItems;
{ - Заполнение дерева классификаторов для метки}
 var
  lAttribute : IDictAttributeTool;

 function IterHandler(CurNode : Il3Node) : Boolean; far;
  function lRecAccessProc(aRec : Pointer) : Boolean;
  begin
   Result := True;
   lAttribute.AddRec(PDictID(aRec)^);
  end;

  var
   lIDSab : ISab;
   lStub  : TdtRecAccessProc;
  begin
   lAttribute := (CurNode as IarAttributeContainer).Attribute as IDictAttributeTool;
    begin
     lIDSab := GetDictIDList(TdtAttribute((CurNode as Il3HandleNode).Handle));
     if (lIDSab <> nil) and not lIDSab.IsEmpty then
     begin
      lStub := L2RecAccessProc(@lRecAccessProc);
      try
       lIDSab.IterateRecords(lStub);
      finally
       FreeRecAccessProc(lStub);
      end;
     end;
    end;
  end;

 begin
  Screen.Cursor := crHourGlass;
  try
   //  if aDictSet = [] then aDictSet := fAttrSet;
   //  if (aDictSet * fAttrSet <> []) then
   try
    AttrExplorer.otlAttributes.Changing;
    AttrExplorer.otlAttributes.IterateF(Tl3NodeAction(l3L2FA(@IterHandler)), imOneLevel);
   finally
    AttrExplorer.otlAttributes.Changed;
   end;
  finally
   Screen.Cursor := crDefault;
  end;
 end;

function TDeferDelItemsWin.DoOnItemAction(aAttrID : TdtAttribute; aNode : Il3HandleNode; aReadOnly : boolean; aSub : Longint) : Boolean;
var
 lDLType   : TdaDictionaryType;
 lStr      : String;
 l_DictIDList: Tl3LongintList;
 l_Query   : TdtQuery;
begin
 Result := True;
 Screen.Cursor := crHourGlass;
 try
  try
   l_DictIDList := Tl3LongintList.Make;
   try
    //GetListFromTree(otlAttrFilter.CTree, lSrchData.DictIDList);
    l_DictIDList.Add(aNode.Handle);
    lDLType := TdaDictionaryType(((aNode as Il3Node).Parent as Il3HandleNode).Handle);
    l_Query := TdtDictQuery.Create(lDLType, l_DictIDList);
   finally
    l3Free(l_DictIDList);
   end;
   With TSearchWin.Create(Self) do
   begin
    Family := CurrentFamily;
    DocList.Query := l_Query;

    lStr := l3Str((aNode as Il3Node).Text);
    lStr := l3GetLastPartOfName(lStr, gLinesLevelSlash);
 
    SrchName := Format('Удаляемые в ближайшую версию : "%s"', [lStr]) {cDLPassports[lAttrID].rName};
   end;
  finally
   l3Free(l_Query);
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure RunDeferDeltemsWin;
begin
 with TDeferDelItemsWin.Create(MainForm) do
 begin
  AttrExplorer.AttrSet := [atKeyWords];
  AttrExplorer.OnItemAction := DoOnItemAction;
  LoadDictItems;
 end;


end;

end.
