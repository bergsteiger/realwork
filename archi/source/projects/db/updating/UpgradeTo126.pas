unit UpgradeTo126;

// Добавляем регионы. Теперь старший байт UserID - это код региона
// Апдейт заключается в подкладывании новой таблицы с кодами регионов

{ $Id: UpgradeTo126.pas,v 1.3 2011/12/12 14:02:52 fireton Exp $}

// $Log: UpgradeTo126.pas,v $
// Revision 1.3  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.2  2007/12/03 14:00:54  fireton
// - отвязываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.1  2007/04/18 12:38:22  fireton
// - update админской базы до 126 (регионы)
//

interface

uses
 SysUtils,

 DT_DbReformer,
 DbUpgrade;

type

 EUpdate126Error = class(Exception);

 TUpgradeTo126 = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBd; override;
 public
  class function PrevVersion: Integer; override; // 113
  class function Version: Integer; override;     // 115
 end;

implementation

{$RESOURCE regions.res}

uses
 Windows,
 Classes;

{$INCLUDE nodt_const.inc} 

class function TUpgradeTo126.PrevVersion: Integer;
begin
 Result := 125;
end;

procedure WriteFileFromResource(anID: string; aFileName: string);
var
 l_RCH: HRSRC;
 l_Ptr: Pointer;
 l_Size: Longword;
 l_File: TFileStream;
begin
 l_RCH := FindResource(0, PChar(anID), 'RC_DATA');
 if l_RCH <> 0 then
 begin
  l_Size := SizeofResource(0, l_RCH);
  l_RCH := LoadResource(0, l_RCH);
  if l_RCH <> 0 then
  try
   l_File := TFileStream.Create(aFileName, fmCreate);
   try
    l_Ptr := LockResource(l_RCH);
    l_File.WriteBuffer(l_Ptr^, l_Size);
   finally
    l_File.Free;
   end;
  finally
   FreeResource(l_RCH);
  end
  else
   raise EUpdate126Error.Create('Не могу загрузить ресурс');
 end
 else
  raise EUpdate126Error.Create('Не могу найти ресурс');
end;

procedure TUpgradeTo126.ModifyBd;
begin
 with f_DbReformer do
 begin
  WriteFileFromResource('REGDATA_1', MainTable('REGIONS.HTB'));
  WriteFileFromResource('REGDATA_2', MainTable('REGIONS.HDT'));
  WriteFileFromResource('REGDATA_3', MainTable('REGIONS.HAS'));
 end;
end;

class function TUpgradeTo126.Version: Integer;
begin
 Result := 126;
end;

const
 TBL_DT_9  = 'DT#9001';
 TBL_LOG   = 'LOG001';
 TBL_STAGE = 'STAGE001';



end.

