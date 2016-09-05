//..........................................................................................................................................................................................................................................................
unit ddAutoClassReader2;
{ Специальная читалка данных рубрицирования }


{ $Id: ddAutoClassReader2.pas,v 1.9 2016/06/16 05:40:04 lukyanets Exp $ }

// $Log: ddAutoClassReader2.pas,v $
// Revision 1.9  2016/06/16 05:40:04  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.8  2015/07/02 11:41:28  lukyanets
// Описываем словари
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
 k2Reader, k2TagGen,
 l3Date, l3Base, l3LongintList,
 dt_Types, classes;

type
 TddAutoClassReader = class(Tk2CustomFileParser)
 private
  f_DocumentList: Tl3LongintList;
  f_Errors: TStrings;
  f_Family: TdaFamilyID;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aOwner: Tk2TagGeneratorOwner); override;
  procedure Read; override;
  property DocumentList: Tl3LongintList
   read f_DocumentList;
  // Список обработанных документов (внутренние номера)
  property Errors: TStrings read f_Errors;
  property Family: TdaFamilyID
   read f_Family
   write f_Family;
 end;

const
 aci_AutoSwitch = 0;
 aci_IsLocked   = 1;

implementation

Uses
 daTypes,
 dt_Link, dt_Const, dt_Serv, dt_Dict,
 l3Parser, l3Bits, l3String,
 SysUtils, Dt_ReNum;

resourcestring
  rsInvalidClassID = 'Неизвестный класс: "%s"';

constructor TddAutoClassReader.Create(aOwner: Tk2TagGeneratorOwner);
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

procedure TddAutoClassReader.Cleanup;
begin
 l3Free(f_DocumentList);
 l3Free(f_Errors);
 inherited;
end;

procedure TddAutoClassReader.Read;
var
 l_Text : Tl3String;
 l_TempDoc, l_Doc, l_Sub: Integer;
 l_Item : TDictID;
begin
 LinkServer.Family:= Family;
 LinkServer.Links[da_dlClasses].StartCaching;
 try
  while not Filer.EOF do
  begin
   { [Имя класса]
     DocID.SubID DocID.SubID...
   }
   l_Text:= Filer.ReadLn.Use;
   try
    if (l_Text.First = '[') and (l_Text.Last = ']') then
    begin
     //l3DeleteChars(l_Text, ['[', ']']);
     l_Text.Delete(0, 1); l_Text.Delete(l_text.Len-1, 1);
     l_Item:= DictServer.Dict[da_dlClasses].FindIdByFullPath(l_Text.St);
     if l_Item <> cUndefDictID then
     begin
      Parser.NextTokenSp;
      while not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) do
      begin
       l_TempDoc:= Parser.TokenInt;
       l_Doc:= GlobalHtServer.RenumTbl[Currentfamily].ConvertToRealNumber(l_TempDoc);
       f_DocumentList.Add(l_Doc);
       Parser.NextTokenSP;
       if Parser.TokenType = l3_ttSingleChar then
        Parser.NextTokenSp;
       if not (Parser.TokenType in [l3_ttEOF, l3_ttEOL]) then
        l_Sub:= Parser.TokenInt;
       if l_Doc <> cUndefDocID then
        LinkServer.AddSubNode(da_dlClasses, l_Doc, l_Sub, l_Item);
       Parser.NextTokenSp;
      end; // while not (Parser.TokenType in [l3_ttEOF, l3_ttEOL])
     end // l_Item <> cUndefDictID
     else
     begin
      l3System.Msg2Log(rsInvalidClassID, [l_text.AsString]);
      f_Errors.Add(l_text.AsString);
      f_Errors.Add(Filer.ReadLn.AsString);
     end;
    end; // if (l_Text.First = '[') and (l_Text.Last = ']')
   finally
    l3Free(l_Text);
   end; // try..finally
  end; // while not Filer.EOF
 finally
  LinkServer.Links[da_dlClasses].StopCaching;
 end; // try..finally
end;

end.


