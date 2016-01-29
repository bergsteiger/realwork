unit TreeDWin;

interface
{$I ProjectDefine.inc}
{.$Define SilentAttrSet}
uses
  SysUtils, WinTypes, WinProcs, Messages, Menus,
  Classes, Graphics, Controls, ImgList,
  Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, ComCtrls,
  Mask, ToolEdit, TB97ctls,

  vtDialogs, vtCtrls, vtlister, vtOutliner, vtStatusBar,

  l3LongintList, l3DatLst, l3Nodes, l3Tree_TLB, l3Types, l3InternalInterfaces, l3TreeInterfaces, l3Interfaces,

  OvcBase,

  daTypes,

  Dt_Const, DT_Types, dt_AttrSchema,
  DT_Dict,

  afwControl, afwInputControl,
  afwControlPrim, afwBaseControl,

  ActnList,


  DictMetaForm
  ;

type
  TTreeDesignerForm = class(TDictMetaForm)
    tbShowEqLeaf: TSpeedButton;
    miInsertClassToObjList2: TMenuItem;
    N1: TMenuItem;
    miShowEqLeaf: TMenuItem;
    miAddEqLeaf: TMenuItem;
    miDelEqLeaf: TMenuItem;
    N2: TMenuItem;
    miTransformToDivision: TMenuItem;
    N3: TMenuItem;
    miMostLinked: TMenuItem;
    ListPopUpMenu: TPopupMenu;
    miInsertClassToObjList: TMenuItem;
    N4: TMenuItem;
    miLoadFromFile: TMenuItem;
    acKeepItemToObjList: TAction;
    acShowEqLeaf: TAction;
    acAddEqLeaf: TAction;
    acDelEqLeaf: TAction;
    acTransformToDivision: TAction;
    acLoadFromFile: TAction;
    miEmptyItems: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acShowEqLeafClick(Sender: TObject);
    procedure acKeepItemToObjListClick(Sender: TObject);
    procedure DictOutlinerGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);
    function  DictOutlinerGetItemImage(Sender: TObject; Index: Integer; var aImages: TCustomImageList): Integer;
    procedure acAddEqLeafClick(Sender: TObject);
    procedure acTransformToDivisionClick(Sender: TObject);
    procedure miMostLinkedClick(Sender: TObject);
    procedure DictOutlinerCurrentChanged(Sender: TObject; aNewCurrent, aOldCurrent: Integer);
    function  DictOutlinerIsCommandProcessed(aSender: TObject; aOperation: Cardinal): Boolean;
    procedure acLoadFromFileClick(Sender: TObject);
    procedure miEmptyItemsClick(Sender: TObject);
   private
    Family   : TFamilyID;
    //fShowMode : TDictShowMode;
    fLeafIDList : Tl3LongintList;

    function  GetDictServ : TDictionaryServer;
    //procedure ChangeJourNodeOperation(aNode : IDictItemJour; aOperation : TOperActionType);
    //procedure evntNodeMoved(const aNode: Il3Node; aDirection : Tl3Direction);
    procedure AddInfoToLogJournal(aItemID : Longint; aDictID : TdaDictionaryType); overload;
    procedure AddInfoToLogJournal(aItemID : Longint); overload;
    procedure SetFlagOnSubTree(const aSubRoot : Il3Node; aFlag : TOperActionType);
    procedure evntNodeMoveEnd(aSender : TObject; const aNode : Il3SimpleNode; aParentWasChange : Boolean);

    procedure LoadFromFile(FName : TFileName);
    procedure WaitDlgCanClose(var aCanClose: Boolean);
   protected
    procedure Cleanup; override;

    procedure AddItem;                     override;
    function AddExtItem(const aParentNode: Il3Node; var aNode: Il3Node): Boolean;

    procedure DeleteItem;                  override;
    procedure EditItem(aIndex : Longint);  override;
    function  EditItemOfSourcesDict(anID: Longint): Boolean;
    function  EditItemOfUsualDict(const aNode: Il3HandleNode): Boolean;
    function  EditItemOfNewClassesDict(const aNode: Il3HandleNode): Boolean;

    function AddItemOfPublishedlDict(const aParentNode: Il3Node; var aNode: Il3Node): Boolean;
    function  EditItemOfPublishedlDict(const aNode: Il3ExtItemNode): Boolean;

    procedure SaveToFile;                  override;

    function CheckMayBeSelected(aIndex : Integer) : Boolean; override;
   public
    constructor Create(aOwner : TComponent; aFamily : TFamilyID;
                       aDictID : TdaDictionaryType; aShowMode : TDictShowMode); reintroduce;

    procedure   SetSpeedButton(Enabled : Boolean); override;
    procedure   UndoEdit;

    function    Execute(const aItemList : Il3IntegerList = nil;
                        aAllowSelNonLeaf : Boolean = False; aMultiSelect : Boolean = True) : Boolean;

    property    DictServ : TDictionaryServer read GetDictServ;

  end;

procedure ApplyClassDeltaFile(aFamily : TFamilyID; aDeltaFileName : TFileName);

{ применяет файл добавленных/удаленных/замененных Элементов словаря
  Проблемы с заливкой
   - если New - подпапка Old, то убивать Old не надо, но надо перенести линки
   - если New = Old - ничего не делать
 }

procedure ApplyClassBatchFile(aFamily : TFamilyID; aBatchFileName : TFileName);
 {применяет файл добавленных/удаленных/замененных Линков словаря к документам}

implementation

{$R *.DFM}
{.$define newEditDlg}

uses
     Windows,
     OvcConst,
     k2Tags, k2TagGen,
     ddRTFWriter,
     l3ControlsTypes,
     l3Base, l3MinMax, l3Chars, l3String, l3Bits, l3Languages, l3FileUtils, l3Filer, l3DateSt,
     l3Const, l3Tree, l3TreeSupport, l3InterfacesMisc,
     l3Except, l3IniFile,
     evdTypes, evdStyles,
     StrShop, ResShop,
     ObjList,
     daDataProvider,
     HT_Const, HT_Dll,
     dtIntf, dt_Sab, DT_Query,
     Dt_Link, Dt_LinkServ, dt_Err,
     DtSupport,
     dt_DictExport,

     IniShop, DictsSup,
     Main, LinkHistoWin,
     d_DirEdit, D_FileEdit, d_NameEd, d_NameSrcEd,
     d_ExtNameEd, //{.$ifNdef NewPubDict} D_DictItemEdit (*{$else} d_ExtNameEd {$endif}*),
     d_NewClassNameEd,
     d_DelRpl, {d_GetSrc,} dShowEqI, d_DictItemRequest, D_IssueProps,
     D_DictItemKind, l3LongintListPrim,

     PageBreak_Const,
     TextPara_Const,
     SegmentsLayer_Const,
     TextSegment_Const,
     Document_Const
     , l3Date, dt_DictConst, dt_DictTypes, dt_DictIntf;

resourcestring
 sEditDialogCaption = 'Исправить';

function NormPCharLen(const aStr : Tl3WString) : Tl3PCharLen;
begin
 Result := l3ReplaceNonReadable(l3Trim(aStr));
end;

procedure ApplyClassBatchFile(aFamily : TFamilyID; aBatchFileName : TFileName);
 type
  TOperation = (otNone,otAdd,otDel,otChange);
  PAddr      = ^TAddr;
  TAddr      = record
                doc : integer;
                sub : integer;
               end;
 const
  cLevelSlash : AnsiString = '\';
 var
  CN        : Il3Node;
  lDictServ : TDictionaryServer;
  lDictID   : TdaDictionaryType;

  lOldStr   : AnsiString;
  lNewStr   : AnsiString;

  lOldDictNum : Integer;
  lNewDictNum : Integer;

  lCurFile  : TevDOSFiler;

  lOperation : TOperation;
  lAddrList  : Tl3DataList;

  lNode      : Il3HandleNode;
  lRootNode  : TDictRootNode;
  I          : Integer;
  lLinkServ  : TLinkServer;

  procedure AddAddr2List(const AddrStr : AnsiString);
   var
    lAddr : TAddr;
    lPos  : Integer;
   begin

    lPos := Pos('.', AddrStr);
    If lPos = 0
     then
      begin
       lAddr.Doc := StrToInt(AddrStr);
       lAddr.Sub := 0;
      end
     else
      begin
       lAddr.Doc := StrToInt(Copy(AddrStr,0,Pred(lPos)));
       lAddr.Sub := StrToInt(Copy(AddrStr,Succ(lPos),MaxInt));
      end;
    lAddr.Doc := lLinkServ.Renum.ConvertToRealNumber(lAddr.Doc);
    If lAddr.Doc <> -1
     then lAddrList.Add(@lAddr);
   end;

var
  lStr      : Tl3String;
 begin
  lDictID := da_dlClasses;
  lDictServ := DictServer(aFamily);

  lLinkServ := LinkServer(aFamily);
  lLinkServ.Links[lDictID].Table.StartCaching;

  try
   lOldStr   := '';
   lNewStr   := '';

   lRootNode := lDictServ.DictRootNode[lDictID];

   lCurFile:=TevDOSFiler.Make(aBatchFileName);
   Try
    lCurFile.Mode:=l3_fmRead;
    lCurFile.Open;
    lAddrList := Tl3DataList.CreateSize(SizeOf(TAddr));
    Try
     lOperation := otNone;
     //Cnt:=0;
      While not lCurFile.EOF do
       begin
        lStr := Tl3String.Make(lCurFile.ReadLn);
        try
         lStr.CodePage := GlobalDataProvider.BaseLanguage[aFamily].AnsiCodePage; //CP_ANSI;
         lStr.Trim;

         If (lStr.Len <> 0)
          then
           begin
            If l3AnsiStrLICompExt(lStr.St, '!CLASS', 6) = 0
             then
              begin
               If lOldStr = ''
                then lOldStr := Trim(l3GetStrPas(lStr.St+7))
                else lNewStr := Trim(l3GetStrPas(lStr.St+7));
              end
             else
              If l3AnsiStrLICompExt(lStr.St, 'CHA', 3) = 0
               then
                lOperation := otChange
               else
                If l3AnsiStrLICompExt(lStr.St, 'ADD', 3) = 0
                 then
                  lOperation := otAdd
                 else
                  If l3AnsiStrLICompExt(lStr.St, 'DEL', 3) = 0
                   then
                    lOperation := otDel
                   else
                    AddAddr2List(Trim(l3GetStrPas(lStr.St)));
           end;
         If ((lStr.Len = 0) or (lCurFile.EOF))
          then
           If (lOperation <> otNone)
            then
             try
              {Apply}
              lNode := l3SearchByPath(lRootNode, l3PCharLen(lOldStr), cLevelSlash) as Il3HandleNode;
              If lNode <> nil
               then lOldDictNum := lNode.Handle
               else Exception.Create('DictItem = '+ lOldStr + 'не найден.');

              If (lOperation = otChange) then
               begin
                lNode := l3SearchByPath(lRootNode, l3PCharLen(lNewStr), cLevelSlash) as Il3HandleNode;
                If lNode <> nil
                 then lNewDictNum := lNode.Handle
                 else Exception.Create('DictItem = '+ lNewStr + 'не найден.');
               end;
              for I := 0 to Pred(lAddrList.Count) do
              with PAddr(lAddrList.Data[I])^ do
              begin
               case lOperation of
                otAdd    : begin
                            lLinkServ.AddSubNode(DLType2AttrID(lDictID), Doc, Sub, lOldDictNum);
                           end;
                otDel    : begin
                            lLinkServ.DelSubNode(DLType2AttrID(lDictID), Doc, Sub, lOldDictNum);
                           end;
                otChange : begin
                            lLinkServ.DelSubNode(DLType2AttrID(lDictID), Doc, Sub, lOldDictNum);
                            lLinkServ.AddSubNode(DLType2AttrID(lDictID), Doc, Sub, lNewDictNum);
                           end;
               end;
              end;

              lOldStr   := '';
              //lNewStr   := '';

              lOperation := otNone;
              lAddrList.Clear;
              continue;
             except
              On E : Exception do Application.ShowException(E);
             end;
        finally
         FreeAndNil(lStr);
        end;//try..finally

       end;
    finally
     l3Free(lAddrList);
    end;
   finally
    l3Free(lCurFile);
   end;
  finally
   lLinkServ.Links[lDictID].Table.StopCaching;
  end;

  lRootNode.Save;
 end;

procedure ApplyClassDeltaFile(aFamily : TFamilyID; aDeltaFileName : TFileName);
 const
  cLevelSlash : AnsiString = '\';
 var
  CN        : Il3Node;
  lDictServ : TDictionaryServer;
  lDictID   : TdaDictionaryType;
  lRootNode : TDictRootNode;
  lOldStr   : AnsiString;
  lNewStr   : AnsiString;
  lCurFile  : TevDOSFiler;


 function AddtoDict(aFullName : Tl3WString) : Il3HandleNode;
 var
  l_EndPos   : Integer;
  l_Part     : Tl3WString;
 begin
  Result := l3GetPartPath(lRootNode, aFullName, cLevelSlash) as Il3HandleNode;
  if not l3IsNil(aFullName) then
    repeat
   l_EndPos := l3Pos(aFullName, l3PCharLen(cLevelSlash));
   if l_EndPos <> l3NotFound then
    l_Part := l3Copy(aFullName, 0, l_EndPos)
   else
    l_Part := aFullName;

   if not l3IsNil(l_Part) then
   begin
    Result := lDictServ.Dict[lDictID].AddDictNode(cUndefDictID, l_Part, l3PCharLen(cEmptyEngName), l3PCharLen, Result as Il3Node) as Il3HandleNode;
    if l_EndPos <> l3NotFound then
     aFullName := l3Copy(aFullName, l_EndPos+Length(cLevelSlash));
   end;
  until l_EndPos = l3NotFound;
 end;

 procedure DelOldItem(aNewID : TDictID = cUndefDictID);
  var
   lDelID   : Integer;
   lNode    : Il3Node;
   lDelNode : Il3Node;
  begin
   if lOldStr = '' then Exit;
   lNode := l3SearchByPath(lRootNode, l3PCharLen(lOldStr), cLevelSlash);
   if lNode <> nil then
   begin
    lDelNode := lNode;
    lNode := lNode.ParentNode;
    (lDelNode as IPersistentNode).DeleteEx(aNewID);
    while lNode.ChildNode = nil do
    begin
     lDelNode := lNode;
     lNode := lNode.ParentNode;
     lDelNode.Delete;
    end;
   end;
   lOldStr := '';
  end;
  
 var
  lStr      : Tl3String;
 begin
  lDictID := da_dlClasses;
  lDictServ := DictServer(aFamily); {TDictionaryServer.Create;}

  lRootNode := lDictServ.DictRootNode[lDictID];

  lCurFile := TevDOSFiler.Make(aDeltaFileName);
  try
   lCurFile.Mode:=l3_fmRead;
   lCurFile.Open;
   //Cnt:=0;
   while not lCurFile.EOF do
    begin
     lStr := Tl3String.Make(lCurFile.ReadLn);
     try
      lStr.CodePage := GlobalDataProvider.BaseLanguage[aFamily].AnsiCodePage; //CP_ANSI;
      if lStr.Len <> 0
       then
        begin
         If l3AnsiStrLICompExt(lStr.St, 'OLD', 3) = 0
          then
           begin
            DelOldItem;
            lOldStr := Trim(l3GetStrPas(lStr.St+4));
           end
          else
           If l3AnsiStrLICompExt(lStr.St, 'NEW', 3) = 0
            then
             begin
              lNewStr := Trim(l3GetStrPas(lStr.St+4));

              {If l3AnsiStrLICompExt(PAnsiChar(lNewStr), PAnsiChar(lOldStr), Length(lOldStr)) = 0
               then
                begin
                 AppendToLogLN('d:\log.log', 'old = '+lOldStr);
                 AppendToLogLN('d:\log.log', 'new = '+lNewStr);
                end;
               }

              DelOldItem(AddtoDict(l3PCharLen(lNewStr)).Handle);
             end;
        end
       else
        begin
         DelOldItem;
        end;

      if lCurFile.EOF then
      begin
       DelOldItem;
      end;
     finally
      FreeAndNil(lStr);
     end;//try..finally

    end;
  finally
   l3Free(lCurFile);
  end;

  lRootNode.Save;
 end;

 function tdwFindReadNodeByHandle(const aRootNode : Il3Node;
                                    aHandle   : Integer{;
                                    aIterMode : Integer = 0;
                              const aFromNode : Il3Node = nil}) : Il3Node;

  function IterHandler(const CurNode : Il3Node) : Boolean; far;
   var
    l_HandleNode : Il3HandleNode;
   begin
    try
     if l3IOk(CurNode.QueryInterface(Il3HandleNode, l_HandleNode)) and
        not l3TestMask(CurNode.Flags, cEqualNode) then
      try
       Result := (aHandle = l_HandleNode.Handle);
      finally
       l_HandleNode := nil;
      end//try..finally
     else
      Result := false;
    except
     Result := false;
    end;
   end;

  begin
   Result := l3IterateSubTreeF(aRootNode, l3L2NA(@IterHandler), imCheckResult {or aIterMode, aFromNode});
  end;

constructor TTreeDesignerForm.Create(aOwner : TComponent; aFamily   : TFamilyID;
                                        aDictID : TdaDictionaryType; aShowMode : TDictShowMode);
 procedure lpAssignRootNode;
  var
   lNode : Il3Node;
   I     : Integer;
  begin
   DictOutliner.TreeStruct.RootNode := DictServ.DictRootNode[DictID];
   DictOutliner.OnNodeMoveEnd := evntNodeMoveEnd;

   case DictID of
    da_dlAccGroups :
     with DictOutliner.CTree do
     begin
      // это спец. ноды из словаря ACCGroups, которые не следует показывать пользователю
      for I := 1 to 4 do
      begin
       lNode := l3FindNodeByHandle(CRootNode, I);
       NodeFlags[lNode] := NodeFlags[lNode] or nfHidden;
      end;
     end;

    da_dlNewClasses_Deprecated :
     Assert(False, 'Deprecated dlNewClasses');
//     DictOutliner.OnNodeMoveEnd := evntNodeMoveEnd;
   end;
  end;

 begin
  inherited Create(aOwner, aDictID, aShowMode);
  Family := aFamily;
  DictOutliner.UseStyleTable:= True;
  if DictID = da_dlNewClasses_Deprecated then
  begin
   Assert(False, 'Deprecated dlNewClasses');
//   DictOutliner.MultiStrokeItem := True;
//   DictOutliner.ViewOptions := DictOutliner.ViewOptions + [voShowInterRowSpace];
  end;

  case ShowMode of
   dmShow : begin
             Screen.Cursor := crHourglass;
             try
              DictOutliner.PickedList := True;
              DictOutliner.CTree.CommonExpanded := True;
              lpAssignRootNode;
             finally
              Screen.Cursor := crDefault;
             end;
            end;

   dmEdit : begin
             Screen.Cursor := crHourglass;
             try
              Application.ProcessMessages;
              lpAssignRootNode;
              If DictID = da_dlKeyWords then
               DictOutliner.CTree.CRootNode.ChildSorted := True;

              if dsIsAllowEditDict(DictID) then
              begin
                DictOutliner.EditOptions := DictOutliner.EditOptions + [eoItemHMoving, eoItemVMoving] - [eoItemDelete];
                ReadOnly := False;
              end
              else
              begin
                DictOutliner.EditOptions := DictOutliner.EditOptions - [eoItemDelete, eoItemHMoving, eoItemVMoving];
                ReadOnly := True;
              end
              {UserConfig.Section := 'DICT';
              If (DictID = da_dlClasses) and not UserConfig.ReadParamBoolDef('ClassEditEnable',false) then
               ReadOnly := True; // нельзя редактировать эталонный словарь классов
              }
             finally
              Screen.Cursor := crDefault;
             end;
             Visible   := True;
            end;
  end;
 end;

procedure TTreeDesignerForm.Cleanup;
begin
 l3Free(fLeafIDList);
 Inherited;
end;

procedure TTreeDesignerForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 inherited FormCloseQuery(Sender, CanClose);

 if CanClose then
 begin
  if ShowMode = dmEdit then {DD Мне кажется, нет смысла сохранять режим просмотра }
   DictServ.DictRootNode[DictID].Save;
 end;
end;

function  TTreeDesignerForm.GetDictServ : TDictionaryServer;
 begin
  Result := DictServer(family); {TDictionaryServer.Create;}
 end;

{function  TTreeDesignerForm.GetLinkServ : TLinkServer;
 begin
  If fLinkServ = nil
   then fLinkServ := TLinkServer.Create;
  Result := fLinkServ;
 end;
}


procedure TTreeDesignerForm.LoadFromFile(FName : TFileName);
const
  cLevelSlash : AnsiString = '\';
var
 CurFile    : TevDOSFiler;
 tStr       : Tl3String;
 pStr, cStr : PAnsiChar;
 NStr       : PAnsiChar;
 NumStr     : AnsiString;
 I, SpCnt   : Word;
 Cnt        : Longint;
 lCurParent : Il3Node;
 lCurNode   : Il3Node;
 lCurIndent : Integer;
 lIndent    : Integer;

 function GetIndent(aSt : PAnsiChar) : Integer;
 begin
  Result := 0;
  while aSt[Result] = ' '{#9} do Inc(Result);
 end;

 procedure AddItemToTree;
 var
  lNode    : Il3Node;
  lSrchNode : Il3Node;
  lName,
  lEndPos  : PAnsiChar;
  lExists  : Boolean;
 begin
  if tStr.Empty then Exit;

  lName := tStr.St;
  //lNode := l3GetPartPath(DictOutliner.CTree.RootNode, lName, cLevelSlash);
  lNode := DictOutliner.CTree.CRootNode;
  if lName = nil then Exit;
  lExists := True;
  Repeat
   lEndPos := StrPos(lName, PAnsiChar(cLevelSlash));
   if lEndPos <> nil then lEndPos[0] := #0;

   // отрежем начальные '001='
   if lName[3] = '=' then
    Inc(lName, 4);

   if lExists then
   begin
    lSrchNode := l3SearchByName(lNode, l3PCharLen(lName), imOneLevel);
    if lSrchNode = nil then
     lExists := False
    else
     lNode := lSrchNode;
   end;

   if lName[0] <> #0 then
   begin
    if not lExists then
     lNode := DictServ.Dict[DictID].AddDictNode(cUndefDictID,
              l3PCharLen(lName), l3PCharLen(cEmptyEngName), l3PCharLen, lNode{lCurParent});
    if lEndPos <> Nil then
     lName := lEndPos + Length(cLevelSlash);
   end;
  until lEndPos = Nil;
 end;

begin
  CurFile:=TevDOSFiler.Create(Nil);
  Try
   CurFile.FileName := FName;
   CurFile.AnalizeCodePage;
   CurFile.Mode:=l3_fmRead;
   CurFile.Open;
   Cnt:=0;
   lCurParent := DictOutliner.CTree.CRootNode;
   lCurIndent := -1;
   DictOutliner.CTree.Changing;
   try
    while not CurFile.EOF do
    begin
     try
      tStr := Tl3String.Make(CurFile.ReadLn);
      if tStr.Len = 0 then Continue;
      lIndent := GetIndent(tStr.St);
      if tStr.Len = lIndent then Continue;
      tStr.CodePage := GlobalDataProvider.BaseLanguage[Family].AnsiCodePage; //CP_ANSI;

      //грузит из текстового файла с полными путями
      AddItemToTree;

      (*
       //грузит из текстового файла с отступами
      {
       //"мягкий" алгоритм : не учитывает точное количество пробелов в отступе,
       //   не позволяет грузить деревья с резкими переходами (>1 уровня)

      If lCurIndent < 0 then
       lCurIndent := lIndent
      else
       If lCurIndent > lIndent then
       begin
        lCurIndent := lIndent;
        lCurParent := lCurParent.ParentNode;
       end
       else
       if lCurIndent < lIndent then
       begin
        lCurIndent := lIndent;
        lCurParent := lCurNode;
       end;
      }

      if lCurIndent < 0 then
       lCurIndent := lIndent
      else
       If lCurIndent > lIndent then
       begin
        for I := 1 to (lCurIndent - lIndent) do
         lCurParent := lCurParent.ParentNode;
        lCurIndent := lIndent;
       end
       else
       if lCurIndent < lIndent then
       begin
        lCurIndent := lIndent;
        lCurParent := lCurNode;
       end;

       Application.ProcessMessages;
       tStr.ReplaceNonReadable.TrimAll;
       lCurNode := DictServ.AddDictNode(TdaDictionaryType(DictID), cUndefDictID, tStr.St, nil, lCurParent);
       //lCurNode := DictOutliner.TreeStruct.InsertNode(lCurParent, MakeNode(@tStr.St[lIndent]));
       *)

      finally
       l3Free(tStr);
      end;{try..finally}

     Inc(Cnt);
     Footer.Panels[0].Text := IntToStr(Cnt);
    end;
   finally
    DictOutliner.CTree.Changed;
   end;
  finally
   l3Free(CurFile);
  end;
end;


(*
// грузит президентский классификатор
Procedure TTreeDesignerForm.LoadFromFile(FName : TFileName);
 var
  CurFile  : TevDOSFiler;
  lStr     : Tl3String;
  lPrevStr : Tl3String;

  procedure ProcessString(aStr : AnsiString);
  var
   lLevel : Integer;
   lParentNode : Il3Node;
  begin
   if Length(aStr) = 0 then Exit;
   if system.Copy(aStr,9,3) <> '000' then
    lLevel := 3
   else
   if system.Copy(aStr,5,3) <> '000' then
    lLevel := 2
   else
    lLevel := 1;

   lParentNode := DictOutliner.TreeStruct.RootNode;

   While lLevel > 1 do
   begin
    Dec(lLevel);
    lParentNode := lParentNode.ChildNode.PrevNode;
   end;
   DictServ.AddDictNode(DictID, cUndefDictID, PAnsiChar(DeleteDoubleSpace(Trim(aStr))), nil, lParentNode);

  end;

 begin
   DictServer.Family := 1;

   CurFile:=TevDOSFiler.Create(Nil);
   CurFile.FileName := FName;
   Try
    CurFile.Mode:=l3_fmRead;
    CurFile.Open;
    Try
     lPrevStr := Tl3String.Create(Nil);

     while True do
     begin
      Application.ProcessMessages;
      lStr := CurFile.ReadLN;

      If lStr.Len <> lStr.Indent then
      begin

       if (lStr[0] in ['0'..'9']) then
       begin
        ProcessString(lPrevStr.AsString);
        l3Free(lPrevStr);
        lPrevStr := lStr.Use;
       end
       else
       begin
        lPrevStr.Append(' ');
        lPrevStr.JoinWith(lStr);
       end;
      end;

      If CurFile.EOF then
      begin
       ProcessString(lPrevStr.AsString);
       break;
      end;
     end;

     finally
      l3Free(lPrevStr);
     end;
    finally
     l3Free(CurFile);
    end;
 end;

*)

{Const
 NNN : Array[1..11] of longint = (8002,8006,8010,8003,8008,8007,8011,8004,8009,8001,8005);}

procedure TTreeDesignerForm.AddItem;
 var
  CN       : Il3Node;
  lCodeStr : AnsiString;
  lCodeStrPtr : PAnsiChar;
  ll3Str  : Tl3PCharLen;
  l_pSourDictRec: PSourDictRec;
//  l_pNewClassDictRec: PNewClassDictRec;
  l_StrR  : Tl3String;
  l_StrE  : Tl3String;
  lID     : TDictID;
  l_Dlg   : TvtCurtainMsg;
  lExtNode : Il3Node;

  function GetItemKind : TItemKind;
  var
   lChildNode : Il3SimpleNode;
   lExtNode : Il3ExtItemNode;
  begin
   Result := ikBase;
   if cDLPassports[DictID].rDepDictID = da_dlNone then Exit;
   if DictOutliner.TreeStruct.IsRoot(CN) then Exit;

   lChildNode := CN.Child;
   if lChildNode <> nil then
   begin
    if Supports(lChildNode, Il3ExtItemNode, lExtNode) then
     Result := ikExt;
   end
   else
    // вложенных нет, придется спросить
    Result := GetDictItemKind;
  end;

 begin
  if ReadOnly then Exit;
  CN := DictOutliner.GetCurrentNode As Il3Node;

  if Supports(CN, Il3ExtItemNode, lExtNode) then Exit;

  case DictID of
   da_dlSources :
    begin
     with TNameEditSrcDlg.Create(Self) do
      try
       BiLingual := DictServ.BiLingual;
       If Execute(GetDictNameLength(DictID)) then
       begin
        New(l_pSourDictRec);
        l3FillChar(l_pSourDictRec^, SizeOf(TSourDictRec));
        l_pSourDictRec.FNameE[1] := cWrongEnglishMark;
        try
         ll3Str := NormPCharLen(mNameRus.Buffer);
         if ll3Str.SLen > 0 then
          l3Move(ll3Str.S^,
               l_pSourDictRec^.FNameR,
               Min(ll3Str.SLen, SizeOf(l_pSourDictRec^.FNameR)));

         if BiLingual then
          ll3Str := NormPCharLen(mNameEng.Buffer)
         else
          ll3Str := l3PCharLen;

         if ll3Str.SLen > 0 then
          l3Move(ll3Str.S^,
               l_pSourDictRec^.FNameE,
               Min(ll3Str.SLen, SizeOf(l_pSourDictRec^.FNameE)));

         lCodeStr := l3DeleteDoubleSpace(Trim(edShortName.Text));
         if Length(lCodeStr) > 0 then
          l3Move(lCodeStr[1], l_pSourDictRec^.SName, Length(lCodeStr));

         ll3Str := NormPCharLen(edSynon.Buffer);
         if ll3Str.SLen > 0 then
          l3Move(ll3Str.S^,
               l_pSourDictRec^.Sinon,
               Min(ll3Str.SLen, SizeOf(l_pSourDictRec^.Sinon)));
         lID := cUndefDictID;
         CN := DictServ.Dict[DictID].AddDictFullDataNode(lID, PAnsiChar(l_pSourDictRec), CN);
         {$IFDEF RemoteDict}
         vtShowWaitMessage('Пожалуйста, подождите', WaitDlgCanClose);
         CN:= DictServer.Dict[DictID].FindNodeByID(DictServer.LastEditedID);
         {$ENDIF}
        finally
         Dispose(l_pSourDictRec);
        end;
       end;
      finally
       Free;
      end;
    end;

   da_dlNewClasses_Deprecated :
    begin
     Assert(False, 'Deprecated dlNewClasses');
(*     with TNewClassNameEditDlg.Create(Self) do
     try
      BiLingual := DictServ.BiLingual;
      pnlRelinkID.Visible := False;
      pnlJuristicChanges.Visible := False;
      if Execute(GetDictNameLength(DictID)) then
      begin
       New(l_pNewClassDictRec);
       try
        l3FillChar(l_pNewClassDictRec^, SizeOf(TNewClassDictRec));
        l_pNewClassDictRec.FNameE[1] := cWrongEnglishMark;

        l_StrR := Tl3String.Make(EditTextR);
        try
         l_StrR.ReplaceNonReadable.TrimAll;
         l_StrR.CodePage := GlobalDataProvider.BaseLanguage[Family].AnsiCodePage; //cp_ANSI;
         l3Move(l_StrR.St^, l_pNewClassDictRec^.FNameR, l_StrR.Len);
        finally
         l_StrR.Free;
        end;

        if BiLingual then
         ll3Str := NormPCharLen(mNameEng.Buffer)
        else
         ll3Str := l3PCharLen;

        if ll3Str.SLen > 0 then
         l3Move(ll3Str.S^,
              l_pNewClassDictRec^.FNameE,
              Min(ll3Str.SLen, SizeOf(l_pNewClassDictRec^.FNameE)));

        if CommentText.SLen > 0 then
         l3Move(CommentText.S^, l_pNewClassDictRec^.Comment, CommentText.SLen);

        l_pNewClassDictRec^.Flag := Ord(atAdd);      //TOperActionType = (atAdd,atDelete,atEdit,atMove);

        lID := cUndefDictID;
        CN := DictServ.Dict[DictID].AddDictFullDataNode(lID, PAnsiChar(l_pNewClassDictRec), CN);
        {$IFDEF RemoteDict}
         vtShowWaitMessage('Пожалуйста, подождите', WaitDlgCanClose);
         CN:= DictServer.Dict[DictID].FindNodeByID(DictServer.LastEditedID);
        {$ENDIF}
        with (CN as IDictItemJour) do
        begin
         Comment := l3PCharLen2String(CommentText) + SysUtils.Format(' (add: %s)',[dsGetCurrentUserName]);
         Operation := TOperActionType(l_pNewClassDictRec^.Flag);
        end;
       finally
        Dispose(l_pNewClassDictRec);
       end;
      end;
     finally
      Free;
     end;*)
    end;

   else {case}
   begin
    if (DictID = da_dlKeyWords) and
       not ((CN.ParentNode = nil) or (CN.ParentNode.ParentNode = nil)) then
    begin
     vtMessageDlg(l3CStr('Попытка создать третий уровень вложенности.'^M+
                  'Словарь ключевых слов двухуровневый.'), mtWarning);
     Exit;
    end;

    case GetItemKind of
     ikCancel : ; //прерываем операцию

     ikExt : //Дополнительные элементы
     begin
      if AddExtItem(CN, lExtNode) then
       CN := lExtNode as Il3Node;
     end;

     ikBase : //базовые элементы
     begin
      with TExtNameEditDlg.Create(Application) do
      Try
       BiLingual := DictServ.BiLingual;
       Caption:='Новый';
       If Execute(DictID, True) then
        Begin
         l_StrR := Tl3String.Make(EditTextR);
         try

          l_StrR.ReplaceNonReadable.TrimAll;
          l_StrR.CodePage := GlobalDataProvider.BaseLanguage[Family].AnsiCodePage; //cp_ANSI;

          if BiLingual then
          begin
           l_StrE := Tl3String.Make(EditTextE);
           l_StrE.ReplaceNonReadable.TrimAll;
           l_StrE.CodePage := cp_ANSI;
           if l_StrE.Len = 0 then
            l_StrE.AsString := cWrongEnglishMark;
          end
          else
           l_StrE := Tl3String.Make(l3PCharLen(AnsiString(cWrongEnglishMark)));

          try
           if ElemID <> cUndefDictID then
            DictServ.Dict[DictID].Tbl.ClaimFreeNum(ElemID);
           CN := DictServ.Dict[DictID].AddDictNode(ElemID, l_StrR.AsWStr, l_StrE.AsWStr, l3PCharLen(Code), CN, IsPrivate, IsNonPeriodic);
           {$IFDEF RemoteDict}
           vtShowWaitMessage('Пожалуйста, подождите', WaitDlgCanClose);
           CN := DictServer.Dict[DictID].FindNodeByID(DictServer.LastEditedID);
           {$ENDIF}
          finally
           l3Free(l_StrE);
          end;

         finally
          l3Free(l_StrR);
         end;
        end;
      finally
       Free;
      end;
     end; //ikBase :
    end; //case GetItemKind of
   end;
  end;
  if CN <> nil then
  begin
   CN.Sort;
   DictOutliner.GotoOnNode(CN As Il3SimpleNode);
  end;
end;

function TTreeDesignerForm.AddExtItem(const aParentNode: Il3Node; var aNode: Il3Node): Boolean;
begin
 Result := AddItemOfPublishedlDict(aParentNode, aNode);
end;

{
procedure TTreeDesignerForm.ChangeJourNodeOperation(aNode : IDictItemJour;
                                                    aOperation : TOperActionType);
var
 lNCRec  : TNewClassDictRec;
 ItID    : Longint;
 //TOperActionType = (atAdd,atDelete,atEdit,atMove);
begin
 ItID := (aNode as Il3HandleNode).Handle;
 FillChar(lNCRec,SizeOf(lNCRec),0);

 lNCRec.FNameSize := aNode.Name.StSize;
 l3Move(aNode.Name.St^, lNCRec.FName, lNCRec.FNameSize);
 l3Move(aNode.Comment[1],lNCRec.Comment,Length(aNode.Comment));

 lNCRec.Flag := Ord(aOperation);

 DictServ.EditDictFullData(fDictID, ItID, @lNCRec);
 aNode.Operation := TOperActionType(lNCRec.Flag);
end;
}
procedure TTreeDesignerForm.AddInfoToLogJournal(aItemID : Longint);
begin
 AddInfoToLogJournal(aItemID,  DictID);   
end;

procedure TTreeDesignerForm.AddInfoToLogJournal(aItemID : Longint; aDictID : TdaDictionaryType);
 {занесение в журнал информации об удаленном или исправленном айтеме,
                   для документов с которыми он был связан }
var
 l_Query : TdtQuery;
 l_List  : Tl3LongintList;
begin
 {$IfDef SilentAttrSet}
  Exit;
 {$EndIf SilentAttrSet}

 //if (DictID = da_dlCorSources) then Exit; // нет поиска по da_dlCorSources

 l_List := Tl3LongintList.Make;
 try
  l_List.Add(aItemID);
  l_Query := TdtDictQuery.Create(aDictID{AttrID2DLType(aAttrID)}, l_List, False{WithEquals}, True{WithSubtree});
  try
   if not l_Query.IsEmpty then
    LinkServer(Family).LogBook.PutLogRecToDocs(l_Query.GetDocIdList, DictIDToJournalAction(aDictID));
  finally
   l3Free(l_Query);
  end;
 finally
  l3Free(l_List);
 end;
end;

procedure TTreeDesignerForm.DeleteItem;
var
 CNode   : Il3Node;
 lDelID  : Longint;
 lHeirID : TDictID;
 lHNode  : IDictItemJour;
 lExtItemNode : Il3ExtItemNode;
 lDictID : TdaDictionaryType;
 l_DateDeleted: TstDate;
 l_Ok: Boolean;

 function HasNonDeletedChild : Boolean;
 var
  lRes : Boolean;

  function IterHandler(const aCurNode : Il3Node) : Boolean; far;
  var
   lHNode : IDictItemJour;
  begin
   if l3IOk(aCurNode.QueryInterface(IDictItemJour, lHNode)) then
   begin
    Result := lHNode.Operation <> atDelete;
    lRes := Result;
   end;
  end;

 begin
  l3IterateSubTreeF(CNode, l3L2NA(@IterHandler),imCheckResult or imOneLevel);
  Result := lRes;
 end;

begin
 if ReadOnly then Exit;
 CNode := DictOutliner.GetCurrentNode As Il3Node;
 if DictOutliner.TreeStruct.IsRoot(CNode) then Exit;

 if CNode.HasChild and
    not l3TestMask(CNode.Flags, cNodeHasEquals) and
    ({(DictID <> da_dlNewClasses_Deprecated) or} HasNonDeletedChild) then
  raise Exception.Create(SysUtils.Format(sidDeleteDenied,[sidDictItemNotLeaf]));


 lDelID := (CNode as Il3HandleNode).Handle;
 l_DateDeleted:= 0;
 if (DictID = da_dlNewClasses_Deprecated) and
     l3TestMask(DictOutliner.TreeStruct.Nodes[DictOutliner.Current].Flags, cEqualNode) then
  Assert(False, 'Deprecated dlNewClasses')
//  l_Ok:= IsPositiveResult(vtMessageDlg(l3Fmt(sidDelQst, [l3PCharLen2String(CNode.Text)]),
//                  mtConfirmation, [mbYes, mbNo], 0, mbNo, mbNo))
 else
 {$IFDEF RemoteDict}
 if DictID = da_dlKeywords then
  l_Ok:= DictItemRequest(Self, DictID, lHeirID, l_DateDeleted,
                          'Элемент-приемник (ID)', 'Подтвердите',
                          SysUtils.Format(sidDelQst,[l3PCharLen2String(CNode.Text)]))
 else
 {$ENDIF}
  l_Ok:= DictItemRequest(Self, DictID, lHeirID,
                          'Элемент-приемник (ID)', 'Подтвердите',
                          SysUtils.Format(sidDelQst,[l3PCharLen2String(CNode.Text)]));

 if not l_Ok then
  Exit;
 Screen.Cursor := crHourglass;
 try
  if (DictID = da_dlNewClasses_Deprecated) then
  begin
   Assert(False, 'Deprecated dlNewClasses');
(*   if l3IOk(CNode.QueryInterface(IDictItemJour, lHNode)) then
   begin
    with lHNode do
    begin
     if (Operation = atAdd) or
        //люк для удаления "левых"
        (l3System.Keyboard.Key[VK_LMENU].Down and
         l3System.Keyboard.Key[VK_RMENU].Down) then
     begin
       if CNode.HasChild and not l3TestMask(CNode.Flags, cNodeHasEquals) and HasNonDeletedChild then
        raise Exception.Create(SysUtils.Format(sidDeleteDenied,[sidDictItemNotLeaf]));

       if lHeirID = 0 then lHeirID := cUndefDictID;
       //CNode := FindTreeNodeByID(DictID, lDelID);
       (CNode as IPersistentNode).DeleteEx(lHeirID);
       //DictServ.DelDictItem(DictID, lDelID, lHeirID);
       //DictServ.DictEqualObj[DictID].DelAllEqualOnID(lDelID);
      end
      else
      begin
       Operation := atDelete;
       NewID     := Max(lHeirID, 0);
       Comment   := Comment + SysUtils.Format(' (del: %s)',[dsGetCurrentUserName]);
      end;
    end
   end
   else
    CNode.Delete;
*)
  end
  else // (DictID = da_dlNewClasses_Deprecated)
  begin
   if Supports(CNode, Il3ExtItemNode, lExtItemNode) then
    lDictID := cDLPassports[DictID].rDepDictID
   else
    lDictID := DictID;

   AddInfoToLogJournal(lDelID, lDictID); //сразу, а то потом не найдутся документы

   //if (lHeirID <> cUndefDictID) and (lHeirID > 0) and (DictServer.DictTbl[lAttrID].iCheckItemInList(lHeirID) = nil) then
   // raise EHtErrors.CreateInt(ecNotEnable);

   (CNode as IPersistentNode).DeleteEx(lHeirID, l_DateDeleted);
  end;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TTreeDesignerForm.SetFlagOnSubTree(const aSubRoot : Il3Node;
                                                   aFlag : TOperActionType);

function IterHandler(const aCurNode : Il3Node) : Boolean; far;
 var
  lHNode : IDictItemJour;
 begin
  if l3IOk(aCurNode.QueryInterface(IDictItemJour, lHNode)) and
     (aFlag <> lHNode.Operation) and
     ((aFlag in [atMove, atEdit]) and
      not (lHNode.Operation in [atAdd, atEdit, atDelete, atJurEdit])) then
   lHNode.Operation := aFlag;

  (*If l3IOk(aCurNode.QueryInterface(IDictItemJour, lHNode)) then
   If ((aFlag = atEdit) and not (lHNode.Operation in [atAdd, atDelete, atJurEdit])) or
      ((aFlag = atMove) and not (lHNode.Operation in [atAdd, atEdit, atDelete, atJurEdit])) then
    lHNode.Operation := aFlag;
  *)
 end;
begin
 l3IterateSubTreeF(aSubRoot, l3L2NA(@IterHandler));
end;

procedure TTreeDesignerForm.evntNodeMoveEnd(aSender : TObject; const aNode : Il3SimpleNode; aParentWasChange : Boolean);
var
  lHNode : IDictItemJour;
begin
 if DictID = da_dlNewClasses_Deprecated then
 begin
  Assert(False, 'Deprecated dlNewClasses');
(*  if l3IOk(aNode.QueryInterface(IDictItemJour, lHNode)) then
  begin
   if aParentWasChange then
    SetFlagOnSubTree(aNode as Il3Node, atEdit);
   lHNode.Comment := lHNode.Comment + SysUtils.Format(' (move: %s)',[dsGetCurrentUserName]);
  end;*)
 end
 else
 begin
  l3System.Msg2Log(SysUtils.Format('!!Move в словаре %s. Пользователь: %s',[GetDictName(DictID), dsGetCurrentUserName]));
  // AddInfoToLogJournal((aNode as Il3HandleNode).Handle);
 end;
end;

procedure TTreeDesignerForm.EditItem(aIndex : integer);
var
 lCNode       : Il3Node;
 lExtItemNode : Il3ExtItemNode;
 l_IsChanged  : Boolean;
begin
 lCNode:=DictOutliner.GetNode(aIndex) As Il3Node;
 If l3TestMask(lCNode.Flags, cEqualNode) then
 begin
  try
   DictOutliner.GotoOnNode(
      tdwFindReadNodeByHandle(DictOutliner.CTree.CRootNode,
                              (lCNode as Il3HandleNode).Handle) As Il3SimpleNode);
  except
  end;
 end
 else
 begin
  case ShowMode of
   dmShow :
    begin
     if DictOutliner.MultiSelect then
      DictOutliner.ChangeSelect(aIndex)
     else
      if CheckMayBeSelected(aIndex) then
       ModalResult := mrOk;
    end;
   dmEdit :
    //if not ReadOnly then
    begin
     if (lCNode as Il3HandleNode).Handle = 0 then Exit;
     case DictID of
      da_dlSources:
       l_IsChanged := EditItemOfSourcesDict((lCNode as Il3HandleNode).Handle);
      da_dlNewClasses_Deprecated:
       Assert(False, 'Deprecated dlNewClasses');
//       l_IsChanged := EditItemOfNewClassesDict(lCNode as Il3HandleNode);
      else
      begin
       if Supports(lCNode, Il3ExtItemNode, lExtItemNode) then
        l_IsChanged := EditItemOfPublishedlDict(lExtItemNode)
       else
        l_IsChanged := EditItemOfUsualDict(lCNode as Il3HandleNode);
      end;
     end;
     {$IFDEF RemoteDict}
     if l_IsChanged then
     begin
      vtShowWaitMessage('Пожалуйста, подождите', WaitDlgCanClose);
      lCNode:= DictServer.Dict[DictID].FindNodeByID(DictServer.LastEditedID);
     end;
     {$ENDIF}
     if l_IsChanged and (lCNode <> nil) then
     begin
      lCNode.Sort;
      DictOutliner.GotoOnNode(lCNode As Il3SimpleNode);
     end;
    end;
  end;
 end;
end;

procedure TTreeDesignerForm.SaveToFile;
var
 lDir : TFileName;
 lDict : TdaDictionaryType;
begin
 if RequestDirName(lDir, Self, 'Каталог для экспорта',
                               'Введите каталог для экспорта') then
 Screen.Cursor := crHourGlass;
 try
  lDict := DictID;
  if lDict = da_dlCorSources then
   lDict := da_dlPublisheds;
  ExportDictionary(DictServ, lDict, lDir);
 finally
  Screen.Cursor := crDefault;
 end;
end;

function TTreeDesignerForm.CheckMayBeSelected(aIndex : Integer) : Boolean;
var
  lExtNode : Il3ExtItemNode;
 begin
  (*
  if //not fAllowSelNonLeaf and
     //запрет селекта папок для составных словарей (временно, пока не доделаю)
     (GetMasterDict(DictID) <> da_dlNone)
     and not Supports(DictOutliner.TreeStruct.Nodes[aIndex], Il3ExtItemNode, lExtNode) then
   Result := false
  else
  *)
   Result := Inherited CheckMayBeSelected(aIndex);
end;

procedure TTreeDesignerForm.DictOutlinerCurrentChanged(Sender: TObject;
  aNewCurrent, aOldCurrent: Integer);
var
 lHNode : Il3HandleNode;
 lExtNode : Il3ExtItemNode;
begin
 inherited;
 If l3IOk(DictOutliner.TreeStruct.Nodes[aNewCurrent].QueryInterface(Il3HandleNode, lHNode))
  then Footer.Panels[1].Text := SysUtils.Format(' ID : %d', [lHNode.Handle])
  else Footer.Panels[1].Text := '';

 if ReadOnly or (ShowMode <> dmEdit) or Supports(DictOutliner.TreeStruct.Nodes[aNewCurrent], Il3ExtItemNode, lExtNode) then
 begin
  MainForm.acDictAdd.Enabled := False;
  acNew.Enabled := False;
 end
 else
 begin
  MainForm.acDictAdd.Enabled := True;
  acNew.Enabled := True;
 end
end;

procedure TTreeDesignerForm.SetSpeedButton(Enabled : Boolean);
begin
 inherited SetSpeedButton(Enabled);
 with MainForm do
 begin
  acDictSort.Enabled := MainForm.acDictSort.Enabled and
                            not (DictID in [da_dlNewClasses_Deprecated]);
  acDictUndo.Enabled := Enabled and not ReadOnly and
                              (DictID in [da_dlNewClasses_Deprecated]);
  acDictTransformToDivision.Enabled := Enabled and not ReadOnly and
                              (DictID in [da_dlNewClasses_Deprecated]);
 end;
end;

procedure TTreeDesignerForm.acShowEqLeafClick(Sender: TObject);
var
 lGotoItem : Longint;
begin
 if DictID = da_dlNewClasses_Deprecated then
 begin
  Assert(False, 'Deprecated dlNewClasses');
//  DictServer(Family).DictRootNode[DictID].HasEqualNodes := True;
 end
 else if DictID in [da_dlClasses, da_dlKeyWords] then
 begin
  If DictOutliner.GetCurrentNode = nil then
   Exit;
  With TDShowEq.Create(Self) do
   try
    DictServer(Family).GetNearestEqualsFor(DictID,
                                   (DictOutliner.GetCurrentNode as Il3HandleNode).Handle,
                                   ItemList.Items);
    If ItemList.Total > 0 then
    begin
     If Execute(lGotoItem) then
      With DictOutliner do
       GotoOnNode(CTree.FindNodeByParam(CTree.CRootNode, lGotoItem, 0) As Il3SimpleNode);
    end
    else
     vtMessageDlg(l3Fmt(sidNoEqItems,[l3PCharLen2String(DictOutliner.GetCurrentNode.Text)]), mtWarning);
   finally
    Free;
   end;
 end
 (*
 else
 if DictID in [da_dlCorSources{, da_dlPublisheds}] then
 begin
  DictServer.Family := Family;
  //DictServer.DictRootNode[DictID].HasEqualNodes := True;
  DictServer.LoadExtItemsToTree(DictID);
 end
 *)
end;

procedure TTreeDesignerForm.acKeepItemToObjListClick(Sender: TObject);
var
 ItDataRec : TDictItemAddr;
 lNode : Il3SimpleNode;
begin
 If DictOutliner.GetCurrentNode = nil then Exit;

 lNode := DictOutliner.GetCurrentNode;
 With (lNode as Il3HandleNode), ItDataRec do
 begin
  FamID  := Family;
  DictID := DictID;
  ItemID := Handle;
  ItemTag := nil;
  ArchiObjectList.AddObjRec(PAnsiChar(l3PCharLen2String(lNode.Text)), ddDictItem, @ItDataRec);
 end;
end;
                 
procedure TTreeDesignerForm.UndoEdit;
var
 CNode  : Il3SimpleNode;
 lHNode : IDictItemJour;
begin
 CNode := DictOutliner.GetCurrentNode;
 If (DictID = da_dlNewClasses_Deprecated) and
    l3IOk(CNode.QueryInterface(IDictItemJour, lHNode)) and
    (lHNode.Operation <> atAdd) then
 begin
  Assert(False, 'Deprecated dlNewClasses');
(*  If (lHNode.Operation = atDelete) and
     (lHNode.NewID <> 0) then
   lHNode.NewID := 0;
  lHNode.Operation := atNone;
  DictOutliner.InvalidateItem(DictOutliner.Current);*)
 end;
end;

function TTreeDesignerForm.Execute(const aItemList : Il3IntegerList = nil;
                                   aAllowSelNonLeaf : Boolean = False;
                                   aMultiSelect     : Boolean = True) : Boolean;

procedure lSetListToTree(aTree : Il3Tree; const aList : Il3IntegerList);
 var
  lCheckExtItem : boolean;

 function lFindInList(aHandle : Integer) : boolean;
 var
  I : Integer;
 begin
  Result := false;
  for I := 0 to Pred(aList.Count) do
   if aList.Items[I] = aHandle then
   begin
    Result := True;
    Exit;
   end;
 end;

 procedure IterHandler(const aCurNode : Il3Node); far;
 var
  lExtNode : Il3ExtItemNode;
  lHandle  : Integer;
 begin
  lHandle := (aCurNode as Il3HandleNode).Handle;
  if lCheckExtItem and not Supports(aCurNode, Il3ExtItemNode, lExtNode) then
   lHandle := -lHandle;

  if lFindInList(lHandle) then
    {aTree.SelectedNode[aCurNode] := True;} //!!VVЇа®ўҐаЁвм Є Є  ­­®Є« ббл бв ўпвбп
   aTree.NodeFlags[aCurNode] := aTree.NodeFlags[aCurNode] or nfSelected and not nfSelModified
  else
   aTree.NodeFlags[aCurNode] := aTree.NodeFlags[aCurNode] and not nfSelected and not nfSelModified;
  // aTree.SelectedNode[aCurNode] := True;
 end;

begin
 if aList.Count = 0 then exit;
 lCheckExtItem := GetMasterDict(DictID) <> da_dlNone;
 if fAllowSelNonLeaf then
  aTree.IterateF(l3L2NA(@IterHandler){, imLeavesOnly})
 else
  aTree.IterateF(l3L2NA(@IterHandler), imLeavesOnly);
end;

var
 lCurNode  : Il3Node;
begin
 DictOutliner.MultiSelect := aMultiSelect;
 DictOutliner.PickedList  := aMultiSelect;

 fAllowSelNonLeaf := aAllowSelNonLeaf or IniRec.AllowSelNonLeaf;

 try
  Screen.Cursor := crHourGlass;
  try
   if aItemList <> nil then
    With DictOutliner.CTree do
    begin
     Changing;
     try
      ResetSelection;
      LockSelModify;
      try
       if aMultiSelect then
        lSetListToTree(DictOutliner.CTree, aItemList)
       else
        if (aItemList.Count = 1) then
        begin
         with DictOutliner.CTree do
          lCurNode := FindNodeByParam(CRootNode, aItemList.Items[0], 0);
         DictOutliner.GotoOnNode(lCurNode);
        end;

      finally
       UnLockSelModify;
      end;
     finally
      Changed;
     end;
    end;

  finally
   Screen.Cursor := crDefault;
  end;

  Result := (ShowModal = mrOk) and
          ((DictOutliner.CTree.SelModifiedCount > 0) or Not (DictOutliner.MultiSelect));

  If Result then
  begin
   If not aMultiSelect then
   begin
    If l3IEQ(DictOutliner.GetCurrentNode, lCurNode) then
     begin
      Result := False;
      Exit;
     end;

    With DictOutliner.CTree do
    begin
     ResetSelection;
     NodeFlags[DictOutliner.CurrentCNode] := NodeFlags[DictOutliner.CurrentCNode] or nfSelected or nfSelModified;
     If (lCurNode <> nil) then
     begin
      LockSelModify;
      try
       NodeFlags[lCurNode] := NodeFlags[lCurNode] and not nfSelected or nfSelModified;
      finally
       UnLockSelModify;
      end;
     end;
    end;
   end;
  end;
 finally
  //l3Free(TCur);
 end;
end;

function TTreeDesignerForm.DictOutlinerGetItemImage(Sender: TObject;
                        Index: Integer; var aImages: TCustomImageList): Integer;
var
  lHNode : IDictItemJour;
  lNode : Il3Node;
begin
 Result := -1;

 lNode := DictOutliner.CTree.CNodes[Index];
 If l3TestMask(lNode.Flags, cNodeHasEquals) and
    lNode.HasChild then
 begin       
  aImages := ArchiResources.CommonImageList;
  Result := picEQDiamond;
 end
 else
  If l3TestMask(lNode.Flags, cEqualNode) then
  begin
   aImages := ArchiResources.CommonImageList;
   Result := picSrchHLink;
  end
  else
   If l3IOk(lNode.QueryInterface(IDictItemJour, lHNode)) then
    If Length(lHNode.Comment) > 0 then
    begin
     aImages := ArchiResources.CommonImageList;
     If (Result = picDiamond) or not (lHNode as Il3Node).HasChild then
      Result := picDiamondWarn
     else
      Result := picFolderWarn;
    end;
end;

procedure TTreeDesignerForm.acAddEqLeafClick(Sender: TObject);
var
 lCNode  : Il3Node;
 lDictID : Longint;
 lAddBackEq : Boolean;
begin
 lCNode := DictOutliner.CurrentCNode;
 If not l3TestMask(lCNode.Flags, cEqualNode) and
    (Not lCNode.HasChild or l3TestMask(lCNode.Flags, cNodeHasEquals)) then
  If DictItemRequest(Self, DictID, lDictID, lAddBackEq,
                      'ID эквивалентного элемента',
                      'Добавить эквивалентный',
                      'Добавить эквивалентный элемент') then
  begin
   DictServ.Dict[DictID].AddEqualNode((lCNode as Il3HandleNode).Handle, lDictID);
   If lAddBackEq then
    DictServ.Dict[DictID].AddEqualNode(lDictID, (lCNode as Il3HandleNode).Handle);
  end;
end;

procedure TTreeDesignerForm.acTransformToDivisionClick(Sender: TObject);
var
 lDivNode,
 lCNode  : Il3Node;
 lDictJour : IDictItemJour;
 lName   : AnsiString;
begin
 If ReadOnly then Exit;
 lCNode := DictOutliner.CurrentCNode;
 If not l3TestMask(lCNode.Flags, cEqualNode) and
    (Not lCNode.HasChild or l3TestMask(lCNode.Flags, cNodeHasEquals)) then
  with DictOutliner.CTree do
  begin
   lName := l3PCharLen2String(lCNode.Text, CP_DefaultValue);
   ChangeName(lCNode, 'Общие вопросы');

   lDivNode := DictServ.Dict[TdaDictionaryType(DictID)].AddDictNode(cUndefDictID, l3PCharLen(lName), l3PCharLen(cEmptyEngName), l3PCharLen, lCNode.ParentNode);
   if Supports(lDivNode, IDictItemJour, lDictJour) then
    lDictJour.Operation := atAdd;
   lDivNode.Remove;
   InsertNodeBefore(lCNode, lDivNode);
   lCNode.Remove;
   InsertNode(lDivNode, lCNode);

   DictOutliner.GotoOnNode(lCNode);
  end;
end;

procedure TTreeDesignerForm.miMostLinkedClick(Sender: TObject);
begin
 TLinkHistoForm.Create(MainForm, Family, DictID);
end;

procedure TTreeDesignerForm.DictOutlinerGetItemFont(Sender: TObject; Index: Integer; const aFont: Il3Font);

var
 lHNode : IDictItemJour;

 lNode : Il3SimpleNode;
 lHandle : Integer;
 lDeferDelRec : PdtDeferDelRec;

begin
 if DictID = da_dlNewClasses_Deprecated then
 begin
  Assert(False, 'Deprecated dlNewClasses');
(*  if l3IOk(DictOutliner.TreeStruct.Nodes[Index].QueryInterface(IDictItemJour, lHNode)) then
   case lHNode.Operation of
    atAdd     : aFont.ForeColor := clRed;
    atDelete  : aFont.Style := aFont.Style + [fsStrikeOut];
    atEdit    : aFont.ForeColor := clGreen;
    atJurEdit : aFont.ForeColor := clTeal;
    atMove    : aFont.ForeColor := clSilver;
   end;
  Exit;*)
 end;

 try
  lNode := DictOutliner.GetNode(Index);
  if (DictID = da_dlTypes) {and (fShowMode = dmShow)} and
     not DictOutliner.TreeStruct.IsRoot(lNode.Parent) then
   aFont.ForeColor := clBlue;

  lHandle := (lNode as Il3HandleNode).Handle;
  lDeferDelRec := DictServ.Dict[DictID].GetDeferDelInfo(lHandle);
  if (lDeferDelRec <> nil) then
  begin
   if (lDeferDelRec^.rDelDate > DateTimeToStDate(IniRec.NextVersionDate)) then
    aFont.ForeColor := clMaroon
   else
    aFont.ForeColor := clRed;
   aFont.Style := aFont.Style + [{fsBold,} fsStrikeOut];
  end;

  if (fLeafIDList <> nil) and (fLeafIDList.IndexOf(lHandle) >= 0) then
   aFont.BackColor := clSilver;
 except
 end;

end;

function TTreeDesignerForm.EditItemOfSourcesDict(anID: Integer): Boolean;
var
 l_SourDictRec   : TSourDictRec;
 lStr            : AnsiString;
 ll3Str          : Tl3PCharLen;
 lRusChanged     : Boolean; // Русское название изменено
 lEngChanged     : Boolean; // Английское название изменено
 l_IsEnglishObsolete: Boolean; // Признак неправильного перевода рус.->англ. :
                               // 1. англ. текст не пустой
                               // 2. рус. текст изменился, а англ. остался прежним
                               // 3. англ. текст еще не имеет пометку
begin
 with TNameEditSrcDlg.Create(Self) do
  try
   BiLingual := DictServ.BiLingual;
   ROnly := ReadOnly;
   DictServ.DictTbl[da_dlSources].GetData(anID,
                                       PAnsiChar(@l_SourDictRec),
                                       SizeOf(l_SourDictRec));

   mNameRus.Buffer := l3RTrim(l3PCharLen(l_SourDictRec.FNameR, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage));
   if BiLingual then
    mNameEng.Buffer := l3RTrim(l3PCharLen(l_SourDictRec.FNameE, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage));

   edShortName.Text := l3ArrayToString(l_SourDictRec.SName, SizeOf(l_SourDictRec.SName));

   edSynon.Buffer:= l3RTrim(l3PCharLen(l_SourDictRec.Sinon, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage));

   Caption := sEditDialogCaption;

   Result := Execute(GetDictNameLength(DictID));
   if Result then
   begin
    lRusChanged := (l3Compare(EditTextR, l3RTrim(l3PCharLen(l_SourDictRec.FNameR, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage))) <> 0);
    lEngChanged := BiLingual and (l3Compare(EditTextE, l3RTrim(l3PCharLen(l_SourDictRec.FNameE, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage))) <> 0);

    l_IsEnglishObsolete := (not BiLingual or (EditTextE.SLen > 0)) // (1)
     and lRusChanged // (2a)
     and not lEngChanged // (2b)
     and (l_SourDictRec.FNameE[1] <> cWrongEnglishMark); // (3)

    // FNameR
    ll3Str := NormPCharLen(mNameRus.Buffer);
    l3FillChar(l_SourDictRec.FNameR, SizeOf(l_SourDictRec.FNameR));
    l3Move(ll3Str.S^, l_SourDictRec.FNameR, Min(ll3Str.SLen, SizeOf(l_SourDictRec.FNameR)));
    // FNameE
    if BiLingual then
    begin
     ll3Str := NormPCharLen(mNameEng.Buffer);
     l3FillChar(l_SourDictRec.FNameE, SizeOf(l_SourDictRec.FNameE));
     l3Move(ll3Str.S^,
          l_SourDictRec.FNameE,
          Min(ll3Str.SLen, SizeOf(l_SourDictRec.FNameE)));
    end;

    if l_IsEnglishObsolete then // вставляем * в начало NameEng
    begin
     // сдвиг право на 1 символ
     l3Move(l_SourDictRec.FNameE[1],
          l_SourDictRec.FNameE[2],
          SizeOf(l_SourDictRec.FNameE) - 1);
     // собственно вставка *
     l_SourDictRec.FNameE[1] := cWrongEnglishMark;
    end;

    // SName
    lStr := l3DeleteDoubleSpace(Trim(edShortName.Text));
    l3FillChar(l_SourDictRec.SName, SizeOf(l_SourDictRec.SName));
    if Length(lStr) > 0 then
     l3Move(lStr[1],
          l_SourDictRec.SName,
          Length(lStr));
    // Sinon
    ll3Str := NormPCharLen(edSynon.Buffer);
    l3FillChar(l_SourDictRec.Sinon, SizeOf(l_SourDictRec.Sinon));
    If ll3Str.SLen > 0 then
     l3Move(ll3Str.S^,
          l_SourDictRec.Sinon,
          Min(ll3Str.SLen, SizeOf(l_SourDictRec.Sinon)));

    DictServ.Dict[da_dlSources].EditDictFullData(anID, PAnsiChar(@l_SourDictRec));

    if lRusChanged then
     AddInfoToLogJournal(anID);
    // сейчас английских документов нет,
    // поэтому документы (русские) "потрогиваются" только когда русское название изменилось
    // когда будут английские документы надо "трогать" документы принадлежащие анлийской базе //Belongs = eng
    // или остальные

   end;
  finally
   Free;
  end;
end;

function TTreeDesignerForm.EditItemOfUsualDict(const aNode: Il3HandleNode): Boolean;
var
 lStr: AnsiString;
 l_NameR: AnsiString;
 l_NameE: AnsiString;
 l_StrR: Tl3String;
 lRusChanged     : Boolean; // Русское название изменено
 lEngChanged     : Boolean; // Английское название изменено
 l_IsEnglishObsolete: Boolean; // Признак неправильного перевода рус.->англ. :
                               // 1. англ. текст не пустой
                               // 2. рус. текст изменился, а англ. остался прежним
                               // 3. англ. текст еще не имеет пометку
begin

  {$ifdef newEditDlg}
  with TDictItemEditDlg.Create(Application), Frame1 do
  {$else}
  with TExtNameEditDlg.Create(Application) do
  {$endif}
  Try
   BiLingual := DictServ.BiLingual;
   ROnly := ReadOnly;

   if DictServ.BiLingual then
   begin
    l_NameR := DictServ.DictTbl[DictID].GetNameR(aNode.Handle);
    l_NameE := l3PCharLen2String((aNode As Il3Node).Text, CP_DefaultValue);
   end
   else
   begin
    l_NameR := l3PCharLen2String((aNode As Il3Node).Text, CP_DefaultValue);
    l_NameE := DictServ.DictTbl[DictID].GetNameE(aNode.Handle);
   end;

   EditTextR := l3PCharLen(l_NameR, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage);
   if BiLingual then
    EditTextE := l3PCharLen(l_NameE, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage);

   if DictID in GlAttrWithCodeSet then
    edtCode.Text := DictServ.Dict[DictID].GetShortName(aNode.Handle);

   if DictID in GlAttrWithPrivateSet then
   begin
    cbxPrivate.Checked := DictServ.DictTbl[DictID].GetIsPrivate(aNode.Handle) = 1;
    cbxIsNonPeriodic.Checked := DictServ.DictTbl[DictID].GetIsNonPeriodic(aNode.Handle) = 1;
   end;

   Caption:=sEditDialogCaption;

   Result := Execute(DictID);
   If Result then
   begin
    lRusChanged := (l3Compare(EditTextR, l3PCharLen(l_NameR, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage)) <> 0);
    lEngChanged := BiLingual and (l3Compare(EditTextE, l3PCharLen(l_NameE)) <> 0);

    l_IsEnglishObsolete := (not BiLingual or (EditTextE.SLen > 0)) // (1)
     and lRusChanged // (2a)
     and not lEngChanged // (2b)
     and ((Length(l_NameE) = 0) or (l_NameE[1] <> cWrongEnglishMark)); // (3)

    if l_IsEnglishObsolete then
     l_NameE := cWrongEnglishMark + StrPas(EditTextE.S)
    else
     l_NameE := StrPas(EditTextE.S);

    l_StrR := Tl3String.Make(EditTextR);
    try

     l_StrR.ReplaceNonReadable.TrimAll;
     l_StrR.CodePage := GlobalDataProvider.BaseLanguage[Family].AnsiCodePage{CP_ANSI};

     (*
     If DictID in GlAttrWithCodeSet then
     begin
      lStr := tCode.Text;
      DictServ.EditDictItemEx(DictID, aNode.Handle, l_StrR.St, PAnsiChar(l_NameE), PAnsiChar(lStr));
     end
     else
     *)

     DictServ.Dict[DictID].EditDictItem(aNode.Handle, l_StrR.AsWStr, l3PCharLen(l_NameE), l3PCharLen(Code), IsPrivate, IsNonperiodic);

    finally
     l_StrR.Free;
    end;

    if lRusChanged then
     AddInfoToLogJournal(aNode.Handle);
    // сейчас английских документов нет,
    // поэтому документы (русские) "потрогиваются" только когда русское название изменилось
    // когда будут английские документы надо "трогать" документы принадлежащие анлийской базе //Belongs = eng
    // или остальные

   end;
  finally
   Free;
  end;
end;

function TTreeDesignerForm.EditItemOfNewClassesDict(const aNode: Il3HandleNode): Boolean;
(*var
 l_NewClassDictRec: TNewClassDictRec;
 lStr             : AnsiString;
 ll3Str           : Tl3PCharLen;
 l_Flag           : TOperActionType;
 l_NewID          : TDictID;
 lRusChanged     : Boolean; // Русское название изменено
 lEngChanged     : Boolean; // Английское название изменено
 l_IsEnglishObsolete: Boolean; // Признак неправильного перевода рус.->англ. :
                               // 1. англ. текст не пустой
                               // 2. рус. текст изменился, а англ. остался прежним
                               // 3. англ. текст еще не имеет пометку
 lNodeHandle: Longint;
 lHNode : IDictItemJour;*)
begin
 Assert(False, 'Deprecated dlNewClasses');
(* lNodeHandle := aNode.Handle;
 with TNewClassNameEditDlg.Create(Self) do
  try
   BiLingual := DictServ.BiLingual;
   ROnly := ReadOnly;
   DictServ.DictTbl[dlNewClasses].GetData(lNodeHandle,
                                          PAnsiChar(@l_NewClassDictRec),
                                          SizeOf(l_NewClassDictRec));

   mNameRus.Buffer := l3RTrim(l3PCharLen(l_NewClassDictRec.FNameR, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage));
   if BiLingual then
    mNameEng.Buffer := l3RTrim(l3PCharLen(l_NewClassDictRec.FNameE, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage));

   CommentText := l3PCharLen(l_NewClassDictRec.Comment);

   l_NewID := l_NewClassDictRec.NewID;

   l_Flag := TOperActionType(l_NewClassDictRec.Flag);

   If l_Flag = atDelete then
    edtRelinkDictID.AsInteger := l_NewID
   else
    pnlRelinkID.Visible := False;

   pnlJuristicChanges.Visible := True;
   if (l_Flag = atAdd) or (l_Flag = atJurEdit) then
   begin
    cbxJuristicChanges.Checked := True;
    cbxJuristicChanges.Enabled := False;
   end
   else
    cbxJuristicChanges.Checked := (l_Flag = atJurEdit);

   Caption:=sEditDialogCaption;

   Result := Execute(GetDictNameLength(DictID));
   If Result then
   begin
    lRusChanged := (l3Compare(EditTextR, l3RTrim(l3PCharLen(l_NewClassDictRec.FNameR, GlobalDataProvider.BaseLanguage[Family].AnsiCodePage))) <> 0);
    lEngChanged := BiLingual and (l3Compare(EditTextE, l3RTrim(l3PCharLen(l_NewClassDictRec.FNameE))) <> 0);

    l_IsEnglishObsolete := (not BiLingual or (EditTextE.SLen > 0)) // (1)
     and lRusChanged // (2a)
     and not lEngChanged // (2b)
     and (l_NewClassDictRec.FNameE[1] <> cWrongEnglishMark); // (3)

    // FNameR
    ll3Str := NormPCharLen(mNameRus.Buffer);
    l3FillChar(l_NewClassDictRec.FNameR, SizeOf(l_NewClassDictRec.FNameR));
    l3Move(ll3Str.S^,
         l_NewClassDictRec.FNameR,
         Min(ll3Str.SLen, SizeOf(l_NewClassDictRec.FNameR)));
    // FNameE
    if BiLingual then
    begin
     ll3Str := NormPCharLen(mNameEng.Buffer);
     l3FillChar(l_NewClassDictRec.FNameE, SizeOf(l_NewClassDictRec.FNameE));
     l3Move(ll3Str.S^,
          l_NewClassDictRec.FNameE,
          Min(ll3Str.SLen, SizeOf(l_NewClassDictRec.FNameE)));
    end;

    if l_IsEnglishObsolete then // вставляем * в начало NameEng
    begin
     // сдвиг право на 1 символ
     l3Move(l_NewClassDictRec.FNameE[1],
          l_NewClassDictRec.FNameE[2],
          SizeOf(l_NewClassDictRec.FNameE) - 1);
     // собственно вставка *
     l_NewClassDictRec.FNameE[1] := cWrongEnglishMark;
    end;

    // Comment
    ll3Str := NormPCharLen(CommentText);
    l3FillChar(l_NewClassDictRec.Comment, SizeOf(l_NewClassDictRec.Comment));
    l3Move(ll3Str.S^,
          l_NewClassDictRec.Comment,
          Min(ll3Str.SLen, SizeOf(l_NewClassDictRec.Comment)));

    // Flag
    if (TOperActionType(l_Flag) <> atAdd) and (lRusChanged or lEngChanged) then
    begin
     if cbxJuristicChanges.Checked then
      TOperActionType(l_NewClassDictRec.Flag) := atJurEdit
     else
      TOperActionType(l_NewClassDictRec.Flag) := atEdit;

     SetFlagOnSubTree(aNode As Il3Node, atEdit);
    end;

    if l3IOk(aNode.QueryInterface(IDictItemJour, lHNode)) then
     lHNode.Comment := lHNode.Comment + SysUtils.Format(' (edit: %s)',[dsGetCurrentUserName]);

    DictServ.Dict[dlNewClasses].EditDictFullData(lNodeHandle, PAnsiChar(@l_NewClassDictRec));
    // нет документов связанных со словарем "проект классификатора"
   end;
  finally
   Free;
  end;*)
end;

function TTreeDesignerForm.AddItemOfPublishedlDict(const aParentNode: Il3Node; var aNode: Il3Node): Boolean;
var
 lData : TPublishedDictRec;
begin
 lData.ID := cUndefDictID;
 lData.Sour := (aParentNode as Il3HandleNode).Handle;
 Result := RunGetIssuePropsDlg(Self, Family, aParentNode.Text.S, DictServ.Dict[da_dlCorSources].DictTbl.GetIsNonperiodic(lData.Sour) = 1, @lData, True {aWasEmpty});
 if not Result then Exit;

 aNode := DictServ.Dict[DictID].AddExtItem(aParentNode, @lData) as Il3Node;
 {$IFDEF RemoteDict}
 vtShowWaitMessage('Пожалуйста, подождите', WaitDlgCanClose);
 aNode:= DictServer.Dict[DictID].FindNodeByID(DictServer.LastEditedID);
 lData.ID := DictServer.LastEditedID; //возвращаем lID в рекорд
 DictServ.Dict[DictID].CreateExtNode(aParentNode, @lData);
 {$ENDIF}
end;

function TTreeDesignerForm.EditItemOfPublishedlDict(const aNode : Il3ExtItemNode): Boolean;
var
 lData : PPublishedDictRec;
begin
 lData := aNode.Data;
 Result := RunGetIssuePropsDlg(Self, Family, (aNode as Il3Node).Parent.Text.S, DictServ.Dict[da_dlCorSources].DictTbl.GetIsNonperiodic(lData^.Sour) = 1, PPublishedDictRec(lData), False {aWasEmpty});

 if Result then
 begin
  aNode.Data := lData;
  AddInfoToLogJournal(lData^.ID, cDLPassports[DictID].rDepDictID);
 end;
end;

function TTreeDesignerForm.DictOutlinerIsCommandProcessed(aSender: TObject; aOperation: Cardinal): Boolean;
begin
 Result := not ((aOperation = ccActionItem) and (ShowMode = dmShow));
end;

procedure TTreeDesignerForm.acLoadFromFileClick(Sender: TObject);
var
 aFileName : TFileName;
begin
 //if not (l3System.Keyboard.Key[VK_SHIFT].Down and
 //   l3System.Keyboard.Key[VK_ESCAPE].Down) then Exit;

 if not GlobalDataProvider.LockAll then
  Raise El3NoLoggedException.Create('Импорт словарей возможен только при монопольном доступе.');
 try
  if RequestFileName(aFileName, Self, 'Импорт из файла', 'Имя файла') then
  try
   LoadFromFile(aFileName);
  except
  end;
 finally
  GlobalDataProvider.UnLockAll;
 end;
end;

procedure TTreeDesignerForm.WaitDlgCanClose(var aCanClose: Boolean);
begin
 aCanClose:= not DictServ.Busy;
end;

procedure TTreeDesignerForm.miEmptyItemsClick(Sender: TObject);
var
 lSab : ISab;
 lUsedIDList : Tl3LongintList;

 function IterHandler(const aCurNode : Il3Node) : Boolean; far;
 var
  lNode : IDictNode;
 begin
  if (aCurNode.HasChild and not l3TestMask(aCurNode.Flags, cNodeHasEquals)) then Exit;

  if l3IOk(aCurNode.QueryInterface(IDictNode, lNode)) and (lNode.NodeType = dntItem) then
   fLeafIDList.Add(lNode.Handle);
 end;

begin
 lSab := MakeAllRecords(LinkServer(Family).Links[DictID]);
 lSab.ValuesOfKey(lnkDictIDFld);

 lUsedIDList := dtMakeSortedIDListBySab(lSab);
 try
  lSab := nil;

  {MakeLeafDocIDList}
  l3Free(fLeafIDList);
  fLeafIDList := Tl3LongintList.Create;
  l3IterateSubTreeF(DictServer(Family).DictRootNode[DictID], l3L2NA(@IterHandler){, imCheckResult});
  fLeafIDList.Sort;

  fLeafIDList.DeleteList(lUsedIDList);
 finally
  l3Free(lUsedIDList);
 end;

 DictOutliner.Invalidate;
end;

end.
