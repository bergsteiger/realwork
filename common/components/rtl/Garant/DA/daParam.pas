unit daParam;

// Модуль: "w:\common\components\rtl\Garant\DA\daParam.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaParam" MUID: (5555AD2A0004)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , l3Date
;

type
 TdaParam = class(Tl3ProtoObject, IdaParam)
  private
   f_Description: IdaParamDescription;
   f_Converter: IdaDataConverter;
   f_Buffer: Pointer;
  protected
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
   procedure Set_AsStDate(const aValue: TStDate);
   function Get_AsStTime: TStTime;
   procedure Set_AsStTime(const aValue: TStTime);
   function Get_ParamType: TdaParamType;
   function Get_AsByte: Byte;
   procedure Set_AsByte(aValue: Byte);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aConverter: IdaDataConverter;
    const aDesc: IdaParamDescription); reintroduce;
   class function Make(const aConverter: IdaDataConverter;
    const aDesc: IdaParamDescription): IdaParam; reintroduce;
 end;//TdaParam

implementation

uses
 l3ImplUses
 //#UC START# *5555AD2A0004impl_uses*
 //#UC END# *5555AD2A0004impl_uses*
;

constructor TdaParam.Create(const aConverter: IdaDataConverter;
 const aDesc: IdaParamDescription);
//#UC START# *5555AD6F0065_5555AD2A0004_var*
//#UC END# *5555AD6F0065_5555AD2A0004_var*
begin
//#UC START# *5555AD6F0065_5555AD2A0004_impl*
 inherited Create;
 f_Description := aDesc;
 f_Converter := aConverter;
 f_Buffer := f_Converter.AllocateParamBuffer(f_Description);
//#UC END# *5555AD6F0065_5555AD2A0004_impl*
end;//TdaParam.Create

class function TdaParam.Make(const aConverter: IdaDataConverter;
 const aDesc: IdaParamDescription): IdaParam;
var
 l_Inst : TdaParam;
begin
 l_Inst := Create(aConverter, aDesc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaParam.Make

function TdaParam.Get_Name: AnsiString;
//#UC START# *5555CC750283_5555AD2A0004get_var*
//#UC END# *5555CC750283_5555AD2A0004get_var*
begin
//#UC START# *5555CC750283_5555AD2A0004get_impl*
 Result := f_Description.Name;
//#UC END# *5555CC750283_5555AD2A0004get_impl*
end;//TdaParam.Get_Name

function TdaParam.IsSameType(const aDesc: IdaParamDescription): Boolean;
//#UC START# *5555D4F5030D_5555AD2A0004_var*
//#UC END# *5555D4F5030D_5555AD2A0004_var*
begin
//#UC START# *5555D4F5030D_5555AD2A0004_impl*
 Result := (f_Description.DataType = aDesc.DataType) and (f_Description.Size = aDesc.Size);
//#UC END# *5555D4F5030D_5555AD2A0004_impl*
end;//TdaParam.IsSameType

function TdaParam.Get_AsInteger: LongInt;
//#UC START# *5555E85C00B8_5555AD2A0004get_var*
//#UC END# *5555E85C00B8_5555AD2A0004get_var*
begin
//#UC START# *5555E85C00B8_5555AD2A0004get_impl*
 f_Converter.ParamFromDataBase(f_Description, da_dtInteger, f_Buffer, @Result);
//#UC END# *5555E85C00B8_5555AD2A0004get_impl*
end;//TdaParam.Get_AsInteger

procedure TdaParam.Set_AsInteger(aValue: LongInt);
//#UC START# *5555E85C00B8_5555AD2A0004set_var*
//#UC END# *5555E85C00B8_5555AD2A0004set_var*
begin
//#UC START# *5555E85C00B8_5555AD2A0004set_impl*
 f_Converter.ParamToDataBase(f_Description, da_dtInteger, @aValue, f_Buffer);
//#UC END# *5555E85C00B8_5555AD2A0004set_impl*
end;//TdaParam.Set_AsInteger

function TdaParam.Get_DataBuffer: Pointer;
//#UC START# *555D928D00E0_5555AD2A0004get_var*
//#UC END# *555D928D00E0_5555AD2A0004get_var*
begin
//#UC START# *555D928D00E0_5555AD2A0004get_impl*
 Result := f_Buffer;
//#UC END# *555D928D00E0_5555AD2A0004get_impl*
end;//TdaParam.Get_DataBuffer

function TdaParam.Get_AsLargeInt: LargeInt;
//#UC START# *55FA75FD01D3_5555AD2A0004get_var*
//#UC END# *55FA75FD01D3_5555AD2A0004get_var*
begin
//#UC START# *55FA75FD01D3_5555AD2A0004get_impl*
 f_Converter.ParamFromDataBase(f_Description, da_dtQWord, f_Buffer, @Result);
//#UC END# *55FA75FD01D3_5555AD2A0004get_impl*
end;//TdaParam.Get_AsLargeInt

procedure TdaParam.Set_AsLargeInt(aValue: LargeInt);
//#UC START# *55FA75FD01D3_5555AD2A0004set_var*
//#UC END# *55FA75FD01D3_5555AD2A0004set_var*
begin
//#UC START# *55FA75FD01D3_5555AD2A0004set_impl*
 f_Converter.ParamToDataBase(f_Description, da_dtQWord, @aValue, f_Buffer);
//#UC END# *55FA75FD01D3_5555AD2A0004set_impl*
end;//TdaParam.Set_AsLargeInt

function TdaParam.Get_AsString: AnsiString;
//#UC START# *560CEA210293_5555AD2A0004get_var*
//#UC END# *560CEA210293_5555AD2A0004get_var*
begin
//#UC START# *560CEA210293_5555AD2A0004get_impl*
 f_Converter.ParamFromDataBase(f_Description, da_dtChar, f_Buffer, @Result);
//#UC END# *560CEA210293_5555AD2A0004get_impl*
end;//TdaParam.Get_AsString

procedure TdaParam.Set_AsString(const aValue: AnsiString);
//#UC START# *560CEA210293_5555AD2A0004set_var*
//#UC END# *560CEA210293_5555AD2A0004set_var*
begin
//#UC START# *560CEA210293_5555AD2A0004set_impl*
 f_Converter.ParamToDataBase(f_Description, da_dtChar, @aValue, f_Buffer);
//#UC END# *560CEA210293_5555AD2A0004set_impl*
end;//TdaParam.Set_AsString

function TdaParam.Get_AsStDate: TStDate;
//#UC START# *563C8B50016A_5555AD2A0004get_var*
//#UC END# *563C8B50016A_5555AD2A0004get_var*
begin
//#UC START# *563C8B50016A_5555AD2A0004get_impl*
 f_Converter.ParamFromDataBase(f_Description, da_dtDate, f_Buffer, @Result);
//#UC END# *563C8B50016A_5555AD2A0004get_impl*
end;//TdaParam.Get_AsStDate

procedure TdaParam.Set_AsStDate(const aValue: TStDate);
//#UC START# *563C8B50016A_5555AD2A0004set_var*
//#UC END# *563C8B50016A_5555AD2A0004set_var*
begin
//#UC START# *563C8B50016A_5555AD2A0004set_impl*
 f_Converter.ParamToDataBase(f_Description, da_dtDate, @aValue, f_Buffer);
//#UC END# *563C8B50016A_5555AD2A0004set_impl*
end;//TdaParam.Set_AsStDate

function TdaParam.Get_AsStTime: TStTime;
//#UC START# *564C37CF00C4_5555AD2A0004get_var*
//#UC END# *564C37CF00C4_5555AD2A0004get_var*
begin
//#UC START# *564C37CF00C4_5555AD2A0004get_impl*
 f_Converter.ParamFromDataBase(f_Description, da_dtTime, f_Buffer, @Result);
//#UC END# *564C37CF00C4_5555AD2A0004get_impl*
end;//TdaParam.Get_AsStTime

procedure TdaParam.Set_AsStTime(const aValue: TStTime);
//#UC START# *564C37CF00C4_5555AD2A0004set_var*
//#UC END# *564C37CF00C4_5555AD2A0004set_var*
begin
//#UC START# *564C37CF00C4_5555AD2A0004set_impl*
 f_Converter.ParamToDataBase(f_Description, da_dtTime, @aValue, f_Buffer);
//#UC END# *564C37CF00C4_5555AD2A0004set_impl*
end;//TdaParam.Set_AsStTime

function TdaParam.Get_ParamType: TdaParamType;
//#UC START# *5666822101CA_5555AD2A0004get_var*
//#UC END# *5666822101CA_5555AD2A0004get_var*
begin
//#UC START# *5666822101CA_5555AD2A0004get_impl*
 Result := f_Description.ParamType;
//#UC END# *5666822101CA_5555AD2A0004get_impl*
end;//TdaParam.Get_ParamType

function TdaParam.Get_AsByte: Byte;
//#UC START# *578625FB03A1_5555AD2A0004get_var*
//#UC END# *578625FB03A1_5555AD2A0004get_var*
begin
//#UC START# *578625FB03A1_5555AD2A0004get_impl*
 f_Converter.ParamFromDataBase(f_Description, da_dtByte, f_Buffer, @Result);
//#UC END# *578625FB03A1_5555AD2A0004get_impl*
end;//TdaParam.Get_AsByte

procedure TdaParam.Set_AsByte(aValue: Byte);
//#UC START# *578625FB03A1_5555AD2A0004set_var*
//#UC END# *578625FB03A1_5555AD2A0004set_var*
begin
//#UC START# *578625FB03A1_5555AD2A0004set_impl*
 f_Converter.ParamToDataBase(f_Description, da_dtByte, @aValue, f_Buffer);
//#UC END# *578625FB03A1_5555AD2A0004set_impl*
end;//TdaParam.Set_AsByte

procedure TdaParam.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5555AD2A0004_var*
//#UC END# *479731C50290_5555AD2A0004_var*
begin
//#UC START# *479731C50290_5555AD2A0004_impl*
 f_Converter.FreeParamBuffer(f_Description, f_Buffer);
 f_Description := nil;
 f_Converter := nil;
 inherited;
//#UC END# *479731C50290_5555AD2A0004_impl*
end;//TdaParam.Cleanup

end.
