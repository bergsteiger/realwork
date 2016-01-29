Unit VersionSupport;
{* Проверка на правильность номера версии }

{ Автор: Дудко Д.В. }
{ Модуль: VersionSupport}
{ Начат: 01.10.2002 }
{ $Id: VersionSupport.pas,v 1.7 2004/12/23 11:47:02 lulin Exp $ }

// $Log: VersionSupport.pas,v $
// Revision 1.7  2004/12/23 11:47:02  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.6  2003/12/05 17:05:11  voba
// - add procedure CompareLongVersions
//
// Revision 1.5  2002/10/16 10:58:05  narry
// - new behavior: больше не обновляет файл с версией, добавлен параметр максимальной версии
//
// Revision 1.4  2002/10/15 06:27:22  narry
// - new behavior: обновление номера версии
//
// Revision 1.3  2002/10/02 06:48:55  narry
// - bug fix: ошибки синтаксиса
//
// Revision 1.2  2002/10/01 14:53:13  narry
// - update
//
// Revision 1.1  2002/10/01 14:30:26  voba
// Проверка номера версии Архивариуса
//

interface

function IsValidVersion: Boolean;

implementation
Uses
 vtVerInf, l3IniFile, l3FileUtils, SysUtils;


function VersionFileName: String;
var
  S: ShortString;
begin
  ServerConfig.Section:= 'FamilyConst';
  S:= ServerConfig.ReadParamStrDef('FamilyPath', '');
  Result:= ConcatDirName(S, 'archi.version');
end;


function IsValidVersion: Boolean;
var

 l_MyVersion : TLongVersion;
 l_ArchiVersionLo,
 l_ArchiVersionHi: String;
begin
 with TVersionInfo.Create, FileLongVersion do
  try
   l_MyVersion := FileLongVersion;
  finally
   Free;
  end; // with
 l_ArchiVersionLo:= '0.0.0.0';
 l_ArchiVersionHi:= '9.9.9.9';
 if FileExists(VersionFileName) then
 begin
  with TCfgList.Create(VersionFileName)do
  try
   Section:= 'Version';
   l_ArchiVersionLo:= ReadParamStrDef('Ver', l_ArchiVersionLo);
   l_ArchiVersionHi:= ReadParamStrDef('VerMax', l_ArchiVersionHi);
  finally
   Free;
  end; // try..finally
 end;
 Result := (CompareLongVersions(l_MyVersion, StringToLongVersion(l_ArchiVersionLo)) >= 0) and
           (CompareLongVersions(l_MyVersion, StringToLongVersion(l_ArchiVersionHi)) <= 0);
end;

end.