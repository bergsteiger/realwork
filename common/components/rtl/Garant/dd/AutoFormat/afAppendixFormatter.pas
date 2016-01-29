unit afAppendixFormatter;
{ Форматирует приложения }
// $Id: afAppendixFormatter.pas,v 1.5 2015/07/02 11:41:25 lukyanets Exp $

// $Log: afAppendixFormatter.pas,v $
// Revision 1.5  2015/07/02 11:41:25  lukyanets
// Описываем словари
//
// Revision 1.4  2014/04/29 14:06:19  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.3  2014/04/11 15:30:52  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.2  2013/04/16 09:30:55  fireton
// - не собиралось
//
// Revision 1.1  2013/04/16 08:09:55  narry
// Автоматические форматировщики
//



interface

uses
  dd_lcTextFormatter2, k2Interfaces, l3Types;

type
 TafAppendixKind = (af_akForm, af_akApproved);
 TafAppendixFormatter = class(Tdd_lcBaseFormatter)
 private
  f_CollectHeader: Boolean;
  f_CollectTitle: Boolean;
  f_Header: string;
  f_Title: string;
  f_AppendixKind: TafAppendixKind;
  f_NeedCourier: Boolean;
  procedure AddTitle;
  function MakeHeaderStr: string;
 protected
  procedure ClearParameters; override;
  function EnableWrite(aPara: Tl3Variant): Tdd_lcTextReaction; override;
 public
        {-}
  procedure StartChild(TypeID: Long); override;
 end;

implementation

uses StrUtils, TextPara_Const, l3Chars, k2Tags, evdStyles, l3String, ddUtils,
 m4PhraseParser, dt_Dict, m4DictTypes, m4DictScanner, DT_Const, dt_AttrSchema,
 SysUtils, l3DateSt, l3LingLib, evdTypes, daTypes;

procedure TafAppendixFormatter.AddTitle;
begin
  AddEmptyPara;
  if f_AppendixKind = af_akApproved then
  begin
   Generator.StartChild(k2_idTextPara);
   try
    Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
    Generator.AddStringAtom(k2_tiText, f_Title+cc_SoftEnter+MakeHeaderStr);
   finally
    Generator.Finish;
   end;
  end
  else
  begin
   Generator.StartChild(k2_idTextPara);
   try
    Generator.AddIntegerAtom(k2_tiJustification, ord(ev_itRight));
    Generator.AddIntegerAtom(k2_tiStyle, ev_saColorSelection);
    Generator.AddStringAtom(k2_tiText, f_Header);
   finally
    Generator.Finish;
   end;
   if f_Title <> '' then
   begin
    AddEmptyPara;
    Generator.StartChild(k2_idTextPara);
    try
     Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtHeader1);
     Generator.AddStringAtom(k2_tiText, f_Title);
    finally
     Generator.Finish;
    end;
   end; // f_Title <> ''
  end;
  AddEmptyPara;
end;

procedure TafAppendixFormatter.ClearParameters;
begin
 inherited;
 CheckEmptyPara:= True;
 f_Title:= '';
 f_Header:= '';
 f_CollectHeader:= False;
 f_CollectTitle:= False;
 f_NeedCourier:= False;
end;

function TafAppendixFormatter.EnableWrite(aPara: Tl3Tag): Tdd_lcTextReaction;
var
 i, l_Pos: Integer;
 l_CityName: ShortString;
 l_Text: String;
begin
 Result:= lcWrite;
 if not f_CollectHeader and not f_CollectTitle then
 begin
  l_Text:= aPara.StrA[k2_tiText];
  l3Replace(l_Text, cc_Quotes, ' ');
  l_Text:= Trim(l_text);
  if AnsiStartsText('утвержден', l_text) or AnsiStartsText('приложение', l_Text) then
  begin
   if AnsiStartsText('приложение', l_Text) then
    f_AppendixKind:= af_akForm
   else
    f_AppendixKind:= af_akApproved;
   f_CollectHeader:= True;
   f_Header:= '';
   Result:= lcSkip;
  end;
 end;
 if f_CollectHeader then
 begin
  if aPara.IntA[k2_tiStyle] = ev_saTxtHeader1 then
  begin
   f_CollectHeader:= False;
   f_CollectTitle:= True;
   f_Title:= '';
   if f_AppendixKind = af_akApproved then
    f_Header:= f_Header + ')';
   Result:= lcSkip;
  end
  else
  begin
   if f_Header = '' then
   begin
    if f_AppendixKind = af_akApproved then
     f_Header:= '(утв.'
    else
    begin
     f_Header:= AnsiLowerCase(aPara.StrA[k2_tiText]);
     UpperCaseFirstLetter(f_Header);
    end;
   end
   else
   begin
   // Проверить наличие слова Форма
    if AnsiStartsText('Форма', aPara.StrA[k2_tiText]) then
     f_NeedCourier:= True;
    f_Header:= f_Header + ifThen(f_AppendixKind = af_akApproved, ' ', cc_SoftEnter) + aPara.StrA[k2_tiText];
   end;
   Result:= lcSkip;
  end;
 end;
 if f_CollectTitle then
 begin
  if aPara.IntA[k2_tiStyle] = ev_saTxtHeader1 then
  begin
   if f_Title = '' then
   begin
    f_Title:= AnsiLowerCase(aPara.StrA[k2_tiText]);
    UpperCaseFirstLetter(f_Title);
    f_Title:= f_Title + cc_SoftEnter;
   end
   else
    f_Title:= f_Title + IfThen(AnsiEndsText(cc_SoftEnter, f_Title), '', ' ') + aPara.StrA[k2_tiText];
   Result:= lcSkip;
  end
  else
  begin
   f_CollectTitle:= False;
   Result:= lcWrite;
   AddTitle;
  end;
 end;
 if (Result = lcWrite) and f_NeedCourier then
 begin
  aPara.IntW[k2_tiStyle, nil]:= ev_saTxtNormalOEM;
 end;
end;

function TafAppendixFormatter.MakeHeaderStr: string;
var
 lFDIProcStub : Tm4FoundDictItemProc;
 l_Text: String;

 function lFoundDictItem(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 var
  l_FoundStr: string;
 begin
  Result := True;
  case aDictItemID.rDictionaryID of
   cDateDictID :
    begin
     f_Date := aDictItemID.rID;
    end;

   cNumDictID :
    begin
     f_Number := Copy(f_Header, Succ(aSegment.rOffs), aSegment.rLen);
    end;
  else
   if aDictItemID.rDictionaryID > 0 then
   case TdaDictionaryType(aDictItemID.rDictionaryID) of
     da_dlSources:
      begin
       f_Source:= DictServer(CurrentFamily).Dict[TdaDictionaryType(aDictItemID.rDictionaryID)].GetShortName(aDictItemID.rID);
      end;
     da_dlTypes  :
      begin
       f_Type:= DictServer(CurrentFamily).Dict[TdaDictionaryType(aDictItemID.rDictionaryID)].GetShortName(aDictItemID.rID);
      end;
   end;
  end;
 end;


begin
  lFDIProcStub := L2FoundDictItemProc(@lFoundDictItem);
  try
   DoParsePhrase(l3PCharLen(f_Header), DictServer(CurrentFamily).DictScanner, lFDIProcStub);
  finally
   FreeFoundDictItemProc(lFDIProcStub);
  end;
 l_Text:= Format('%s %s от %s №'+cc_SoftSpace+'%s', [mlmaRusDeclensionStr(AnsiLowerCase(f_Type), rdTvorit), mlmaRusDeclensionStr(f_Source, rdRodit), l3DateToStr(f_Date, 'd mmmm yyyy'+cc_SoftSpace+'г.'), f_Number]);
 Result:= '(утв. '+ l_Text + ')';
end;

procedure TafAppendixFormatter.StartChild(TypeID: Long);
begin
 if not TypeTable[TypeID].InheritsFrom(k2_idTextPara) then
 begin
  f_CollectHeader:= False;
  if f_CollectTitle then
  begin
   AddTitle;
   f_CollectTitle:= False;
  end;
 end;
 inherited StartChild(TypeID);
end;

end.
