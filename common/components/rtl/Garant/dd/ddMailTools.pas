unit ddMailTools;

interface

procedure ddPurgeOldMailInHomes(const aHomesDir: AnsiString; aKeepDays: Integer = 30);

function ddPurgeOldMail(const aDir: AnsiString; aKeepDays: Integer = 30; anUpdateOnly: Boolean = False): Integer;
{- aDir - папка с почтой, aKeepDays - за сколько последних дней почту сохран€ть }
{- ¬озвращает число удалЄнных писем }

procedure ddUpdateMailInHomes(const aHomesDir: AnsiString; aKeepDays: Integer = 30);
 {* - обновл€ет INI-файл дл€ текущей почты дл€ тестов. }

implementation
uses
 Classes,
 SysUtils,
 DateUtils,
 l3Date,
 l3FileUtils,
 l3IniFile,
 l3Base,
 ddUtils;

function ddPurgeOldMail(const aDir: AnsiString; aKeepDays: Integer = 30; anUpdateOnly: Boolean = False): Integer;
var
 l_MailFileName: AnsiString;
 l_OldFileName, l_NewFileName: AnsiString;
 l_OldMailIni: TCfgList;
 l_NewMailIni: TCfgList;
 l_MailToDelete: TStringList;
 I, l_Num: Integer;
 l_NewCount: Integer;
 l_DT: TStDateTimeRec;
 l_Today: TStDate;
 l_FN: AnsiString;
 l_Ok: Boolean;
begin
 Result := 0;
 l_OldFileName := ConcatDirName(aDir, 'MailBox.ini');
 if FileExists(l_OldFileName) then
 begin
  l_NewFileName := ConcatDirName(aDir, 'NewMailBox.ini');
  l_OldMailIni := TCfgList.Create(l_OldFileName);
  try
   l_OldMailIni.Section := 'MAIN';
   l_Num := l_OldMailIni.ReadParamIntDef('MaxMail', 0) - 1;
   if l_Num > 0 then
   begin
    l_MailToDelete := TStringList.Create;
    try
     l_Today := CurrentDate;
     l_NewCount := 0;
     l_NewMailIni := TCfgList.Create(l_NewFileName);
     try
      for I := 1 to l_Num do
      begin
       l_OldMailIni.Section := Format('MAIL%d', [I]);
       l_MailFileName := l_OldMailIni.ReadParamStrDef('File', '');
       if l_MailFileName <> '' then
       begin
        try
         l_OldMailIni.ReadParamRec('DateTime', 'DD', l_DT);
         l_Ok := True;
        except
         on EcfgReadError do
          l_Ok := False;
        end;
        if anUpdateOnly or (l_Ok and ((l_Today - l_DT.D) <= aKeepDays)) then
        begin
         Inc(l_NewCount);
         l_NewMailIni.Section := Format('MAIL%d', [l_NewCount]);
         l_NewMailIni.WriteParamStr('Name', l_OldMailIni.ReadParamStrDef('Name', ''));
         l_NewMailIni.WriteParamStr('Type', l_OldMailIni.ReadParamStrDef('Type', ''));
         l_NewMailIni.WriteParamStr('File', l_MailFileName);
         l_NewMailIni.WriteParamStr('FromUser', l_OldMailIni.ReadParamStrDef('FromUser', ''));
          if anUpdateOnly then
          begin
           l_DT := CurrentDateTime;
           l_NewMailIni.WriteParamRec('DateTime', 'DD', l_DT);
          end
          else
           l_NewMailIni.WriteParamStr('DateTime', l_OldMailIni.ReadParamStrDef('DateTime', ''));
         l_NewMailIni.WriteParamStr('Family', l_OldMailIni.ReadParamStrDef('Family', ''));
        end
        else
        begin
         l_OldMailIni.ReadParamString('File', l_FN);
         l_FN := Trim(l_FN);
         if l_FN <> '' then
          l_MailToDelete.Add(l_FN);
        end;
       end;
      end;
      l_NewMailIni.Section := 'MAIN';
      l_NewMailIni.WriteParamInt('MaxMail', l_NewCount + 1);
      FreeAndNil(l_NewMailIni);
      FreeAndNil(l_OldMailIni);
      DeleteFile(l_OldFileName);
      RenameFile(l_NewFileName, l_OldFileName);
      for I := 0 to l_MailToDelete.Count - 1 do
      begin
       l_FN := ConcatDirName(aDir, l_MailToDelete[I]);
       DeleteFile(l_FN);
      end;
     finally
      FreeAndNil(l_NewMailIni);
     end;
     Result := l_Num - l_NewCount;
    finally
     FreeAndNil(l_MailToDelete);
    end;
   end;
  finally
   FreeAndNil(l_OldMailIni);
  end;
 end;
end;

procedure ddPurgeOldMailInHomes(const aHomesDir: AnsiString; aKeepDays: Integer = 30);
var
 l_TotalDeleted: Integer;

function WorkoutOne(const aFileName: AnsiString;  aData: Pointer): Boolean;
var
 l_Deleted: Integer;
 l_Dir: AnsiString;
begin
 Result := True;
 l_Dir := ConcatDirName(aHomesDir, aFileName);
 l_Deleted := ddPurgeOldMail(l_Dir, Integer(aData));
 if l_Deleted > 0 then
 begin
  l3System.Msg2Log('%s: %s', [aFileName, NumSuffix(l_Deleted, 'письмо', 'письма', 'писем')]);
  l_TotalDeleted := l_TotalDeleted + l_Deleted;
 end;
end;

var
 l_Stub: Pointer;

begin
 l3System.Msg2Log('”даление старой почты (сохран€ютс€ письма за последние %s)', [NumSuffix(aKeepDays, 'день', 'дн€', 'дней')]);
 l_TotalDeleted := 0;
 l_Stub := l3LocalStub(@WorkoutOne);
 try
  ProcessSubDirectories(aHomesDir, TFileProcessingFunc(l_Stub), Pointer(aKeepDays));
  if l_TotalDeleted > 0 then
   l3System.Msg2Log('¬сего удалено %s', [NumSuffix(l_TotalDeleted, 'письмо', 'письма', 'писем')])
  else
   l3System.Msg2Log('Ќи одного письма не удалено');
 finally
  l3FreeLocalStub(l_Stub);
 end;
end;

procedure ddUpdateMailInHomes(const aHomesDir: AnsiString; aKeepDays: Integer = 30);

 function lp_WorkoutOne(const aFileName: AnsiString; aData: Pointer): Boolean;
 var
  l_Dir: AnsiString;
 begin
  Result := True;
  l_Dir := ConcatDirName(aHomesDir, aFileName);
  ddPurgeOldMail(l_Dir, Integer(aData), True);
 end;

var
 l_Stub: Pointer;
begin
 l_Stub := l3LocalStub(@lp_WorkoutOne);
 try
  ProcessSubDirectories(aHomesDir, TFileProcessingFunc(l_Stub), Pointer(aKeepDays));
 finally
  l3FreeLocalStub(l_Stub);
 end;
end;

end.
