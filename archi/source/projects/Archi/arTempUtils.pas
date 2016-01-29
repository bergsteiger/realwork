unit arTempUtils;

// ¬с€кие временные или "одноразовые" процедуры

{ $Id: arTempUtils.pas,v 1.6 2015/07/02 11:41:00 lukyanets Exp $}

// $Log: arTempUtils.pas,v $
// Revision 1.6  2015/07/02 11:41:00  lukyanets
// ќписываем словари
//
// Revision 1.5  2007/11/26 12:25:58  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.4  2006/03/06 12:32:37  voba
// - научил удал€ть записи CHDATE
//
// Revision 1.1.2.1  2006/02/16 16:00:24  fireton
// - хитра€ процедура заливки дат и номеров
//

interface

procedure tempImportDateNums(aFileName: string);

implementation
uses
 SysUtils,

 l3Base,
 l3Types,
 l3Stream,
 l3Parser,
 l3Date,

 daTypes,

 HT_Const, HT_Dll,
 Dt_ATbl,
 DT_Types,
 DT_Const,
 DT_Doc,
 DT_Link, DT_DICT;

type
 TCHDateFind = record
  //ID      : Longint;
  Date    : TStDate;
  Typ     : TDNType;
 end;

procedure tempImportDateNums(aFileName: string);
var
 l_Stream: Tl3FileStream;
 l_Parser: Tl3Parser;
 l_Number, l_Date: string;
 l_LineNum: Integer;
 l_NumberValue: Integer;
 l_DateValue: TDateTime;
 l_DateOK: Boolean;
 l_DocID: Integer;
 l_DNRec: TDNDictRec;
 l_CHDateFind : TCHDateFind;
 l_FindDictRec : Sab;
 l_DictIDs     : Sab;
 l_FindLinkRec : Sab;
 l_ResSab      : Sab;
 l_AbsNumFld   : Smallint;
 l_AbsNum       : Longint;
begin
 l_Stream := Tl3FileStream.Create(aFileName, l3_fmRead);
 try
  l_Parser := Tl3Parser.Make(l_Stream, [], ['!'..#255], l3_DefaultParserWhiteSpace-[#10,#13]);
  try
   l_Number  := '';
   l_Date    := '';
   l_LineNum := 1;
   try
    DictServer.Family := CurrentFamily;
    DictServer.GroupTbl[da_dlDateNums].StartCaching;
    LinkServer.Family := CurrentFamily;
    LinkServer.Links[da_dlDateNums].StartCaching;
    repeat
     l_Parser.NextTokenSp;
     case l_Parser.TokenType of
      l3_ttSymbol:
       if l_Number = '' then
        l_Number := l_Parser.TokenString
       else
        if l_Date = '' then
         l_Date := l_Parser.TokenString
        else
         l3System.Msg2Log('Ћишние токены в строке '+IntToStr(l_LineNum));
      l3_ttEOL:
       begin
        if (l_Number <> '') and (l_Date <> '') then
        begin
         l_NumberValue := StrToIntDef(l_Number, -1);
         if l_NumberValue < 0 then
          l3System.Msg2Log('Ќеверный номер в строке '+IntToStr(l_LineNum)+' ("'+l_Number+'")')
         else
         begin
          try
           l_DateValue := StrToDateFmt('dd/mm/yyyy', l_Date);
           l_DateOK := True;
          except
           l3System.Msg2Log('Ќеверна€ дата в строке '+IntToStr(l_LineNum)+' ("'+l_Date+'")');
           l_DateOK := False;
          end;
          if l_DateOK then
          begin
           DocumentServer.Family := CurrentFamily;
           l_DocID := DocumentServer.ReNumTbl.ConvertToRealNumber(l_NumberValue);
           if l_DocID > 0 then
           begin
            (* Ёто добавл€ть записи
            FillChar(l_DNRec, SizeOf(l_DNRec), 0);
            with l_DNRec do
            begin
             ID := cUndefDictID;
             Date := DateTimeToStDate(l_DateValue);
             Typ := dnChangerDate;
            end;
            DictServer.GroupTbl[da_dlDateNums].AddData(l_DNRec.ID,PChar(@l_DNRec.ID)+SizeOf(l_DNRec.ID));
            LinkServer.Links[da_dlDateNums].AddNode(l_DocID, l_DNRec.ID);
            *)
            (*Ёто удал€ть записи*)
            FillChar(l_CHDateFind, SizeOf(l_CHDateFind), 0);
            with l_CHDateFind do
            begin
             Date := DateTimeToStDate(l_DateValue);
             Typ := dnChangerDate;
            end;

            if DictServer.GroupTbl[da_dlDateNums].FindByFields([dnDateFld,dnTypFld], l_CHDateFind, l_FindDictRec) then
            try
             LinkServer.Links[da_dlDateNums].GetNodes(l_DocID, l_DictIDs, True);
             try
              DictServer.GroupTbl[da_dlDateNums].RefreshSrchList;
              htTransferToPhoto(l_DictIDs, DictServer.GroupTbl[da_dlDateNums].fSrchList, dtIDFld);
              htRecordsByKey(l_FindLinkRec,l_DictIDs);
             finally
              htClearResults(l_DictIDs);
             end;
             htAndResults(l_ResSab,l_FindDictRec,l_FindLinkRec);
             if (l_ResSab.gFoundCnt = 0) then
              l3System.Msg2Log(SysUtils.Format('запись %s %s не найдена (строка #%d)', [l_Number, l_Date, l_LineNum]))
             else
             if (l_ResSab.gFoundCnt > 1) then
              l3System.Msg2Log(SysUtils.Format('найдено несколько записей %s %s (строка #%d)', [l_Number, l_Date, l_LineNum]))
             else
             begin
              try
               l_AbsNumFld := AbsNumFld;
               htOpenResults(l_ResSab, ROPEN_READ, @l_AbsNumFld, 1);
               try
                htReadResults(l_ResSab,@l_AbsNum,SizeOf(l_AbsNum));
               finally
                htCloseResults(l_ResSab);
               end;
               htOpenResults(l_ResSab, ROPEN_BODY, nil, 0);
               try
                htReadResults(l_ResSab,@l_DNRec,SizeOf(l_DNRec));
               finally
                htCloseResults(l_ResSab);
               end;
              finally
               htClearResults(l_ResSab);
              end;
              DictServer.GroupTbl[da_dlDateNums].DelRec(l_AbsNum);
              LinkServer.Links[da_dlDateNums].DelNode(l_DocID,l_DNRec.ID);
             end;
            finally
             htClearResults(l_ResSab);
             htClearResults(l_FindLinkRec);
             htClearResults(l_FindDictRec);
            end;

            //DictServer.GroupTbl[da_dlDateNums].AddData(l_DNRec.ID,PChar(@l_DNRec.ID)+SizeOf(l_DNRec.ID));
            //LinkServer.Links[da_dlDateNums].AddNode(l_DocID, l_DNRec.ID);
           (**)
           end
           else
            l3System.Msg2Log('¬ базе нет документа с номером '+l_Number+' (строка '+IntToStr(l_LineNum)+')');
          end;
         end;
        end
        else
         l3System.Msg2Log('Ќедостаточно данных в строке '+IntToStr(l_LineNum));
        l_Number := '';
        l_Date := '';
        Inc(l_LineNum);
       end;
     end;
    until l_Parser.TokenType = l3_ttEOF;
   finally
    DictServer.GroupTbl[da_dlDateNums].StopCaching;
    LinkServer.Links[da_dlDateNums].StopCaching;
   end;
  finally
   l3Free(l_Parser);
  end;
 finally
  l3Free(l_Stream);
 end;
end;

end.
