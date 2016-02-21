unit pgField;

// Модуль: "w:\common\components\rtl\Garant\PG\pgField.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , pgInterfaces
 , daTypes
 , l3Date
;

type
 TpgField = class(Tl3ProtoObject, IdaField)
  private
   f_ClientInfo: IdaSelectField;
   f_DataBuffer: IdaResultBuffer;
   f_DataConverter: IpgDataConverter;
   f_FieldIndex: Integer;
  private
   function BufferPtr: Pointer;
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
    const aDataConverter: IpgDataConverter;
    const aClientInfo: IdaSelectField;
    aFieldIndex: Integer); reintroduce;
   class function Make(const aDataBuffer: IdaResultBuffer;
    const aDataConverter: IpgDataConverter;
    const aClientInfo: IdaSelectField;
    aFieldIndex: Integer): IdaField; reintroduce;
 end;//TpgField
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
;

constructor TpgField.Create(const aDataBuffer: IdaResultBuffer;
 const aDataConverter: IpgDataConverter;
 const aClientInfo: IdaSelectField;
 aFieldIndex: Integer);
//#UC START# *562744D501B9_5627445F00C1_var*
//#UC END# *562744D501B9_5627445F00C1_var*
begin
//#UC START# *562744D501B9_5627445F00C1_impl*
 inherited Create;
 f_FieldIndex := aFieldIndex;
 f_DataConverter := aDataConverter;
 f_ClientInfo := aClientInfo;
 f_DataBuffer := aDataBuffer;
 Assert(Assigned(f_DataBuffer));
 f_DataBuffer.RegisterField(Self);
//#UC END# *562744D501B9_5627445F00C1_impl*
end;//TpgField.Create

class function TpgField.Make(const aDataBuffer: IdaResultBuffer;
 const aDataConverter: IpgDataConverter;
 const aClientInfo: IdaSelectField;
 aFieldIndex: Integer): IdaField;
var
 l_Inst : TpgField;
begin
 l_Inst := Create(aDataBuffer, aDataConverter, aClientInfo, aFieldIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgField.Make

function TpgField.BufferPtr: Pointer;
//#UC START# *56274C87017A_5627445F00C1_var*
//#UC END# *56274C87017A_5627445F00C1_var*
begin
//#UC START# *56274C87017A_5627445F00C1_impl*
 Result := f_DataBuffer.FieldBufferPtr(f_FieldIndex);
//#UC END# *56274C87017A_5627445F00C1_impl*
end;//TpgField.BufferPtr

function TpgField.Get_AsLargeInt: LargeInt;
//#UC START# *5593905401D1_5627445F00C1get_var*
//#UC END# *5593905401D1_5627445F00C1get_var*
begin
//#UC START# *5593905401D1_5627445F00C1get_impl*
 Result := f_DataConverter.ToLargeInt(BufferPtr);
//#UC END# *5593905401D1_5627445F00C1get_impl*
end;//TpgField.Get_AsLargeInt

function TpgField.Get_AsInteger: Integer;
//#UC START# *55939068000C_5627445F00C1get_var*
//#UC END# *55939068000C_5627445F00C1get_var*
begin
//#UC START# *55939068000C_5627445F00C1get_impl*
 Result := f_DataConverter.ToInteger(BufferPtr);
//#UC END# *55939068000C_5627445F00C1get_impl*
end;//TpgField.Get_AsInteger

function TpgField.Get_AsStDate: TStDate;
//#UC START# *559393510239_5627445F00C1get_var*
//#UC END# *559393510239_5627445F00C1get_var*
begin
//#UC START# *559393510239_5627445F00C1get_impl*
 Result := f_DataConverter.ToStDate(BufferPtr);
//#UC END# *559393510239_5627445F00C1get_impl*
end;//TpgField.Get_AsStDate

function TpgField.Get_AsStTime: TStTime;
//#UC START# *5593936A031A_5627445F00C1get_var*
//#UC END# *5593936A031A_5627445F00C1get_var*
begin
//#UC START# *5593936A031A_5627445F00C1get_impl*
 Result := f_DataConverter.ToStTime(BufferPtr);
//#UC END# *5593936A031A_5627445F00C1get_impl*
end;//TpgField.Get_AsStTime

function TpgField.Get_AsString: AnsiString;
//#UC START# *55FA82A80085_5627445F00C1get_var*
//#UC END# *55FA82A80085_5627445F00C1get_var*
begin
//#UC START# *55FA82A80085_5627445F00C1get_impl*
 Result := f_DataConverter.ToString(BufferPtr);
//#UC END# *55FA82A80085_5627445F00C1get_impl*
end;//TpgField.Get_AsString

function TpgField.Get_AsByte: Byte;
//#UC START# *562E07C801CF_5627445F00C1get_var*
//#UC END# *562E07C801CF_5627445F00C1get_var*
begin
//#UC START# *562E07C801CF_5627445F00C1get_impl*
 Result := f_DataConverter.ToByte(BufferPtr);
//#UC END# *562E07C801CF_5627445F00C1get_impl*
end;//TpgField.Get_AsByte

function TpgField.Get_Alias: AnsiString;
//#UC START# *56375577038B_5627445F00C1get_var*
//#UC END# *56375577038B_5627445F00C1get_var*
begin
//#UC START# *56375577038B_5627445F00C1get_impl*
 Result := f_ClientInfo.Alias;
//#UC END# *56375577038B_5627445F00C1get_impl*
end;//TpgField.Get_Alias

procedure TpgField.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5627445F00C1_var*
//#UC END# *479731C50290_5627445F00C1_var*
begin
//#UC START# *479731C50290_5627445F00C1_impl*
 Assert(Assigned(f_DataBuffer));
 f_DataBuffer.UnregisterField(Self);
 f_DataBuffer := nil;
 f_ClientInfo := nil;
 f_DataConverter := nil;
 inherited;
//#UC END# *479731C50290_5627445F00C1_impl*
end;//TpgField.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
