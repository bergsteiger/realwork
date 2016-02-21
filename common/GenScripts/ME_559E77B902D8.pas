unit htField;

// Модуль: "w:\common\components\rtl\Garant\HT\htField.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 {$If NOT Defined(Nemesis)}
 , HT_Const
 {$IfEnd} // NOT Defined(Nemesis)
 , htInterfaces
 , daTypes
 , l3Date
;

type
 ThtField = class(Tl3ProtoObject, IdaField)
  private
   f_ClientInfo: IdaSelectField;
   f_ServerInfo: OPEL;
   f_DataBuffer: IdaResultBuffer;
   f_DataConverter: IhtDataConverter;
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
    const aDataConverter: IhtDataConverter;
    const aClientInfo: IdaSelectField;
    const aServerInfo: OPEL); reintroduce;
   class function Make(const aDataBuffer: IdaResultBuffer;
    const aDataConverter: IhtDataConverter;
    const aClientInfo: IdaSelectField;
    const aServerInfo: OPEL): IdaField; reintroduce;
 end;//ThtField

implementation

uses
 l3ImplUses
;

constructor ThtField.Create(const aDataBuffer: IdaResultBuffer;
 const aDataConverter: IhtDataConverter;
 const aClientInfo: IdaSelectField;
 const aServerInfo: OPEL);
//#UC START# *559E77D30158_559E77B902D8_var*
//#UC END# *559E77D30158_559E77B902D8_var*
begin
//#UC START# *559E77D30158_559E77B902D8_impl*
 inherited Create;
 f_DataConverter := aDataConverter;
 f_ClientInfo := aClientInfo;
 f_ServerInfo := aServerInfo;
 f_DataBuffer := aDataBuffer;
 Assert(Assigned(f_DataBuffer));
 f_DataBuffer.RegisterField(Self);
//#UC END# *559E77D30158_559E77B902D8_impl*
end;//ThtField.Create

class function ThtField.Make(const aDataBuffer: IdaResultBuffer;
 const aDataConverter: IhtDataConverter;
 const aClientInfo: IdaSelectField;
 const aServerInfo: OPEL): IdaField;
var
 l_Inst : ThtField;
begin
 l_Inst := Create(aDataBuffer, aDataConverter, aClientInfo, aServerInfo);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtField.Make

function ThtField.BufferPtr: Pointer;
//#UC START# *55C8A09B00F0_559E77B902D8_var*
//#UC END# *55C8A09B00F0_559E77B902D8_var*
begin
//#UC START# *55C8A09B00F0_559E77B902D8_impl*
 Result := f_DataBuffer.FieldBufferPtr(f_ServerInfo.nNum - 1);
//#UC END# *55C8A09B00F0_559E77B902D8_impl*
end;//ThtField.BufferPtr

function ThtField.Get_AsLargeInt: LargeInt;
//#UC START# *5593905401D1_559E77B902D8get_var*
//#UC END# *5593905401D1_559E77B902D8get_var*
begin
//#UC START# *5593905401D1_559E77B902D8get_impl*
 Result := f_DataConverter.ToLargeInt(BufferPtr, f_ServerInfo);
//#UC END# *5593905401D1_559E77B902D8get_impl*
end;//ThtField.Get_AsLargeInt

function ThtField.Get_AsInteger: Integer;
//#UC START# *55939068000C_559E77B902D8get_var*
//#UC END# *55939068000C_559E77B902D8get_var*
begin
//#UC START# *55939068000C_559E77B902D8get_impl*
 Result := f_DataConverter.ToInteger(BufferPtr, f_ServerInfo);
//#UC END# *55939068000C_559E77B902D8get_impl*
end;//ThtField.Get_AsInteger

function ThtField.Get_AsStDate: TStDate;
//#UC START# *559393510239_559E77B902D8get_var*
//#UC END# *559393510239_559E77B902D8get_var*
begin
//#UC START# *559393510239_559E77B902D8get_impl*
 Result := f_DataConverter.ToStDate(BufferPtr, f_ServerInfo);
//#UC END# *559393510239_559E77B902D8get_impl*
end;//ThtField.Get_AsStDate

function ThtField.Get_AsStTime: TStTime;
//#UC START# *5593936A031A_559E77B902D8get_var*
//#UC END# *5593936A031A_559E77B902D8get_var*
begin
//#UC START# *5593936A031A_559E77B902D8get_impl*
 Result := f_DataConverter.ToStTime(BufferPtr, f_ServerInfo);
//#UC END# *5593936A031A_559E77B902D8get_impl*
end;//ThtField.Get_AsStTime

function ThtField.Get_AsString: AnsiString;
//#UC START# *55FA82A80085_559E77B902D8get_var*
//#UC END# *55FA82A80085_559E77B902D8get_var*
begin
//#UC START# *55FA82A80085_559E77B902D8get_impl*
 Result := f_DataConverter.ToString(BufferPtr, f_ServerInfo);
//#UC END# *55FA82A80085_559E77B902D8get_impl*
end;//ThtField.Get_AsString

function ThtField.Get_AsByte: Byte;
//#UC START# *562E07C801CF_559E77B902D8get_var*
//#UC END# *562E07C801CF_559E77B902D8get_var*
begin
//#UC START# *562E07C801CF_559E77B902D8get_impl*
 Result := f_DataConverter.ToByte(BufferPtr, f_ServerInfo);
//#UC END# *562E07C801CF_559E77B902D8get_impl*
end;//ThtField.Get_AsByte

function ThtField.Get_Alias: AnsiString;
//#UC START# *56375577038B_559E77B902D8get_var*
//#UC END# *56375577038B_559E77B902D8get_var*
begin
//#UC START# *56375577038B_559E77B902D8get_impl*
 Result := f_ClientInfo.Alias;
//#UC END# *56375577038B_559E77B902D8get_impl*
end;//ThtField.Get_Alias

procedure ThtField.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_559E77B902D8_var*
//#UC END# *479731C50290_559E77B902D8_var*
begin
//#UC START# *479731C50290_559E77B902D8_impl*
 Assert(Assigned(f_DataBuffer));
 f_DataBuffer.UnregisterField(Self);
 f_DataBuffer := nil;
 f_ClientInfo := nil;
 f_DataConverter := nil;
 inherited;
//#UC END# *479731C50290_559E77B902D8_impl*
end;//ThtField.Cleanup

end.
