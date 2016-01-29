unit UpgradeTo114;
// 1. ƒобавление в таблицу DT#A нового пол€ Nonperiod.
// 2. »справление почтовых сообщений (файлы ..\Homes\Usr#___\Mail___.dat).
//    ј именно - изменение размера пол€, хран€щего полную длину сообщени€ (касаетс€
//    только сообщений типа mlNone и mlDoc).

{ $Id: UpgradeTo114.pas,v 1.4 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo114.pas,v $
// Revision 1.4  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.3  2007/12/03 14:00:54  fireton
// - отв€зываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.2  2005/12/12 07:24:48  step
// убран update115 и его содержимое перенесено в update114
//
// Revision 1.1  2005/10/17 09:20:48  step
// обновление 114
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo114 = class(TDocBaseUpgrade)
 private
  function BackupDir: string;
  function UpdateUserMail(const aUserFolder: string): Integer;
  function UpdateMailMessage(const aMailFile: string): Boolean;

  procedure UpdateTableA;
  procedure UpdateAllMailMessages;
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
  procedure AfterSaveBackup; override;
  procedure AfterUndo; override;
 public
  class function PrevVersion: Integer; override; // 112
  class function Version: Integer; override;     // 114
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 Classes, SysUtils,
 DT_DbReformer,
 l3Base, l3IniFile, l3FileUtils;

{$INCLUDE nodt_const.inc} 

const
 DT_A        = 'DT#A001';
 TEMP_DT_A   = 'DT#A_NEW';

class function TUpgradeTo114.PrevVersion: Integer;
begin
 Result := 112;
end;

procedure fn_AddFieldToDtA(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName = 'Nonperiod';
begin
 SetLength(aStruct, Length(aStruct) + 1);

 // добавление пол€
 FillChar(aStruct[5], SizeOf(aStruct[5]), #0);
 with aStruct[5] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_BYTE;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName;
 end;
end;

procedure TUpgradeTo114.ModifyBd;
begin
 UpdateTableA;
 UpdateAllMailMessages;
end;

class function TUpgradeTo114.Version: Integer;
begin
 Result := 114;
end;

procedure TUpgradeTo114.InitRestorableTableList;
begin
 inherited;

 with f_DbReformer do
  AddToRestorableList(FamilyTable(DT_A));
end;

function TUpgradeTo114.BackupDir: string;
begin
 Result := ConcatDirName(f_DbReformer.DirBackup, 'saved_homes');
end;

function TUpgradeTo114.UpdateMailMessage(const aMailFile: string): Boolean;
var
 l_Stream: TFileStream;
 l_MemStream: TMemoryStream;
 l_FileSize: Int64;
 l_SizeAsWord: Word;
 l_SizeAsInt: Longint;
begin
 Result := False;
 if not FileExists(aMailFile) then
  Exit;
 l_Stream := TFileStream.Create(aMailFile, fmOpenReadWrite);
 try
  l_FileSize := l_Stream.Size;

  l_Stream.Position := 0;
  if l_FileSize >= SizeOf(l_SizeAsWord) then
   l_Stream.ReadBuffer(l_SizeAsWord, SizeOf(l_SizeAsWord))
  else
   l_SizeAsWord := 0;

  l_Stream.Position := 0;
  if l_FileSize >= SizeOf(l_SizeAsInt) then
   l_Stream.ReadBuffer(l_SizeAsInt, SizeOf(l_SizeAsInt))
  else
   l_SizeAsInt := 0;

  // собственно проверка
  if (l_SizeAsInt + SizeOf(l_SizeAsInt) = l_FileSize) then // новый формат - ниче не трогаем
   Exit
  else if (l_SizeAsWord + SizeOf(l_SizeAsWord) = l_FileSize) then // старый формат - надо исправл€ть
  begin
   l_MemStream := TMemoryStream.Create;
   try
    l_SizeAsInt := l_SizeAsWord;
    l_MemStream.WriteBuffer(l_SizeAsInt, SizeOf(l_SizeAsInt));
    l_Stream.Position := 2;
    l_MemStream.CopyFrom(l_Stream, l_Stream.Size - 2);

    l_Stream.Size := 0;
    l_MemStream.Position := 0; 
    l_Stream.CopyFrom(l_MemStream, l_MemStream.Size);

    Result := True;
   finally
    l3Free(l_MemStream);
   end;
  end
  else
   f_DbReformer.Log('Ќеизвестный формат файла "' + aMailFile + '" (не обработано).');

 finally
  l3Free(l_Stream);
 end;
end;

function TUpgradeTo114.UpdateUserMail(const aUserFolder: string): Integer;
const
 c_SectHeader = 'MAIL';
var
 l_CfgList: TCfgList;
 l_Sections: TStringList;
 I: Integer;
 l_MailType: Integer;
 l_MailFile: string;
begin
 Result := 0;
 l_CfgList := TCfgList.Create(ConcatDirName(aUserFolder, 'mailbox.ini'));
 try
  l_Sections := TStringList.Create;
  try
   l_CfgList.GetSectionNameList(l_Sections);

   // перебор секций [MAIL*]
   for I := 0 to l_Sections.Count - 1 do
   begin
    if CompareText(Copy(l_Sections[I], 1, Length(c_SectHeader)),
                   c_SectHeader) = 0 then
    begin
     l_CfgList.Section := l_Sections[I];
     if l_CfgList.ReadParamInt('Type', l_MailType) then
     begin
      if l_MailType in [0, 2, 128, 130] then // mlDone=0, 128 ;  mlDoc=2, 130
      begin
       if l_CfgList.ReadParamString('File', l_MailFile) then
        if UpdateMailMessage(ConcatDirName(aUserFolder, l_MailFile)) then
        begin
         Inc(Result);
         // снимаем отметку о "прочитанности"
         if l_MailType >= 128 then
         begin
          l_MailType := l_MailType - 128;
          l_CfgList.WriteParamInt('Type', l_MailType);
         end; // if
        end; // if
      end; // if
     end; // if
    end; // if
   end; // for
  finally
   l3Free(l_Sections);
  end;
 finally
  l3Free(l_CfgList);
 end;

end;

procedure TUpgradeTo114.AfterSaveBackup;
begin
 if DirectoryExists(BackupDir) then
  DelDir(BackupDir);
 CopyDir(f_DbReformer.DbInfo.HomesFolder, BackupDir);
end;

procedure TUpgradeTo114.AfterUndo;
begin
 if DirectoryExists(f_DbReformer.DbInfo.HomesFolder) then
  DelDir(f_DbReformer.DbInfo.HomesFolder);
 CopyDir(BackupDir, f_DbReformer.DbInfo.HomesFolder);
 if DirectoryExists(BackupDir) then
  DelDir(BackupDir);
end;

class function TUpgradeTo114.NameEx: string;
begin
 Result := 'базы документов и почтовых сообщений';
end;

procedure TUpgradeTo114.UpdateAllMailMessages;
const
 c_DirMask = 'Usr#*';
var
 l_SearchDirRec: TSearchRec;
 l_FindResult: Integer;
 l_UserFolder: string;
 l_RepairedCounter: Integer;
begin
 l_RepairedCounter := 0;
 with f_DbReformer do
 begin
  Log('ѕроверка и исправление сохраненных почтовых сообщений.');

  // перебираем папки \homes\Usr#*
  begin
   l_FindResult := FindFirst(ConcatDirName(DbInfo.HomesFolder, c_DirMask),
                             faDirectory,
                             l_SearchDirRec);
   try
    while l_FindResult = 0 do
    begin
     l_UserFolder := ConcatDirName(DbInfo.HomesFolder, l_SearchDirRec.Name);
     Inc(l_RepairedCounter, UpdateUserMail(l_UserFolder));

     l_FindResult:=FindNext(l_SearchDirRec);
    end;
   finally
    FindClose(l_SearchDirRec);
   end;
  end;
  Log('»справлено ' + IntToStr(l_RepairedCounter) + ' почтовых сообщений.');
 end; // with
end;

procedure TUpgradeTo114.UpdateTableA;
begin
 with f_DbReformer do
 begin
  Log('—оздание новой пустой таблицы DT#A с полем Private');
  CopyTableStruct(FamilyTable(DT_A),
                  FamilyTable(TEMP_DT_A),
                  fn_AddFieldToDtA);

  Log(' опирование данных из старой таблицы в новую');
  CopyData(FamilyTable(DT_A),
           FamilyTable(TEMP_DT_A));

  Log('”даление старой таблицы');
  htDropTable(PChar(FamilyTable(DT_A)), nil, nil);

  Log('ѕереименование новой таблицы');
  htTableRename(PChar(FamilyTable(TEMP_DT_A)),
                nil,
                nil,
                PChar(FamilyTable(DT_A)));
 end; // with
end;

end.

