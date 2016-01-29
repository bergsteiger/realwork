unit dt_ImageLoader;
{ Более универсальный объект для подключения образов }

{ $Id: dt_ImageLoader.pas,v 1.1 2011/03/23 11:59:55 narry Exp $ }
// $Log: dt_ImageLoader.pas,v $
// Revision 1.1  2011/03/23 11:59:55  narry
// K254352041. Цеплять исходный rtf или doc к судебной практике в виде образа
//

interface

uses
 Controls, StdCtrls, ComCtrls, Forms, Classes,
 l3Base,
 Dt_Types, Dt_Link, Dt_DocImages;

type
 TdtImageLoader = class(Tl3Base)
 private
  f_ByMail: Boolean;
  f_DocSourceId: TDictId;
  f_DocSourceId2: TDictId;
  f_SrcFile: string;
  f_Terminated: Boolean;
  function CheckFiles: Boolean;
  procedure ProcessSrcFile;
 protected
  procedure CleanUp; override;
 public
  constructor Create;
  procedure Execute(const aFileName: String; aDocSource, aDocSource2: Integer; aByMail: Boolean);
  procedure Terminate;
 end;

implementation

uses
 Dialogs, SysUtils,
 Dt_Doc,
 Dt_Log,
 dt_Renum,
 DT_Serv,
 DT_Const,
 DT_Err,
 Dt_LinkServ,
 l3Types,
 l3Chars,
 l3Date,
 l3DateSt,
 l3String,
 l3Stream,
 l3Parser, l3Filer;

{ TdtImageLoader }

function TdtImageLoader.CheckFiles: Boolean;
begin
 Result := False;
 f_SrcFile := Trim(f_SrcFile);
 if f_SrcFile = '' then
  l3System.Msg2Log('Файл с описаниями образов не указан.')
 else
 if not FileExists(f_SrcFile) then
  l3System.Msg2Log('Файл с описаниями образов %s не найден.', [f_SrcFile])
 else
  Result := True;
end;

procedure TdtImageLoader.CleanUp;
begin
 inherited;
end;

constructor TdtImageLoader.Create;
begin
 inherited Create;
 f_ByMail := False;
 f_DocSourceId := 0; // по умолчанию
 f_DocSourceId2 := 0; // по умолчанию
 DocumentServer.Family := CurrentFamily;
end;

procedure TdtImageLoader.Execute(const aFileName: String; aDocSource, aDocSource2: Integer;
    aByMail: Boolean);
begin
 f_SrcFile:= aFileName;
 f_ByMail:= aByMail;
 f_DocSourceID:= aDocSource;
 f_DocSourceID2:= aDocSource2;
 if CheckFiles then
   ProcessSrcFile;
end;

procedure TdtImageLoader.Terminate;
begin
 f_Terminated := True;
 l3System.Msg2Log('Процесс прерван с сервера приложений');
end;

procedure TdtImageLoader.ProcessSrcFile;
const
 c_Delim = #9;
var
 I: Integer;
 l_ProcessedAmount: Integer;
 l_SrcStream: Tl3FileStream;
 l_Parser   : Tl3Parser;
 l_ImageFile: string;
 l_Pages    : string;
 l_DocId: TDocId;
 l_IssueNum: string;
 l_StartDate, l_EndDate: TStDate;
 l_DelimPos: Integer;
 l_FieldNum: Integer;
 l_LineNum: Integer;
 l_BadRecords: Integer;
 l_Log: TLogBookTbl;
 l_TmpStr: string;

 procedure ClearFields();
 begin
  l_ImageFile := '';
  l_DocId := 0;
  l_Pages := '';
  l_FieldNum := 0;
  l_IssueNum := '';
  l_StartDate := 0;
  l_EndDate := 0;
 end;

 procedure BadRecord(const aStr: string);
 begin
  Inc(l_BadRecords);
  Inc(l_ProcessedAmount);
  l3System.Msg2Log(aStr);
 end;

begin
 try
  f_Terminated := False;
  l3System.Msg2Log('Начало процесса обработки. Исходный файл: %s', [f_SrcFile]);
  l_Log := LinkServer(CurrentFamily).LogBook; //Attribute[atLogRecords];
  l_Log.Table.StartCaching;
  try
   l_SrcStream := Tl3FileStream.Create(f_SrcFile, l3_fmRead);
   try
    //LinkServer.Family := CurrentFamily;
    DocImageServer.StartBatch;
    try

     l_ProcessedAmount := 0;
     l_BadRecords := 0;
     l_Parser := Tl3Parser.Make(l_SrcStream, [], [#32..#255], [cc_Tab]);
     try
      ClearFields;
      l_LineNum := 0;
      repeat
       l_Parser.NextTokenSp;
       case l_Parser.TokenType of
        l3_ttSymbol:
         begin
          Inc(l_FieldNum);
          case l_FieldNum of
           1 : l_ImageFile := l3OEM2ANSI(Trim(l_Parser.TokenString));
           2 : l_DocId := StrToIntDef(l_Parser.TokenString, -1);
           3 : l_Pages := Trim(l_Parser.TokenString);
           4 : l_IssueNum := l_Parser.TokenString;
           5 : l3StrToDateInterval(l_Parser.TokenString, l_StartDate, l_EndDate);
          end;
         end;
        l3_ttEOL, l3_ttEOF:
         begin
          Inc(l_LineNum);
          if l_FieldNum > 1 then
          begin
           if l_DocId > -1 then
           begin
            l_DocId := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_DocId);

            if DocumentServer.FileTbl.HasUniqRec(l_DocId) then
            begin
             // Если имя файла пустое, то файл образа копировать не надо, он уже есть.
             // Надо просто добавить запись.
             if (l_ImageFile = '.') or FileExists(l_ImageFile) then
             begin
              try
               if l_ImageFile = '.' then
                l_ImageFile := '';
               DocImageServer.Add(l_DocId, l_ImageFile, [f_DocSourceId, f_DocSourceId2], l_Pages,
                    l_IssueNum, l_StartDate, l_EndDate, True, f_ByMail);
               l_Log.PutLogRec(l_DocId, acPublInWork);
               Inc(l_ProcessedAmount);
              except
               on E: Exception do
                BadRecord(Format('Ошибка (строка %d): ', [l_LineNum]) + E.Message);
              end;
             end
             else
              BadRecord(Format('Ошибка (строка %d): файл образа (%s) не найден', [l_LineNum, l_ImageFile]));
            end
            else
             BadRecord(Format('Ошибка (строка %d): неверный номер документа', [l_LineNum]));
           end
           else
            BadRecord(Format('Ошибка (строка %d): номер документа не является числом', [l_LineNum]));
          end
          else
           if l_FieldNum > 0 then // пустые строки пропускаем
            BadRecord(Format('Ошибка (строка %d): не указан номер документа', [l_LineNum]));
          ClearFields;
         end;
       end;
      until f_Terminated or (l_Parser.TokenType = l3_ttEOF);
     finally
      l3Free(l_Parser);
      l3System.Msg2Log('Всего обработано %d документов.  Из них отвергнуто %d.', [l_ProcessedAmount, l_BadRecords]);
     end;
    finally
     DocImageServer.StopBatch;
    end;
   finally
    FreeAndNil(l_SrcStream);
   end;
  finally
   l_Log.Table.StopCaching;
  end;
 except
  // ловим ошибку о дубликатах (чтобы она не валилась в лог)
  on E: EHtErrors do
   if E.ErrorValue <> -25 then
    raise;
  else
   raise;
 end;
end;

end.

