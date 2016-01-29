unit UpgradeTo115;

// Переход на HyTech 64. Все связанное с большим UserID уехало в UpgradeTo125

{ $Id: UpgradeTo115.pas,v 1.7 2011/12/12 14:02:52 fireton Exp $}

// $Log: UpgradeTo115.pas,v $
// Revision 1.7  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.6  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.5  2007/10/19 13:53:15  narry
// - исправление ошибок обновления с базы 113 на 129
//
// Revision 1.4  2007/02/22 15:00:58  fireton
// - переход на 64 бита в HyTech
//

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo115_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBd; override;
 public
  class function PrevVersion: Integer; override; // 113
  class function Version: Integer; override;     // 115
 end;

 TUpgradeTo115_DOC = class(TDocBaseUpgrade)
 private
 protected
  procedure ModifyBd; override;
  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 114
  class function Version: Integer; override;     // 115
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const,
 DT_Types;

{.$INCLUDE nodt_const.inc}

const
 MainTblNames : Array [1..10] of TTblNameStr =
                 ('ACCESS','PASS','USERS','GUDT','GULNK',
                  'FAMILY','FREE','BB_LOG', 'CTRL', 'REGIONS');
 MainPassIndex : Array[1..10] of Byte = (1,1,0,0,0,0,0,1,0,0);

 FamTblNames : Array [1..49] of TTblNameStr =
                ('FILE','HLINK','SUB','FREE',
                 'DT#1','DT#2','DT#3','DT#5','DT#5E',
                 'DT#6','DT#7','DT#8','DT#9','DT#A',
                 'DT#B','DT#C','DT#D','DT#E','DT#3E',
                 'DT#F','DT#G','DT#GE','DT#I',

                 'LNK#1','LNK#2','LNK#3','LNK#4','LNK#5',
                 'LNK#6','LNK#7','LNK#8','LNK#9','LNK#A',
                 'LNK#B','LNK#C','LNK#D','LNK#E',
                 'LNK#F','LNK#G', 'LNK#H', 'LNK#I','LNK#J',
                 'PRIOR','RENUM','STAGE','LOG',
                 'ACTIV', 'ALARM', 'CTRL');

 FamPassIndex : Array[1..49] of Byte =
                (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

 TblPassW : Array [0..1] of String[8] = ('','corvax');

const
 TEMP_TABLE = 'TEMP_TBL';

class function TUpgradeTo115_MAIN.PrevVersion: Integer;
begin
 Result := 113;
end;

procedure TUpgradeTo115_MAIN.ModifyBd;
var
 l_TempStr: string;
 l_PassStr: string;
 l_Pass: PChar;
 l_Res: SmallInt;
 I: Integer;
begin
 // избавляемся от двоек в именах таблиц ACCESS2 и DICTSRC2
 with f_DbReformer do
 begin
  if RenameTableDirect(MainTable('ACCESS2'), MainTable('ACCESS')) and
     RenameTableDirect(MainTable('DICTSRC2'), MainTable('DICTSRC')) then
  begin
   // конвертируем таблицы в 64 бита
   Log('*** Конвертация таблиц в 64-битный формат ***');
   for I := 1 to 10 do
   begin
    Log('Конвертируется таблица ' + MainTblNames[I]);
    l_TempStr := MainTable(MainTblNames[I]);
    l_PassStr := TblPassW[MainPassIndex[I]];
    if l_PassStr <> '' then
     l_Pass := @l_PassStr[1]
    else
     l_Pass := nil;
    if FileExists(ChangeFileExt(l_TempStr,'.htb')) then
    begin
     l_Res := htConvertTable(@l_TempStr[1], @l_TempStr[1], l_Pass, l_Pass, HT_48);
     if l_Res < 0 then
      Exception.Create('Ошибка при конвертации таблицы');
    end
    else
     Log(Format('Таблица %s не найдена', [MainTblNames[I]]));
   end;
  end
  else
   Exception.Create('Ошибка при переименовании таблиц');
 end;
end;

class function TUpgradeTo115_MAIN.Version: Integer;
begin
 Result := 115;
end;


procedure TUpgradeTo115_DOC.ModifyBd;
var
 l_TempStr: string;
 l_PassStr: string;
 l_Pass: PChar;
 l_Res: SmallInt;
 I: Integer;
begin
 with f_DbReformer do
 begin
  // конвертируем таблицы в 64 бита
  Log('*** Конвертация таблиц в 64-битный формат ***');
  for I := 1 to 49 do
  begin
   Log('Конвертируется таблица ' + FamTblNames[I]);
   l_TempStr := FamilyTable(FamTblNames[I]) + '001'; // пока так. если будет больше семейств - переделаем
   l_PassStr := TblPassW[FamPassIndex[I]];
   if l_PassStr <> '' then
    l_Pass := @l_PassStr[1]
   else
    l_Pass := nil;
   if FileExists(ChangeFileExt(l_TempStr,'.htb')) then
   begin
    l_Res := htConvertTable(@l_TempStr[1], @l_TempStr[1], l_Pass, l_Pass, HT_48);
    if l_Res < 0 then
     Exception.Create('Ошибка при конвертации таблицы');
   end
   else
    Log(Format('Таблица %s не найдена', [FamTblNames[I]]));
  end;
 end;
end;

class function TUpgradeTo115_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo115_DOC.PrevVersion: Integer;
begin
 Result := 114;
end;

class function TUpgradeTo115_DOC.Version: Integer;
begin
 Result := 115;
end;


end.

