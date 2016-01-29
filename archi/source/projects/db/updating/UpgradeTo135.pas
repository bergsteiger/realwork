unit UpgradeTo135;

{ $Id: UpgradeTo135.pas,v 1.1 2013/12/20 07:58:43 fireton Exp $ }

// Меняем местами поля SourDoc и ID в таблице HLINK
// Удаляем поле Station из таблицы LOG

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo135_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBD; override;
 public
  class function PrevVersion: Integer; override; // 134
  class function Version: Integer; override;     // 135
 end;

 TUpgradeTo135_DOC = class(TDocBaseUpgrade)
 private
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 134
  class function Version: Integer; override;     // 135
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc}

const
 HLINK_TBL = 'HLINK001';
 LOG_TBL   = 'LOG001';
 c_LSubIDFieldName = 'LSubID';

class function TUpgradeTo135_MAIN.PrevVersion: Integer;
begin
 Result := 134;
end;

procedure fn_ExchangeFirstTwoFields(var aStruct: TElemArray; aData: Pointer = nil);
var
 l_Tmp: ThtElementInfo;
begin
 l_Tmp := aStruct[0];
 aStruct[0] := aStruct[1];
 aStruct[1] := l_Tmp;
end;

procedure fn_DeleteStationField(var aStruct: TElemArray; aData: Pointer = nil);
begin
 aStruct[5] := aStruct[6];
 aStruct[6] := aStruct[7];
 SetLength(aStruct, 7);
end;

procedure TUpgradeTo135_MAIN.ModifyBD;
begin
 f_DbReformer.Log('Увеличиваем номер версии базы');
end;

class function TUpgradeTo135_MAIN.Version: Integer;
begin
 Result := 135;
end;

procedure TUpgradeTo135_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(HLINK_TBL));
  AddToRestorableList(FamilyTable(LOG_TBL));
 end;
end;

procedure TUpgradeTo135_DOC.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('*** Меняем местами поля SourDoc и ID в HLINK001 ***');
  RestructTable(HLINK_TBL, ffGarant, fn_ExchangeFirstTwoFields);
  Log('*** Удаляем поле Station из LOG001 ***');
  RestructTable(LOG_TBL, ffGarant, fn_DeleteStationField);
 end; // with;
end;

class function TUpgradeTo135_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo135_DOC.PrevVersion: Integer;
begin
 Result := 134;
end;

class function TUpgradeTo135_DOC.Version: Integer;
begin
 Result := 135;
end;


end.

