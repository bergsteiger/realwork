unit UpgradeTo130;

// ƒобавление пол€ "Urgency" в таблицу FILE
// »зменение длины пол€ Number в таблице DT#B (Publisheds) на 30
// »зменение длины пол€ No в таблице DT#7 (DateNums) на 50
// ƒобавление пол€ "LDocID" в таблицу DT#7 (DateNums)

{ $Id: UpgradeTo130.pas,v 1.6 2011/12/12 14:02:52 fireton Exp $}

// $Log: UpgradeTo130.pas,v $
// Revision 1.6  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.5  2008/09/18 07:57:09  fireton
// - добавлен ключ к Urgency
// - убрано заполнение значени€ми
//
// Revision 1.4  2008/09/17 14:28:36  fireton
// - нова€ верси€ базы (130)
//
// Revision 1.3  2008/02/15 08:49:35  fireton
// - 130 верси€ базы (атрибут "срочность" у документа)
//
// Revision 1.2  2007/12/03 14:00:54  fireton
// - отв€зываем updater от имен таблиц dt_const и проводим профилактику подобных злоупотреблений
//
// Revision 1.1  2007/11/28 12:27:07  fireton
// - обновление базы до версии 130
//


interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo130_MAIN = class(TAdminBaseUpgrade)
 private
 protected
  procedure ModifyBD; override;
 public
  class function PrevVersion: Integer; override; // 129
  class function Version: Integer; override;     // 130
 end;

 TUpgradeTo130_DOC = class(TDocBaseUpgrade)
 private
  procedure AddUrgencyField;
  procedure EnlargeNumberField;
  procedure ModifyDateNums;
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;

  class function NameEx: string; override;
 public
  class function PrevVersion: Integer; override; // 129
  class function Version: Integer; override;     // 130
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
 DTB_TBL  = 'DT#B001';
 DT7_TBL  = 'DT#7001';
 c_UrgencyFieldName = 'Urgency';
 c_LDocIDFieldName  = 'LDocID';
 DEF_URGENCY: Byte = 0;

class function TUpgradeTo130_MAIN.PrevVersion: Integer;
begin
 Result := 129;
end;

procedure fn_AddUrgencyField(var aStruct: TElemArray; aData: Pointer = nil);
var
 l_Idx: Integer;
begin
 SetLength(aStruct, Length(aStruct) + 1);
 l_Idx := Length(aStruct)-1;
 // добавление полей
 FillChar(aStruct[l_Idx], SizeOf(aStruct[l_Idx]), #0);
 with aStruct[l_Idx] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_BYTE;
  cKey    := EK_COMMON;
  mName   := c_UrgencyFieldName;
 end;
end;

procedure fn_EnlargeNumberFld(var aStruct: TElemArray; aData: Pointer = nil);
begin
 with aStruct[4] do // Number
 begin
  wLength := 30;
 end;
end;

procedure fn_ModifyDateNums(var aStruct: TElemArray; aData: Pointer = nil);
var
 l_Idx: Integer;
begin
 // увеличиваем длину пол€ No до 50
 with aStruct[2] do // No
 begin
  wLength := 50;
 end;

 // добавл€ем поле LDocID
 SetLength(aStruct, Length(aStruct) + 1);
 l_Idx := Length(aStruct)-1;
 FillChar(aStruct[l_Idx], SizeOf(aStruct[l_Idx]), #0);
 with aStruct[l_Idx] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_DWRD;
  cKey    := EK_NOTKEY;
  mName   := c_LDocIDFieldName;
 end;
end;

procedure TUpgradeTo130_MAIN.ModifyBD;
begin
 f_DbReformer.Log('”величиваем номер версии базы');
end;

class function TUpgradeTo130_MAIN.Version: Integer;
begin
 Result := 130;
end;

procedure TUpgradeTo130_DOC.AddUrgencyField;
begin
 with f_DbReformer do
 begin
  Log('*** ƒобавл€ем поле "Urgency" в FILE001 ***');
  RestructTable(FILE_TBL, ffGarant, fn_AddUrgencyField);
  {
  Log('«аполнен€ем новое пол€ исходными значени€ми.');
  SetFieldValue(FamilyTable(FILE_TBL), 16, DEF_URGENCY);
  }
 end; // with;
end;

procedure TUpgradeTo130_DOC.EnlargeNumberField;
begin
 with f_DbReformer do
 begin
  Log('*** ”величиваем длину пол€ "Number" в DT#B001 ***');
  RestructTable(DTB_TBL, ffGarant, fn_EnlargeNumberFld);
 end;
end;

procedure TUpgradeTo130_DOC.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(FILE_TBL));
  AddToRestorableList(FamilyTable(DTB_TBL));
  AddToRestorableList(FamilyTable(DT7_TBL));
 end;
end;

procedure TUpgradeTo130_DOC.ModifyBd;
begin
 AddUrgencyField;
 EnlargeNumberField;
 ModifyDateNums;
end;

procedure TUpgradeTo130_DOC.ModifyDateNums;
begin
 with f_DbReformer do
 begin
  Log('*** ћодифицируем словарь DateNums (DT#7001) ***');
  RestructTable(DT7_TBL, ffGarant, fn_ModifyDateNums);
 end;
end;

class function TUpgradeTo130_DOC.NameEx: string;
begin
 Result := 'базы документов';
end;

class function TUpgradeTo130_DOC.PrevVersion: Integer;
begin
 Result := 129;
end;

class function TUpgradeTo130_DOC.Version: Integer;
begin
 Result := 130;
end;


end.

