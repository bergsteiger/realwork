unit ddAutolinkDocEntry;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddAutolinkDocEntry.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::Autolink::TddAutolinkDocEntry
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Interfaces,
  l3Types,
  l3LongintList,
  l3Date,
  l3ProtoObject,
  ddAutolinkInterfaces,
  ddBaseAutoLinkDataSource
  ;

type
 TddAutolinkDocEntry = class(Tl3ProtoObject, IddAutolinkDocEntry)
 private
 // private fields
   f_DocType : Integer;
   f_Sources : Tl3LongintList;
   f_Date : TStDate;
   f_Num : Il3CString;
   f_DocID : TddALDocRec;
 protected
 // realized methods
   function Get_Sources(anIndex: Integer): Integer;
   function Get_DocType: Integer;
   procedure Set_DocType(aValue: Integer);
   function Get_Num: Il3CString;
   procedure Set_Num(const aValue: Il3CString);
   function Get_Date: TStDate;
   procedure Set_Date(aValue: TStDate);
   procedure AddSource(aSource: Integer);
   procedure DelSource(anIndex: Integer);
   procedure Clear;
     {* очищает все данные }
   function Get_SourceCount: Integer;
   function IsEmpty: Boolean;
     {* Если нет никаких данных... }
   function IsSame(const anEntry: IddAutolinkDocEntry): Boolean;
   function SourcesIdenticalTo(const anEntry: IddAutolinkDocEntry): Boolean;
   function Clone: IddAutolinkDocEntry;
   function Get_DocID: TddALDocRec;
   procedure Set_DocID(const aValue: TddALDocRec);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aDocType: Integer;
     aDate: TStDate;
     const aNum: Tl3PCharLen;
     aSources: Tl3LongintList;
     const aDocID: TddALDocRec); reintroduce;
   class function Make(aDocType: Integer;
     aDate: TStDate;
     const aNum: Tl3PCharLen;
     aSources: Tl3LongintList;
     const aDocID: TddALDocRec): IddAutolinkDocEntry; reintroduce;
     {* Сигнатура фабрики TddAutolinkDocEntry.Make }
 end;//TddAutolinkDocEntry

implementation

uses
  SysUtils,
  l3String,
  l3Base
  ;

// start class TddAutolinkDocEntry

constructor TddAutolinkDocEntry.Create(aDocType: Integer;
  aDate: TStDate;
  const aNum: Tl3PCharLen;
  aSources: Tl3LongintList;
  const aDocID: TddALDocRec);
//#UC START# *4E8ECFF20106_4E8EB01701A5_var*
//#UC END# *4E8ECFF20106_4E8EB01701A5_var*
begin
//#UC START# *4E8ECFF20106_4E8EB01701A5_impl*
 inherited Create;
 f_Sources := Tl3LongintList.Make;
 f_DocType := aDocType;
 f_Date := aDate;
 f_Num  := l3CStr(aNum);
 f_Sources.Assign(aSources);
 f_DocID := aDocID;
//#UC END# *4E8ECFF20106_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.Create

class function TddAutolinkDocEntry.Make(aDocType: Integer;
  aDate: TStDate;
  const aNum: Tl3PCharLen;
  aSources: Tl3LongintList;
  const aDocID: TddALDocRec): IddAutolinkDocEntry;
var
 l_Inst : TddAutolinkDocEntry;
begin
 l_Inst := Create(aDocType, aDate, aNum, aSources, aDocID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TddAutolinkDocEntry.Get_Sources(anIndex: Integer): Integer;
//#UC START# *4E8EB87300FE_4E8EB01701A5get_var*
//#UC END# *4E8EB87300FE_4E8EB01701A5get_var*
begin
//#UC START# *4E8EB87300FE_4E8EB01701A5get_impl*
 Result := f_Sources[anIndex];
//#UC END# *4E8EB87300FE_4E8EB01701A5get_impl*
end;//TddAutolinkDocEntry.Get_Sources

function TddAutolinkDocEntry.Get_DocType: Integer;
//#UC START# *4E8ECDAF0379_4E8EB01701A5get_var*
//#UC END# *4E8ECDAF0379_4E8EB01701A5get_var*
begin
//#UC START# *4E8ECDAF0379_4E8EB01701A5get_impl*
 Result := f_DocType;
//#UC END# *4E8ECDAF0379_4E8EB01701A5get_impl*
end;//TddAutolinkDocEntry.Get_DocType

procedure TddAutolinkDocEntry.Set_DocType(aValue: Integer);
//#UC START# *4E8ECDAF0379_4E8EB01701A5set_var*
//#UC END# *4E8ECDAF0379_4E8EB01701A5set_var*
begin
//#UC START# *4E8ECDAF0379_4E8EB01701A5set_impl*
 f_DocType := aValue;
//#UC END# *4E8ECDAF0379_4E8EB01701A5set_impl*
end;//TddAutolinkDocEntry.Set_DocType

function TddAutolinkDocEntry.Get_Num: Il3CString;
//#UC START# *4E8EDF6900EC_4E8EB01701A5get_var*
//#UC END# *4E8EDF6900EC_4E8EB01701A5get_var*
begin
//#UC START# *4E8EDF6900EC_4E8EB01701A5get_impl*
 Result := f_Num;
//#UC END# *4E8EDF6900EC_4E8EB01701A5get_impl*
end;//TddAutolinkDocEntry.Get_Num

procedure TddAutolinkDocEntry.Set_Num(const aValue: Il3CString);
//#UC START# *4E8EDF6900EC_4E8EB01701A5set_var*
//#UC END# *4E8EDF6900EC_4E8EB01701A5set_var*
begin
//#UC START# *4E8EDF6900EC_4E8EB01701A5set_impl*
 f_Num := aValue;
//#UC END# *4E8EDF6900EC_4E8EB01701A5set_impl*
end;//TddAutolinkDocEntry.Set_Num

function TddAutolinkDocEntry.Get_Date: TStDate;
//#UC START# *4E8EE02D0168_4E8EB01701A5get_var*
//#UC END# *4E8EE02D0168_4E8EB01701A5get_var*
begin
//#UC START# *4E8EE02D0168_4E8EB01701A5get_impl*
 Result := f_Date;
//#UC END# *4E8EE02D0168_4E8EB01701A5get_impl*
end;//TddAutolinkDocEntry.Get_Date

procedure TddAutolinkDocEntry.Set_Date(aValue: TStDate);
//#UC START# *4E8EE02D0168_4E8EB01701A5set_var*
//#UC END# *4E8EE02D0168_4E8EB01701A5set_var*
begin
//#UC START# *4E8EE02D0168_4E8EB01701A5set_impl*
 f_Date := aValue;
//#UC END# *4E8EE02D0168_4E8EB01701A5set_impl*
end;//TddAutolinkDocEntry.Set_Date

procedure TddAutolinkDocEntry.AddSource(aSource: Integer);
//#UC START# *4E8EE40A00F2_4E8EB01701A5_var*
//#UC END# *4E8EE40A00F2_4E8EB01701A5_var*
begin
//#UC START# *4E8EE40A00F2_4E8EB01701A5_impl*
 f_Sources.Add(aSource);
//#UC END# *4E8EE40A00F2_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.AddSource

procedure TddAutolinkDocEntry.DelSource(anIndex: Integer);
//#UC START# *4E8EE45F0201_4E8EB01701A5_var*
//#UC END# *4E8EE45F0201_4E8EB01701A5_var*
begin
//#UC START# *4E8EE45F0201_4E8EB01701A5_impl*
 f_Sources.Delete(anIndex);
//#UC END# *4E8EE45F0201_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.DelSource

procedure TddAutolinkDocEntry.Clear;
//#UC START# *4E8EE4900220_4E8EB01701A5_var*
//#UC END# *4E8EE4900220_4E8EB01701A5_var*
begin
//#UC START# *4E8EE4900220_4E8EB01701A5_impl*
 f_Sources.Clear;
 f_Date := 0;
 f_Num := nil;
 f_DocType := -1;
 f_DocID.rIntDocID := 0;
 f_DocID.rExtDocID := 0;
//#UC END# *4E8EE4900220_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.Clear

function TddAutolinkDocEntry.Get_SourceCount: Integer;
//#UC START# *4E8EE4F003A3_4E8EB01701A5get_var*
//#UC END# *4E8EE4F003A3_4E8EB01701A5get_var*
begin
//#UC START# *4E8EE4F003A3_4E8EB01701A5get_impl*
 Result := f_Sources.Count;
//#UC END# *4E8EE4F003A3_4E8EB01701A5get_impl*
end;//TddAutolinkDocEntry.Get_SourceCount

function TddAutolinkDocEntry.IsEmpty: Boolean;
//#UC START# *4E8EF11E0095_4E8EB01701A5_var*
//#UC END# *4E8EF11E0095_4E8EB01701A5_var*
begin
//#UC START# *4E8EF11E0095_4E8EB01701A5_impl*
 Result := (f_DocType = -1) and (f_Sources.Count = 0) and (f_Date = 0) and (l3IsNil(f_Num));
//#UC END# *4E8EF11E0095_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.IsEmpty

function TddAutolinkDocEntry.IsSame(const anEntry: IddAutolinkDocEntry): Boolean;
//#UC START# *4E940A4C004D_4E8EB01701A5_var*
//#UC END# *4E940A4C004D_4E8EB01701A5_var*
begin
//#UC START# *4E940A4C004D_4E8EB01701A5_impl*
 Result := (anEntry <> nil) and (f_DocType = anEntry.DocType) and (f_Date = anEntry.Date) and
           l3Same(f_Num, anEntry.Num, True) and SourcesIdenticalTo(anEntry);
//#UC END# *4E940A4C004D_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.IsSame

function TddAutolinkDocEntry.SourcesIdenticalTo(const anEntry: IddAutolinkDocEntry): Boolean;
//#UC START# *4E9596DB0242_4E8EB01701A5_var*
var
 I: Integer;
//#UC END# *4E9596DB0242_4E8EB01701A5_var*
begin
//#UC START# *4E9596DB0242_4E8EB01701A5_impl*
 Result := (anEntry <> nil) and (anEntry.SourceCount = f_Sources.Count);
 if Result and (anEntry.SourceCount > 0) then
 begin
  for I := 0 to anEntry.SourceCount - 1 do
  begin
   Result := f_Sources.IndexOf(anEntry.Sources[I]) >= 0;
   if not Result then
    Break;
  end;
 end;
//#UC END# *4E9596DB0242_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.SourcesIdenticalTo

function TddAutolinkDocEntry.Clone: IddAutolinkDocEntry;
//#UC START# *4E96BF820064_4E8EB01701A5_var*
//#UC END# *4E96BF820064_4E8EB01701A5_var*
begin
//#UC START# *4E96BF820064_4E8EB01701A5_impl*
 Result := Make(f_DocType, f_Date, Tl3PCharLen(f_Num.AsWStr), f_Sources, f_DocID);
//#UC END# *4E96BF820064_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.Clone

function TddAutolinkDocEntry.Get_DocID: TddALDocRec;
//#UC START# *4E96DF99012B_4E8EB01701A5get_var*
//#UC END# *4E96DF99012B_4E8EB01701A5get_var*
begin
//#UC START# *4E96DF99012B_4E8EB01701A5get_impl*
 Result := f_DocID;
//#UC END# *4E96DF99012B_4E8EB01701A5get_impl*
end;//TddAutolinkDocEntry.Get_DocID

procedure TddAutolinkDocEntry.Set_DocID(const aValue: TddALDocRec);
//#UC START# *4E96DF99012B_4E8EB01701A5set_var*
//#UC END# *4E96DF99012B_4E8EB01701A5set_var*
begin
//#UC START# *4E96DF99012B_4E8EB01701A5set_impl*
 f_DocID := aValue;
//#UC END# *4E96DF99012B_4E8EB01701A5set_impl*
end;//TddAutolinkDocEntry.Set_DocID

procedure TddAutolinkDocEntry.Cleanup;
//#UC START# *479731C50290_4E8EB01701A5_var*
//#UC END# *479731C50290_4E8EB01701A5_var*
begin
//#UC START# *479731C50290_4E8EB01701A5_impl*
 FreeAndNil(f_Sources);
 inherited;
//#UC END# *479731C50290_4E8EB01701A5_impl*
end;//TddAutolinkDocEntry.Cleanup

end.