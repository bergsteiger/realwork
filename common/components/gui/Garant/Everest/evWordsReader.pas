unit evWordsReader;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evWordsReader - }
{ Начат: 12.04.2002 13:35 }
{ $Id: evWordsReader.pas,v 1.6 2009/08/07 09:28:14 lulin Exp $ }

// $Log: evWordsReader.pas,v $
// Revision 1.6  2009/08/07 09:28:14  lulin
// {RequestLink:159353531}.
//
// Revision 1.5  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.4  2002/05/13 12:32:58  law
// - new behavior: сбор информации о словах с переносами.
//
// Revision 1.3  2002/04/19 12:55:14  law
// - new proc: l3ParseWords.
//
// Revision 1.2  2002/04/15 12:16:50  law
// - new method: AcceptWord.
//
// Revision 1.1  2002/04/12 11:32:43  law
// - new unit: evWordsReader.
//

{$I evDefine.inc }

interface

uses
  Windows,
  
  l3Types,
  l3Base,

  k2PlTxRd
  ;
  
type
  TevWordsReader = class(Tk2CustomPlainTextReader)
    protected
    // internal fields
      f_ConvertBuff : PChar;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure DoText(S: Tl3PrimString);
        override;
        {-}
      procedure DoPara(const aPara : Tl3PCharLen);
        virtual;
        {-}
      function  AcceptWord(var aWord  : Tl3PCharLen;
                           IsLast     : Bool): Bool;
        virtual;
        {-}
      function  DoWord(const aWord : Tl3PCharLen;
                       IsLast      : Bool): Bool;
        overload;
        {-}
      function  DoWord(const aWord : WideString;
                       IsLast      : Bool): Bool;
        overload;
        virtual;
        {-}
  end;//TevWordsReader

implementation

uses
  l3String,
  l3StringEx
  ;

// start class TevWordsReader

procedure TevWordsReader.Cleanup;
  //override;
  {-}
begin
 l3System.FreeLocalMem(f_ConvertBuff);
 inherited;
end;

procedure TevWordsReader.DoText(S: Tl3PrimString);
  //override;
  {-}
begin
 if not S.Empty then
  DoPara(Tl3PCharLen(S.AsWStr));
end;

procedure TevWordsReader.DoPara(const aPara : Tl3PCharLen);
  {-}
begin
 l3ParseWords(aPara, DoWord);
end;

function TevWordsReader.DoWord(const aWord : Tl3PCharLen;
                               IsLast      : Bool): Bool;
  //overload;
  {-}
var
 l_Word   : Tl3PCharLen;
 l_Str    : Tl3Str;
 l_Len    : Long;
 l_String : WideString;
begin
 Result := true;
 l_Word := aWord;
 if AcceptWord(l_Word, IsLast) then begin
  l_Str.Init(Tl3Str(l_Word),
             CP_Unicode,
             @f_ConvertBuff);
  l_String := l_Str.AsWideString;
  l_Len := Length(l_String);
  if (l_Len > 0) then begin
   CharUpperBuffW(PWideChar(l_String), l_Len);
   Result := DoWord(l_String, IsLast);
  end;//l_Len > 0
 end;//AcceptWord..
end;
  
function TevWordsReader.AcceptWord(var aWord : Tl3PCharLen;
                                   IsLast    : Bool): Bool;
  //virtual;
  {-}
begin
 Result := true;
end;

function TevWordsReader.DoWord(const aWord : WideString;
                               IsLast      : Bool): Bool;
  {-}
begin
 Result := true;
end;
  
end.

