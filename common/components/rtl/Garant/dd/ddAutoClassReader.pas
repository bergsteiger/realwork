//..........................................................................................................................................................................................................................................................
unit ddAutoClassReader;
{ Специальная читалка данных рубрицирования }


{ $Id: ddAutoClassReader.pas,v 1.13 2016/06/16 05:40:04 lukyanets Exp $ }

// $Log: ddAutoClassReader.pas,v $
// Revision 1.13  2016/06/16 05:40:04  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.12  2007/09/28 05:35:51  narry
// - обновление
//
// Revision 1.11  2007/08/14 19:31:52  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.10  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.9  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.8  2004/07/06 10:45:42  narry
// - update
//
// Revision 1.7  2004/06/02 16:24:49  narry
// - update: изменения в иерархии листов
//
// Revision 1.6  2003/07/10 08:15:56  narry
// - update: объединение с основной веткой
//
// Revision 1.5  2003/06/18 13:57:44  narry
// - bug fix: строки, содержащие неполное число параметров вызывают ошибку
//
// Revision 1.4  2003/06/11 09:56:15  narry
// - bug fix: данные добавлялись по внешнему номеру документа
//
// Revision 1.3  2003/06/11 09:07:08  narry
// - update: записи с неправильным идентификатором класса не заливаются
//
// Revision 1.2.2.2  2003/07/08 15:29:20  narry
// - change: ведение списка обработанных топиков
//
// Revision 1.2.2.1  2003/06/24 13:53:20  narry
// - update: объединение с основной веткой
//
// Revision 1.5  2003/06/18 13:57:44  narry
// - bug fix: строки, содержащие неполное число параметров вызывают ошибку
//
// Revision 1.4  2003/06/11 09:56:15  narry
// - bug fix: данные добавлялись по внешнему номеру документа
//
// Revision 1.3  2003/06/11 09:07:08  narry
// - update: записи с неправильным идентификатором класса не заливаются
//
// Revision 1.2  2003/06/03 11:15:20  narry
// - update: расширение функциональности для автоклассификатора
//
// Revision 1.1  2003/05/28 11:53:15  narry
// - чтение файла результатов автоматического рубрицирования
//

interface
Uses
 k2Reader, k2TagGen,
 l3Date, l3Base,
 dt_Types;

type
 TddAutoClassReader = class(Tk2CustomFileParser)
 private
  f_Family: TdaFamilyID;
  FTaskDate: TstDate;
  f_TopicList: Tl3LongintList;
  procedure SetTaskDate(const Value: TstDate);
 protected
  procedure Cleanup; override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner); override;
  procedure Read; override;
  property Family: TdaFamilyID
   read f_Family
   write f_Family;
  property TaskDate: TstDate read FTaskDate write SetTaskDate;
  property TopicList: Tl3LongintList read f_TopicList write f_TopicList;
 end;

const
 aci_AutoSwitch = 0;
 aci_IsLocked   = 1;

implementation

Uses
 dt_Link, dt_Const, dt_Serv,
 l3Parser, l3Bits, 
 SysUtils;

resourcestring
  rsInvalidClassID = 'Неправильный идентификатор класса (%d)';

constructor TddAutoClassReader.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited;
 with Parser do
 begin
  CheckFloat:= False;
  CheckKeyWords := false;
  LineComment  := ';';
  OpenComment  := '';
  CloseComment := '';
  WordChars:= ['0'..'9','-'];
  WhiteSpace:= [','];
 end;
end;

procedure TddAutoClassReader.Cleanup;
begin
 inherited;
end;

procedure TddAutoClassReader.Read;
var
 l_AutoClassLink: TAutoClassesLinkTbl;
 l_Rec: TAutoClassesBodyRec;
 l_DocID: Longint;
 l_Locked, l_AutoSwitch: Byte;
 l_Flags: Word;
 l_AddRec: Boolean;
 l_ParamCount: Integer;
begin
 LinkServer.Family:= Family;
 l_AutoClassLink:= TAutoClassesLinkTbl(LinkServer.Links[dlAutoClasses]);
 if l_AutoClassLink <> nil then
 begin
  l_AutoClassLink.StartCaching;
  try
   while not Filer.EOF do
   begin
    l_ParamCount:= 0;
    Parser.NextTokenSp;
    if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
    begin
     { DocID,BlockID,ClassID,BlockWeight,AutoSwitch,IsLocked
          |    |        |            |         |       \----------- 1 bit l_Rec.Flags
          |    |        |            |         \------------------- 0 bit l_Rec.Flags
          |    |        |            \----------------------------- l_Rec.BlockWeight
          |    |        \------------------------------------------ l_Rec.ClassID
          |    \--------------------------------------------------- l_Rec.SubID
          \-------------------------------------------------------- aDoc
     }
     Inc(l_ParamCount);
     l3FillChar(l_Rec, SizeOf(l_Rec), 0);
     l_Flags:= 0;
     l_DocID:= GlobalHTServer.RenumTbl[Family].ConvertToRealNumber(Parser.TokenInt);
     if f_TopicList <> nil then
      f_TopicList.Add(Longint(l_DocID));
     with l_Rec do
     begin
      Parser.NextTokenSP;
      if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
      begin
       SubID:= Parser.TokenInt;
       Inc(l_ParamCount);
       Parser.NextTokenSP;
       if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
       begin
        if (Parser.TokenInt < 0) or (Parser.TokenInt > High(TDictID)) then
        begin
         l_AddRec:= False;
         l3System.Msg2Log(Format(rsInvalidClassID, [Parser.TokenInt]));
        end
        else
        begin
         ClassID:= Parser.TokenInt;
         l_AddRec:= True;
        end;
        Inc(l_ParamCount);
        if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
        begin
         Parser.NextTokenSP;
         BlockWeight:= Parser.TokenInt;
         Inc(l_ParamCount);
         if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
         begin
          Parser.NextTokenSP;
          l_AutoSwitch:= Parser.TokenInt;
          if l_AutoSwitch = 1 then
           l3SetBit(l_Flags, aci_AutoSwitch);
          Inc(l_ParamCount);
          if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
          begin
           Parser.NextTokenSP;
           l_Locked:= Parser.TokenInt;
           if l_Locked = 1 then
            l3SetBit(l_Flags, aci_IsLocked);
           Flags:= l_Flags;
           Inc(l_ParamCount);
           if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
           begin
            Parser.NextTokenSP;
            Date:= TaskDate;
            Inc(l_ParamCount);
           end;
          end;
         end;
        end;
       end;
      end;
     end; // with l_Rec
     if l_ParamCount <> 7 then
      l3System.Msg2Log('Количество параметров меньше необходимого');
     if l_AddRec and (l_ParamCount = 7) then
      l_AutoClassLink.AddNodeWithExternalInfo(l_DocID, l_Rec);
    end; // Parser.TokenType <> l3_ttEOF
   end; // while
  finally
   l_AutoClassLink.StopCaching;
  end;
 end;
end;

procedure TddAutoClassReader.SetTaskDate(const Value: TstDate);
begin
 FTaskDate := Value;
end;

end.


