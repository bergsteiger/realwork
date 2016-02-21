unit RegExpTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\RegExpTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TRegExpTest = {abstract} class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TRegExpTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3RegEx
 , l3String
 , SysUtils
 , l3IniFile
 , l3Parser
 , l3Base
 , l3Interfaces
 , l3Filer
;

procedure TRegExpTest.DoIt;
//#UC START# *4F6840D602F3_4F68409203D1_var*
var
 l_InFilename: String;
 l_Ini: TCfgList;
 l_Parser: Tl3Parser;
 l_Str: Il3CString;
 l_Settings: AnsiString;
 l_Pos: Tl3MatchPosition;
 I : Integer;
 l_Filer : Tl3CustomFiler;
 l_RegEx : Tl3RegularSearch;
 l_Title : Il3CString;
 l_Pattern : AnsiString;
 l_TestString : Il3CString;
//#UC END# *4F6840D602F3_4F68409203D1_var*
begin
//#UC START# *4F6840D602F3_4F68409203D1_impl*
 l_InFilename := FileFromCurrent(DataSubFolder + '\' + KPage, FolderMode);
 l_Filer := FilerForOutput;
 try
  l_Filer.Open;
  l_RegEx := Tl3RegularSearch.Create;
  try
   l_Ini := TCfgList.Create(l_InFilename);
   try
    l_Ini.Section := 'RegExp';
    l_Title := l3CStr(l_Ini.ReadParamStrDef('Title', '<без имени>'));
    l_RegEx.IgnoreCase := l_Ini.ReadParamBoolDef('IgnoreCase', False);
    l_RegEx.IgnoreCRLF := l_Ini.ReadParamBoolDef('IgnoreCRLF', False);
    l_Str := l3CStr(l_Ini.ReadParamStrDef('Pattern', ''));
    Check(not l3IsNil(l_Str), 'Pattern = nil');
    l_Str := l3Cat([l3CStr(''''), l_Str, l3CStr('''')]);
    l_Parser := Tl3Parser.Make(l_Str.AsWStr, []);
    try
     Check(l_Parser.NextToken = l3_ttString, 'Pattern описан не как строка');
     l_Pattern := l_Parser.TokenString;
    finally
     FreeAndNil(l_Parser);
    end;

    l_Str := l3CStr(l_Ini.ReadParamStrDef('TestString', ''));
    Check(not l3IsNil(l_Str), 'TestString = nil');
    l_Str := l3Cat([l3CStr(''''), l_Str, l3CStr('''')]);
    l_Parser := Tl3Parser.Make(l_Str.AsWStr, []);
    try
     Check(l_Parser.NextToken = l3_ttString, 'TestString описана не как строка');
     l_TestString := l3CStr(l_Parser.TokenString);
    finally
     FreeAndNil(l_Parser);
    end;
   finally
    FreeAndNil(l_Ini);
   end;

   l_Filer.WriteLn('');
   l_Filer.WriteLn(l_Title.AsWStr);
   l_Filer.Writeln(Format('Паттерн: %s', [l_Pattern]));
   l_Filer.Write('Строка: ');
   l_Filer.Writeln(l_TestString.AsWStr);
   l_Settings := '';
   if l_RegEx.IgnoreCase then
    l_Settings := 'Без учёта регистра';
   if l_RegEx.IgnoreCRLF then
    if l_Settings = '' then
     l_Settings := 'Через переносы строк'
    else
     l_Settings := l_Settings + ', через переносы строк';
   if l_Settings <> '' then
   begin
    l_Filer.Write(l_Settings);
    l_Filer.Writeln('.');
   end;
   l_RegEx.SearchPattern := l_Pattern;
   try
    if l_RegEx.SearchInString(l_TestString.AsWStr, l_Pos) then
    begin
     l_Filer.Write('Найдено: ');
     l_Filer.Writeln(l3Copy(l_TestString.AsWStr, l_Pos.StartPos, l_Pos.Length));
     if l_RegEx.TagParts.Count > 0 then
     begin
      l_Filer.WriteLn(Format('Выделено тегов - %d', [l_RegEx.TagParts.Count]));
      for I := 0 to Pred(l_RegEx.TagParts.Count) do
      begin
       l_Filer.Write(Format(' %2d: ', [I]));
       l_Filer.Writeln(l_RegEx.TagParts.ItemW[I]);
      end;
     end;
    end
    else
     l_Filer.Writeln('СТРОКА НЕ НАЙДЕНА');
   except
    on E: El3RegExError do
     l_Filer.WriteLn('ОШИБКА: '+E.Message);
   end;
  finally
   FreeAndNil(l_RegEx);
  end;
 finally
  FreeAndNil(l_Filer);
 end;
 CheckOutputWithInput(ChangeFileExt(l_InFilename, EtalonSuffix), #0);
//#UC END# *4F6840D602F3_4F68409203D1_impl*
end;//TRegExpTest.DoIt

function TRegExpTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RegExp';
end;//TRegExpTest.GetFolder

function TRegExpTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F68409203D1';
end;//TRegExpTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
