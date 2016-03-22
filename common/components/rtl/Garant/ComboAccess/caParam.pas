unit caParam;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ComboAccess"
// Модуль: "w:/common/components/rtl/Garant/ComboAccess/caParam.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::ComboAccess::Provider::TcaParam
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\ComboAccess\caDefine.inc}

interface

{$If defined(TestComboAccess) AND defined(UsePostgres)}
uses
  l3ProtoObject,
  daInterfaces,
  daTypes,
  l3Date
  ;
{$IfEnd} //TestComboAccess AND UsePostgres

{$If defined(TestComboAccess) AND defined(UsePostgres)}
type
 TcaParam = class(Tl3ProtoObject, IdaParam)
 private
 // private fields
   f_HTParam : IdaParam;
   f_PGParam : IdaParam;
 protected
 // realized methods
   function Get_Name: AnsiString;
   function IsSameType(const aDesc: IdaParamDescription): Boolean;
   function Get_AsInteger: LongInt;
   procedure Set_AsInteger(aValue: LongInt);
   function Get_DataBuffer: Pointer;
   function Get_AsLargeInt: LargeInt;
   procedure Set_AsLargeInt(aValue: LargeInt);
   function Get_AsString: AnsiString;
   procedure Set_AsString(const aValue: AnsiString);
   function Get_AsStDate: TStDate;
   procedure Set_AsStDate(aValue: TStDate);
   function Get_AsStTime: TStTime;
   procedure Set_AsStTime(aValue: TStTime);
   function Get_ParamType: TdaParamType;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aHTParam: IdaParam;
     const aPGParam: IdaParam); reintroduce;
   class function Make(const aHTParam: IdaParam;
     const aPGParam: IdaParam): IdaParam; reintroduce;
     {* Сигнатура фабрики TcaParam.Make }
 end;//TcaParam
{$IfEnd} //TestComboAccess AND UsePostgres

implementation

{$If defined(TestComboAccess) AND defined(UsePostgres)}

// start class TcaParam

constructor TcaParam.Create(const aHTParam: IdaParam;
  const aPGParam: IdaParam);
//#UC START# *56E14D92025C_56E14CE0012E_var*
//#UC END# *56E14D92025C_56E14CE0012E_var*
begin
//#UC START# *56E14D92025C_56E14CE0012E_impl*
 inherited Create;
 f_HTParam := aHTParam;
 f_PGParam := aPGParam;
//#UC END# *56E14D92025C_56E14CE0012E_impl*
end;//TcaParam.Create

class function TcaParam.Make(const aHTParam: IdaParam;
  const aPGParam: IdaParam): IdaParam;
var
 l_Inst : TcaParam;
begin
 l_Inst := Create(aHTParam, aPGParam);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TcaParam.Get_Name: AnsiString;
//#UC START# *5555CC750283_56E14CE0012Eget_var*
//#UC END# *5555CC750283_56E14CE0012Eget_var*
begin
//#UC START# *5555CC750283_56E14CE0012Eget_impl*
 Result := f_HTParam.Name;
 Assert(Result = f_PGParam.Name);
//#UC END# *5555CC750283_56E14CE0012Eget_impl*
end;//TcaParam.Get_Name

function TcaParam.IsSameType(const aDesc: IdaParamDescription): Boolean;
//#UC START# *5555D4F5030D_56E14CE0012E_var*
//#UC END# *5555D4F5030D_56E14CE0012E_var*
begin
//#UC START# *5555D4F5030D_56E14CE0012E_impl*
 Result := f_HTParam.IsSameType(aDesc);
 Assert(Result = f_PGParam.IsSameType(aDesc));
//#UC END# *5555D4F5030D_56E14CE0012E_impl*
end;//TcaParam.IsSameType

function TcaParam.Get_AsInteger: LongInt;
//#UC START# *5555E85C00B8_56E14CE0012Eget_var*
//#UC END# *5555E85C00B8_56E14CE0012Eget_var*
begin
//#UC START# *5555E85C00B8_56E14CE0012Eget_impl*
 Result := f_HTParam.AsInteger;
 Assert(Result = f_PGParam.AsInteger);
//#UC END# *5555E85C00B8_56E14CE0012Eget_impl*
end;//TcaParam.Get_AsInteger

procedure TcaParam.Set_AsInteger(aValue: LongInt);
//#UC START# *5555E85C00B8_56E14CE0012Eset_var*
//#UC END# *5555E85C00B8_56E14CE0012Eset_var*
begin
//#UC START# *5555E85C00B8_56E14CE0012Eset_impl*
 f_HTParam.AsInteger := aValue;
 f_PGParam.AsInteger := aValue;
 Assert(f_HTParam.AsInteger = f_PGParam.AsInteger);
//#UC END# *5555E85C00B8_56E14CE0012Eset_impl*
end;//TcaParam.Set_AsInteger

function TcaParam.Get_DataBuffer: Pointer;
//#UC START# *555D928D00E0_56E14CE0012Eget_var*
//#UC END# *555D928D00E0_56E14CE0012Eget_var*
begin
//#UC START# *555D928D00E0_56E14CE0012Eget_impl*
 Result := nil;
 Assert(False, 'Unimplemented');
//#UC END# *555D928D00E0_56E14CE0012Eget_impl*
end;//TcaParam.Get_DataBuffer

function TcaParam.Get_AsLargeInt: LargeInt;
//#UC START# *55FA75FD01D3_56E14CE0012Eget_var*
//#UC END# *55FA75FD01D3_56E14CE0012Eget_var*
begin
//#UC START# *55FA75FD01D3_56E14CE0012Eget_impl*
 Result := f_HTParam.AsLargeInt;
 Assert(Result = f_PGParam.AsLargeInt);
//#UC END# *55FA75FD01D3_56E14CE0012Eget_impl*
end;//TcaParam.Get_AsLargeInt

procedure TcaParam.Set_AsLargeInt(aValue: LargeInt);
//#UC START# *55FA75FD01D3_56E14CE0012Eset_var*
//#UC END# *55FA75FD01D3_56E14CE0012Eset_var*
begin
//#UC START# *55FA75FD01D3_56E14CE0012Eset_impl*
 f_HTParam.AsLargeInt := aValue;
 f_PGParam.AsLargeInt := aValue;
 Assert(f_HTParam.AsLargeInt = f_PGParam.AsLargeInt);
//#UC END# *55FA75FD01D3_56E14CE0012Eset_impl*
end;//TcaParam.Set_AsLargeInt

function TcaParam.Get_AsString: AnsiString;
//#UC START# *560CEA210293_56E14CE0012Eget_var*
//#UC END# *560CEA210293_56E14CE0012Eget_var*
begin
//#UC START# *560CEA210293_56E14CE0012Eget_impl*
 Result := f_HTParam.AsString;
 Assert(Result = f_PGParam.AsString);
//#UC END# *560CEA210293_56E14CE0012Eget_impl*
end;//TcaParam.Get_AsString

procedure TcaParam.Set_AsString(const aValue: AnsiString);
//#UC START# *560CEA210293_56E14CE0012Eset_var*
//#UC END# *560CEA210293_56E14CE0012Eset_var*
begin
//#UC START# *560CEA210293_56E14CE0012Eset_impl*
 f_HTParam.AsString := aValue;
 f_PGParam.AsString := aValue;
 Assert(f_HTParam.AsString = f_PGParam.AsString);
//#UC END# *560CEA210293_56E14CE0012Eset_impl*
end;//TcaParam.Set_AsString

function TcaParam.Get_AsStDate: TStDate;
//#UC START# *563C8B50016A_56E14CE0012Eget_var*
//#UC END# *563C8B50016A_56E14CE0012Eget_var*
begin
//#UC START# *563C8B50016A_56E14CE0012Eget_impl*
 Result := f_HTParam.AsStDate;
 Assert(Result = f_PGParam.AsStDate);
//#UC END# *563C8B50016A_56E14CE0012Eget_impl*
end;//TcaParam.Get_AsStDate

procedure TcaParam.Set_AsStDate(aValue: TStDate);
//#UC START# *563C8B50016A_56E14CE0012Eset_var*
//#UC END# *563C8B50016A_56E14CE0012Eset_var*
begin
//#UC START# *563C8B50016A_56E14CE0012Eset_impl*
 f_HTParam.AsStDate := aValue;
 f_PGParam.AsStDate := aValue;
 Assert(f_HTParam.AsStDate = f_PGParam.AsStDate);
//#UC END# *563C8B50016A_56E14CE0012Eset_impl*
end;//TcaParam.Set_AsStDate

function TcaParam.Get_AsStTime: TStTime;
//#UC START# *564C37CF00C4_56E14CE0012Eget_var*
//#UC END# *564C37CF00C4_56E14CE0012Eget_var*
begin
//#UC START# *564C37CF00C4_56E14CE0012Eget_impl*
 Result := f_HTParam.AsStTime;
 Assert(Result = f_PGParam.AsStTime);
//#UC END# *564C37CF00C4_56E14CE0012Eget_impl*
end;//TcaParam.Get_AsStTime

procedure TcaParam.Set_AsStTime(aValue: TStTime);
//#UC START# *564C37CF00C4_56E14CE0012Eset_var*
//#UC END# *564C37CF00C4_56E14CE0012Eset_var*
begin
//#UC START# *564C37CF00C4_56E14CE0012Eset_impl*
 f_HTParam.AsStTime := aValue;
 f_PGParam.AsStTime := aValue;
 Assert(f_HTParam.AsStTime = f_PGParam.AsStTime);
//#UC END# *564C37CF00C4_56E14CE0012Eset_impl*
end;//TcaParam.Set_AsStTime

function TcaParam.Get_ParamType: TdaParamType;
//#UC START# *5666822101CA_56E14CE0012Eget_var*
//#UC END# *5666822101CA_56E14CE0012Eget_var*
begin
//#UC START# *5666822101CA_56E14CE0012Eget_impl*
 Result := f_HTParam.ParamType;
 Assert(Result = f_PGParam.ParamType);
//#UC END# *5666822101CA_56E14CE0012Eget_impl*
end;//TcaParam.Get_ParamType

procedure TcaParam.Cleanup;
//#UC START# *479731C50290_56E14CE0012E_var*
//#UC END# *479731C50290_56E14CE0012E_var*
begin
//#UC START# *479731C50290_56E14CE0012E_impl*
 f_HTParam := nil;
 f_PGParam := nil;
 inherited;
//#UC END# *479731C50290_56E14CE0012E_impl*
end;//TcaParam.Cleanup

{$IfEnd} //TestComboAccess AND UsePostgres

end.