unit arSpeller;

interface

 procedure InitSpeller;
 procedure ReleaseSpeller;

implementation
uses
 SysUtils,
 Forms,
 l3Base,
 l3String,
 l3FileUtils,
 l3Hunspell,
 l3mlmaruSpeller,
 l3Speller,
 Dialogs,
 vtDialogs,
 l3IniFile,
 IniShop;

procedure InitSpeller;
type
 TLingModule = (lmMlmaru, lmHun);
var
 lPath : AnsiString;
 lSpeller : Tl3Speller;

 procedure lAddMlmaruModule;
 var
  lmlmaruSpell : Tl3mlmaruSpeller;
 begin
 lmlmaruSpell := Tl3mlmaruSpeller.Create;
  try
   lSpeller.AddModule(lmlmaruSpell);
  finally
   FreeAndNil(lmlmaruSpell);
  end;
  l3System.Msg2Log('Run mlmaru', 3{aMsgLevel});
 end;

 procedure lAddHunSpellModule(aDictName : AnsiString);
 var
  lHunSpell : THunspell;
 begin
  aDictName := ConcatDirName(lPath, aDictName);
  if FileExists(aDictName + '.dic') then
  begin
   lHunSpell := THunspell.Create;
   try
    lHunSpell.LoadDictionary(aDictName);
    lSpeller.AddModule(lHunSpell);
   finally
    FreeAndNil(lHunSpell);
   end;
  end;
  l3System.Msg2Log('Run Hunspell '+ aDictName, 3{aMsgLevel});
 end;

 procedure lAddSpellModule(aLMSelector : TLingModule; const aParam : AnsiString = '');
 begin
  try
   case aLMSelector of
    lmMlmaru : lAddMlmaruModule;
    lmHun    : lAddHunSpellModule(aParam);
   end;
  except
    On E : Exception do
    begin
     l3System.Exception2Log(E);
     vtMessageDlg(l3CStr(E.Message), mtError);
    end;
  end;
 end;


 var
  lHasIniData : boolean;

 procedure IterFunc(const ItStr: ShortString);
 var
  lSel, lParam : ShortString;
  lPos : byte;
 begin
  lSel := LowerCase(ItStr);
  lPos := Pos(',', lSel);
  if lPos > 0 then
  begin
   lParam := Trim(Copy(lSel, lPos+1, 255));
   lSel := Trim(Copy(lSel, 0, lPos-1));
  end;

  lHasIniData := True;
  if lSel = 'mlmaru' then
   lAddSpellModule(lmMlmaru)
  else
   if lSel = 'hun' then
    lAddSpellModule(lmHun, lParam);
 end;

var
 lIterFunc : TOnSetListItem;

 begin
 lHasIniData := false;
 lPath := ExtractFilePath(Application.ExeName); //'dict\';
 lSpeller := Tl3Speller.Create;
 try
  StationConfig.Section := 'SpellChecker';
  lIterFunc := MakeRGLStub(@IterFunc);
  try
   StationConfig.ReadParamExtList('Module', lIterFunc);
  finally
   FreeRGLStub(lIterFunc);
  end;

  if not lHasIniData then // конфигурация "по-умолчанию" - mlmaru + 'en_US' если есть
  begin
   lAddSpellModule(lmMlmaru);
   lAddSpellModule(lmHun, 'en_US');
  end;

  SetSpeller(lSpeller);
 finally
  FreeAndNil(lSpeller);
 end;
end;

procedure ReleaseSpeller;
begin
 l3Speller.ReleaseSpeller;
end;
end.
