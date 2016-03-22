unit dd_lcTypeConverter;
// Преобразование внешних типов во внутренние

{ $Id: dd_lcTypeConverter.pas,v 1.13 2016/02/16 07:31:33 lukyanets Exp $ }

// $Log: dd_lcTypeConverter.pas,v $
// Revision 1.13  2016/02/16 07:31:33  lukyanets
// Не собиралось
//
// Revision 1.12  2014/04/10 11:59:56  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.9  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.8  2013/04/12 15:02:04  lulin
// - расставляем const.
//
// Revision 1.7  2013/04/12 12:12:38  voba
// -bug fix
//
// Revision 1.6  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.5  2011/10/21 13:11:59  narry
// Накопившиеся изменения
//
// Revision 1.4  2011/09/13 12:03:05  narry
// Расшифровка типа "Решения и Постановления"  (281526721)
//
// Revision 1.3  2011/09/08 12:17:10  narry
// Не определен тип (282692743)
//
// Revision 1.2  2011/06/21 12:31:22  narry
// Двойные типы документа (269083294)
//


interface

uses
 dd_lcBaseFilter, dd_lcBaseDocFilter, ddHeaderFilter,
 l3Types, l3Interfaces,
 //l3String,
 k2Types, k2Interfaces, l3VCLStrings, k2TagGen, ddTypes;

type
 Tdd_lcTypeConverter = class(Tdd_lcSynoFilter)
 protected
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 public
 end;

 Tdd_lcTypeConverterEx = class(Tdd_lcBaseDocFilter)
  function GetWord(const aStr: AnsiString): AnsiString;
 // Ловим Тип - если из нескольких слов, начинаем анализ текста
 protected
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
 end;

 Tdd_lcTypeConverter2 = class(Tdd_lcBaseHeaderFilter)
 private
  f_Sources: Tl3Strings;
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
  procedure Cleanup; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner); override;
  procedure LoadSources(const aSourceFilename: AnsiString);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer;
      aOnError: TddErrorEvent; const aSourceFilename: AnsiString): Pointer; overload;
 end;

 

implementation

uses
 l3Variant,
 k2Tags,
 DictItem_Const, l3String, TextPara_Const, l3LingLib, l3SpellMisc, k2Base, StrUtils,
 SysUtils, ddUtils;

procedure Tdd_lcTypeConverter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_CorrectText: AnsiString;
begin
 if CurrentType.IsKindOf(k2_typDictItem) and (TopObject[1].IsProp and (TopObject[1].AsProp.TagIndex = k2_tiTypes)) then
 begin
  if (Value.Kind = k2_vkString) and (AtomIndex = k2_tiName) then
   if CheckValue(Value.AsString.AsString, l_CorrectText) then
   begin
    if Pos(' и ', Value.AsString.AsString) = 0 then // Это нужно для расширенной проверки типа
     Value.AsString.AsString:= l_CorrectText;
   end;
 end; // CurrentType.IsKindOf(k2_typDictItem) and (TopObject[1].IsProp and (TopObject[1].AsProp.TagIndex = k2_tiTypes))
 inherited DoAddAtomEx(AtomIndex, Value);
end;

function Tdd_lcTypeConverterEx.GetWord(const aStr: AnsiString): AnsiString;
var
 lGetNormWordProc : TllAddStrProc;
 l_Str: Tl3WString;

 procedure GetNormWord(aWord : PAnsiChar; aWordLen : integer);
 begin
  Result := l3Str(l3PcharLen(aWord, aWordLen));
 end;

begin
 l_Str:= l3PCharlen(aStr);
 lGetNormWordProc := L2llAddStrProc(@GetNormWord);
 try
  if not mlmaLemmatize(l_Str, 0{maStopAfterFirst}, lGetNormWordProc) then
   // если ничего не нашли возвращаем поданное
   Result := aStr;
 finally
  FreellAddStrProc(lGetNormWordProc);
 end;
end;

procedure Tdd_lcTypeConverterEx.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
var
 l_1stType, l_2ndType: AnsiString;
 l_Types: Tl3Variant;
 l_Pos: Integer;
 l_text: AnsiString;

 function lp_CheckPara(aPara: Tl3Variant; Index: Long): Boolean;
 
  function lp2_CheckType(const aType: AnsiString): Boolean;
  begin
   if AnsiSameText(Trim(aPara.StrA[k2_tiText]), aType) then
   begin
    Result:= False;
    l_Types.Child[0].StrW[k2_tiName, nil]:= aType;
   end
   else
    Result:= True;
  end; // lp2_CheckType
 begin
  Result:= True;
  if aPara.IsKindOf(k2_typTextPara) and aPara.Attr[k2_tiText].IsValid then
  begin
   Result:= lp2_CheckType(l_1stType);
   if Result then
    Result:= lp2_CheckType(l_2ndType);
  end;
 end; // lp_CheckPara

begin
 // aLeaf - это весь документ
 // Найти тип и проверить сколько в нем слов
 l_Types:= aLeaf.Attr[k2_tiTypes];
 if l_Types.IsValid and (l_Types.ChildrenCount > 0) then
 begin
  l_Text:= l_Types.Child[0].StrA[k2_tiName];
  l_Pos:= Pos(' и ', l_text);
  if l_Pos <> 0 then
  begin
   l_1stType:= GetWord(Copy(l_text, 1, Pred(l_Pos)));
   UpperCaseFirstLetter(l_1stType);
   l_2ndType:= GetWord(Copy(l_text, l_pos + 3, Length(l_Text)));
   UpperCaseFirstLetter(l_2ndType);
   // Если слов несколько, пробежаться по абзацам в поисках первого или второго слова - это и есть тип
   aLeaf.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckPara));
  end;
 end;
 inherited;
end;

constructor Tdd_lcTypeConverter2.Create(anOwner: Tk2TagGeneratorOwner);
begin
 inherited Create(anOwner);
 f_Sources := Tl3Strings.Create();
end;

procedure Tdd_lcTypeConverter2.Cleanup;
begin
 FreeAndNil(f_Sources);
 inherited Cleanup;
end;

procedure Tdd_lcTypeConverter2.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_1stType, l_2ndType: AnsiString;
 l_Types, l_Sources: Tl3Variant;
 l_Pos: Integer;
 l_text: AnsiString;
begin
 l_Types:= aHeaderRoot.Attr[k2_tiTypes];
 if l_Types.IsValid and (l_Types.ChildrenCount > 0) then
 begin
  l_Text:= l_Types.Child[0].StrA[k2_tiName];
  if AnsiSameText('Решения и постановления', l_Text) then
  begin
   l_Sources:= aHeaderRoot.Attr[k2_tiSources];
   if l_Sources.IsValid and (l_Sources.ChildrenCount > 0) then
   begin
    l_Text:= l_Sources.Child[0].StrA[k2_tiName];
    // Найти в списке орган и присвоить необходимый тип
    if f_Sources.IndexOf(l_text) <> -1 then
     l_Types.Child[0].StrW[k2_tiName, nil]:= 'Постановление'
    else
     l_Types.Child[0].StrW[k2_tiName, nil]:= 'Решение';
   end;
  end;
 end;
end;

procedure Tdd_lcTypeConverter2.LoadSources(const aSourceFilename: AnsiString);
begin
 f_Sources.LoadFromFile(aSourceFileName);
end;

class function Tdd_lcTypeConverter2.SetTo(var theGenerator: Tk2TagGenerator;
    aCategory: Integer; aOnError: TddErrorEvent; const aSourceFilename:
    AnsiString): Pointer;
var
 l_Filter : Tdd_lcTypeConverter2;
begin
 l_Filter := SetTo(theGenerator, aCategory, aOnError);
 l_Filter.LoadSources(aSourceFileName);
 Result := l_Filter;
end;

end.
