unit dt_DictExport;

interface
 uses
  SysUtils,
  l3Tree_TLB,
  l3Types,
  l3Chars,
  l3DateSt,
  daTypes,
  dt_Err,
  dt_Dict,
  dt_Types,
  dt_AttrSchema;

procedure ExportDictionary(aDictServ : TDictionaryServer; aDictType : TdaDictionaryType; const aDir : TFileName);
   {* - экспорт словаря в "канонической" форме для копилятора NSRC}

procedure ExportAllDictionary(aDictServ : TDictionaryServer; const aDir : TFileName);
   {* - экспорт комплекта словарей в "канонической" форме для копилятора NSRC}


procedure ExportDictTree(aDictServ      : TDictionaryServer;
                         aDictType      : TdaDictionaryType;
                         aFlName        : TFileName;
                         aAppendCurrent : Boolean = False;
                         aProgress      : Tl3ProgressProc = nil;
                         aProgTitle     : ShortString = '';
                         WithID         : Boolean = False;
                         WithCommands   : Boolean = False;
                         WithNumbers    : Boolean = False;
                         WithEquals     : Boolean = False;
                         const aCurRoot : Il3Node = nil);

procedure ExportDictLink(aDictServ: TDictionaryServer; aDict: TdaDictionaryType; aFile: TFileName; aRenum: Boolean; aProgress:
    Tl3ProgressProc; aWithDocLinks: Boolean = True; WithoutAbolished: Boolean = False);

implementation
uses
 Graphics,
 l3TreeInterfaces,
 l3Base,
 l3Bits,
 l3FileUtils,
 l3Filer,
 l3String,
 l3Stream,
 l3LongintList,
 l3Nodes,

 k2Tags,
 k2TagGen,
 PageBreak_Const,
 TextPara_Const,

 m2XltLib,

 evdTypes,
 evdStyles,

 daDataProvider,
 //HT_Const,
 ht_Const,
 dt_Const,
 dtIntf,
 dt_Sab,
 dt_Equal,
 dt_Doc, ht_Dll, dt_Link, dt_LinkServ,
 dt_DictConst, dt_DictTypes, dt_DictIntf,
 Writers,

 vConst,

 l3FieldSortRecList,
 SegmentsLayer_Const,
 TextSegment_Const,
 Document_Const;

procedure MakeDictDocument(aDictServ : TDictionaryServer; const aDir : TFileName; aWithEQ : Boolean = false);
(* var
  lDosFiler     : TevDosFiler;
  lDocGenerator : Tk2TagGenerator;
  lRootNode     : Il3Node;
  lIndStr       : AnsiString;

 function IterHandler(const aCurNode : Il3Node) : Boolean; far;
 var
  lHNode : IDictItemJour;
  lLevel : Integer;
 begin
  If l3IOk(aCurNode.QueryInterface(IDictItemJour, lHNode)) then
  begin
   with lHNode, lDocGenerator do
    If Operation <> atDelete then
    begin
     If (aCurNode.ParentNode = lRootNode) and
        not aCurNode.IsFirst then
     begin
      StartChild(k2_typPageBreak);
      Finish;
     end;

     StartChild(k2_typTextPara);
      lIndStr := l3GetNodeIndentString(lRootNode, aCurNode, '· ');
      AddStringAtom(k2_tiText, lIndStr + l3PCharLen2String(aCurNode.Text));

      lLevel := aCurNode.GetLevelFor(lRootNode);

      If lLevel = 1 then
       AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1)
      else
       If lLevel < 3 then
       begin
        StartTag(k2_tiFont);
        AddBoolAtom(k2_tiBold, True);
        Finish;
       end;

      StartTag(k2_tiSegments);
       StartChild(k2_typSegmentsLayer);
        AddIntegerAtom(k2_tiHandle, Ord(ev_slView));
        StartChild(k2_typTextSegment);
         AddIntegerAtom(k2_tiStart, 1);
         AddIntegerAtom(k2_tiFinish, Length(lIndStr));

         StartTag(k2_tiFont);
          AddStringAtom(k2_tiName,'Symbol');
          AddBoolAtom(k2_tiBold, False);
         Finish;


        Finish;
       Finish;
      Finish;

     Finish;
    end
  end
  else
   If aWithEQ and l3TestMask(aCurNode.Flags, cEqualNode) then
    with lDocGenerator do
    begin
     StartChild(k2_typTextPara);
      lIndStr := l3GetNodeIndentString(lRootNode, aCurNode, '· ');
      AddStringAtom(k2_tiText, 'EQ = ' + l3PCharLen2String(aCurNode.Text));
      AddIntegerAtom(k2_tiLeftIndent, 2000);
      lLevel := aCurNode.GetLevelFor(lRootNode);
     Finish;
    end;
 end;
*)
 begin
  Assert(False, 'Deprecated dlNewClasses');
(*  lRootNode := aDictServ.DictRootNode[da_dlNewClasses_Deprecated];
  lDosFiler := TevDosFiler.Create(Nil);
  try
   If aWithEQ then
    lDosFiler.FileName := ConcatDirName(aDir,'class(EQ).doc')
   else
    lDosFiler.FileName := ConcatDirName(aDir,'class.doc');

   lDosFiler.Mode := l3_fmWrite;

   lDocGenerator := TevRTFWriter.Create(nil);
   try
    TevRTFWriter(lDocGenerator).Filer := lDosFiler;
    with lDocGenerator do
    begin
     Start;
      StartChild(k2_typDocument);
       l3IterateSubTreeF(lRootNode, l3L2NA(@IterHandler));
      Finish;
     Finish;
    end;
   finally
    l3Free(lDocGenerator);
   end;
  finally
   l3Free(lDosFiler);
  end;*)
 end;

procedure MakeDictDocumentColor(aDictServ : TDictionaryServer; const aDir : TFileName);
(* var
  lDosFiler     : TevDosFiler;
  lDocGenerator : Tk2TagGenerator;
  lRootNode     : Il3Node;
  lIndStr       : AnsiString;

 function IterHandler(const aCurNode : Il3Node) : Boolean; far;
 var
  lHNode : IDictItemJour;
  lLevel : Integer;
 begin
  If l3IOk(aCurNode.QueryInterface(IDictItemJour, lHNode)) then
   with lHNode, lDocGenerator do
    begin
     If (aCurNode.ParentNode = lRootNode) and
        not aCurNode.IsFirst then
     begin
      StartChild(k2_typPageBreak);
      Finish;
     end;

     StartChild(k2_typTextPara);
      lIndStr := l3GetNodeIndentString(lRootNode, aCurNode, '· ');
      AddStringAtom(k2_tiText, lIndStr + l3PCharLen2String(aCurNode.Text));

      lLevel := aCurNode.GetLevelFor(lRootNode);

      If lLevel = 1 then
       AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1)
      else
       If (lLevel < 3) or (Operation <> atNone) then
       begin
        StartTag(k2_tiFont);
        {If (lLevel < 3) then} AddBoolAtom(k2_tiBold, True);
        case lHNode.Operation of
         atAdd     : AddIntegerAtom(k2_tiForeColor, clRed);
         atDelete  : AddBoolAtom(k2_tiStrikeOut, True);
         atEdit    : AddIntegerAtom(k2_tiForeColor, clGreen);
         atJurEdit : AddIntegerAtom(k2_tiForeColor, clTeal);
         atMove    : AddIntegerAtom(k2_tiForeColor, clSilver);
        end;
        Finish;
       end;

      StartTag(k2_tiSegments);
       StartChild(k2_typSegmentsLayer);
        AddIntegerAtom(k2_tiHandle, Ord(ev_slView));
        StartChild(k2_typTextSegment);
         AddIntegerAtom(k2_tiStart, 1);
         AddIntegerAtom(k2_tiFinish, Length(lIndStr));

         StartTag(k2_tiFont);
          AddStringAtom(k2_tiName,'Symbol');
          AddBoolAtom(k2_tiBold, False);
         Finish;


        Finish;
       Finish;
      Finish;

     Finish;
    end
  else
   If l3TestMask(aCurNode.Flags, cEqualNode) then
   with lDocGenerator do
    begin
     StartChild(k2_typTextPara);
      lIndStr := l3GetNodeIndentString(lRootNode, aCurNode, '· ');
      AddStringAtom(k2_tiText, 'EQ = ' + l3PCharLen2String(aCurNode.Text));

      AddIntegerAtom(k2_tiLeftIndent, 2000);

      lLevel := aCurNode.GetLevelFor(lRootNode);

     Finish;

    end;
  end;   *)
 begin
     Assert(False, 'Deprecated dlNewClasses');
(*
  lRootNode := aDictServ.DictRootNode[da_dlNewClasses_Deprecated];
  lDosFiler := TevDosFiler.Create(Nil);
  try
   lDosFiler.FileName := ConcatDirName(aDir,'class_color.doc');
   lDosFiler.Mode     := l3_fmWrite;

   lDocGenerator := TevRTFWriter.Create(nil);
   try
    TevRTFWriter(lDocGenerator).Filer := lDosFiler;
    with lDocGenerator do
    begin
     Start;
      StartChild(k2_typDocument);
       l3IterateSubTreeF(lRootNode, l3L2NA(@IterHandler));
      Finish;
     Finish;
    end;
   finally
    l3Free(lDocGenerator);
   end;
  finally
   l3Free(lDosFiler);
  end;*)
 end;

procedure MakeDiffFiles(aDictServ : TDictionaryServer; const aDir : TFileName);
(* var
  lDosFilerAdd       : TevDosFiler;
  lDosFilerDel       : TevDosFiler;
  lDosFilerDel_woDest: TevDosFiler;
  lDosFilerEdit      : TevDosFiler;
  lDosFilerMove      : TevDosFiler;
  lDosFilerComment   : TevDosFiler;
  lOldNode           : Il3Node;
  lNewNode           : Il3Node;
  lRootNode          : Il3Node;
  lRootNodeOfClasses : Il3Node;
  lMoveList          : Tl3LongintList;
  lCurIt             : Integer;
  lCurNode           : Il3Node;
  lAnsiCP            : Integer;
  lOemCP             : Integer;

  function lFindReadNodeByHandle(const aRootNode : Il3Node; aHandle : Integer) : Il3Node;
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
   Result := l3IterateSubTreeF(aRootNode, l3L2NA(@IterHandler), imCheckResult);
  end;

 function lChangeCP(const aString: AnsiString): AnsiString;
 begin
  Result := l3ChangeCodePage(aString, lAnsiCP, lOemCP);
 end;

 function IterHandler(const aCurNode : Il3Node) : Boolean; far;
 var
  lHNode : IDictItemJour;
 begin
  If l3IOk(aCurNode.QueryInterface(IDictItemJour, lHNode)) then
   with lHNode do
   begin
    If Length(Comment) > 0 then
     begin
      lDosFilerComment.Writeln(SysUtils.Format('CLASS %S', [lChangeCP(l3GetFullPathStr(lRootNode, aCurNode))]));
      lDosFilerComment.Writeln(SysUtils.Format('COMMENT %S', [lChangeCP(Comment)]));
      lDosFilerComment.OutEOL;
     end;

    If {(Operation <> atMove) and}
       (not aCurNode.HasChild or
        l3TestMask(aCurNode.Flags, cNodeHasEquals)) then
    case Operation of
     {atNone   :
      Exit;}
     atAdd    :
      lDosFilerAdd.Writeln(SysUtils.Format('NEW %S'#13#10, [lChangeCP(l3GetFullPathStr(lRootNode, aCurNode))]));
     atDelete :
      begin
       lOldNode := l3FindNodeByHandle(lRootNodeOfClasses, (aCurNode as Il3HandleNode).Handle);
       lDosFilerDel.Writeln(SysUtils.Format('OLD %S'#13#10, [lChangeCP(l3GetFullPathStr(lRootNodeOfClasses, lOldNode))]));

       {удаленные с новым значением тоже в список измененнных заносим,
        скорее всего если новое значение это добавленный элемент, то не надо}
       If lHNode.NewID > 0 then
       begin
        lNewNode := lFindReadNodeByHandle(lRootNode, lHNode.NewID);
        If lNewNode = nil then
         lDosFilerEdit.Writeln(SysUtils.Format('!!!Error Элемент-приемник (#%d) для #%d отсутствует',
                               [lHNode.NewID, (aCurNode as Il3HandleNode).Handle]))
        else
        begin
         lDosFilerEdit.Write(SysUtils.Format('OLD = !CLASS %S'#13#10,[lChangeCP(l3GetFullPathStr(lRootNodeOfClasses, lOldNode))]));
         lDosFilerEdit.Writeln(SysUtils.Format('NEW = !CLASS %S'#13#10,[lChangeCP(l3GetFullPathStr(lRootNode, lNewNode))]));
        end;
       end
       else
        lDosFilerDel_woDest.Writeln(SysUtils.Format('OLD %S'#13#10, [lChangeCP(l3GetFullPathStr(lRootNodeOfClasses, lOldNode))]));
      end;
     atEdit, atJurEdit :
      begin
       lOldNode := l3FindNodeByHandle(lRootNodeOfClasses, (aCurNode as Il3HandleNode).Handle);
       If lOldNode = nil then
        lDosFilerEdit.Write(SysUtils.Format('!!!Error Старый отсутствует [%D] %S'#13#10,[(aCurNode as Il3HandleNode).Handle,
                                                                                         lChangeCP(l3GetFullPathStr(lRootNode, aCurNode))]))
       else
       begin
        lDosFilerEdit.Write(SysUtils.Format('OLD = !CLASS %S'#13#10,[lChangeCP(l3GetFullPathStr(lRootNodeOfClasses, lOldNode))]));
        lDosFilerEdit.Writeln(SysUtils.Format('NEW = !CLASS %S'#13#10,[lChangeCP(l3GetFullPathStr(lRootNode, aCurNode))]));
       end;
      end;
     atMove :
      begin
       If lMoveList.Add((aCurNode.ParentNode as Il3HandleNode).Handle) <> -1 then
       begin
        lDosFilerMove.Writeln(lChangeCP(l3GetFullPathStr(lRootNode, aCurNode.ParentNode)));
        lCurNode := aCurNode.ParentNode.ChildNode;
        repeat
         lDosFilerMove.Writeln(lChangeCP('     ' + l3PCharLen2String(lCurNode.Text)));
         If lCurNode.IsLast then Break;
         lCurNode := lCurNode.NextNode;
        until false;
        lDosFilerMove.OutEOL;
       end;
      end;
    end;
   end;
 end;
*)
begin
     Assert(False, 'Deprecated dlNewClasses');
(* lAnsiCP := GlobalDataProvider.BaseLanguage[CurrentFamily].AnsiCodePage{CP_ANSI};
 lOemCP  := GlobalDataProvider.BaseLanguage[CurrentFamily].OEMCodePage {CP_OEM};

 lDosFilerAdd        := TevDosFiler.Create(Nil);
 lDosFilerDel        := TevDosFiler.Create(Nil);
 lDosFilerDel_woDest := TevDosFiler.Create(Nil); //удалены без переноса связей на другой элемент
 lDosFilerEdit       := TevDosFiler.Create(Nil);
 lDosFilerMove       := TevDosFiler.Create(Nil);
 lDosFilerComment    := TevDosFiler.Create(Nil);
 try
  lMoveList  := Tl3LongintList.Create;
  try
   lMoveList.Sorted := True;
   //lMoveList.Duplicates :=
   lDosFilerAdd       .FileName := ConcatDirName(aDir,'class.add');
   lDosFilerDel       .FileName := ConcatDirName(aDir,'class.del');
   lDosFilerDel_woDest.FileName := ConcatDirName(aDir,'class.del_woDest');
   lDosFilerEdit      .FileName := ConcatDirName(aDir,'class.edit');
   lDosFilerMove      .FileName := ConcatDirName(aDir,'class.move');
   lDosFilerComment   .FileName := ConcatDirName(aDir,'class.comm');

   lDosFilerAdd       .Mode := l3_fmWrite;
   lDosFilerDel       .Mode := l3_fmWrite;
   lDosFilerDel_woDest.Mode := l3_fmWrite;
   lDosFilerEdit      .Mode := l3_fmWrite;
   lDosFilerMove      .Mode := l3_fmWrite;
   lDosFilerComment   .Mode := l3_fmWrite;

   lDosFilerAdd       .Open;
   lDosFilerDel       .Open;
   lDosFilerDel_woDest.Open;
   lDosFilerEdit      .Open;
   lDosFilerMove      .Open;
   lDosFilerComment   .Open;

   lRootNode := aDictServ.DictRootNode[dlNewClasses];
   lRootNodeOfClasses := aDictServ.DictRootNode[da_dlClasses];
   l3IterateSubTreeF(lRootNode, l3L2NA(@IterHandler));
  finally
   l3Free(lMoveList);
  end;
 finally
  l3Free(lDosFilerAdd);
  l3Free(lDosFilerDel);
  l3Free(lDosFilerDel_woDest);
  l3Free(lDosFilerEdit);
  l3Free(lDosFilerMove);
  l3Free(lDosFilerComment);
 end;*)
end;


procedure ExportNewClasses(aDictServ : TDictionaryServer; aDir : TFileName);
begin
     Assert(False, 'Deprecated dlNewClasses');
(* MakeDiffFiles(aDictServ, aDir);
 MakeDictDocument(aDictServ, aDir);
 MakeDictDocument(aDictServ, aDir, True);
 MakeDictDocumentColor(aDictServ, aDir);
 ExportDictTree(aDictServ, da_dlNewClasses_Deprecated, ConcatDirName(aDir, 'clax.new'), false,
                nil, '', {aProgress : Tl3ProgressProc; aProgTitle: ShortString;}
                         False {WithID}, True {WithCommands}, True {WithNumbers}, True {WithEquals});
 ExportDictTree(aDictServ, da_dlNewClasses_Deprecated, ConcatDirName(aDir, 'gar.cla'), false,
                nil, '', {aProgress : Tl3ProgressProc; aProgTitle: ShortString;}
                False {WithID}, False {WithCommands}, False {WithNumbers}, False {WithEquals});

 //MakeFileFoAutoClass(lDir);
*)
end;

procedure MakeFileFoAutoClass(aDictServ : TDictionaryServer; const aDir : TFileName);
(* var
  lDosFiler  : TevDosFiler;
  lRootNode          : Il3Node;
  //IDictItemJour}

function IterHandler(const aCurNode : Il3Node) : Boolean; far;
 var
  lHNode   : IDictItemJour;
  lChanged : Byte;
  lCommStr : AnsiString;
 begin

  if (aCurNode.HasChild and not l3TestMask(aCurNode.Flags, cNodeHasEquals)) then Exit;

  If l3IOk(aCurNode.QueryInterface(IDictItemJour, lHNode)) then
   with lHNode do
   begin
    If Operation = atDelete then Exit;
    If Operation in [atAdd, atJurEdit] then
     lChanged := 1
    else
     lChanged := 0;

    If Length(Comment) > 0 then
     lCommStr := ' #'+Comment
    else
     lCommStr :='';

    lDosFiler.Writeln(SysUtils.Format('!CLASS %D %D %S%S',[Handle, lChanged, l3GetFullPathStr(lRootNode, aCurNode),lCommStr]));
   end;
 end;
*)
begin
     Assert(False, 'Deprecated dlNewClasses');
(* lDosFiler := TevDosFiler.Create(Nil);
 try
  lDosFiler.FileName := ConcatDirName(aDir,'class_for_PLK.lst');
  lDosFiler.Mode := l3_fmWrite;
  lDosFiler.Open;

  lRootNode := aDictServ.DictRootNode[da_dlNewClasses_Deprecated];
  l3IterateSubTreeF(lRootNode, l3L2NA(@IterHandler));
 finally
  l3Free(lDosFiler);
 end;*)
end;

procedure MakeFilePublishedInSrc(aDictServ : TDictionaryServer; const aFileName : TFileName);
var
 F : Integer;
 lSaveFolderNode : Il3SimpleNode;
 lSaveFolderNodeName : AnsiString;
 lNeedOut : Boolean;

 procedure IterHandler(const aCurNode : Il3Node); far;

  function GetFolderNode : Il3SimpleNode;
  var
   lNode : Il3SimpleNode;
   lDictNode : IDictItem;
  begin
   lNode := aCurNode.Parent;
   while not Supports(lNode, IDictItem, lDictNode) do
    lNode := aCurNode.Parent;
   Result := lNode;
  end;

 var
  S        : AnsiString;
  LL       : Byte;
  I        : Integer;
  lHandle  : Integer;
  lExtNode : Il3ExtItemNode;
  lFolderNode : Il3SimpleNode;
 begin
  if Supports(aCurNode, Il3ExtItemNode, lExtNode) then
  begin
   lFolderNode := GetFolderNode;
   if not lFolderNode.IsSame(lSaveFolderNode) then
   begin
    lSaveFolderNode := lFolderNode;
    lNeedOut := (aDictServ.Dict[da_dlCorSources].DictTbl.GetIsPrivate((lFolderNode as Il3HandleNode).Handle) = 0);

    if lNeedOut then
     lSaveFolderNodeName := l3GetFullPathStr(aDictServ.DictRootNode[da_dlCorSources{da_dlPublisheds}], lSaveFolderNode as Il3Node, '\', '', False, True);
   end;

   if lNeedOut then
   begin
    with PPublishedDictRec(lExtNode.Data)^ do
     S := lSaveFolderNodeName + Format('|%s|%s|%s', [MakeDateIntervalStr(SDate, EDate, '/'),
                                                     l3ArrayToString(Num, SizeOf(Num)),
                                                     l3ArrayToString(Comment, SizeOf(Comment))]);
    S := S + cc_EOL;
    FileWrite(F, S[1], Length(S));
   end;
  end;
 end;

begin
 F := FileCreate(aFileName);
 l3IterateSubTreeF(aDictServ.DictRootNode[da_dlCorSources{da_dlPublisheds}], l3L2NA(@IterHandler));
 FileClose(F);
end;

procedure ExportDictTree(aDictServ      : TDictionaryServer;
                         aDictType      : TdaDictionaryType;
                         aFlName        : TFileName;
                         aAppendCurrent : Boolean = False;
                         aProgress      : Tl3ProgressProc = nil;
                         aProgTitle     : ShortString = '';
                         WithID         : Boolean = False;
                         WithCommands   : Boolean = False;
                         WithNumbers    : Boolean = False;
                         WithEquals     : Boolean = False;
                         const aCurRoot : Il3Node = nil);

Const
 cEqCommand = '!EQ';
Var
 FlH       : Tl3FileStream;
 lStr      : AnsiString;
 TmpID     : AnsiString;
 ProgInd   : LongInt;
 lCurRoot  : Il3Node;

 Command      : PAnsiChar;
 CommLength   : Word;

 mCurEqualTbl : TEqualItemsTbl;
 EqPosList    : Tl3LongintList;
 CurStrNum    : LongInt;
 lEquals      : ISAB;
 lLastID      : LongInt;

 lPersistentNode : IPersistentNode;
 lDictJourItem   : IDictItemJour;

 lNonDelFindItem   : IDictItemJour;

 lStub : TdtRecAccessProc;

 procedure WriteChar(aCh : AnsiChar);
 begin
  FlH.WriteBuffer(aCh, 1);
 end;

 function HasNonDelChild(const aNode : Il3Node) : boolean;

  function NonDelFindIterHandler(const aTestNode : Il3Node) : Boolean; far;
   begin
    Result := l3IOk(aTestNode.QueryInterface(IDictItemJour, lNonDelFindItem)) and
              (lNonDelFindItem.Operation <> atDelete);
   end;

 begin
  Result := l3IterateSubTreeF(aNode,l3L2NA(@NonDelFindIterHandler),imCheckResult) <> nil;
 end;

 function IterHandler(const CurNode : Il3Node) : Boolean; far;
 begin
  Result := False;

  if Assigned(aProgress) then
  begin
   aProgress(piCurrent, ProgInd);
   Inc(ProgInd);
  end;

  //Savable l3IOk(CurNode.QueryInterface(IPersistentNode,lPersistentNode));
  if l3IOk(CurNode.QueryInterface(IPersistentNode,lPersistentNode)) then
  try
   if not lPersistentNode.MaySaved then Exit;
  finally
   lPersistentNode := nil;
  end;

  if l3IOk(CurNode.QueryInterface(IDictItemJour,lDictJourItem)) then
  try
   if // удаленный
      (lDictJourItem.Operation = atDelete)
      or
      // дети - эквивалентные
      l3TestMask(CurNode.Flags, cNodeHasEquals)
      or
      // все дети удалены
      HasNonDelChild(CurNode) then Exit;

  finally
   lDictJourItem:=nil;
  end
  else
   if CurNode.HasChild then Exit;

  if WithCommands and (CommLength > 0) then
  begin
   FlH.WriteBuffer(Command^, CommLength);
   WriteChar(cc_HardSpace);

  end;

  if WithID then
  begin
   tmpID:=IntToStr((CurNode as Il3HandleNode).Handle);
   FlH.WriteBuffer(TmpID[1],Length(TmpID));
   WriteChar(cc_Tab);
  end;

  lStr := l3GetFullPathStr(lCurRoot, CurNode, '\', '', false, WithNumbers {false- это порядковые номера из Item'ов убирает});
  if Length(lStr) > 0 then
  begin
   lStr := l3ChangeCodePage(lStr,
                    GlobalDataProvider.BaseLanguage[CurrentFamily].ANSICodePage,
                    GlobalDataProvider.BaseLanguage[CurrentFamily].OEMCodePage);
   FlH.WriteBuffer(lStr[1], Length(lStr));
  end;
  FlH.WriteBuffer(cc_EOL, cc_EOL_Len);
  if WithEquals then
  begin
   EqPosList.Items[(CurNode as Il3HandleNode).Handle]:=CurStrNum;
   Inc(CurStrNum);
  end;
 end;

function lEqualRecAccessProc(aRec : PAnsiChar) : Boolean;
begin
 Result := True;
 if lLastID <> PEqualRec(aRec)^.FirstID then
 begin
  if (EqPosList.Items[PEqualRec(aRec)^.FirstID]<>0) and
     (EqPosList.Items[PEqualRec(aRec)^.SecondID]<>0) then
  begin
   FlH.WriteBuffer(cc_EOL, cc_EOL_Len);
   lLastID:=PEqualRec(aRec)^.FirstID;
   FlH.WriteBuffer(cEqCommand, 3);
   WriteChar(cc_Tab);
   tmpID:=IntToStr(EqPosList.Items[PEqualRec(aRec)^.FirstID]);
   FlH.WriteBuffer(TmpID[1],Length(TmpID));
   WriteChar(cc_Tab);
   tmpID:=IntToStr(EqPosList.Items[PEqualRec(aRec)^.SecondID]);
   FlH.WriteBuffer(TmpID[1],Length(TmpID));
  end;
 end
 else
  if (EqPosList.Items[PEqualRec(aRec)^.SecondID]<>0) then
  begin
   WriteChar(cc_Comma);
   tmpID:=IntToStr(EqPosList.Items[PEqualRec(aRec)^.SecondID]);
   FlH.WriteBuffer(TmpID[1],Length(TmpID));
  end;
 //FlH.WriteBuffer(cc_EOL, cc_EOL_Len);
end;

const
 cDefValStr = '!DEFAULT ';
begin
 if not IsDictClass(aDictType) then
  raise EHtErrors.CreateInt(ecNotEnable);

 if aCurRoot = nil then
  lCurRoot := aDictServ.DictRootNode[aDictType]
 else
  lCurRoot := aCurRoot;

 Try
  if aAppendCurrent then
   FlH:=Tl3FileStream.Create(aFlName, l3_fmAppend)
  else
   FlH:=Tl3FileStream.Create(aFlName, l3_fmWrite);

  try
   if Assigned(aProgress) then
   begin
    aProgress(piStart, aDictServ.DictTbl[aDictType].ItemList.Count, aProgTitle);
    ProgInd := 1;
   end;

   if aAppendCurrent then
    FlH.WriteBuffer(cc_EOL, cc_EOL_Len);

   if WithCommands then
   begin
    Command:=PAnsiChar(DictionCommands[aDictType]);
    CommLength:=Length(DictionCommands[aDictType]);
   end;

   if cDLPassports[aDictType].rDefValue <> cNoDefValue then
   begin
    lStr := l3GetFullPathStr(lCurRoot, cDLPassports[aDictType].rDefValue);
    if Length(lStr) > 0 then
    begin
     FlH.WriteBuffer(cDefValStr, Length(cDefValStr));
     lStr := l3ChangeCodePage(lStr,
                    GlobalDataProvider.BaseLanguage[CurrentFamily].ANSICodePage,
                    GlobalDataProvider.BaseLanguage[CurrentFamily].OEMCodePage);
     FlH.WriteBuffer(lStr[1], Length(lStr));
     FlH.WriteBuffer(cc_EOL, cc_EOL_Len);
    end;
   end;

   if WithEquals then
   begin
    mCurEqualTbl := aDictServ.DictEqualObj[aDictType];
    if Assigned(mCurEqualTbl) then
    begin
     EqPosList := Tl3LongintList.Create;
     try
      EqPosList.Count := aDictServ.DictTbl[aDictType].GetMaxID+1;

      CurStrNum := 1;

      //EqPosList.Changing;
      try
       l3IterateSubTreeF(lCurRoot,l3L2NA(@IterHandler), 0);
      finally
       //EqPosList.Changed;
      end;

      lEquals := mCurEqualTbl.GetAllEquals;
      lStub := L2RecAccessProc(@lEqualRecAccessProc);
      try
       lEquals.IterateRecords(lStub, []);
      finally
       FreeRecAccessProc(lStub);
      end;

      FlH.WriteBuffer(cc_EOL, cc_EOL_Len);
     finally
      l3Free(EqPosList);
     end;
    end
    else
     WithEquals := False;
   end;

  if not WithEquals then
   l3IterateSubTreeF(lCurRoot,l3L2NA(@IterHandler), 0);

  finally
   if Assigned(aProgress) then
    aProgress(piEnd, 0);
   l3Free(FlH);
  end;
 finally
  lCurRoot := nil;
 end;
end;

procedure ExportDictionary(aDictServ : TDictionaryServer; aDictType : TdaDictionaryType; const aDir : TFileName);
   {* - экспорт словаря в "канонической" форме для копилятора NSRC}
 procedure lExportAnno;
 var
  lNum : Integer;

  function IterHandler(const aNode : Il3Node) : Boolean; far;
   begin
    Result := True;
    Inc(lNum);
    ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, Format('anno%d.txt', [lNum])), False {AppendCurrent},
                                           nil {aProgress}, '' {aProgTitle},
                                           False {WithID}, False {WithCommands}, True {WithNumbers}, True {WithEquals},
                                           aNode);
   end;

 begin
  lNum := 0;
  l3IterateSubTreeF(aDictServ.DictRootNode[aDictType], l3L2NA(@IterHandler), imOneLevel);
 end;

begin
 MakeDir(aDir);
 case aDictType of
  //da_dlNone : ;
  da_dlSources :
   // source3.txt (+ территория действия источника опубликования)
   ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'source3.txt'), False {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  False {WithID}, False {WithCommands}, True {WithNumbers}, True {WithEquals});
  da_dlTypes :
   //type3.txt (+table.txt - таблица приоритетов)
   ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'type3.txt'), False {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  False {WithID}, False {WithCommands}, True {WithNumbers}, True {WithEquals});

  da_dlClasses :
   ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'clax'), False {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  False {WithID}, True {WithCommands}, True {WithNumbers}, True {WithEquals});
  da_dlPrefixes :
   ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'clax'), True {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  False {WithID}, True {WithCommands}, True {WithNumbers}, True {WithEquals});

  da_dlNewClasses_Deprecated  :
   Assert(False, 'Deprecated dlNewClasses');
//   ExportNewClasses(aDictServ, aDir);

  //da_dlKeyWords : ; // отдельная песня

  da_dlBases       : ; //belongs.tbl + ID, Code, вес базы 2 языка

  da_dlWarnings    :  //warning.txt
   ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'warning.txt'), False {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  True {WithID}, False {WithCommands}, False {WithNumbers}, True {WithEquals});

  (*da_dlCorSources  : ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'CorSources'), True {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  False {WithID}, True {WithCommands}, false {WithNumbers}, false {WithEquals});
  *)
  da_dlPublisheds  :  //publ.sta
   MakeFilePublishedInSrc(aDictServ, ConcatDirName(aDir, 'publ.sta'));
   //ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'publ.sta'), False {AppendCurrent},
   //               nil {aProgress}, '' {aProgTitle},
   //               True {WithID}, False {WithCommands}, False {WithNumbers}, True {WithEquals});

  da_dlTerritories :  //territor.txt
   ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'territor.txt'), False {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  False {WithID}, False {WithCommands}, True{false} {WithNumbers}, True {WithEquals});

  da_dlNorms :       // norm.txt + default
   ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'norm.txt'), False {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  False {WithID}, True {WithCommands}, False {WithNumbers}, True {WithEquals});


  da_dlAnnoClasses :
   //сливается в пять файлов 8-( по веткам annoi.txt; annok.txt; annoo.txt; annot.txt; annou.txt
   lExportAnno;

  da_dlServiceInfo :
   ExportDictTree(aDictServ, aDictType, ConcatDirName(aDir, 'ServiceInfo.txt'), False {AppendCurrent},
                  nil {aProgress}, '' {aProgTitle},
                  True {WithID}, False {WithCommands}, False {WithNumbers}, True {WithEquals});

  //da_dlCorrects    : ; //не сливается
  //da_dlDateNums    : ; //не сливается
  //da_dlAccGroups   : ; //не сливается
  //da_dlAutoClasses : ; //не сливается
 end;

 //objtype.txt
end;

procedure ExportAllDictionary(aDictServ : TDictionaryServer; const aDir : TFileName);
   {* - экспорт комплекта словарей в "канонической" форме для копилятора NSRC}
var
 lDict : TdaDictionaryType;
begin
 for lDict := Succ(Low(TdaDictionaryType)) to High(TdaDictionaryType) do
  ExportDictionary(aDictServ, lDict, aDir);
end;

procedure ExportDictLink(aDictServ: TDictionaryServer; aDict: TdaDictionaryType; aFile: TFileName; aRenum: Boolean; aProgress:
    Tl3ProgressProc; aWithDocLinks: Boolean = True; WithoutAbolished: Boolean = False);
type
 PLinkRec = ^TLinkRec;
 TLinkRec = record
  rDictID : TDictID;
  rDocID  : TDocID;
  rSubID  : TSubID;
 end;
 {запись с переставленными полями, так как она лежит в lLinkRecList}

Var
 lOutStream : Tl3FileStream;

 KWLinkSab,
 TmpSab,
 TmpSab1,
 SortSab,
 l_AllSab   : Sab;

 ProgInd  {, I}         : LongInt;
 SortCount : SmallInt;
 lOutString : AnsiString;

 lLinkRecList : Tl3FieldSortRecList;
 lSaveParentNode : Il3Node;

 procedure PutDocNumbers;
 var
  CurID  : TDocID;
  tmpSab : Sab;
 begin
   tmpSab := LinkServer(CurrentFamily).Renum.ConvertToImportNumbers(l_AllSab);
   try
    htOpenResults(tmpSab, ROpen_Read, Nil, 0);
    try
     lOutString := '';
     While htReadResults(tmpSab,@CurID,SizeOf(CurID)) <> 0 do
      lOutString := lOutString + ';' + IntToStr(CurID);
     lOutString := lOutString + #13#10;
     lOutStream.Write(lOutString[1], Length(lOutString));
    finally
     htCloseResults(tmpSab);
    end;
   finally
    htClearResults(tmpSab);
   end;
 end;

 procedure lWriteStringLN(var lOutStr : AnsiString);
 var
  lOutStrLen : Integer;
 begin
  lOutStr :=lOutStr + #13#10;
  lOutStrLen := Length(lOutStr);
  m2XLTConvertBuff(PAnsiChar(lOutStr), lOutStrLen, Cm2XLTANSI2OEM);
  lOutStream.Write(lOutStr[1], Length(lOutStr));
 end;

 function IterHandlerForEmpty(CurNode : Il3Node) : Boolean;
 var
  lHandle : Longint;
  lIndex  : Integer;
 begin
  if Assigned(aProgress) then
  begin
   aProgress(piCurrent, ProgInd, '');
   Inc(ProgInd);
  end;

  if CurNode.HasChild then
   lOutString := '!KEY ' + l3PCharLen2String(CurNode.Text)
  else
   lOutString := '     ' + l3PCharLen2String(CurNode.Text);

  lWriteStringLN(lOutString);

  Result := False;
 end;

 function IterHandler(CurNode : Il3Node) : Boolean;
 var
  lHandle : Longint;
  lIndex  : Integer;
  lDocId  : TDocID;
 begin
  if Assigned(aProgress) then
  begin
   aProgress(piCurrent,ProgInd,'');
   Inc(ProgInd);
  end;

  if CurNode.HasChild then
   lSaveParentNode := CurNode
  else
  begin
   lHandle := (CurNode as Il3HandleNode).Handle;
   if lLinkRecList.FindPart(lHandle, 1, lIndex) then
   begin
    lOutString:= '!ITEM ' + l3GetFullPathStr(DictServer(CurrentFamily).DictRootNode[aDict], CurNode) + ':';
    // добавляем список адресов в строку
    while lIndex < lLinkRecList.Count do
     with PLinkRec(lLinkRecList.ItemSlot(lIndex))^ do
      if rDictID = lHandle then
      begin
       lDocID := rDocID;
       if aReNum then
        lDocID := LinkServer(CurrentFamily).Renum.GetExtDocID(lDocID);

       if rSubID > 0 then
        lOutString := lOutString + Format(' %d.%d', [lDocID, rSubID])
       else
        lOutString := lOutString + Format(' %d', [lDocID]);
       Inc(lIndex);
      end
      else
       Break;

    lWriteStringLN(lOutString);
   end;
  end;

  Result := False;
 end;
var
 lFldArr : TSmallIntArray;
 lSab : ISab;
Begin
 lOutStream := Tl3FileStream.Create(aFile, l3_fmCreateReadWrite);
 Try
  If aReNum then LinkServer(CurrentFamily).Renum.Buffered:=True;
  Try
   aDictServ.Family:= CurrentFamily;
   aDictServ.ReloadDict(aDict);

   {DocumentServer.Family:= CurrentFamily;
   DocumentServer.FileTbl.RefreshSrchList;
   Ht(htSortResults(l_AllSAB, DocumentServer.FileTbl.fSrchList, @docIdFld, 1));
   try
    htValuesOfKey(l_AllSab, fId_Fld, DocumentServer.FileTbl.fSrchList);
   }


    if aWithDocLinks then
     begin
      //LinkServer[da_dlKeyWords].RefreshSrchList;
      //htTransferToPhoto(l_AllSab,LinkServer[aDict].fSrchList,lnkDocIDFld);
      //htRecordsByKey(KWLinkSab, l_AllSab);
      lSab := MakeAllRecords(LinkServer(CurrentFamily).Links[aDict]);
      KWLinkSab := lSab.ExtractHTSab;


      if WithoutAbolished and (aDict = da_dlKeywords) then
      begin
       TmpSab := LinkServer(CurrentFamily).LogBook.GetDocsOnAction(acAbolished);
       htTransferToPhoto(TmpSab,KWLinkSab,lnkDocIDFld);
       htRecordsByKey(TmpSab1,TmpSab);
       htClearResults(TmpSab);
       htNotResults(TmpSab,TmpSab1);
       htClearResults(TmpSab1);
       TmpSab1:=KWLinkSab;
       htAndResults(KWLinkSab,TmpSab,TmpSab1);
       htClearResults(TmpSab);
       htClearResults(TmpSab1);
      end; // WithoutAbolished and (aDict = da_dlKeywords) then

      if LinkServer(CurrentFamily).Links[aDict].Table.fldCount = 3 then
      begin
       SetLength(lFldArr, 3);
       lFldArr[0] := lnkDictIDFld;
       lFldArr[1] := lnkDocIDFld;
       lFldArr[2] := lnkSubIDfld;
      end
      else
      begin
       SetLength(lFldArr, 2);
       lFldArr[0] := lnkDictIDFld;
       lFldArr[1] := lnkDocIDFld;
      end;
      SortCount := 2;
      Ht(htSortResults(SortSab, KWLinkSab, @lFldArr[0], SortCount));
      htClearResults(KWLinkSab);

      lLinkRecList := dtMakeRecListBySab(SortSab, lFldArr);
      try
       if Assigned(aProgress) then
        aProgress(piStart, DictServer(CurrentFamily).DictTbl[aDict].ItemList.Count, 'Экспорт словаря');

       //PutDocNumbers;
       ProgInd := 1;
       l3IterateSubTreeF(DictServer(CurrentFamily).DictRootNode[aDict],l3L2NA(@IterHandler),0);

       if Assigned(aProgress) then
        aProgress(piEnd, 0, '');
      finally
       l3Free(lLinkRecList);
      end;
     end //if not aEmpty then
     else
     begin
      if Assigned(aProgress) then
       aProgress(piStart, DictServer(CurrentFamily).DictTbl[aDict].ItemList.Count, 'Экспорт словаря');

      ProgInd := 1;
      l3IterateSubTreeF(DictServer(CurrentFamily).DictRootNode[aDict], l3L2NA(@IterHandlerForEmpty), 0);

      if Assigned(aProgress) then
       aProgress(piEnd, 0, '');
     end;
   {finally
    htClearResults(l_AllSab);
   end;}
  finally
   If aReNum then LinkServer(CurrentFamily).Renum.Buffered := False;
  end;
 finally
  l3Free(lOutStream);
 end;
end;

end.
