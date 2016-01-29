unit SavedQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/NOT_FINISHED_SavedQuery.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DT::Query::TSavedQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\DT\DtDefine.inc}

interface

uses
  l3ProtoObject,
  dt_Types,
  dt_Query
  ;

type
 TSavedQuery = class(Tl3ProtoObject)
 private
  fName     : String;
  fFamily   : Longint;
  f_FileName: TPathStr;

 public
  constructor CreateFromFile(aFileName : TPathStr);
  constructor Create(aName : String);

  function CompareWith(anObject: TSavedQuery): Integer;
     {* функция сравнения объекта с другим объектом. }

  procedure LoadHeader;
  procedure Save(aQuery : TdtQuery);

  function MakeQuery : TdtQuery;
  procedure DeletePersist;

  property Name     : String read fName write fName;
  property FileName: TPathStr read f_FileName write f_FileName;
  property Family   : Longint read fFamily;
 end;//TSavedQuery

implementation

uses
  Classes,
  l3String,
  l3Stream,
  l3Types,
  SysUtils
  ;

{TSavedQuery}
constructor TSavedQuery.CreateFromFile(aFileName : TPathStr);
begin
 inherited Create;
 f_FileName := aFileName;
 LoadHeader;
end;

constructor TSavedQuery.Create(aName : String);
begin
 inherited Create;
 fFamily := 1;
 fName := aName;
end;

function TSavedQuery.CompareWith(anObject: TSavedQuery): Integer;
begin
 Result := l3Compare(fName, TSavedQuery(anObject).Name);
end;

procedure TSavedQuery.LoadHeader;
var
 aStream    : Tl3FileStream;
 lVersion   : Longint;
 lHeaderLen : Longint;
 lNameLen   : Longint;
begin
 Assert(f_FileName <> '');
 aStream := Tl3FileStream.Create(f_FileName, l3_fmReadWrite);
 try
  aStream.Read(lVersion, SizeOf(Longint));
  aStream.Read(lHeaderLen, SizeOf(Longint));
  aStream.Read(fFamily, SizeOf(Longint));
  aStream.Read(lNameLen, SizeOf(Longint));
  SetLength(fName, lNameLen);
  if lNameLen > 0 then
   aStream.Read(fName[1], lNameLen);
 finally
  FreeAndNil(aStream);
 end;
end;

function TSavedQuery.MakeQuery : TdtQuery;
var
 lStream    : Tl3FileStream;
 lVersion   : Longint;
 lHeaderLen : Longint;
 lNameLen   : Longint;
begin
 Assert(f_FileName <> '');
 lStream := Tl3FileStream.Create(f_FileName, l3_fmReadWrite);
 try
  lStream.Read(lVersion, SizeOf(Longint));
  lStream.Read(lHeaderLen, SizeOf(Longint));
  lStream.Seek(lHeaderLen, soBeginning);
  Result := g_dtLoadQuery(lStream);
 finally
  FreeAndNil(lStream);
 end;
end;

procedure TSavedQuery.Save(aQuery : TdtQuery);
var
 lStream    : Tl3FileStream;
 lVersion   : Longint;
 lHeaderLen : Longint;
 lNameLen   : Longint;
begin
 Assert(f_FileName <> '', 'Нельзя сохранять запрос без имени файла');
 lStream := Tl3FileStream.Create(f_FileName, l3_fmCreateReadWrite);
 try
  lVersion := 0;
  lStream.Write(lVersion, SizeOf(Longint));
  lNameLen := Length(fName);
  lHeaderLen := SizeOf(Longint) {lVersion} + SizeOf(Longint) {lHeaderLen} + SizeOf(Longint) {fFamily} + SizeOf(Longint) {lNameLen} + lNameLen;
  lStream.Write(lHeaderLen, SizeOf(Longint));
  lStream.Write(fFamily, SizeOf(Longint));
  lStream.Write(lNameLen, SizeOf(Longint));
  lStream.Write(fName[1], lNameLen);
  g_dtSaveQuery(aQuery, lStream);
 finally
  FreeAndNil(lStream);
 end;
end;

procedure TSavedQuery.DeletePersist;
begin
 if f_FileName <> '' then
  SysUtils.DeleteFile(f_FileName);
end;

end.