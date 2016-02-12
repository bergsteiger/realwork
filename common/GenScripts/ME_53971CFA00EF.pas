unit atPositionTypeConverter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atPositionTypeConverter.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , DocumentUnit
;

type
 _EnumType_ = TPositionType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatPositionTypeConverter = class(_atEnumConverter_)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TatPositionTypeConverter;
    {* Метод получения экземпляра синглетона TatPositionTypeConverter }
 end;//TatPositionTypeConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , l3Base
;

var g_TatPositionTypeConverter: TatPositionTypeConverter = nil;
 {* Экземпляр синглетона TatPositionTypeConverter }

procedure TatPositionTypeConverterFree;
 {* Метод освобождения экземпляра синглетона TatPositionTypeConverter }
begin
 l3Free(g_TatPositionTypeConverter);
end;//TatPositionTypeConverterFree

{$If not Declared(_SecondType_)}type _SecondType_ = _EnumType_;{$IfEnd}

{$If not Declared(_FirstType_)}type _FirstType_ = AnsiString;{$IfEnd}

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

class function TatPositionTypeConverter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TatPositionTypeConverter <> nil;
end;//TatPositionTypeConverter.Exists

class function TatPositionTypeConverter.Instance: TatPositionTypeConverter;
 {* Метод получения экземпляра синглетона TatPositionTypeConverter }
begin
 if (g_TatPositionTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatPositionTypeConverterFree);
  g_TatPositionTypeConverter := Create;
 end;
 Result := g_TatPositionTypeConverter;
end;//TatPositionTypeConverter.Instance

end.
