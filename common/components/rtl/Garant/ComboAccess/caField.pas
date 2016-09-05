unit caField;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caField.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaField" MUID: (56E009B303E1)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , l3Date
;

type
 TcaField = class(Tl3ProtoObject, IdaField)
  private
   f_HTField: IdaField;
   f_PGField: IdaField;
   f_DataBuffer: IdaResultBuffer;
  protected
   function Get_AsLargeInt: LargeInt;
   function Get_AsInteger: Integer;
   function Get_AsStDate: TStDate;
   function Get_AsStTime: TStTime;
   function Get_AsString: AnsiString;
   function Get_AsByte: Byte;
   function Get_Alias: AnsiString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDataBuffer: IdaResultBuffer;
    const aHTField: IdaField;
    const aPGField: IdaField); reintroduce;
   class function Make(const aDataBuffer: IdaResultBuffer;
    const aHTField: IdaField;
    const aPGField: IdaField): IdaField; reintroduce;
 end;//TcaField
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 //#UC START# *56E009B303E1impl_uses*
 //#UC END# *56E009B303E1impl_uses*
;

constructor TcaField.Create(const aDataBuffer: IdaResultBuffer;
 const aHTField: IdaField;
 const aPGField: IdaField);
//#UC START# *56E00A25007C_56E009B303E1_var*
//#UC END# *56E00A25007C_56E009B303E1_var*
begin
//#UC START# *56E00A25007C_56E009B303E1_impl*
 inherited Create;
 f_DataBuffer := aDataBuffer;
 Assert(Assigned(f_DataBuffer));
 f_DataBuffer.RegisterField(Self);
 f_HTField := aHTField;
 f_PGField := aPGField;
//#UC END# *56E00A25007C_56E009B303E1_impl*
end;//TcaField.Create

class function TcaField.Make(const aDataBuffer: IdaResultBuffer;
 const aHTField: IdaField;
 const aPGField: IdaField): IdaField;
var
 l_Inst : TcaField;
begin
 l_Inst := Create(aDataBuffer, aHTField, aPGField);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaField.Make

function TcaField.Get_AsLargeInt: LargeInt;
//#UC START# *5593905401D1_56E009B303E1get_var*
//#UC END# *5593905401D1_56E009B303E1get_var*
begin
//#UC START# *5593905401D1_56E009B303E1get_impl*
 Result := f_HTField.AsLargeInt;
 Assert(Result = f_PGField.AsLargeInt);
//#UC END# *5593905401D1_56E009B303E1get_impl*
end;//TcaField.Get_AsLargeInt

function TcaField.Get_AsInteger: Integer;
//#UC START# *55939068000C_56E009B303E1get_var*
//#UC END# *55939068000C_56E009B303E1get_var*
begin
//#UC START# *55939068000C_56E009B303E1get_impl*
 Result := f_HTField.AsInteger;
 Assert(Result = f_PGField.AsInteger);
//#UC END# *55939068000C_56E009B303E1get_impl*
end;//TcaField.Get_AsInteger

function TcaField.Get_AsStDate: TStDate;
//#UC START# *559393510239_56E009B303E1get_var*
//#UC END# *559393510239_56E009B303E1get_var*
begin
//#UC START# *559393510239_56E009B303E1get_impl*
 Result := f_HTField.AsStDate;
 Assert(Result = f_PGField.AsStDate);
//#UC END# *559393510239_56E009B303E1get_impl*
end;//TcaField.Get_AsStDate

function TcaField.Get_AsStTime: TStTime;
//#UC START# *5593936A031A_56E009B303E1get_var*
//#UC END# *5593936A031A_56E009B303E1get_var*
begin
//#UC START# *5593936A031A_56E009B303E1get_impl*
 Result := f_HTField.AsStTime;
 Assert(Result = f_PGField.AsStTime);
//#UC END# *5593936A031A_56E009B303E1get_impl*
end;//TcaField.Get_AsStTime

function TcaField.Get_AsString: AnsiString;
//#UC START# *55FA82A80085_56E009B303E1get_var*
//#UC END# *55FA82A80085_56E009B303E1get_var*
begin
//#UC START# *55FA82A80085_56E009B303E1get_impl*
 Result := f_HTField.AsString;
 Assert(Result = f_PGField.AsString);
//#UC END# *55FA82A80085_56E009B303E1get_impl*
end;//TcaField.Get_AsString

function TcaField.Get_AsByte: Byte;
//#UC START# *562E07C801CF_56E009B303E1get_var*
//#UC END# *562E07C801CF_56E009B303E1get_var*
begin
//#UC START# *562E07C801CF_56E009B303E1get_impl*
 Result := f_HTField.AsByte;
 Assert(Result = f_PGField.AsByte);
//#UC END# *562E07C801CF_56E009B303E1get_impl*
end;//TcaField.Get_AsByte

function TcaField.Get_Alias: AnsiString;
//#UC START# *56375577038B_56E009B303E1get_var*
//#UC END# *56375577038B_56E009B303E1get_var*
begin
//#UC START# *56375577038B_56E009B303E1get_impl*
 Result := f_HTField.Alias;
 Assert(Result = f_PGField.Alias);
//#UC END# *56375577038B_56E009B303E1get_impl*
end;//TcaField.Get_Alias

procedure TcaField.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56E009B303E1_var*
//#UC END# *479731C50290_56E009B303E1_var*
begin
//#UC START# *479731C50290_56E009B303E1_impl*
 f_DataBuffer.UnRegisterField(Self);
 f_DataBuffer := nil;
 f_HTField := nil;
 f_PGField := nil;
 inherited;
//#UC END# *479731C50290_56E009B303E1_impl*
end;//TcaField.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
