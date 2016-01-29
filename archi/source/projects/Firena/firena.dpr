program firena;

{ ��������� ������������� ��� �������������� ������ � ������� ���� ���� ����� ������ }
{ ��������� ���������� �� ��������� (�������� � ini-�����) }

{ $Id: firena.dpr,v 1.3 2004/01/12 12:17:16 fireton Exp $ }

// $Log: firena.dpr,v $
// Revision 1.3  2004/01/12 12:17:16  fireton
// - ��������� ����
//
// Revision 1.2  2004/01/12 09:35:17  fireton
// - ������ ��������
//

{$APPTYPE CONSOLE}

uses
 Classes, IniFiles, SysUtils, l3Base, l3RangeManager, l3Chars, l3String;

resourcestring
 SERRRangeOut = '�������� ������� ��������';
 SINISettings = 'Settings';

var
 RM  : Tl3RangeManager;
 Ini : TIniFile;
 ExePath, WorkMask, WorkPath, MaskStr, PrefixStr: string;
 RangeStr: string;
 LastNumber, NumWidth: Integer;
 X, I, CurIndex, FCount: Integer;
 NewName : string;
 Files: TStringList;

function DS(S: String): String;
begin
 Result := l3ChangeCodePage(S, CP_RussianWin, CP_RussianDOS);
end;

procedure Error(Msg: string);
var
 S: string;
begin
 S := '������: '+Msg;
 Writeln(DS(S));
 Abort;
end;

procedure LoadList(const AMask: string);
var
 FS : TSearchRec;
 X  : Integer;
begin
 Files.Clear;
 X := FindFirst(AMask, faArchive, FS);
 while X = 0 do
 begin
  if UpperCase(ChangeFileExt(FS.Name,'')) <> 'FIRENA' then
   Files.Add(FS.Name);
  X := FindNext(FS);
 end;
end;

begin
 Writeln;
 Writeln('FIRENA [file renamer] 1.0    Copyright 2004 Garant-Service');
 Writeln;
 ExePath := ExtractFilePath(ParamStr(0));
 WorkMask := ParamStr(1);
 WorkPath := ExtractFilePath(WorkMask);
 MaskStr := ExtractFileName(WorkMask);
 if WorkPath = '' then
  WorkPath := GetCurrentDir;
 WorkPath := IncludeTrailingPathDelimiter(WorkPath);
 if MaskStr = '' then
  MaskStr := '*.*';
 if DirectoryExists(WorkPath) then
 begin
  FCount := 0;
  Ini := TIniFile.Create(ExePath+'firena.ini');
  try
   LastNumber := Ini.ReadInteger(SINISettings, 'LastNumber', 0);
   RangeStr := Ini.ReadString(SINISettings, 'Range', '');
   PrefixStr := Ini.ReadString(SINISettings, 'Prefix', '');
   NumWidth := Ini.ReadInteger(SINISettings, 'NumWidth',8);
   if RangeStr = '' then
    Error('�� ��������� �������� �������. �������������� INI-����.');
   RM := Tl3RangeManager.Create;
   try
    X := RM.CheckSource(RangeStr);
    if X = 0 then
    begin
     RM.SrcString := RangeStr;

     if LastNumber >= RM[RM.Count] then
      Error(SERRRangeOut);

     if LastNumber <> 0 then
     begin
      CurIndex := RM.IndexOfPage[LastNumber];
      if CurIndex = -1 then
      begin
       Writeln(DS('��������! �������� ������� ��� �������!'));
       CurIndex := 1;
      end
      else
       Inc(CurIndex);
     end
     else
      CurIndex := 1;

     Files := TStringList.Create;
     try
      LoadList(WorkPath+WorkMask);
      for I := 0 to Files.Count-1 do
      begin
       try
        LastNumber := RM[CurIndex];
        NewName := WorkPath + PrefixStr + Format('%.'+IntToStr(NumWidth)+'d',[LastNumber]) + ExtractFileExt(Files[I]);
        Writeln(Files[I] + '  -->  ' + ExtractFileName(NewName));
        RenameFile(WorkPath+Files[I], NewName);
        Inc(FCount);
       except
        Error('���������� ������������� ���� '+ExtractFileName(Files[I])+' � ' + ExtractFileName(NewName));
       end;
       Inc(CurIndex);
       if CurIndex > RM.Count then
        Error(SERRRangeOut);
      end;
     finally
      Files.Free;
     end;
     Writeln;
     Writeln(FCount, DS(' ������ �������������.'));
    end;
   finally
    l3Free(RM);
   end;
  finally
   Ini.WriteInteger(SINISettings, 'LastNumber', LastNumber);
   Ini.Free;
  end;
 end
 else
  Error('���������� ' + WorkPath + ' �� ����������.');
 Writeln;
 Writeln(DS('������� Enter')); 
 Readln;
end.
