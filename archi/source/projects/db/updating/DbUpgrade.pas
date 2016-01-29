unit DbUpgrade;
{///////////////////////////////////////////////////////////////////////////////
 Некоторые пояснения о нумерации версий БД.
 Любой апгрейд увеличивает номер версии строго на единицу.
 Например,
  ПапкаДокументов.Версия = 103
  ПапкаАдминистративная.Версия = 106
  Надо поднять БД до версии 109. Тогда, код будет, например, таким:
                                                                   Prev.   Ver.
  UpgradeПапкаДокументовTo104;            // ПапкаДокументов       103 --> 104
  UpgradeПапкаАдминистративнаяTo105;      // ПапкаАдминистративная 101 --> 105
  UpgradeПапкаДокументовTo106;            // ПапкаДокументов       104 --> 106
  UpgradeПапкаАдминистративнаяTo107;      // ПапкаАдминистративная 105 --> 107
  UpgradeПапкаДокументовTo108;            // ПапкаДокументов       106 --> 108
  UpgradeПапкаДокументовTo109;            // ПапкаДокументов       108 --> 109

  В результате -
   ПапкаДокументов.Версия = 109
   ПапкаАдминистративная.Версия = 107
  Вот по этим номерам и следует проверять соответствие БД и программ.
///////////////////////////////////////////////////////////////////////////////}

{ $Id: DbUpgrade.pas,v 1.14 2011/12/12 14:02:52 fireton Exp $ }
// $Log: DbUpgrade.pas,v $
// Revision 1.14  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.13  2007/03/12 11:18:40  fireton
// - подчистка *.bak файлов за собой после работы
//
// Revision 1.12  2007/02/22 15:00:58  fireton
// - переход на 64 бита в HyTech
//
// Revision 1.11  2005/12/09 14:13:52  step
// добавлены дополн. действия с бэкапом
//
// Revision 1.10  2004/05/26 09:59:44  step
// изменена CanExecute
//
// Revision 1.9  2004/05/26 08:59:48  step
// исправлена проверка текущей версии
//
// Revision 1.8  2004/05/25 15:41:49  step
// new: classes TDocBaseUpgrade, TAdminBaseUpgrade
//
// Revision 1.7  2004/05/07 17:37:47  step
// куча мелких исправлений
//
// Revision 1.6  2004/03/10 14:33:09  step
// изменен алгоритм "Сохранения-Восстановления"
//
// Revision 1.5  2004/03/09 18:40:03  step
// добавлен update № 104 (изменение полей табл. FILE)
//
// Revision 1.4  2004/03/05 09:08:50  step
// мелкие исправления
//
// Revision 1.3  2004/03/04 18:03:10  step
// исправлен алгоритм сохранения-восстановления
//
// Revision 1.2  2004/03/02 15:47:00  step
// куча мелких изменений
//
// Revision 1.1  2004/03/01 19:04:54  step
// Занесен в CVS
//

interface

uses
 DT_DbReformer;

type
 TTableNamesArray = array of string;

 TUpgrade = class(TObject)
 private
  f_RestorableTables: TTableNamesArray;
 protected
  f_DbReformer: TDbReformer;

  function SaveBackup: Boolean; virtual;
   // создает резервную копию
  procedure DeleteBackup; virtual;
   // удаляет резервную копию
  function Undo: Boolean; virtual;
   // восстанавливает данные по резервной копии

  procedure AddToRestorableList(const aFullTableName: string);
   // добавление имени таблицы в список (используется функциями сохранения-восстановления)

  function DoJob: Boolean; virtual;
  function CanExecute: Boolean;
  class function CurVersion: Integer; virtual; abstract;
 protected
  // для переопределения в потомках
  procedure ModifyBd; virtual; abstract;           // собственно модификация БД
  class function NameEx: string; virtual; abstract;
  procedure AdvanceVersionNumber; virtual; abstract;
  procedure InitRestorableTableList; virtual;      // формирование списка модифицируемых таблиц БД

  procedure AfterSaveBackup; virtual;      // дополнительные действия при сохранении резервной копии
  procedure AfterUndo; virtual;      // дополнительные действия при восстановлении по резервной копии
  procedure AfterDeleteBackup; virtual;   // дополнительные действия при удалении резервной копии
 public
  constructor Create(aDbReformer: TDbReformer);
  destructor Free;
  class procedure Execute; virtual;

 public
  // для переопределения в потомках
  class function PrevVersion: Integer; virtual; abstract; // возвр. номер предыд. версии (той, на которую и накладывается update)
  class function Version: Integer; virtual; abstract;     // возвр. номер версии, который будет после наложения update'а
 end;

 TUpgradeClass = class of TUpgrade;

 TDocBaseUpgrade = class(TUpgrade)
 protected
  class function NameEx: string; override;
  class function CurVersion: Integer; override;
  procedure AdvanceVersionNumber; override;
  procedure AfterDeleteBackup; override;
 end;

TAdminBaseUpgrade = class(TUpgrade)
 protected
  class function NameEx: string; override;
  class function CurVersion: Integer; override;
  procedure AdvanceVersionNumber; override;
  procedure AfterDeleteBackup; override;
 end;


implementation

uses
 SysUtils,
 l3FileUtils,
 UpdateManager;

resourcestring
 c_BackupFileMask = '*.bak';

{ TUpgrade }

procedure TUpgrade.AddToRestorableList(const aFullTableName: string);
begin
 if f_RestorableTables = nil then
  SetLength(f_RestorableTables, 1)
 else
  SetLength(f_RestorableTables, Length(f_RestorableTables) + 1);

 f_RestorableTables[Length(f_RestorableTables) - 1] := aFullTableName;
end;

procedure TUpgrade.AfterDeleteBackup;
begin
end;

procedure TUpgrade.AfterSaveBackup;
begin
end;

procedure TUpgrade.AfterUndo;
begin
end;

function TUpgrade.CanExecute: Boolean;
begin
 Result := CurVersion = PrevVersion;
end;

constructor TUpgrade.Create(aDbReformer: TDbReformer);
begin
 f_DbReformer := aDbReformer;
end;

procedure TUpgrade.DeleteBackup;
begin
 with f_DbReformer do
 try
  if DirectoryExists(DirBackup) then
   DelDir(DirBackup);
  AfterDeleteBackup; 
  Log('Резервная копия данных предыдущей версии ' + NameEx + ' удалена.');
 except
  on E: Exception do
  begin
   Log(E.Message);
   Log('Не удалось удалить сохраненые данные предыдущей версии.');
  end;
 end;
end;

function TUpgrade.DoJob: Boolean;
begin
 Result := False;
 if CanExecute then
  with f_DbReformer do
  begin
   Log('=== Обновление ' + NameEx + ' до версии ' + IntToStr(Version) + ' ===');
   InitRestorableTableList;
   if SaveBackup then
   begin
    try
     ModifyBd; // очень даже может выбросить исключение

     // Меняем номер версии
     AdvanceVersionNumber;
     Log('Обновление ' + NameEx + ' до версии ' + IntToStr(Version) + ' выполнено успешно.');

     DeleteBackup;
    except
     on E: Exception do
     begin
      Error(E.Message);
      Log('Ошибка при обновлении ' + NameEx + ' до версии ' + IntToStr(Version) + '.');

      if Undo then
       DeleteBackup
      else
       Log('Не удалось воcстановить ' + NameEx + '.');
     end;
    end; // try-except
   end;
  end;
end;

class procedure TUpgrade.Execute;
begin
 if CurVersion = PrevVersion then
  with Create(TUpdateManager.DbReformer) do
  try
   DoJob;
  finally
   Free;
  end;
end;

destructor TUpgrade.Free;
begin
 f_RestorableTables := nil;
end;

procedure TUpgrade.InitRestorableTableList;
begin
 f_RestorableTables := nil;
end;

function TUpgrade.SaveBackup: Boolean;
var
 I: Integer;
begin
 with f_DbReformer do
 try
  Log('Сохранение резервной копии данных предыдущей версии ' + NameEx + '.');
  // создание папки BACKUP
  if not DirectoryExists(DirBackup) then
   ForceDirectories(DirBackup);

  for I := 0 to Length(f_RestorableTables) - 1 do
   SaveTable(f_RestorableTables[I]);

  AfterSaveBackup;
   
  Result := True;
 except
  on E: Exception do
  begin
   Log(E.Message);
   Log('Не удалось выполнить сохранение резервной копии данных предыдущей версии.');
   Result := False;
  end;
 end;
end;

function TUpgrade.Undo: Boolean;
var
 I: Integer;
begin
 with f_DbReformer do
 try
  for I := 0 to Length(f_RestorableTables) - 1 do
   RestoreTable(f_RestorableTables[I]);

  AfterUndo;

  Result := True;
  Log('Восстановлено состояние ' + NameEx + ' версии ' + IntToStr(PrevVersion));
 except
  on E: Exception do
  begin
   Log(E.Message);
   Log('Не удалось восстановить состояние ' + NameEx + ' версии ' + IntToStr(PrevVersion));
   Result := False;
  end;
 end;
end;

{ TDocBaseUpgrade }

procedure TDocBaseUpgrade.AdvanceVersionNumber;
begin
 f_DbReformer.CurFamilyVersion := Version;
end;

procedure TDocBaseUpgrade.AfterDeleteBackup;
begin
 inherited;
 DeleteFilesByMask(f_DbReformer.FamilyFolder, c_BackupFileMask);
end;

class function TDocBaseUpgrade.CurVersion: Integer;
begin
 Result := TUpdateManager.DbReformer.CurFamilyVersion;
end;

class function TDocBaseUpgrade.NameEx: string;
begin
 Result := 'базы документов';
end;

{ TAdminBaseUpgrade }

procedure TAdminBaseUpgrade.AdvanceVersionNumber;
begin
 f_DbReformer.MainFolderVersion := Version;
end;

procedure TAdminBaseUpgrade.AfterDeleteBackup;
begin
 inherited;
 DeleteFilesByMask(f_DbReformer.MainFolder, c_BackupFileMask);
end;

class function TAdminBaseUpgrade.CurVersion: Integer;
begin
 Result := TUpdateManager.DbReformer.MainFolderVersion;
end;

class function TAdminBaseUpgrade.NameEx: string;
begin
 Result := ' административной базы';
end;

end.
