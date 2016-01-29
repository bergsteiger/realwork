unit ddAlienSpell;
{* Обертка вокруг MS CS API. }

{ Библиотека "DD"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: ddAlienSpell -  }
{ Начат: 08.06.2002 16:29 }
{ $Id: ddAlienSpell.pas,v 1.20 2014/05/27 12:03:57 lulin Exp $ }

// $Log: ddAlienSpell.pas,v $
// Revision 1.20  2014/05/27 12:03:57  lulin
// - чистка кода.
//
// Revision 1.19  2014/04/25 10:28:16  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2014/04/08 14:16:18  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.17  2013/04/17 14:19:22  lulin
// - портируем.
//
// Revision 1.16  2013/01/29 11:25:17  fireton
// - передаём кодировку в проверку орфографии
//
// Revision 1.15  2011/05/18 13:40:50  fireton
// - опция "считать точку разделителем слов при проверке орфографии"
//
// Revision 1.14  2011/05/17 13:56:03  fireton
// - возможность отключения проверки орфографии в коротких словах
//
// Revision 1.13  2008/02/06 11:44:37  lulin
// - список строк переехал в отдельный файл.
//
// Revision 1.12  2007/08/30 19:41:21  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.11  2005/05/24 14:53:14  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.10  2005/04/06 12:37:57  voba
// - bug fix
//
// Revision 1.9  2005/03/28 12:00:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.8  2005/03/11 16:28:58  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.7  2004/06/02 08:33:15  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.6  2004/04/29 16:01:02  law
// - new method: Tl3PCharLen.IsLast.
//
// Revision 1.5  2002/10/29 11:08:03  law
// - new directive: evDualSpell.
//
// Revision 1.4  2002/07/31 15:09:23  law
// - new behavior: сделано обучение спеллера.
//
// Revision 1.3  2002/07/31 14:24:01  law
// - new behavior: пытаемся определять сокращения.
//
// Revision 1.2  2002/07/09 12:12:56  law
// - rename unit: l3UnitsTools -> l3Units.
//
// Revision 1.1  2002/06/28 16:13:33  law
// - new behavior: проверка орфографии при помощи DLL от Информатика.
// - new directive: evAlienSpell.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3StringList,
  l3StringEx,

  k2Interfaces,

  ddSpellInterfaces,
  
  Spellers
  ;

type
  TddSpeller = class(Tl3Base, IddSpeller)
   {* Обертка вокруг MS CS API. }
    private
    // event fields
      f_Filter       : TddFilterWordEvent;
      f_Str          : Tl3Str;
      f_ConvertBuff  : PAnsiChar;
      f_Speller      : TSpellChecker;
      f_Start        : Long;
      f_Finish       : Long;
      f_MinWordLength: Integer;
    protected
    // property methods
      procedure pm_SetFilter(aValue: TddFilterWordEvent);
        {-}
      function pm_GetMinWordLength: Integer;
      procedure pm_SetMinWordLength(const Value: Integer);
        {-}
      function pm_GetDotIsWordSeparator: Boolean;
      procedure pm_SetDotIsWordSeparator(const Value: Boolean);
    protected
    // internal methods
      procedure Release;
        override;
        {-}
      function  CheckWord(const aStr : Tl3PCharLen;
                          aIsLast    : Bool): Bool;
        {-}
    public
    // public methods
      function  CheckSpeller: TSpellChecker;
        {-}
      function  SearchEvent(Sender : Tl3Variant;
                            aString      : Tl3CustomString;
                            aBegPos      : Long;
                            aEndPos      : Long;
                            var aBegRes  : Long;
                            var aEndRes  : Long): Bool;
        {* - проверяет строку. }
      procedure CreateAltvForms(aList : Tl3StringList;
                                aBuff : PAnsiChar;
                                aSize : LongInt;
                                aOemCp: LongBool);
        {* - возвращает список альтернатив. }
      function AddWord(const aStr : Tl3PCharLen): Bool;
        {-}
    public
    // public events
      property Filter : TddFilterWordEvent
        read f_Filter
        write f_Filter;
        {-} 
  end;//TddSpeller

implementation

uses
  l3Chars,
  l3String,
  l3MinMax
  ;

// start class TddSpeller

procedure TddSpeller.Release;
  //override;
  {-}
begin
 l3Free(f_Speller);
 inherited;
 l3System.FreeLocalMem(f_ConvertBuff);
end;

procedure TddSpeller.pm_SetFilter(aValue: TddFilterWordEvent);
  {-}
begin
 f_Filter := aValue;
end;

function TddSpeller.CheckSpeller: TSpellChecker;
  {-}
begin
 if (f_Speller = nil) then begin
  f_Speller := TSpellChecker.Create;
  f_Speller.Language := langRussian;
  f_Speller.Open
   {$IfNDef evUseDefaultSpellcheck}
   ('insp32ml.dll', 'orfo_rus.lex')
   {$EndIf  evUseDefaultSpellcheck}
   ;
 end;//f_Speller = nil
 Result := f_Speller;
end;

function TddSpeller.CheckWord(const aStr : Tl3PCharLen;
                              aIsLast    : Bool): Bool;
  {-}
begin
 Result := true;
 CheckSpeller;
 with aStr do begin
  if (f_MinWordLength > 0) and (SLen < f_MinWordLength) then
   Exit;

  if l3AllCharsInCharSet(S, SLen, cc_ANSIEnglish) then begin
   if (f_Speller.Language <> langEnglishUS) then begin
    f_Speller.Close;
    f_Speller.Language := langEnglishUS;
    f_Speller.Open
     {$IfNDef evUseDefaultSpellcheck}
     ('insp32ml.dll', 'orfo_eng.lex')
     {$EndIf  evUseDefaultSpellcheck}
     ;
   end;//f_Speller.Language <> langEnglishUS
  end else begin
   if (f_Speller.Language <> langRussian) then begin
    f_Speller.Close;
    f_Speller.Language := langRussian;
    f_Speller.Open
     {$IfNDef evUseDefaultSpellcheck}
     ('insp32ml.dll', 'orfo_rus.lex')
     {$EndIf  evUseDefaultSpellcheck}
     ;
   end;//f_Speller.Language <> langRussian
  end;//l3AllCharsInCharSet(S, SLen, cc_ANSIEnglish
  if not f_Speller.IsKnownWord(S, SLen, not aIsLast AND (S[SLen] = cc_Dot)) then begin
   if not Assigned(f_Filter) OR not f_Filter(aStr) then begin
    Result := false;
    f_Start := S - f_Str.S;
    f_Finish := f_Start + SLen;
   end;//not Assigned(f_Filter)
  end;//not f_Speller.IsKnownWord
 end;//with aStr 
end;

function TddSpeller.AddWord(const aStr : Tl3PCharLen): Bool;
  {-}
begin
 CheckSpeller;
 with aStr do
  Result := f_Speller.AddWord(S, SLen);
end;
  
function TddSpeller.SearchEvent(Sender : Tl3Variant;
                                aString      : Tl3CustomString;
                                aBegPos      : Long;
                                aEndPos      : Long;
                                var aBegRes  : Long;
                                var aEndRes  : Long): Bool;
  {* - проверяет строку. }
begin
 Result := false;
 if not aString.Empty AND (aBegPos < aEndPos) then begin
  with aString do
   f_Str.Init(Tl3Str(l3PCharLen(St + aBegPos, Min(aEndPos - aBegPos, Len - aBegPos), CodePage)),
              CP_ANSI, @f_ConvertBuff);
  f_Start := -1;
  l3ParseWords(f_Str, CheckWord);
  if (f_Start >= 0) then begin
   Result := true;
   aBegRes := aBegPos + f_Start;
   aEndRes := aBegPos + f_Finish;
  end;//f_Start >= 0
 end;//not aString.Empty
end;

procedure TddSpeller.CreateAltvForms(aList : Tl3StringList;
                                     aBuff : PAnsiChar;
                                     aSize : LongInt;
                                     aOemCp: LongBool);
  {* - возвращает список альтернатив. }
begin
 aList.Count := 0;
 CheckSpeller;
 f_Speller.GetVariants(aBuff, aSize, aList);
end;

function TddSpeller.pm_GetDotIsWordSeparator: Boolean;
begin
 Result := False;
end;

function TddSpeller.pm_GetMinWordLength: Integer;
begin
 Result := f_MinWordLength;
end;

procedure TddSpeller.pm_SetDotIsWordSeparator(const Value: Boolean);
begin
 Assert(False, 'TddSpeller.pm_SetDotIsWordSeparator not implemented!');
end;

procedure TddSpeller.pm_SetMinWordLength(const Value: Integer);
begin
 f_MinWordLength := Value;
end;

end.

