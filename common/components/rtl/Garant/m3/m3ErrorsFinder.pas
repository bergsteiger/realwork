unit m3ErrorsFinder;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3ErrorsFinder - }
{ Начат: 11.04.2002 19:12 }
{ $Id: m3ErrorsFinder.pas,v 1.6 2013/04/12 16:25:08 lulin Exp $ }

// $Log: m3ErrorsFinder.pas,v $
// Revision 1.6  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.5  2010/11/30 11:47:20  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.4  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.3  2005/04/19 15:41:54  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.2  2004/09/21 11:22:27  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.19  2004/06/02 14:45:56  law
// - rename method: Tk2BaseStackGenerator.Atom2String -> VariantAsString.
// - сделан фильтр для сбора информации о документах со строками в кодировке _1252.
//
// Revision 1.18  2004/05/07 16:15:59  law
// - bug fix: поправлены имена методов.
//
// Revision 1.17  2002/11/21 17:15:55  law
// - new unit: m3OldBaseTools.
//
// Revision 1.16  2002/09/03 08:22:17  law
// - new behavior: нормализация с отбрасыванием частицы НЕ.
//
// Revision 1.15  2002/07/31 10:17:03  law
// - bug fix: "слеплялись" строки.
//
// Revision 1.14  2002/07/30 12:05:55  law
// - change: сделана возможность поиска ошибок по пользовательскому словарю.
//
// Revision 1.13  2002/07/18 16:28:23  law
// no message
//
// Revision 1.12  2002/05/27 12:06:27  law
// - new behavior: сокращения записываем в отдельный log-файл.
//
// Revision 1.11  2002/05/23 13:13:54  law
// - new behavior: изменил логику отыскания ошибок по просьбе Вована. Теперь еще сортируем по стилю параграфов.
//
// Revision 1.10  2002/05/14 08:37:33  law
// - new methods: Tl3VList: LoadFromStream, LoadFromFile, SaveToStream, SaveToFile.
//
// Revision 1.9  2002/05/13 13:46:08  law
// - new behavior: сделано отсечение английских слов с переносами.
//
// Revision 1.8  2002/05/13 12:32:56  law
// - new behavior: сбор информации о словах с переносами.
//
// Revision 1.7  2002/04/17 11:55:55  law
// - cleanup.
//
// Revision 1.6  2002/04/17 08:21:13  law
// - new behavior: менеджеры памяти теперь инициализируются при создании хеша.
//
// Revision 1.5  2002/04/16 15:04:34  law
// - new flag: Cm0LNGLibCheckDashes.
//
// Revision 1.4  2002/04/15 14:28:19  law
// - new behavior: изменен вид отчетов.
//
// Revision 1.3  2002/04/15 12:21:23  law
// - new behavior: сделан вывод кучи различной статистики.
//
// Revision 1.2  2002/04/12 11:31:47  law
// - new behavior: сделан разбор потока на слова.
//
// Revision 1.1  2002/04/11 15:15:10  law
// - new unit: m3ErrorsFinder.
//
// Revision 1.2  2002/02/21 15:58:16  law
// - optimization.
//
// Revision 1.1  2002/02/20 12:42:35  law
// - new units: первая реализация индексации документов.
//

{$I m3Define.inc}

interface

uses
  l3Types,
  l3Base,
  l3Filer,
  l3InternalInterfaces,

  k2Types,
  k2TagGen,

  m3Morph,
  m3IdxCla,

  evWordsReader
  ;

type
  Tm3ErrorsFlag = (m3_efMixed, m3_efMixedNum, m3_efAlternate, m3_efPseudo,
                   m3_efHyphen);
  Tm3ErrorsFlags = set of Tm3ErrorsFlag;

  Tm3ErrorsFinder = class(TevWordsReader, Il3DocIDSource)
    private
    // internal fields
      f_Hash         : Tm3Hash;
      f_Norm         : Tm3MorphNormalizater;
      f_Filer        : Tl3DOSFiler;
      f_AlternateOEM : Tl3DOSFiler;
      f_MixedFiler   : Tl3CustomFiler;
      f_NumFiler     : Tl3CustomFiler;
      f_PseudoFiler  : Tl3CustomFiler;
      f_PseudoPreformattedFiler : Tl3CustomFiler;
      f_Preformatted : Bool;
      f_Comment      : Bool;
      f_DocID        : Long;
      f_Flags        : Tm3ErrorsFlags;
      f_Hyphen       : Tl3PVList;
      f_Dash         : Tl3PVList;
      f_HyphenOEM    : Tl3PVList;
      f_Abbr         : Tl3PVList;
      f_Dict         : Tl3PVlist;
      f_UseDict      : Bool;
//      f_ParaNum      : Int64;
    protected
    // property methods
      procedure pm_SetFlags(aValue: Tm3ErrorsFlags);
        {-}
      function  pm_GetDocID: Long;
      procedure pm_SetDocID(aValue: Long);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      function  DoWord(const aWord : WideString;
                       IsLast      : Bool): Bool;
        override;
        {-}
      procedure DoPara(const aPara : Tl3PCharLen);
        override;
        {-}
      function  AcceptWord(var aWord : Tl3PCharLen;
                           IsLast    : Bool): Bool;
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      procedure AddAtom(AtomIndex: Long; TK: Tk2TypeKind; const Value);
        override;
        {-}
    public
    // public properties
      property DocID: Long
        read f_DocID
        write f_DocID;
        {-}
      property Flags: Tm3ErrorsFlags
        read f_Flags
        write pm_SetFlags;
        {-}
      property UseDict: Bool
        read f_UseDict
        write f_UseDict;
        {-}          
  end;//Tm3ErrorsFinder

  Tm3ErrorHandle = class(Tm3BranchHandle)
    private
    // internal fields
      f_Flags : Tm3SearchWordFlags;
    public
    // public properties
      property Flags: Tm3SearchWordFlags
        read f_Flags
        write f_Flags;
        {-}  
  end;//Tm3ErrorHandle

implementation

uses
  SysUtils,
  {$IfNDef l3ConsoleApp}
  Forms,
  {$EndIf l3ConsoleApp}
  
  l3Chars,
  l3SimpleMM,
  l3String,

  m0LngLib,
  m0ExcLib,

  m2XltLib,

  k2Tags,

  evStyles
  ;

// start class Tm3ErrorsFinder

constructor Tm3ErrorsFinder.Create(anOwner: Tk2TagGeneratorOwner = nil);
  //override;
  {-}
begin
 inherited;
 f_Hash := Tm3Hash.Create(Tm3ErrorHandle);
 f_Filer := Tl3DOSFiler.Make('alternate.log', l3_fmWrite);
 f_Filer.Open;
 f_AlternateOEM := Tl3DOSFiler.Make('alternateOEM.log', l3_fmWrite);
 f_AlternateOEM.Open;
 f_MixedFiler := Tl3DOSFiler.Make('mixed.log', l3_fmWrite);
 f_MixedFiler.Open;
 f_NumFiler := Tl3DOSFiler.Make('mixed_num.log', l3_fmWrite);
 f_NumFiler.Open;
 f_PseudoFiler := Tl3DOSFiler.Make('pseudo.log', l3_fmWrite);
 f_PseudoFiler.Open;
 f_PseudoPreformattedFiler := Tl3DOSFiler.Make('pseudoOEM.log', l3_fmWrite);
 f_PseudoPreformattedFiler.Open;
 Flags := [Low(Tm3ErrorsFlag)..High(Tm3ErrorsFlag)];
 f_Hyphen := Tl3StringList.MakeSorted(l3_dupIgnore, l3_siCaseUnsensitive);
 f_Dash := Tl3StringList.MakeSorted(l3_dupIgnore, l3_siCaseUnsensitive);
 f_HyphenOEM := Tl3StringList.MakeSorted(l3_dupIgnore, l3_siCaseUnsensitive);
 f_Abbr := Tl3StringList.MakeSorted(l3_dupIgnore, l3_siCaseUnsensitive);
 f_Dict := Tl3StringList.MakeSorted(l3_dupIgnore, l3_siCaseUnsensitive);
 f_Dict.LoadFromFile('user.dict');
end;

procedure Tm3ErrorsFinder.pm_SetFlags(aValue: Tm3ErrorsFlags);
  {-}
var
 l_Flags : Cardinal;
begin
 if (f_Flags <> aValue) then begin
  f_Flags := aValue;
  l3Free(f_Norm);
  l_Flags := Cm0LNGLibFlagORIG_FORM or
             Cm0LNGLibFlagNORM_FORM or
             Cm0LNGLibFlagUSET_FORM;
  if (m3_efAlternate in Flags) then
   l_Flags := l_Flags or
              Cm0LNGLibFlagALTV_FORM or
              Cm0LNGLibCheckSpaces or
              Cm0LNGLibCheckDashes;

  if (m3_efPseudo in Flags) then
   l_Flags := l_Flags or
              Cm0LNGLibFlagUPNF_FORM;

  f_Norm := Tm3MorphNormalizater.Create(l_Flags);
 end;//f_Flags
end;

function Tm3ErrorsFinder.pm_GetDocID: Long;
  {-}
begin
 Result := f_DocID;
end;

procedure Tm3ErrorsFinder.pm_SetDocID(aValue: Long);
  {-}
begin
 f_DocID := aValue;
end;

procedure Tm3ErrorsFinder.Cleanup;
  //override;
  {-}

begin
// f_Filer.WriteLn(IntToStr(f_ParaNum));
 l3Free(f_Hash);
 l3Free(f_Norm);
 f_MixedFiler.Close;
 l3Free(f_MixedFiler);
 f_NumFiler.Close;
 l3Free(f_NumFiler);
 f_PseudoFiler.Close;
 l3Free(f_PseudoFiler);
 f_PseudoPreformattedFiler.Close;
 l3Free(f_PseudoPreformattedFiler);
 f_Filer.Close;
 l3Free(f_Filer);
 f_AlternateOEM.Close;
 l3Free(f_AlternateOEM);
 f_Hyphen.SaveToFile('hyphen.log');
 f_Dash.SaveToFile('dash.log');
 f_HyphenOEM.SaveToFile('hyphenOEM.log');
 l3Free(f_HyphenOEM);
 l3Free(f_Dash);
 l3Free(f_Hyphen);
 f_Abbr.SaveToFile('abbr.log');
 l3Free(f_Abbr);
 l3Free(f_Dict);
 inherited;
end;

function Tm3ErrorsFinder.DoWord(const aWord : WideString;
                                IsLast      : Bool): Bool;
  //override;
  {-}
var
 l_Word  : Tm3BranchHandlePrim;

 procedure _Write(aFiler: Tl3CustomFiler);
 var
  l_Index : Long;
 begin
  aFiler.Write(IntToStr(DocID) + cc_Tab);
  aFiler.Write(aWord + cc_Tab);
  if (Length(aWord) < 8) then
   aFiler.Write(cc_Tab);
  if (Length(aWord) < 16) then
   aFiler.Write(cc_Tab);
  if (l_Word Is Tm3BranchHandle) then begin
   with Tm3BranchHandle(l_Word) do begin
     for l_Index := 0 to Pred(g_NormalFormsManager.ItemLength(NormalForms)) do begin
      with Pm3BranchHandlePrim(PAnsiChar(NormalForms) +
                               l_Index * SizeOf(Tm3BranchHandlePrim))^.Data do
      aFiler.Write('"' + g_WideStringManager.StringAsWideString(Value) + '"' + ' ');
     end;//for l_Index
   end//with Tm3BranchHandle(aWord)
  end;//l_Word Is Tm3BranchHandle
  aFiler.OutEOL;
 end;

var
 l_Flags : Tm3SearchWordFlags;
 l_Index : Long;
begin
 Result := true;
 if UseDict then begin
  if f_Comment then begin
   {$IfNDef l3ConsoleApp}
   afw.ProcessMessages;
   {$EndIf l3ConsoleApp}
   if f_Dict.Find(l3PCharLen(aWord), l_Index) then begin
    f_Filer.Write(IntToStr(DocID) + cc_Tab);
    f_Filer.WriteLn(aWord);
   end;//f_Dict.Find
  end;//f_Comment 
 end else if (Flags * [m3_efAlternate, m3_efPseudo] <> []) then begin
  try
   l_Word := f_Hash.SearchBranchHandle(aWord, f_Norm, @l_Flags);
  except
   on E: Exception do begin
    Gm0EXCLibDefSrv.SaveException(E);
    Gm0EXCLibDefSrv.SaveString(aWord + ' ' + IntToStr(DocID) + #13#10);
    Exit;
   end;//on E: Exception
  end;//try..except
  if (m3_swfError in l_Flags) then
   Gm0EXCLibDefSrv.SaveString('Document : ' + IntToStr(DocID) + #13#10);
  if (m3_swfNew in l_Flags) then begin
   if (m3_swfAlternate in l_Flags) then begin
    if f_Preformatted then
     _Write(f_AlternateOEM)
    else
     _Write(f_Filer);
    {$IfNDef l3ConsoleApp}
    afw.ProcessMessages;
    {$EndIf l3ConsoleApp}
   end;//m3_swfAlternate in l_Flags
   if (m3_swfPseudo in l_Flags) then
    if f_Preformatted then
     _Write(f_PseudoPreformattedFiler)
    else
     _Write(f_PseudoFiler);
   if (l_Word Is Tm3ErrorHandle) then
    Tm3ErrorHandle(l_Word).Flags := l_Flags;
   //m3_swfNew in l_Flags
  end else begin
   if (l_Word Is Tm3ErrorHandle) then begin
    if (m3_swfAlternate in Tm3ErrorHandle(l_Word).Flags) then begin
     if f_Preformatted then
      _Write(f_AlternateOEM)
     else
      _Write(f_Filer);
     {$IfNDef l3ConsoleApp}
     afw.ProcessMessages;
     {$EndIf l3ConsoleApp}
    end;//m3_swfAlternate in l_Flags
   end;//l_Word Is Tm3ErrorHandle
  end;//m3_swfNew in l_Flags
 end;//Flags * [m3_efAlternate, m3_efPseudo] <> []
end;

function Tm3ErrorsFinder.AcceptWord(var aWord : Tl3PCharLen;
                                    IsLast    : Bool): Bool;
  //override;
  {-}

 procedure _Write(aFiler: Tl3CustomFiler);
 begin
  aFiler.WriteLn(IntToStr(DocID) + cc_Tab + l3PCharLen2String(aWord, CP_ANSI, @f_ConvertBuff));
 end;

 procedure WriteMixed;
 begin
  Result := false;
  if (m3_efMixed in Flags) then
  _Write(f_MixedFiler);
 end;

 procedure WriteMixedNum;
 begin
  Result := false;
  if (m3_efMixedNum in Flags) then
   _Write(f_NumFiler);
 end;

begin
 Result := (aWord.SLen > 3) AND
           not l3AllCharsInCharSet(aWord.S, aWord.SLen, cc_Digits);
 if Result then begin
  if (aWord.SCodePage = CP_OEM) OR (aWord.SCodePage = CP_OEMLite) then begin
   m2XLTConvertBuff(aWord.S, aWord.SLen, Cm2XLTOem2Ansi);
   aWord.SCodePage := CP_ANSI;
  end;//aWord.SCodePage = CP_OEM
  if (aWord.S^ in cc_ANSIRussian) then begin
   if l3CharSetPresent(aWord.S + 1, aWord.SLen - 1, cc_ANSIEnglish) then
    WriteMixed
   else if l3CharSetPresent(aWord.S + 1, aWord.SLen - 1, cc_Digits) then
    WriteMixedNum;
  end else if (aWord.S^ in cc_ANSIEnglish) then begin
   if l3CharSetPresent(aWord.S + 1, aWord.SLen - 1, cc_ANSIRussian) then
    WriteMixed
   else if l3CharSetPresent(aWord.S + 1, aWord.SLen - 1, cc_Digits) then
    WriteMixedNum;
  end else if (aWord.S^ in cc_Digits) then begin
   if l3CharSetPresent(aWord.S + 1, aWord.SLen - 1, cc_ANSILetter) then
    WriteMixedNum;
  end;//aWord.S^ in cc_ANSIRussian
  if Result then begin
   if l3AllCharsInCharSet(aWord.S, aWord.SLen, ['A'..'Z', 'А'..'Я']) then begin
    f_Abbr.Add(aWord);
    Result := false;
   end;//l3AllCharsInCharSet
  end;//Result
  if Result AND (m3_efHyphen in Flags) AND not IsLast then begin
   with aWord do
    if (S[SLen] = cc_Hyphen) {AND not (S[Succ(SLen)] in cc_ANSIRussian) }then begin
     if l3AllCharsInCharSet(aWord.S, aWord.SLen, cc_ANSIRussian) then begin
      if (S[Succ(SLen)] in cc_ANSIRussian) then
       f_Dash.Add(aWord)
      else begin
       if f_Preformatted then
        f_HyphenOEM.Add(aWord)
       else
        f_Hyphen.Add(aWord);
      end;//S[Succ(SLen)] in cc_ANSIRussian
      Result := false;
     end;//l3AllCharsInCharSet..cc_ANSIRussian
    end;//S[SLen] = cc_Hyphen
  end;//Result..
 end;//Result
end;

procedure Tm3ErrorsFinder.DoPara(const aPara : Tl3PCharLen);
  //override;
  {-}
begin
// Inc(f_ParaNum);
 inherited;
 f_Preformatted := false;
 f_Comment := false;
end;

procedure Tm3ErrorsFinder.AddAtom(AtomIndex: Long; TK: Tk2TypeKind; const Value);
  //override;
  {-}
begin
 inherited;
 if (AtomIndex = k2_tiStyle) AND (TK = k2_tkInteger) then begin
  if ((Long(Value) = ev_saTxtNormalOEM) OR (Long(Value) = ev_saANSIDOS)) then
   f_Preformatted := true
  else if (Long(Value) = ev_saTxtComment) then
   f_Comment := true;
 end;//AtomIndex = k2_tiStyle..
end;

end.

