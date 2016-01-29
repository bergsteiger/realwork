unit dd_lcTextSplitter;
{ Разделятель абзацев }

{ $Id: dd_lcTextSplitter.pas,v 1.12 2014/04/08 14:17:10 lulin Exp $ }
// $Log: dd_lcTextSplitter.pas,v $
// Revision 1.12  2014/04/08 14:17:10  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2014/04/07 09:45:46  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2014/04/03 17:10:43  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2014/03/06 17:23:27  lulin
// - избавляемся от теговых обёрток.
//
// Revision 1.8  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.7  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.6  2013/04/03 09:34:33  narry
// Не проходили тесты
//
// Revision 1.5  2012/09/18 08:13:22  narry
// Мягкий перенос строки - дополнение (393643295)
//
// Revision 1.4  2012/06/01 07:19:04  narry
// Заточки под уникодные строки
//
// Revision 1.3  2012/04/19 09:05:45  narry
// Мягкий перенос строки (356066509)
//
// Revision 1.2  2011/11/14 11:50:50  narry
// Пропадает текст из определений ВАС (297710781)
//
// Revision 1.1  2011/11/11 13:24:04  narry
// Пропадает текст из определений ВАС (297710781)
//


interface

uses
  evSearch, k2Interfaces, k2TagGen, dd_lcTextFormatter2, nevTools, l3Types, l3CustomString;

type
 Tdd_lcTextSplitter = class(Tdd_lcBaseFormatter)
 private
  f_ParaStartText: AnsiString;
 protected
  procedure DoWritePara(aLeaf: Tl3Variant); override;
 public
  class function SetTo(var theGenerator: Tk2TagGenerator; const aParaStartText: AnsiString):
      Tk2TagGenerator; overload;
 published
  property ParaStartText: AnsiString read f_ParaStartText write f_ParaStartText;
 end;

 Tdd_lcParaEndSearcher = class(TevBMTextSearcher)
 protected
        {-}
  function DoCheckText(aPara : Tl3Variant; aText : Tl3CustomString; const aSel : TevPair; out
      theSel : TevPair): Bool; override;
 end;

implementation

uses
  evParaSplitter, evParaTools, k2tags,
  dd_lcSourceUtils, l3Interfaces, evTypes, l3Chars, SysUtils, TextPara_Const;

procedure Tdd_lcTextSplitter.DoWritePara(aLeaf: Tl3Variant);
const
 cOpt = [ev_soNoException, ev_soNoProgress, ev_soReplaceAll];
var
 l_nevPara: InevPara;
 l_Searcher: IevSearcher;
 l_Replacer: IevReplacer;
 l_Pattern: AnsiString;
 l_BS: Boolean;
 l_Pos, i: Integer;
 l_Text, l_NewText: AnsiString;

 procedure lp_WritePara(const aText: AnsiString);
 var
  l_P: Tl3Variant;
 begin
  l_P:= aLeaf.AsObject.CloneTag.AsObject;
  l_P.StrW[k2_titext, nil]:= Trim(aText);
  Generator.StartChild(l_P.TagType);
  try
   l_P.AsObject.WriteTag(Generator);
  finally
   Generator.Finish;
  end;//try..finally
  (*
  Generator.StartChild(k2_idTextPara);
  try
   generator.AddStringAtom(k2_titext, Trim(atext));
  finally
   Generator.Finish;
  end;
  *)
 end; // lp_WritePara

 function lp_NextCharIsSmall(const aText: AnsiString; aPosition: Integer): Boolean;
 begin
  Result:= False;
  if (aPosition < Length(aText)) then
   Result:= aText[Succ(aPosition)] in cc_LoRussian;
 end;

begin
 if (Source2DossierType(f_Source) <> lc_dtVAC) and //(not f_BodyStarted) and
    (aLeaf.Attr[k2_tiText].IsValid and (aLeaf.StrA[k2_tiText] <> '') and (aLeaf.Attr[k2_tiText].AsWStr.SCodePage <> cp_Unicode))then
 begin
  // режем по ParaStartText
  (* *)
  l_BS:= f_BodyStarted;
  l_Text:= aLeaf.StrA[k2_tiText];
  l_pos:= AnsiPos(ParaStartText, l_Text);
  if l_Pos <> 0 then
  begin
   while l_Pos <> 0 do
   begin
    if (l_Pos > 2) then
    begin
     i:= Pred(l_Pos);
     //if l_BS then
      while (i > 1) and (l_Text[i] in [' ', cc_SoftSpace]) do Dec(i);

     if {not l_BS or} ((l_Text[i] = '.') and not lp_NextCharIsSmall(l_Text, l_pos)) or (l_Text[i] in [';', ':']) then
     begin
      l_NewText:= Copy(l_Text, 1, Pred(l_pos));
      lp_WritePara(l_NewText);
      Delete(l_Text, 1, l_Pos + Length(ParaStartText)-1);
     end
     else
     begin
      Delete(l_Text, l_pos, Length(paraStarttext));
      Insert(' ', l_Text, l_pos);
     end;
    end
    else
    begin
     Delete(l_Text, l_pos, Length(paraStarttext));
     Insert(' ', l_Text, l_pos);
    end;
    l_pos:= AnsiPos(ParaStartText, l_Text);
   end;
   lp_WritePara(l_Text);
  end
  else
   inherited;
  (* *)
  (*
  if aLeaf.QT(InevPara, l_nevPara) then
  try
   //if (not f_BodyStarted) then
    l_Searcher:= TevBMTextSearcher.Make(ParaStartText, cOpt);
   //else
   // l_Searcher:= TevRegExpMultipartSearcher.Make('\l\s+', cOpt);
   try
    l_Replacer:= TevParaSplitter.Make(Generator, cOpt);
    try
     EvReplaceInPara(l_nevPara, l_Searcher, l_Replacer);
    finally
     l_Replacer:= nil;
    end;//try..finally
   finally
    l_Searcher:= nil;
   end;//try..finally
  finally
   l_Nevpara:= nil;
  end;//try..finally
  inherited;
  *)
 end//aLeaf.Attr[k2_tiText].IsValid
 else
  inherited;
end;

class function Tdd_lcTextSplitter.SetTo(var theGenerator: Tk2TagGenerator; const aParaStartText:
    AnsiString): Tk2TagGenerator;
begin
 Result:= SetTo(theGenerator);
 Tdd_lcTextSplitter(theGenerator).ParaStartText:= aParaStartText;
end;

function Tdd_lcParaEndSearcher.DoCheckText(aPara : Tl3Variant; aText : Tl3CustomString; const
    aSel : TevPair; out theSel : TevPair): Bool;
var
 l_Char: AnsiChar;
 i: Integer;
begin
 Result := inherited DoCheckText(aPara, aText, aSel, theSel);
 if Result then
 begin
  i:= Pred(theSel.rStart);
  while (i <> 0) and (aText.Ch[i] in [' ', cc_SoftSpace]) do Dec(i);
  if not (aText.Ch[i] in ['.', ':']) then
   Result:= False;
  //else
   // Нужно сдвинуть начало за точкой
  // theSel.rStart:=
 end;
end;

end.
