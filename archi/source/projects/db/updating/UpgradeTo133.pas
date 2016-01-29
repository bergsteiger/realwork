unit UpgradeTo133;

{ $Id: UpgradeTo133.pas,v 1.1 2013/03/26 12:23:05 fireton Exp $ }

// $Log: UpgradeTo133.pas,v $
// Revision 1.1  2013/03/26 12:23:05  fireton
// - 133 версия базы
//

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo133_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBD; override;
 public
  class function PrevVersion: Integer; override; // 131
  class function Version: Integer; override;     // 132
 end;

 TUpgradeTo133_DOC = class(TDocBaseUpgrade)
 private
  procedure RemoveComentField;
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 131
  class function Version: Integer; override;     // 132
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc}

const
 DT7_TBL = 'DT#7001';
 c_ComentFieldName = 'Coment';

class function TUpgradeTo133_MAIN.PrevVersion: Integer;
begin
 Result := 132;
end;

procedure fn_RemoveComentField(var aStruct: TElemArray; aData: Pointer = nil);
const
 cTargetLen = 5;
 cLastIdx   = 5;
begin
 // переносим поле LDocID выше
 aStruct[cLastIdx-1] := aStruct[cLastIdx];
 // последнего поля больше нет
 SetLength(aStruct, cTargetLen);
end;

procedure TUpgradeTo133_MAIN.ModifyBD;
begin
 f_DbReformer.Log('Увеличиваем номер версии базы');
end;

class function TUpgradeTo133_MAIN.Version: Integer;
begin
 Result := 133;
end;

procedure TUpgradeTo133_DOC.RemoveComentField;
begin
 with f_DbReformer do
 begin
  Log('*** Удаляем поле "Coment" из DT#7001 ***');
  RestructTable(DT7_TBL, ffGarant, fn_RemoveComentField);
 end; // with;
end;

procedure TUpgradeTo133_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(DT7_TBL));
 end;
end;

procedure TUpgradeTo133_DOC.ModifyBd;
begin
 RemoveComentField;
end;

class function TUpgradeTo133_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo133_DOC.PrevVersion: Integer;
begin
 Result := 132;
end;

class function TUpgradeTo133_DOC.Version: Integer;
begin
 Result := 133;
end;


end.

