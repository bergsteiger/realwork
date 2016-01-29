unit dtSubTableMiscUpdate;

// ¬незапно обнаружили, что в таблице SUB не хватает ключа
// ѕри этом, почти весь код нормально работает, т.е. версию поднимать не надо
// Ќадо тихонько добавить ключ

{ $Id: dtSubTableMiscUpdate.pas,v 1.2 2011/12/12 14:03:17 fireton Exp $ }

// $Log: dtSubTableMiscUpdate.pas,v $
// Revision 1.2  2011/12/12 14:03:17  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.1  2011/12/09 06:58:06  narry
// перенесен в dbupdate
//
// Revision 1.1  2011/12/01 14:59:33  fireton
// - обновление таблицы SUB001
//

interface

// ѕроцедура проверит версию базы и количество полей в таблице SUB001
function IsSubTableUpdateNeeded(const aBasePath: string): Boolean;

// ¬ыполнит проверку и добавит недостающее поле при необходимости
procedure AddKeyToSubTable(const aBasePath: string);

implementation
uses
 SysUtils,

 HT_Const,

 l3Base,

 DT_DbInfo,
 DT_DbReformer;

const
 cTargetBaseVer = 131;
 cSubTblName = 'SUB001';

type
 TSysLogDbReformer = class (TDbReformer)
 public
  procedure Log(const aStr: string; aShowTime: Boolean = False); override;
 end;

procedure fn_AddDocSubGroup(var aStruct: TElemArray; aData: Pointer = nil);
var
 l_Idx: Integer;
begin
 SetLength(aStruct, Length(aStruct) + 1);
 l_Idx := Length(aStruct)-1;
 // добавление полей
 l3FillChar(aStruct[l_Idx], SizeOf(aStruct[l_Idx]));
 with aStruct[l_Idx] do
 begin
  wLength := 2;
  wOffset := 1;
  cClass  := EC_GROUP;
  cType   := 8;
  cKey    := EK_UNIQUE;
  mName   := 'UniKey';
 end;
end;

procedure AddKeyToSubTable(const aBasePath: string);
var
 l_Count: Integer;
 l_Info: TDbInfo;
 l_Reformer: TSysLogDbReformer;
 l_Struct: TTableStruct;
 l_PathToTable: string;
begin
 l_Info := TDbInfo.Make(aBasePath);
 try
  if l_Info.FamilyFolderVersion = cTargetBaseVer then
  begin
   l_Reformer := TSysLogDbReformer.Create(l_Info);
   try
    l_PathToTable := l_Reformer.FamilyTable(cSubTblName);
    l_Struct := TTableStruct.Create(l_PathToTable);
    try
     l_Count := l_Struct.TableInfo.nGroupCnt;
    finally
     FreeAndNil(l_Struct);
    end;
    if l_Count = 0 then
     l_Reformer.RestructTable(cSubTblName, ffGarant, fn_AddDocSubGroup);
   finally
    FreeAndNil(l_Reformer);
   end;
  end;
 finally
  FreeAndNil(l_Info);
 end;
end;

function IsSubTableUpdateNeeded(const aBasePath: string): Boolean;
var
 l_Count: Integer;
 l_Info: TDbInfo;
 l_Reformer: TSysLogDbReformer;
 l_Struct: TTableStruct;
 l_PathToTable: string;
begin
 Result := False;
 l_Info := TDbInfo.Make(aBasePath);
 try
  if l_Info.FamilyFolderVersion = cTargetBaseVer then
  begin
   l_Reformer := TSysLogDbReformer.Create(l_Info);
   try
    l_PathToTable := l_Reformer.FamilyTable(cSubTblName);
    l_Struct := TTableStruct.Create(l_PathToTable);
    try
     l_Count := l_Struct.TableInfo.nGroupCnt;
    finally
     FreeAndNil(l_Struct);
    end;
    Result := (l_Count = 0);
   finally
    FreeAndNil(l_Reformer);
   end;
  end;
 finally
  FreeAndNil(l_Info);
 end;
end;

procedure TSysLogDbReformer.Log(const aStr: string; aShowTime: Boolean = False);
begin
 inherited;
 l3System.Msg2Log(aStr);
end;

end.
