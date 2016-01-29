Unit Base_CFG;

{ Различные настройки и доточки напильником }

{ $Id: Base_CFG.pas,v 1.7 2013/06/14 13:57:47 voba Exp $ }

// $Log: Base_CFG.pas,v $
// Revision 1.7  2013/06/14 13:57:47  voba
// - K:435458154
//
// Revision 1.6  2008/02/07 14:43:46  lulin
// - класс Tl3LongintList переехал в собственный модуль.
//
// Revision 1.5  2007/04/10 14:13:02  narry
// - расширение функциональности
//
// Revision 1.4  2004/12/23 11:47:05  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.3  2004/05/18 09:34:40  step
// change: GlobalFamPaths[] --> GlobalHtServer.FamilyTbl.FamilyPath()
//
// Revision 1.2  2004/05/07 16:12:34  law
// - поправлены пути.
//
// Revision 1.1  2003/12/22 14:13:54  narry
// - new : очередной напильник
//

interface

Uses
 l3IniFile, l3Base,
 dt_Types, Classes,
 l3LongintList
 ;

type
 TBaseMagic = class(TCFGList)
 private
  function pm_GetMagicString(aSection, aKey: String): string;
  function pm_GetMagicDateTime(aSection, aKey: String): TDateTime;
  function pm_GetMagicNumber(aSection, aKey: String): Integer;
  function pm_GetMagicStringsList(aSection, aKey: String): TStrings;
  function pm_GetMagicNumbersList(aSection, aKey: String): Tl3LongintList;
  procedure pm_SetMagicString(aSection, aKey: String; const Value: string);
  procedure pm_SetMagicDateTime(aSection, aKey: String; const Value: TDateTime);
  procedure pm_SetMagicNumber(aSection, aKey: String; const Value: Integer);
  procedure pm_SetMagicStringsList(aSection, aKey: String; const Value: TStrings);
  procedure pm_SetMagicNumbersList(aSection, aKey: String; const Value: Tl3LongintList);
 public
  property MagicString[aSection, aKey: String]: string
   read pm_GetMagicString
   write pm_SetMagicString;
  property MagicDateTime[aSection, aKey: String]: TDateTime
   read pm_GetMagicDateTime
   write pm_SetMagicDateTime;
  property MagicNumber[aSection, aKey: String]: Integer
   read pm_GetMagicNumber
   write pm_SetMagicNumber;
  property MagicStringsList[aSection, aKey: String]: TStrings
   read pm_GetMagicStringsList
   write pm_SetMagicStringsList;
  property MagicNumbersList[aSection, aKey: String]: Tl3LongintList
   read pm_GetMagicNumbersList
   write pm_SetMagicNumbersList;
 end;

procedure InitBaseConfig(aFamily: TFamilyID);
procedure DoneBaseConfig;

var
 BaseConfig : TBaseMagic = nil;

implementation

Uses
 SysUtils,
 Dt_Serv,
 rxStrUtils;


procedure InitBaseConfig(aFamily: TFamilyID);
var
 l_FileName: String;
begin
 l_FileName:= GlobalHtServer.FamilyTbl.FamilyPath(aFamily)+'base.ini';
 if (BaseConfig <> nil) and (BaseConfig.CfgFileName <> l_FileName) then
  l3Free(BaseConfig);
 if BaseConfig = nil then
  BaseConfig:= TBaseMagic.Create(l_FileName);
end;

procedure DoneBaseConfig;
begin
 l3Free(BaseConfig);
end;

function TBaseMagic.pm_GetMagicDateTime(aSection, aKey: String): TDateTime;
begin
 Section := aSection;
 Result := ReadParamDateTimeDef(aKey, 0);
end;

function TBaseMagic.pm_GetMagicNumber(aSection, aKey: String): Integer;
begin
 Section := aSection;
 Result := ReadParamIntDef(aKey, 0);
end;

function TBaseMagic.pm_GetMagicStringsList(aSection, aKey: String): TStrings;
var
 l_List: String;
 i: Integer;
begin
 Result := TStringList.Create;
 l_List:= MagicString[aSection, aKey];
 for i:= 1 to WordCount(l_List, [';',',']) do
  Result.add(ExtractWord(i, l_LIst, [';',',']));
end;

function TBaseMagic.pm_GetMagicString(aSection, aKey: String): string;
begin
 Section := aSection;
 Result := ReadParamStrDef(aKey, '');
end;

function TBaseMagic.pm_GetMagicNumbersList(aSection, aKey: String): Tl3LongintList;
var
 l_List: TStrings;
 i: Integer;
begin
 Result := Tl3LongintList.Make;
 l_List:= MagicStringsList[aSection, aKey];
 try
  for i:= 0 to Pred(l_List.Count) do
  try
   Result.Add(StrToInt(l_List.Strings[i]));
  except
  end
 finally
  l3Free(l_List)
 end;
end;

procedure TBaseMagic.pm_SetMagicDateTime(aSection, aKey: String; const Value: TDateTime);
begin
 Section := aSection;
 WriteParamDateTime(aKey, Value);
end;

procedure TBaseMagic.pm_SetMagicNumber(aSection, aKey: String; const Value: Integer);
begin
 Section := aSection;
 WriteParamInt(aKey, Value);
end;

procedure TBaseMagic.pm_SetMagicStringsList(aSection, aKey: String; const Value: TStrings);
begin
 MagicString[aSection, aKey] := Value.CommaText;
end;

procedure TBaseMagic.pm_SetMagicString(aSection, aKey: String; const Value: string);
begin
 Section := aSection;
 WriteParamStr(aKey, Value);
end;

procedure TBaseMagic.pm_SetMagicNumbersList(aSection, aKey: String; const Value: Tl3LongintList);
var
 l_List: TStrings;
 i: Integer;
begin
 l_List:= TStringList.Create;
 try
  for i:= 0 to Value.Hi do
   l_List.Add(IntToStr(Value.Items[i]));
  MagicStringsList[aSection, aKey] := l_List;
 finally
  l3Free(l_List);
 end;
end;

initialization
finalization
 DoneBaseConfig;
end.
