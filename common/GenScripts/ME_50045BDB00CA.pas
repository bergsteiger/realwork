unit atQueryTypeConverter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atQueryTypeConverter.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , SearchUnit
;

type
 _EnumType_ = TQueryType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatQueryTypeConverter = class(_atEnumConverter_)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TatQueryTypeConverter;
    {* Метод получения экземпляра синглетона TatQueryTypeConverter }
 end;//TatQueryTypeConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , l3Base
;

var g_TatQueryTypeConverter: TatQueryTypeConverter = nil;
 {* Экземпляр синглетона TatQueryTypeConverter }

procedure TatQueryTypeConverterFree;
 {* Метод освобождения экземпляра синглетона TatQueryTypeConverter }
begin
 l3Free(g_TatQueryTypeConverter);
end;//TatQueryTypeConverterFree

{$If not Declared(_SecondType_)}type _SecondType_ = _EnumType_;{$IfEnd}

{$If not Declared(_FirstType_)}type _FirstType_ = AnsiString;{$IfEnd}

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

class function TatQueryTypeConverter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TatQueryTypeConverter <> nil;
end;//TatQueryTypeConverter.Exists

class function TatQueryTypeConverter.Instance: TatQueryTypeConverter;
 {* Метод получения экземпляра синглетона TatQueryTypeConverter }
begin
 if (g_TatQueryTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatQueryTypeConverterFree);
  g_TatQueryTypeConverter := Create;
 end;
 Result := g_TatQueryTypeConverter;
end;//TatQueryTypeConverter.Instance

end.
