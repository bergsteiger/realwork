unit ddSpellCheckFilter;

interface

{$DEFINE evAlienSpell}

uses
  Classes, l3Except,
  {$IfDef evAlienSpell}
  ddAlienSpell,
  {$ELSE}
  ddNativeSpell,
  {$ENDIF}
  evSearch,
  l3Interfaces, l3Types,
  nevTools,  evdLeafParaFilter, k2Interfaces,
  k2Base,
  k2TagGen, k2Types;

type
 TSpellCheckErrorFound = procedure(aError: Il3CString) of object;
 TddSpellCheckReplacer = class(TevBaseReplacer)
 private
  f_OnErrorFound: TSpellCheckErrorFound;
 protected
  procedure ErrorFound(aError: Il3CString);
  function ReplaceFunc(const aView : InevView; const Container : InevOp; const
      aBlock : InevRange): Bool; override;
 public
  property OnErrorFound: TSpellCheckErrorFound read f_OnErrorFound write f_OnErrorFound;
 end;

 TSpellCheckEvent = procedure (aTopicID: Integer; aWrongWord: Il3CString) of object;
 TddSpellCheckFilter = class(TevdLeafParaFilter)
 private
  f_CurrentID: Integer;
  f_OnWrongWordFound: TSpellCheckEvent;
  f_Searcher: TevBaseSearcher;
  f_Replacer: TevBaseReplacer;
  f_Speller : {$IfDef evAlienSpell}TddSpeller{$Else  evAlienSpell}TmgSpellFormChecker{$EndIf evAlienSpell};
  f_Aborted: Boolean;
  procedure WordFound(aError: Il3CString);
 protected
        {-}
  procedure Cleanup; override;
  procedure DoWritePara(aLeaf: Tl3Variant); override;
        {-}
  function ParaTypeForFiltering: Tk2Type; override;
  procedure WrongWordFound(aTopicID: Integer; aWrongWord: Il3CString);
 public
    // public methods
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
        {-}
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  class function SetTo(var theGenerator: Tk2TagGenerator; aSpellCheckEvent:
      TSpellCheckEvent): Pointer; overload;
  procedure AbortProcess;
 published
  property OnWrongWordFound: TSpellCheckEvent read f_OnWrongWordFound write
      f_OnWrongWordFound;
 end;

implementation

uses
  EvTypes, EvParaTools,
  l3String, l3Chars, l3Const, ddSpecialFormChecker, ddSpell, Document_Const,
  k2Tags, SysUtils, TextPara_Const, l3Base;

const
 c_SROptions = [ev_soFind, ev_soGlobal, ev_soReplaceAll, ev_soNoException];


procedure TddSpellCheckReplacer.ErrorFound(aError: Il3CString);
begin
 if Assigned(f_OnErrorFound) then f_OnErrorFound(aError);
end;

function TddSpellCheckReplacer.ReplaceFunc(const aView : InevView; const
    Container : InevOp; const aBlock : InevRange): Bool;
var
 l_Str: Il3CString;
 l_ValidError: Boolean;
begin
 Result := True;
 l_Str:= evAsString(aBlock.Data);
 l_ValidError:= True;
 // Не нужны:
 // 1. Все числа и даты
 if l_ValidError and l3AllCharsInCharSet(l_Str, ['0'..'9', '.']) then
  l_ValidError:= False;
 // 2. точка является разделителем слов
 if l_ValidError and (l3Pos(l_Str, '.') <> l3NotFound) then
  l_ValidError:= False;
 //3. Короткие слова (< 4 букв)
 if l_ValidError and (l_Str.AsWStr.SLen < 4) then
  l_ValidError:= False;
 //4. Слова, начинающиеся с заглавной буквы
 if l_ValidError and (l_Str.AsWStr.S[0] in cc_UpRussian+cc_UpEnglish) then
  l_ValidError:= False;
 //5. Смесь букв и цифр (первое приближение)
 if l_ValidError and l3CharSetPresent(l_Str, ['0'..'9', '.']+cc_ANSIEnglish) then
 begin
  { Меняем:
    0 -> О
    3 -> З
  }
  l_ValidError:= False;
 end;
 //6. Проверка на спецформы ("хорошие" слова + префиксы)
 if l_ValidError and SFChecker.Check(l_Str.AsWStr) then
  l_ValidError := False;

 if l_ValidError then
  ErrorFound(l_Str);
 l_Str:= nil;
end;

constructor TddSpellCheckFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 inherited;
 f_Speller:= {$IfDef evAlienSpell}TddSpeller{$Else  evAlienSpell}TmgSpellFormChecker{$EndIf evAlienSpell}.Create;
 {$IFNDEF evAlienSpell}
 f_Speller.IgnoreFlags := [CmgSrcEvnDate,
                           CmgSrcEvnDigital,
                           CmgSrcEvnEnglish,
                           CmgSrcEvnAllCapital,
                           cmgSrcEvnNumberChar];
 {$ENDIF}
 f_Searcher:= TddSpellCheckSearcher.Create(f_Speller);
 f_Replacer:= TddSpellCheckReplacer.Create;
 f_Searcher.Options := c_SROptions;
 f_Replacer.Options := c_SROptions;
 TddSpellCheckReplacer(f_Replacer).OnErrorFound:= WordFound;
end;

procedure TddSpellCheckFilter.AddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then
  f_CurrentID:=Value.AsInteger;
 inherited;
end;

procedure TddSpellCheckFilter.Cleanup;
begin
 inherited;
 FreeAndNil(f_Searcher);
 FreeAndNil(f_Replacer);
 FreeAndNil(f_Speller);
end;                               

procedure TddSpellCheckFilter.DoWritePara(aLeaf: Tl3Variant);
const
 cOpt = [ev_soNoException, ev_soNoProgress, ev_soReplaceAll];
var
 l_nevPara: InevPara;
begin
 if f_Aborted then
   raise El3AbortLoadFilter.Create('');
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  if aLeaf.QT(InevPara, l_nevPara) then
  try
   EvReplaceInPara(l_nevPara, f_Searcher, f_Replacer);
  finally
   l_Nevpara:= nil;
  end;//try..finally
 end;//aLeaf.Attr[k2_tiText].IsValid
 inherited;
end;

function TddSpellCheckFilter.ParaTypeForFiltering: Tk2Type;
begin
 Result := k2_typTextPara;
end;

class function TddSpellCheckFilter.SetTo(var theGenerator: Tk2TagGenerator;
    aSpellCheckEvent: TSpellCheckEvent): Pointer;
  {-}
var
 l_Filter : TddSpellCheckFilter;
begin
 l_Filter := Create(nil);
 try
  l_Filter.OnWrongWordFound:= aSpellCheckEvent;
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TddSpellCheckFilter.WordFound(aError: Il3CString);
begin
 WrongWordFound(f_CurrentID, aError);
end;

procedure TddSpellCheckFilter.WrongWordFound(aTopicID: Integer; aWrongWord:
    Il3CString);
begin
 if Assigned(f_OnWrongWordFound) then
  f_OnWrongWordFound(aTopicID, aWrongWord)
 else
  l3System.Msg2Log('%d %s', [aTopicID, aWrongWord.AsWStr.S]);
end;

procedure TddSpellCheckFilter.AbortProcess;
begin
  f_Aborted := True;
end;

end.
