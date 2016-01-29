unit UsersMacro;

{$Include l3Define.inc}
{$Define ChangesInfoOn}

interface
uses
 DocIntf;

 procedure Macros_InsertDocChanges;
 procedure Macros_MakeChangeDoc;   //полнотекстовая редакция

 procedure Macros_ReplaceFutureEditionToCurrent;   //замена текущей редакции на будущую

 procedure Macros_UrOpMakeOldEdition(aFromDoc : TarDocument; aOldEditionUserID: Integer);

implementation

{$INCLUDE ProjectDefine.inc}

uses
 StrUtils,
 Controls,
 Dialogs,

 vtDialogs,

 k2Tags,

 l3Except,
 l3Types,
 l3Interfaces,
 l3Chars,
 l3String,
 l3BMSearch,
 l3FileUtils,
 l3Base,
 l3DatLst,
 l3Date,
 L3MinMax,
 l3DateSt,
 l3LongintList,
 l3InterfacedString,

 evdInterfaces,

 evTypes,
 evOp,
 evEditorWindow,
 evdStyles,
 evInternalInterfaces,
 evParaTools,
 evSearch,
 evCommonTypes,
 evCustomEditor,

 StrSpecUtil, StrShop,
 dtIntf, DT_Sab,
 DT_Serv,
 DT_LinkServ,
 DT_Const, DT_Types, dt_AttrSchema,
 DT_Active, DT_Lock, DT_Doc, DT_Hyper, DT_Dict, DT_Log,
 Types, Windows, SysUtils, Forms,
 Main, CustEditWin, EditWin,
 DocAttrIntf, DocAttrToolsIntf, IDocSpc,
 DictsSup,
 DocUtils,
 ddDocumentCopy,
 nevTools,
 IniShop,
 D_WizIzm, D_WizChangeDoc, d_WizReplaceNextEdition, dt_DictTypes,
 DocAttrTypes;

function TrimQuotasText(aStr : AnsiString) : AnsiString;
var
 lPos : Integer;
begin
 lPos := l3GetPosCharSet(PansiChar(aStr), ['«', '"', '“']);
 if lPos <= 0 then 
  Result := aStr
 else 
  Result := System.Copy(aStr, 1, lPos - 1);
end;

procedure CorrectChangeInfo(const anEditor: TevCustomEditor; const aDataStr: AnsiString; const anOp: InevOp; aChangeDate : TstDate);
var
 l_Sel     : InevRange;
 l_Str     : Tl3InterfacedString;
 l_Para    : InevPara;
 l_TmpStr  : AnsiString;
 l_Cursor  : InevBasePoint;
 l_MIPoint : InevBasePoint;
begin
 // Eсли текущий не ev_saChangesInfo сместимся на след. параграф
 l_MIPoint := anEditor.Selection.Cursor.MostInner;
 l_Para := l_MIPoint.Obj^.AsPara.Next;
 // Eсли след не ev_saChangesInfo вернемся обратно и сделаем за ним новый
 with anEditor do
  if l_Para.IntA[k2_tiStyle] <> ev_saChangesInfo then
  begin
   MoveLeafCursor(ev_ocParaEnd);
   InsertBuf(l3PCharLen(format(#13#10'%s', [aDataStr])));
   TextPara.Style.ID := ev_saChangesInfo;
  end // if l_Para.IntA[k2_tiStyle] <> ev_saChangesInfo then
  else //параграф уже был
  begin
   l_Sel := l_Para.Range;
   l_TmpStr := InsertDate2Str(l3Str(evAsString(l_Sel.Data)), aChangeDate);
   l_Str := Tl3InterfacedString.Make(l3PCharLen(l_TmpStr));
   try
    l_Sel.Text.Modify.InsertString(View, l_Str, anOp, True, [misfDirect]);
   finally
    l3Free(l_Str);
   end;
  end;
end;

procedure Macros_InsertDocChanges;
var
 lMainForm : TMainForm;
 lDocID    : Longint;
 lEdWin    : TDocEditorWindow;
 lMDIWin   : TForm;
 lRect     : TRect;
 lPoint    : TPoint;
 lDY       : Integer;
 lPack     : InevOp;
 lDataStr  : AnsiString;
 lTmpStr   : AnsiString;
 lTextCopy : AnsiString;
 lBT       : Tl3BMTable;
 lStartPos : Cardinal;
 lEndPos   : Cardinal;
 lAttrList : Tl3DataList;
 lWarnNum  : Integer;
 lWasFound : Boolean;
 lBlock    : IevCommonDataObject;
 l_TextModify : InevTextModify;
begin
  lMainForm := TMainForm(Application.MainForm);

  with TIzmWizardDlg.Create(lMainForm) do
   try
    if lMainForm.ActiveMDIChild is TDocEditorWindow then
    begin
     edtChangingDocID.AsInteger := TDocEditorWindow(lMainForm.ActiveMDIChild).Document.UserDocID;
     edtChangingDocID.Modified := True;
    end;
    if Execute(CurrentFamily) then
    begin
     Windows.GetWindowRect(lMainForm.ClientHandle, lRect);
    {Change}
     lDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(edtChangeDocID.AsInteger);
     if lDocID > -1 then
     begin
      lMDIWin := lMainForm.RunTextEditor(CurrentFamily, lDocID);
      with TDocEditorWindow(lMDIWin) do
      begin
       WindowState := wsNormal;
       Top := (lRect.Bottom - lRect.Top) div 2;
       Left := 0;
       Height := (lRect.Bottom - lRect.Top) div 2 - 4;
       Width := lRect.Right - lRect.Left - 4;
       lPoint := Point(0,Top);
       Windows.ClienttoScreen(lMainForm.ClientHandle, lPoint);
       lDY:= (DocTextEditor.ClienttoScreen(Point(0, 0)).Y - lPoint.Y);
      end;
     end;

    {Changing}
     lDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(edtChangingDocID.AsInteger);

     if lDocID > -1 then
     begin
      lWarnNum := 11;
      LinkServer(CurrentFamily).DelSubNode(atWarnings, lDocID, 0, lWarnNum);

      lMDIWin := lMainForm.RunTextEditor(CurrentFamily, lDocID);

      with TDocEditorWindow(lMDIWin) do
      begin
       WindowState := wsNormal;
       Top := 0;
       Left := 0;
       Height := (lRect.Bottom - lRect.Top) div 2 + lDY - 2;
       Width := lRect.Right - lRect.Left - 4;
       if not edtChangeDate.IsEmpty  then
       begin
        lDataStr := l3DateToStr(edtChangeDate.Date, 'd mmmm yyyy г.');
        BMMakeTable(PansiChar(sidUserModifyShortSrch2), lBT, Length(sidUserModifyShortSrch2));
        with FullNameMEdit, Buffer do
         if not l3SearchStr(l3PCharLen(S, SLen, SCodePage), lBT, l3PCharLen(sidUserModifyShortSrch2), lStartPos) then
          Text := Text + ' ' + sidUserModifyShortSrch2;
        FullNameMEdit.Modified := True;
        Application.ProcessMessages;
        with DocTextEditor.DocEditor do
        begin
         lPack := StartOp(ev_ocUser+100);
         try
          GotoTop;
          try
           while True do
           begin
            with CurText, TextPara.Style do
             if (l3RTrimLen(S, SLen) <> 0) and
                (Id <> ev_saTxtComment) and
                (Id <> ev_saVersionInfo) and
                (Id <> ev_saTechComment) then Break;
            if not MoveLeafCursor(ev_ocParaDown, True) then
            begin
             GotoTop;
             Break;
            end;
           end;

          {$IfDef ChangesInfoOn}
          CorrectChangeInfo(DocTextEditor.DocEditor, lDataStr, lPack, edtChangeDate.StDate);
          {$else ChangesInfoOn}

           MoveLeafCursor(ev_ocParaEnd);
           if evSearchPara(CurPara, TevRegularExpressionSearcher.Make(sidUserModifyFullRegSrch), lBlock) then
           begin
            evMoveBorders(View, lBlock, Length(sidUserModifyFullSrch), -1);
            lTmpStr := l3Str(evAsString(lBlock));

            lTmpStr := InsertDate2Str(lTmpStr, edtChangeDate.StDate);

            if Supports(lBlock, InevTextModify, l_TextModify) then
             l_TextModify.InsertString(View, l3CStr(lTmpStr), lPack);
           end
           else
           begin
            MoveLeafCursor(ev_ocParaEnd);
            InsertBuf(l3PCharLen(Format(#10'(с изменениями от %s)',[lDataStr])));
           end;
          {$EndIf ChangesInfoOn}
          except
          end;
         finally
          lPack := nil; {FinishOp;}
         end;
        end;
       end;
       with SprTextEditor.DocEditor do
        if TextSource <> nil then
        begin
         lPack := StartOp(ev_ocUser+100);
         Try
          GotoTop;
          BMMakeTable(PansiChar(sidUserInputModify2), lBT, Length(sidUserInputModify2));

          try
           repeat
            lStartPos:=0;
            with CurText do
             lWasFound := l3SearchStr(l3PCharLen(S, SLen, SCodePage), lBT, l3PCharLen(sidUserInputModify2), lStartPos);
           until lWasFound or (not MoveLeafCursor(ev_ocParaDown, True));

           MoveLeafCursor(ev_ocParaEnd);

           if not lWasFound then
            InsertBuf(l3PCharLen(cc_EOL + sidUserInputModify2));

           InsertBuf(l3PCharLen(cc_EOL + TrimQuotasText(stChangeDocName.Caption)));
          except
          end;

         finally
          lPack := nil; {FinishOp;}
         end;
        end;
       acToolsSubmitJurChanges.Execute;
      end;
     end;

     {old edition}
     if (edtOldEditionDocID.AsInteger > 0) and (lMDIWin <> nil) and (lMDIWin is TDocEditorWindow) then
      Macros_UrOpMakeOldEdition(TDocEditorWindow(lMDIWin).Document, edtOldEditionDocID.AsInteger);
    end;

   finally
    Free;
   end;
end;

procedure Macros_MakeChangeDoc;
 var
  I           : Integer;
  lMainForm   : TMainForm;
  lDocID      : TDocID;
  lOldEdID    : TDocID;
  lEdWin      : TDocEditorWindow;
  lMDIWin     : TForm;
  lRect       : TRect;
  lPoint      : TPoint;
  lDY         : Integer;
  lPack       : InevOp;
  lDataStr    : AnsiString;
  lTmpStr     : AnsiString;
  lTextCopy   : AnsiString;
  //lShortName  : AnsiString;
  lBT         : Tl3BMTable;
  lStartPos,
  lEndPos     : Cardinal;
  lAttrList   : Tl3DataList;
  lWarnNum    : Integer;
  lWasFound   : Boolean;
  lActIntervalAttr : IActiveIntervalsAttributeTool;
  lActIntervalAttr_Changer : IActiveIntervalsAttributeTool;
  lActIntRec       : TActiveIntervalRec;
  lDateNumRec : TDNAttrRec;
  lIsNotSureAdd : Boolean;
  lIntNextDocId : TDocID;
  lChangerDocId : TDocID;

 procedure MakeActiveInterval(aActIntervalAttr : IActiveIntervalsAttributeTool; aDate : TstDate; aOldEdition : Boolean);
  // aOldEdition = true - закрываем интервал aDate, иначе делаем  открытый с aDate
  var
   lInd : Integer;
  begin
   with aActIntervalAttr do
    if aOldEdition then
    begin
     lInd := GetLastIntervalIndex;
     if lInd < 0 then
     begin
      if aDate <= 0 then
       AddRec(minActiveDate, maxActiveDate)
      else
       AddRec(minActiveDate, aDate - 1);

      // lActIntRec := MakeActiveIntervalRec(minActiveDate, maxActiveDate)
      //else
      // lActIntRec := MakeActiveIntervalRec(minActiveDate, aDate - 1);

      //AddRec(@lActIntRec);
     end
     else // if lInd < 0 then...
     begin
      if aDate <= 0 then
       CloseInterval(lInd, maxActiveDate)
      else
       CloseInterval(lInd, aDate - 1)
     end;
    end
    else //if aOldEdition then...
    begin
      DeleteAll;
     if aDate <= 0 then
      aDate := maxActiveDate;
     AddRec(aDate, maxActiveDate);
     //lActIntRec := MakeActiveIntervalRec(aDate, maxActiveDate);
     //Add(@lActIntRec);
    end;
 end;

 procedure InsertIzmStrIntoText(aEdWin : TDocEditorWindow; aChangeDate : TstDate);
 var
  l_Block      : IevCommonDataObject;
  l_TextModify : InevTextModify;
 begin
  with aEdWin do
  begin
   lDataStr := l3DateToStr(aChangeDate, 'd mmmm yyyy г.');
   BMMakeTable(PansiChar(sidUserModifyShortSrch2), lBT, Length(sidUserModifyShortSrch2));
   with FullNameMEdit, Buffer do
    if not l3SearchStr(l3PCharLen(S, SLen, SCodePage), lBT, l3PCharLen(sidUserModifyShortSrch2), lStartPos) then
     Text := Text + ' ' + sidUserModifyShortSrch2;
   FullNameMEdit.Modified := True;
   Application.ProcessMessages;
   with DocTextEditor.DocEditor do
   begin
    lPack := StartOp(ev_ocUser+100);
    Try
     GotoTop;
     Try
      While true do begin
       with CurText, TextPara.Style do
        if (l3RTrimLen(S, SLen) <> 0) and
           (Id <> ev_saTxtComment) and
           (Id <> ev_saVersionInfo) and
           (Id <> ev_saTechComment) then break;
       If not MoveLeafCursor(ev_ocParaDown, True) then
       begin
        GotoTop;
        break;
       end;
      end;

      {$IfDef ChangesInfoOn}
      CorrectChangeInfo(DocTextEditor.DocEditor, lDataStr, lPack, aChangeDate);
      {$else ChangesInfoOn}

      if evSearchPara(CurPara, TevRegularExpressionSearcher.Make(sidUserModifyFullRegSrch), l_Block) then
      begin
       evMoveBorders(View, l_Block, Length(sidUserModifyFullSrch), -1);
       lTmpStr := l3Str(evAsString(l_Block));
       lTmpStr := InsertDate2Str(lTmpStr, aChangeDate);
       if Supports(l_Block, InevTextModify, l_TextModify) then
        l_TextModify.InsertString(View, l3CStr(lTmpStr), lPack);

      end
      else
      begin
       MoveLeafCursor(ev_ocParaEnd);
       InsertBuf(l3PCharLen(Format(#10'(с изменениями от %s)',[lDataStr])));
      end;

          {$EndIf ChangesInfoOn}

     except
     end;
    finally
     lPack := nil; {FinishOp;}
    end;
   end;
   //miSetVChangedClick(nil);
  end;
 end;

 begin
  lOldEdID := 0;

  lMainForm := TMainForm(Application.MainForm);

  with TChangeDocWizardDlg.Create(lMainForm) do
   try
    If lMainForm.ActiveMDIChild is TDocEditorWindow then
     ChangingDocID := TDocEditorWindow(lMainForm.ActiveMDIChild).Document.UserDocID;

    If Execute(CurrentFamily) then
    begin
     Windows.GetWindowRect(lMainForm.ClientHandle, lRect);

    {Changer}
     lChangerDocId := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(ChangerDocID);
     If lChangerDocId <= 0 then
      raise Exception.Create(Format(sidDocLoadFault,[ChangerDocID, sidMakeCopyFault]));

     lMDIWin := lMainForm.RunTextEditor(CurrentFamily, lChangerDocId);
     with TDocEditorWindow(lMDIWin) do
     begin
      // чтобы из изменяющего документа команда NOTSURE вставлялась в изменяемый.
      lActIntervalAttr_Changer := Document.AttrManager.GetDocAttribute(atActiveIntervals) as IActiveIntervalsAttributeTool;
      WindowState := wsNormal;
      Top := (lRect.Bottom - lRect.Top) div 2;
      Left := 0;
      Height := (lRect.Bottom - lRect.Top) div 2 - 4;
      Width := lRect.Right - lRect.Left - 4;
      lPoint := Point(0,Top);
      Windows.ClienttoScreen(lMainForm.ClientHandle, lPoint);
      lDY := (DocTextEditor.ClienttoScreen(Point(0, 0)).Y - lPoint.Y);
     end;

    {Changing} //текущая
     lDocID := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(ChangingDocID);

     If lDocID > -1 then
     begin
      lWarnNum := 11;
      LinkServer(CurrentFamily).DelSubNode(atWarnings, lDocID, 0, lWarnNum);

      lMDIWin := lMainForm.RunTextEditor(CurrentFamily, lDocID);

      with TDocEditorWindow(lMDIWin) do
      begin
       WindowState := wsNormal;
       Top := 0;
       Left := 0;
       Height := (lRect.Bottom - lRect.Top) div 2 + lDY - 2;
       Width := lRect.Right - lRect.Left - 4;

       //Copying to old edition
       if edtEditionDocID.AsInteger > 0 then
       begin
        //raise Exception.Create(sidIDOlEditionNotDefined + ^M + sidMakeCopyFault);

        if rbEditionKindOld.Checked then
        //прошлая
         Document.MakeDocCopy(edtEditionDocID.AsInteger, askMakeOldEdition)
        else
        //будущая
         Document.MakeDocCopy(edtEditionDocID.AsInteger, askMakeNextEdition);

        lOldEdID := LinkServer(DocFamily).Renum.ConvertToRealNumber(edtEditionDocID.AsInteger);
        if lOldEdID <= 0 then
         raise Exception.Create(Format(sidDocLoadFault,[edtEditionDocID.AsInteger, sidMakeCopyFault]));

        if rbEditionKindOld.Checked {делаем прошлую (!!Это текущая)} then
        begin
         (Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := edtEditionDocID.AsInteger;

         with Document.AttrManager.GetDocAttribute(atDateNums) as IDateNumDocAttributeTool do
         begin
          DeleteAllChangerRec;
         {$IF DEFINED(DBver134) and NOT DEFINED(ForRegion)}
          AddRec(dnChangerDate, edtChangeDate.StDate, lChangerDocId, ChangerSubId);
         {$ELSE}
          AddRec(dnChangerDate, edtChangeDate.StDate, cc_UnAssignedStr);
         {$IFEND}
          //lDateNumRec := MakeDateNumRec(edtChangeDate.StDate, '', dnChangerDate);
          //Add(@lDateNumRec);
         end;
        end;
       end;

       lActIntervalAttr := Document.AttrManager.GetDocAttribute(atActiveIntervals) as IActiveIntervalsAttributeTool;
       MakeActiveInterval(lActIntervalAttr, edtChangerActivDate.StDate, not rbEditionKindOld.Checked);

      // чтобы из изменяющего документа команда NOTSURE вставлялась в изменяемый.
       lIsNotSureAdd := False;
       With lActIntervalAttr_Changer do
        CopyNotSureRecTo(lActIntervalAttr);
        {for I := 0 to Pred(Count) do
         if PActiveIntervalRec(Data[I])^.Typ = 1 then // !NotSure
         begin
          lActIntervalAttr.Add(Data[I]);
          lIsNotSureAdd := True;
         end;
         }
       //GetAttrTreeListOnSub(0, [atVerLink, atActiveIntervals]);

       If{ rbEditionKindOld.Checked //прошлая} // с изм. и доп. в текущую вставляем всегда, если делаем будущую, то вставляем в текущую и будущую
          //and
          not edtChangeDate.IsEmpty  then
        InsertIzmStrIntoText(TDocEditorWindow(lMDIWin), edtChangeDate.StDate);

       acToolsSubmitJurChanges.Execute;

       if Document.HasSpravka and (Document.Spravka.HasTextSource) then
        with SprTextEditor.DocEditor do
        begin
         lPack := StartOp(ev_ocUser+100);
         Try
          GotoTop;
          BMMakeTable(PansiChar(sidUserInputModify2), lBT, Length(sidUserInputModify2));

          try
           repeat
            with CurText do
             lWasFound := l3SearchStr(l3PCharLen(S, SLen, SCodePage), lBT, l3PCharLen(sidUserInputModify2), lStartPos);
           until lWasFound or (not MoveLeafCursor(ev_ocParaDown, true));

           MoveLeafCursor(ev_ocParaEnd);

           if not lWasFound then
            InsertBuf(l3PCharLen(cc_EOL + sidUserInputModify2));

           InsertBuf(l3PCharLen(cc_EOL + TrimQuotasText(stChangeDocName.Caption)));
          except
          end;

         finally
          lPack := nil; {FinishOp;}
         end;
        end; // with SprEditor do

      end;
     end;

   {old/future edition}
     If lOldEdID > 0 then
     begin
      lEdWin := TDocEditorWindow(MainForm.RunTextEditor(CurrentFamily, lOldEdID));
      if rbEditionKindNext.Checked {будущая} then
      begin
       lIntNextDocId := DocumentServer(CurrentFamily).FileTbl.CheckVerLink(lDocID); //Next для lDocID
       // Подправляем Verlink у lIntNextDocId
       if lIntNextDocId > 0 then
       begin
        // хакерство в отличии от заремленного далее куска, зато позволяет избежать проверки на дублирование VerLink
        // которое непременно произойдет (временно), т к  по сути VerLink'и меняются местами
        DocumentServer(CurrentFamily).FileTbl.SetVerLink(lIntNextDocId, lOldEdID);
        {lCurDoc := TarDocument.CreateParam(CurrentFamily, lIntNextDocId );
        try
         (lCurDoc.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := lOldEdID;
         lCurDoc.Save;
        finally
         l3Free(lCurDoc);
        end;}
       end;

       (lEdWin.Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := ChangingDocID;

       if not edtChangeDate.IsEmpty then
       with lEdWin.Document.AttrManager.GetDocAttribute(atDateNums) as IDateNumDocAttributeTool do
       begin
        {$IF DEFINED(DBver134) and NOT DEFINED(ForRegion)}
         AddRec(dnChangerDate, edtChangeDate.StDate, lChangerDocId, ChangerSubId);
        {$ELSE}
         AddRec(dnChangerDate, edtChangeDate.StDate, cc_UnAssignedStr);
        {$IFEND}
        //lDateNumRec := MakeDateNumRec(edtChangeDate.StDate, '', dnChangerDate);
        //Add(@lDateNumRec);
       end;
      end;

      //if not edtChangerActivDate.IsEmpty then
      begin
       lActIntervalAttr := lEdWin.Document.AttrManager.GetDocAttribute(atActiveIntervals) as IActiveIntervalsAttributeTool;
       MakeActiveInterval(lActIntervalAttr, edtChangerActivDate.StDate, rbEditionKindOld.Checked);
      end;

      //lEdWin.GetAttrTreeListOnSub(0, [atVerLink, atActiveIntervals]);

      if rbEditionKindNext.Checked {будущая}
         and not edtChangeDate.IsEmpty  then
       InsertIzmStrIntoText(lEdWin, edtChangeDate.StDate);
     end;
    end;

   finally
    Free;
   end; //with TChangeDocWizardDlg.Create(lMainForm) do

  if lIsNotSureAdd then
   vtMessageDlg(l3CStr(@sidWarnAddNotSure), mtWarning);

 end;

procedure GetVerlinkList(aDocList: TL3LongintList; aMainDocID: TDocID; aFutureEdition : TDocID);
var
 l_CurId: TDocId;
begin
 if aDocList = nil then
  Exit;
 aDocList.Clear;
 l_CurId := aMainDocID;
 repeat
  // проверка на дубликаты (опасность зацикливания)
  if aDocList.IndexOf(l_CurId) > -1 then
   raise El3NoLoggedException.Create(sidVerLinkCycle);
  aDocList.Insert(0, l_CurId);

  if (l_CurId = aFutureEdition) then
   Break;
   
  l_CurId := DocumentServer(CurrentFamily).FileTbl.CheckVerLink(l_CurId);
  if l_CurId <= 0 then
           raise El3NoLoggedException.Create(sidVerLinkNonFutureEdition);
 until (l_CurId <= 0);
end;

procedure Macros_ReplaceFutureEditionToCurrent;
var
 lMainForm     : TMainForm;
 lCurEdWin     : TDocEditorWindow;
 lNextEdWin    : TDocEditorWindow;

 lMDIWin       : TForm;

 lIntCurDocId         : TDocID;
 lIntNextDocId        : TDocID;
 lIntNextNextDocId    : TDocID;
 lIntNearestNextDocId : TDocID;
 lIntSprDocID         : TDocID;
 lCurDocId            : TDocID;
 lNextDocId           : TDocID;

 lRect                : TRect;

 lUserDocType         : TUserType;

 lLockHandle          : TJLHandle;

 lDocList             : TL3LongintList;
 lLockHandleList      : TL3LongintList;

 I : Integer;
 lCurDoc : TarDocument;

 lDSList : ISab;

 lHasAnno : Boolean;
 lWarnNum  : Integer;

 //DEBUG
 {$IFDEF DEBUG_HasAnno}
 lHasAnnoAllowSave : boolean;
 {$ENDIF}
 lTempCurDocFileName : TFileName;
 l_PriorFlag: Boolean;
 lPriority: Word;

 function lGetDocument(aDocId : TDocID) : TarDocument;
 var
  lEdWin      : TCustomEditorWindow;
 begin
  lEdWin := MainForm.FindTextEditor(CurrentFamily, aDocId);
  if lEdWin = nil then
   Result := TarDocument.CreateParam(CurrentFamily, aDocId)
  else
  begin
   Result := lEdWin.Document.Use;
   lEdWin.Close;
   Application.ProcessMessages;
  end;
 end;

begin
 // получаем LCurDocId LOldDocId LNextDocId
 lMainForm := TMainForm(Application.MainForm);

 with TReplaceNextEditionDlg.Create(lMainForm) do
  try
   If lMainForm.ActiveMDIChild is TDocEditorWindow then
   begin
    with TDocEditorWindow(lMainForm.ActiveMDIChild) do
    begin
     edtNextEditionDocID.AsInteger := Document.UserDocID;
     edtNextEditionDocID.Modified := True;

     edtCurEditionDocID.AsInteger := (Document.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value;
     edtCurEditionDocID.Modified := True;
    end;
   end;

   If Not Execute(CurrentFamily) then Exit;

   Windows.GetWindowRect(lMainForm.ClientHandle, lRect);

   lCurDocId  := edtCurEditionDocID.AsInteger;
   //lOldDocId  := edtOldEditionDocID.AsInteger;
   lNextDocId := edtNextEditionDocID.AsInteger;

  finally
   Free;
  end;

 if (lCurDocId = 0) or (lNextDocId = 0) or (lCurDocId = lNextDocId) then Exit;

 lIntCurDocId := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(lCurDocId);
 lIntNextDocId := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(lNextDocId);
 lIntNextNextDocId := DocumentServer(CurrentFamily).FileTbl.CheckVerLink(lIntNextDocId); //Next для lIntNextDocId

 lDocList := TL3LongintList.Create;
 try
  GetVerlinkList(lDocList, lIntCurDocId, lIntNextDocId);

  lLockHandleList := TL3LongintList.Create;
  try
   for I := 0 to Pred(lDocList.Count) do
   begin
    lLockHandle := LockServer.PreventLockDoc(CurrentFamily, lDocList[I]);
    if lLockHandle = -1 then
     El3NoLoggedException.Create(sidDocLockDeny)
    else
     lLockHandleList.Add(lLockHandle);
   end;

   // Подправляем Verlink у lIntNextNextDocId
   if lIntNextNextDocId > 0 then
   begin
    // хакерство в отличии от заремленного далее куска, зато позволяет избежать проверки на дублирование VerLink
    // которое непременно произойдет (временно), т к  по сути VerLink'и меняются местами
    DocumentServer(CurrentFamily).FileTbl.SetVerLink(lIntNextNextDocId, lIntCurDocId);
    LinkServer(CurrentFamily).LogBook.PutLogRec(lIntNextNextDocId, acAttrWork);
    {lCurDoc := TarDocument.CreateParam(CurrentFamily, lIntNextNextDocId);
    try
     (lCurDoc.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := lCurDocId;
     lCurDoc.Save;
    finally
     l3Free(lCurDoc);
    end;}
   end;


   //1. В текущей удаляем ссылки на буд. редакцию из версионных комментариев

   lIntNearestNextDocId := lDocList[lDocList.Count - 2];  //ближайшая к текущей будущая редакция

   While lDocList.Count > 0 do
   begin
    lCurDoc := lGetDocument(lDocList[Pred(lDocList.Count)]);
    try
     lDocList.Delete(Pred(lDocList.Count));

     lCurDoc.LoadText;

     // эта хрень удаляет ev_saVersionInfo со ссылками на буд. редакцию
     // но этого мало потому что нужно удалять еще предыдущий
     //if lDocList.Count > 0 then
     // EraseSpecialParaWithHyperlinks(lCurDoc, lDocList, ev_saVersionInfo);

    //4.1 Подправляем Verlink
    if lCurDoc.DocID = lIntNearestNextDocId then
      (lCurDoc.AttrManager.GetDocAttribute(atVerLink) as IIntegerDocAttribute).Value := lNextDocId;

     if lCurDoc.DocID = lIntCurDocId then
     begin
      //lDSList.SetDocIds(lDocList); //lDocList уже без lIntCurDocId
      if lDocList.Count > 1 then
       lDSList := MakeValueSet(DocumentServer(CurrentFamily).FileTbl, docIdFld,
                               lDocList.ItemSlot(1 {первый элемент (lNextDocId) не нужен}),
                               Pred(lDocList.Count))
      else
       lDSList := nil;

      lIntSprDocID := lCurDoc.GetSprDocID;
      l_PriorFlag  := lCurDoc.PriorFlag;
      lPriority    := lCurDoc.Priority;
      lCurDoc.SetPriority(lCurDoc.Priority, False); // Обнуляем priority у бывшего текущего
      lUserDocType := lCurDoc.UserType;
      lHasAnno := lCurDoc.HasAnno;
     end;

     //2. Копируем текущую в прошлую
     if lCurDoc.DocID = lIntCurDocId then
     //тут во временный копируем
     try
      Screen.Cursor := crHourGlass;

      lCurDoc.Save;
      with TddDocumentCopier.Create do
      try
       Family := CurrentFamily;
       { TODO -oВованыч -cРазвитие : Тут нужно присвоить функцию прогресса }
       //ProgressFunc :=
       lTempCurDocFileName := l3GetTempFileName('ar');
       //lTempCurDocFileName := 'd:\archi.tmp';
       WriteToFile(lIntCurDocId, lIntNextDocId, askCopyToOldEdition, lTempCurDocFileName{, aCopyType});
      finally
       Free;
      end;

     finally
      Screen.Cursor := crDefault;
     end;

     if lCurDoc.DocID = lIntNextDocId then
     begin
      //4.2 Приклеиваем справку
      //lCurDoc.DocData.SetRelatedDoc(lIntSprDocID);
      lCurDoc.Related := lIntSprDocID;
      //1.1 Удаляем acIncluded
      (lCurDoc.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).DelAction(acIncluded);
     end;

     lCurDoc.Save;

     if lCurDoc.DocID = lIntNextDocId then
     begin
    //1.2 Копируем журналы из текущей в будущую
      LinkServer(CurrentFamily).LogBook.CopyRecords(lIntCurDocId, lIntNextDocId);

    //3. Во всех будущих редакциях ссылки на текущую заменяем на прошлую
    //* тут нужно менять на lIntNextDocId,
    // саму lIntNextDocId так нельзя скорректировать, надо при копировании в текущую одновременно
    //исправлять lIntCurDocId -> lIntNextDocId
    //           lIntNextDocId -> lIntCurDocId (типа внутренние ссылки)
     if lDSList <> nil then
      DocUtils.ReplaceReferences(CurrentFamily, lDSList, lIntCurDocId, lIntNextDocId);
    //  DocUtils.ReplaceReferences(CurrentFamily, lDSList, [(lIntCurDocId, lIntOldDocId)]);

    //5. Копируем будущую в текущую
      //lCurDoc.Save;
      try
       Screen.Cursor:=crHourGlass;
       with TddDocumentCopier.Create do
       try
        Family := CurrentFamily;
        { TODO -oВованыч -cРазвитие : Тут нужно присвоить функцию прогресса }
        //ProgressFunc :=
        MakeCopy(lIntNextDocId, lIntCurDocId, askAllAttributes, True {aReverseHlinkRenum},  lUserDocType, lIntCurDocId);
       finally
        Free;
       end;
      finally
       Screen.Cursor:=crDefault;
      end;
     end;

    finally
     l3Free(lCurDoc);
    end;
   end;

   (*lCurDoc := TarDocument.CreateParam(CurrentFamily, lIntCurDocId);
   try
    // Корректируем атрибуты у нового текущего
    if lHasAnno then
    //восстанавливаем HasAnno у текущего
     lCurDoc.HasAnno := lHasAnno;

    // и добавляем VChanged
    with (lCurDoc.AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool) do
     AddLogRecOnce(acChanged,
                   DateTimeToStDate(IniRec.NextVersionDate),
                   DateTimeToStDate(IniRec.NextVersionDate));

    if l_PriorFlag then
    begin
     // копируем сюда priority
     lCurDoc.PriorFlag := l_PriorFlag;
     lCurDoc.Priority := lPriority;
    end;
    lCurDoc.Save;
   finally
    l3Free(lCurDoc);
   end;
   *)
   try
    Screen.Cursor:=crHourGlass;
    with TddDocumentCopier.Create do
    try
     Family := CurrentFamily;
     { TODO -oВованыч -cРазвитие : Тут нужно присвоить функцию прогресса }
     //ProgressFunc :=
     ReadFromFile(lTempCurDocFileName);
     DeleteFile(lTempCurDocFileName);
    finally
     Free;
    end;

   finally
    Screen.Cursor:=crDefault;
   end;

   //переставляем на текущую все ссылки, которые шли на будущую
   //ReplaceReferences(aFamID : TFamilyID; aDocList : ISab;
   //aSearchHLDocID: TDocID; aReplaceHLDocID: TDocID);

   with (lMainForm.RunTextEditor(CurrentFamily, lIntCurDocId) as TCustomEditorWindow).Document do
   begin
    if lHasAnno then
    //восстанавливаем HasAnno у текущего
     HasAnno := lHasAnno;

    // и добавляем VChanged
    with (AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool) do
     AddLogRecOnce(acChanged,
                   DateTimeToStDate(IniRec.NextVersionDate),
                   DateTimeToStDate(IniRec.NextVersionDate));

    if l_PriorFlag then
    begin
     // копируем сюда priority
     //PriorFlag := l_PriorFlag;
     SetPriority(lPriority, l_PriorFlag);
    end;
    //Save;
   end;

  finally
   for I := 0 to Pred(lLockHandleList.Count) do
    LockServer.UnLockDoc(CurrentFamily, lLockHandleList[I]);

   l3Free(lLockHandleList);
  end;

 finally
  l3Free(lDocList);
 end;
 vtMessageDlg(l3CStr(@sidProcessDone), mtInformation);
end;

procedure Macros_UrOpMakeOldEdition(aFromDoc : TarDocument; aOldEditionUserID: Integer);
var
 lDocID : TDocID;
 lEdWin : TDocEditorWindow;
 lName  : AnsiString;
 lPos   : Integer;
begin
 if aOldEditionUserID <= 0 then
  Exit;
 lDocID := LinkServer(aFromDoc.DocFamily).Renum.ConvertToRealNumber(aOldEditionUserID);
 if lDocID > -1 then
 begin
  lEdWin := TDocEditorWindow(MainForm.RunTextEditor(aFromDoc.DocFamily, lDocID));
  lEdWin.WindowState := wsNormal;
 end
 else
 begin
  lEdWin := TDocEditorWindow.Create(MainForm);
  lEdWin.WindowState := wsNormal;
  try
   lEdWin.DocFamily := aFromDoc.DocFamily;
   lEdWin.LoadNewEmptyTextDocEx('', DocAddr(aFromDoc.DocFamily, aOldEditionUserID), utNoDoc);
   lEdWin.Lock;
   //lEdWin.ShortNameEdit.Text := AnsiUpperCase(sidUserOldEditNamePrefix) + ShortNameEdit.Text;
   //lEdWin.ShortNameEdit.Modified := True;
   lName := l3Str(aFromDoc.Name); //FullNameMEdit.Text;
   lPos := Pos(sidUserModifyShortSrch2, lName);
   if lPos > 0 then
    Delete(lName, lPos, Length(sidUserModifyShortSrch2));

   lEdWin.FullNameMEdit.Text := sidUserOldEditNamePrefix + lName;
   lEdWin.FullNameMEdit.Modified := True;
   lEdWin.Document.AttrManager.GetDocAttribute(atBases).Copy(aFromDoc.AttrManager.GetDocAttribute(atBases));
   lEdWin.Document.AttrManager.GetDocAttribute(atAccGroups).Copy(aFromDoc.AttrManager.GetDocAttribute(atAccGroups));
   lEdWin.LoadPage(piJourn);
   if not lEdWin.cbxIncDone.Checked then
    lEdWin.cbxIncDone.Checked := True;
  except
   lEdWin.Free;
  end;
 end;
end;

end.
