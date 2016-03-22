unit caDataConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ComboAccess"
// Модуль: "w:/common/components/rtl/Garant/ComboAccess/caDataConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::ComboAccess::Provider::TcaDataConverter
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
  htInterfaces,
  pgInterfaces,
  caInterfaces,
  daInterfaces,
  daTypes
  ;
{$IfEnd} //TestComboAccess AND UsePostgres

{$If defined(TestComboAccess) AND defined(UsePostgres)}
type
 TcaDataConverter = class(Tl3ProtoObject, IcaDataConverter)
 private
 // private fields
   f_HTConverter : IhtDataConverter;
   f_PGConverter : IpgDataConverter;
 protected
 // realized methods
   function AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
   procedure ParamToDataBase(const aDescription: IdaParamDescription;
    ClientBufferFormat: TdaDataType;
    aClientBuffer: Pointer;
    var aServerBuffer: Pointer);
   procedure ParamFromDataBase(const aDescription: IdaParamDescription;
    ClientBufferFormat: TdaDataType;
    aServerBuffer: Pointer;
    aClientBuffer: Pointer);
   procedure FreeParamBuffer(const aDescription: IdaParamDescription;
    aBuffer: Pointer);
   function Get_HTConverter: IhtDataConverter;
   function Get_PGConverter: IpgDataConverter;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aHTConverter: IhtDataConverter;
     const aPGConverter: IpgDataConverter); reintroduce;
   class function Make(const aHTConverter: IhtDataConverter;
     const aPGConverter: IpgDataConverter): IcaDataConverter; reintroduce;
     {* Сигнатура фабрики TcaDataConverter.Make }
 end;//TcaDataConverter
{$IfEnd} //TestComboAccess AND UsePostgres

implementation

{$If defined(TestComboAccess) AND defined(UsePostgres)}

// start class TcaDataConverter

constructor TcaDataConverter.Create(const aHTConverter: IhtDataConverter;
  const aPGConverter: IpgDataConverter);
//#UC START# *56C2EE30009E_56C2E7040035_var*
//#UC END# *56C2EE30009E_56C2E7040035_var*
begin
//#UC START# *56C2EE30009E_56C2E7040035_impl*
 inherited Create;
 f_HTConverter := aHTConverter;
 f_PGConverter := aPGConverter;
//#UC END# *56C2EE30009E_56C2E7040035_impl*
end;//TcaDataConverter.Create

class function TcaDataConverter.Make(const aHTConverter: IhtDataConverter;
  const aPGConverter: IpgDataConverter): IcaDataConverter;
var
 l_Inst : TcaDataConverter;
begin
 l_Inst := Create(aHTConverter, aPGConverter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TcaDataConverter.AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
//#UC START# *555995210007_56C2E7040035_var*
//#UC END# *555995210007_56C2E7040035_var*
begin
//#UC START# *555995210007_56C2E7040035_impl*
 Result := f_HTConverter.AllocateParamBuffer(aDescription);
//#UC END# *555995210007_56C2E7040035_impl*
end;//TcaDataConverter.AllocateParamBuffer

procedure TcaDataConverter.ParamToDataBase(const aDescription: IdaParamDescription;
  ClientBufferFormat: TdaDataType;
  aClientBuffer: Pointer;
  var aServerBuffer: Pointer);
//#UC START# *5559955500DF_56C2E7040035_var*
//#UC END# *5559955500DF_56C2E7040035_var*
begin
//#UC START# *5559955500DF_56C2E7040035_impl*
 f_HTConverter.ParamToDataBase(aDescription, ClientBufferFormat, aClientBuffer, aServerBuffer);
//#UC END# *5559955500DF_56C2E7040035_impl*
end;//TcaDataConverter.ParamToDataBase

procedure TcaDataConverter.ParamFromDataBase(const aDescription: IdaParamDescription;
  ClientBufferFormat: TdaDataType;
  aServerBuffer: Pointer;
  aClientBuffer: Pointer);
//#UC START# *55599596005B_56C2E7040035_var*
//#UC END# *55599596005B_56C2E7040035_var*
begin
//#UC START# *55599596005B_56C2E7040035_impl*
 f_HTConverter.ParamFromDataBase(aDescription, ClientBufferFormat, aServerBuffer, aClientBuffer);
//#UC END# *55599596005B_56C2E7040035_impl*
end;//TcaDataConverter.ParamFromDataBase

procedure TcaDataConverter.FreeParamBuffer(const aDescription: IdaParamDescription;
  aBuffer: Pointer);
//#UC START# *5559D14D02D1_56C2E7040035_var*
//#UC END# *5559D14D02D1_56C2E7040035_var*
begin
//#UC START# *5559D14D02D1_56C2E7040035_impl*
 f_HTConverter.FreeParamBuffer(aDescription, aBuffer);
//#UC END# *5559D14D02D1_56C2E7040035_impl*
end;//TcaDataConverter.FreeParamBuffer

function TcaDataConverter.Get_HTConverter: IhtDataConverter;
//#UC START# *56C2DED50129_56C2E7040035get_var*
//#UC END# *56C2DED50129_56C2E7040035get_var*
begin
//#UC START# *56C2DED50129_56C2E7040035get_impl*
 Result := f_HTConverter;
//#UC END# *56C2DED50129_56C2E7040035get_impl*
end;//TcaDataConverter.Get_HTConverter

function TcaDataConverter.Get_PGConverter: IpgDataConverter;
//#UC START# *56C2DEED008B_56C2E7040035get_var*
//#UC END# *56C2DEED008B_56C2E7040035get_var*
begin
//#UC START# *56C2DEED008B_56C2E7040035get_impl*
 Result := f_PGConverter;
//#UC END# *56C2DEED008B_56C2E7040035get_impl*
end;//TcaDataConverter.Get_PGConverter

procedure TcaDataConverter.Cleanup;
//#UC START# *479731C50290_56C2E7040035_var*
//#UC END# *479731C50290_56C2E7040035_var*
begin
//#UC START# *479731C50290_56C2E7040035_impl*
 f_HTConverter := nil;
 f_PGConverter := nil;
 inherited;
//#UC END# *479731C50290_56C2E7040035_impl*
end;//TcaDataConverter.Cleanup

{$IfEnd} //TestComboAccess AND UsePostgres

end.