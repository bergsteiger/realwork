unit UpgradeTo131;

// —оздаем новую таблицу LNK#K - св€зь между измен€ющим и измен€емым документом <K 77235676>
//   DocID : DWORD // документ которому принадлежит атрибут
//   LinkType : byte // тип св€зи
//   LinkDocID : DWORD // документ с которым св€зан DocID (параметр св€зи)
//   все пол€ ключевые, уникальных ключей нет

// ƒобавл€ем поле COMMENT string[100] в таблицу FILE   <K 121164344>

{ $Id: UpgradeTo131.pas,v 1.3 2012/02/08 07:29:49 fireton Exp $ }

// $Log: UpgradeTo131.pas,v $
// Revision 1.3  2012/02/08 07:29:49  fireton
// - исправление нескольких ошибок
//
// Revision 1.2  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.1  2009/02/09 10:54:34  fireton
// - верси€ базы 131
//


interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo131_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBD; override;
 public
  class function PrevVersion: Integer; override; // 130
  class function Version: Integer; override;     // 131
 end;

 TUpgradeTo131_DOC = class(TDocBaseUpgrade)
 private
  procedure AddCommentField;
  procedure CreateLnkKTable;
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 130
  class function Version: Integer; override;     // 131
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc}

const
 FILE_TBL = 'FILE001';
 LNKK_TBL = 'LNK#K001';
 c_CommentFieldName = 'Comment';

class function TUpgradeTo131_MAIN.PrevVersion: Integer;
begin
 Result := 130;
end;

procedure fn_AddCommentField(var aStruct: TElemArray; aData: Pointer = nil);
var
 l_Idx: Integer;
begin
 SetLength(aStruct, Length(aStruct) + 1);
 l_Idx := Length(aStruct)-1;
 // добавление полей
 FillChar(aStruct[l_Idx], SizeOf(aStruct[l_Idx]), #0);
 with aStruct[l_Idx] do
 begin
  wLength := 100;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_CHAR;
  cKey    := EK_NOTKEY;
  mName   := c_CommentFieldName;
 end;
end;

procedure TUpgradeTo131_MAIN.ModifyBD;
begin
 f_DbReformer.Log('”величиваем номер версии базы');
end;

class function TUpgradeTo131_MAIN.Version: Integer;
begin
 Result := 131;
end;

procedure TUpgradeTo131_DOC.AddCommentField;
begin
 with f_DbReformer do
 begin
  Log('*** ƒобавл€ем поле "Comment" в FILE001 ***');
  RestructTable(FILE_TBL, ffGarant, fn_AddCommentField);
 end; // with;
end;

procedure TUpgradeTo131_DOC.CreateLnkKTable;
var
 l_Struct: TElemArray;
begin
 with f_DbReformer do
 begin
  Log('*** —оздаем новую таблицу LNK#K001 ***');
  SetLength(l_Struct, 4);
  // определ€ем пол€
  with l_Struct[0] do
  begin
   wLength := 0;
   wOffset := 0;
   cClass  := EC_FIELD;
   cType   := ET_DWRD;
   cKey    := EK_COMMON;
   mName   := 'DocID';
  end;
  with l_Struct[1] do
  begin
   wLength := 0;
   wOffset := 0;
   cClass  := EC_FIELD;
   cType   := ET_BYTE;
   cKey    := EK_COMMON;
   mName   := 'LinkType';
  end;
  with l_Struct[2] do
  begin
   wLength := 0;
   wOffset := 0;
   cClass  := EC_FIELD;
   cType   := ET_DWRD;
   cKey    := EK_COMMON;
   mName   := 'LinkDocID';
  end;
  with l_Struct[3] do
  begin
   wLength := 3;
   wOffset := 1;
   cClass  := EC_GROUP;
   cType   := ET_NMBR;
   cKey    := EK_UNIQUE;
   mName   := 'Unikey';
  end;
  CreateTable(l_Struct, LNKK_TBL, ffGarant);
 end;
end;

procedure TUpgradeTo131_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(FILE_TBL));
 end;
end;

procedure TUpgradeTo131_DOC.ModifyBd;
begin
 AddCommentField;
 CreateLnkKTable;
end;

class function TUpgradeTo131_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo131_DOC.PrevVersion: Integer;
begin
 Result := 130;
end;

class function TUpgradeTo131_DOC.Version: Integer;
begin
 Result := 131;
end;


end.

