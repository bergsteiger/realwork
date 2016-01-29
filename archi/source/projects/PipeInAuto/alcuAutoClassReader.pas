//..........................................................................................................................................................................................................................................................
unit alcuAutoClassReader;
{ Специальная читалка данных рубрицирования }


{ $Id: alcuAutoClassReader.pas,v 1.8 2015/07/02 07:34:38 lukyanets Exp $ }

// $Log: alcuAutoClassReader.pas,v $
// Revision 1.8  2015/07/02 07:34:38  lukyanets
// Описываем словари
//
// Revision 1.7  2010/09/24 12:41:07  voba
// - k : 235046326
//
// Revision 1.6  2010/09/21 11:20:17  fireton
// - переводим деревья с PChar на Tl3WString
//
// Revision 1.5  2010/02/25 06:38:10  narry
// - удаление зависимости проектов от парня
// - выключение обработки очереди заданий на время еженедельного обновления
//
// Revision 1.4  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.3  2009/06/24 13:12:59  narry
// - переделки под новый LinkServer
//
// Revision 1.2  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.1  2009/01/23 16:19:11  narry
// - дополенение механизма АК простановкой команды DOC
//
// Revision 1.7  2008/07/12 12:35:19  fireton
// - рефакторинг DT_Dict
//
// Revision 1.6  2008/04/23 07:26:36  narry
// - не компилировалось
//
// Revision 1.5  2008/02/19 16:01:38  narry
// - не компилировалось
//
// Revision 1.4  2008/02/01 13:31:13  narry
// - терялась информация
//
// Revision 1.3  2008/01/31 13:01:16  narry
// - обновление
//
// Revision 1.2  2008/01/30 09:17:51  narry
// - накапливаем номера документов
//
// Revision 1.1  2007/12/06 11:29:21  narry
// - поддержка автоклассификации
//

interface
Uses
 Classes,
 k2Reader, k2TagGen,
 l3Date, l3Base, l3LongintList,
 dt_Types, dt_AttrSchema;

type
 TalcuClassifiedReader = class(Tk2CustomFileParser)
 private
  f_DocumentList: Tl3LongintList;
  f_Errors: TStrings;
  f_Family: TFamilyID;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner); override;
  procedure Read; override;
  property DocumentList: Tl3LongintList
   read f_DocumentList;
  // Список обработанных документов (внутренние номера)
  property Errors: TStrings read f_Errors;
  property Family: TFamilyID
   read f_Family
   write f_Family;
 end;

 TalcuNotClassifiedReader = class(Tk2CustomFileParser)
 private
  f_DocumentList: Tl3LongintList;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner); override;
  procedure Read; override;
  property DocumentList: Tl3LongintList read f_DocumentList write f_DocumentList;
 end;

const
 aci_AutoSwitch = 0;
 aci_IsLocked   = 1;

implementation

Uses
 daTypes,
 dt_Link, dt_Const, dt_Serv, dt_Dict,
 l3Parser, l3Bits, l3String,
 SysUtils, Dt_ReNum, dt_DictConst, dt_LinkServ, l3Interfaces;

resourcestring
  rsInvalidClassID = 'Неизвестный класс: "%s"';
  rsNotClassified   = 'Not autoclassified';

constructor TalcuClassifiedReader.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited;
 f_Errors:= TStringList.Create;
 with Parser do
 begin
  CheckFloat:= False;
  CheckKeyWords := false;
  LineComment  := ';';
  OpenComment  := '';
  CloseComment := '';
  WordChars:= ['0'..'9'];
  WhiteSpace:= [' '];
 end;
 f_DocumentList := Tl3LongintList.MakeSorted;
end;

procedure TalcuClassifiedReader.Cleanup;
begin
 l3Free(f_DocumentList);
 l3Free(f_Errors);
 inherited;
end;

procedure TalcuClassifiedReader.Read;
var
 l_Text : Tl3String;
 l_TempDoc, l_Doc, l_Sub: Integer;
 l_Item : TDictID;
begin
 LinkServer(Family)[atClasses].Table.StartCaching;
 try
  f_DocumentList.Clear;
  l_Text:= Tl3String.Make(Filer.Codepage);
  try
   while not Filer.EOF do
   begin
    { [Имя класса]
      DocID.SubID DocID.SubID...
    }
    l_Text.Clear;
    l_Text.Append(Filer.Readln);
     if (l_Text.First = '[') and (l_Text.Last = ']') then
     begin
      //l3DeleteChars(l_Text, ['[', ']']);
      l_Text.Delete(0, 1); l_Text.Delete(l_text.Len-1, 1);
      l_Item:= DictServer(Family).Dict[da_dlClasses].FindIdByFullPath(l_Text.AsWStr);
      if l_Item <> cUndefDictID then
      begin
       Parser.NextTokenSp;
       while not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) do
       begin
        l_TempDoc:= Parser.TokenInt;
        l_Doc:= LinkServer(CurrentFamily).ReNum.ConvertToRealNumber(l_TempDoc);
        f_DocumentList.Add(l_Doc);
        Parser.NextTokenSP;
        if Parser.TokenType = l3_ttSingleChar then
         Parser.NextTokenSp;
        if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
         l_Sub:= Parser.TokenInt;
        if l_Doc <> cUndefDocID then
         LinkServer(Family).AddSubNode(atClasses, l_Doc, l_Sub, l_Item);
        Parser.NextTokenSp;
       end; // while not (Parser.TokenType in [l3_ttEOF, l3_ttEOL])
      end // l_Item <> cUndefDictID
      else
      begin
       l3System.Msg2Log(rsInvalidClassID, [l_text.AsString]);
       f_Errors.Add(l_text.AsString);
       //f_Errors.Add(Filer.ReadLn.AsString);
      end;
     end; // if (l_Text.First = '[') and (l_Text.Last = ']')
   end; // while not Filer.EOF
  finally
   l3Free(l_Text);
  end;
 finally
  LinkServer(Family)[atClasses].Table.StopCaching;
 end; // try..finally
end;

constructor TalcuNotClassifiedReader.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited;
 with Parser do
 begin
  CheckFloat:= False;
  CheckKeyWords := false;
  LineComment  := ';';
  OpenComment  := '';
  CloseComment := '';
  WordChars:= ['0'..'9'];
  WhiteSpace:= [' '];
 end;
 f_DocumentList := Tl3LongintList.MakeSorted;
end;

procedure TalcuNotClassifiedReader.Cleanup;
begin
 l3Free(f_DocumentList);
 inherited;
end;

procedure TalcuNotClassifiedReader.Read;
var
 l_Text : Tl3String;
 l_TempDoc, l_Doc, l_Sub: Integer;
 l_Item : TDictID;
begin
 l_Text:= Tl3String.Make(Filer.CodePage);
 try
  while not Filer.EOF do
  begin
   { rsNotClassified
     DocID DocID...
   }
   l_Text.Clear;
   l_Text.Append(Filer.ReadLn);
    if AnsiCompareText(l_Text.AsString, rsNotClassified) = 0 then
    begin
     //l3DeleteChars(l_Text, ['[', ']']);
      Parser.NextTokenSp;
      while not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) do
      begin
       l_TempDoc:= Parser.TokenInt;
       l_Doc:= LinkServer(CurrentFamily).ReNum.ConvertToRealNumber(l_TempDoc);
       f_DocumentList.Add(l_Doc);
       Parser.NextTokenSP;
      end; // while not (Parser.TokenType in [l3_ttEOF, l3_ttEOL])
    end; // if AnsiCompareText(l_Text.AsString, rsNotClassified) = 0
  end; // while not Filer.EOF
 finally
  l3Free(l_Text);
 end;
end;

end.


