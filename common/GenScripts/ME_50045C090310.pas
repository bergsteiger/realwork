unit atQueryLogicOperationConverter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atQueryLogicOperationConverter.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , SearchUnit
;

type
 _EnumType_ = TQueryLogicOperation;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatQueryLogicOperationConverter = class(_atEnumConverter_)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TatQueryLogicOperationConverter;
    {* Метод получения экземпляра синглетона TatQueryLogicOperationConverter }
 end;//TatQueryLogicOperationConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , l3Base
;

var g_TatQueryLogicOperationConverter: TatQueryLogicOperationConverter = nil;
 {* Экземпляр синглетона TatQueryLogicOperationConverter }

procedure TatQueryLogicOperationConverterFree;
 {* Метод освобождения экземпляра синглетона TatQueryLogicOperationConverter }
begin
 l3Free(g_TatQueryLogicOperationConverter);
end;//TatQueryLogicOperationConverterFree

{$If not Declared(_SecondType_)}type _SecondType_ = _EnumType_;{$IfEnd}

{$If not Declared(_FirstType_)}type _FirstType_ = AnsiString;{$IfEnd}

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

class function TatQueryLogicOperationConverter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TatQueryLogicOperationConverter <> nil;
end;//TatQueryLogicOperationConverter.Exists

class function TatQueryLogicOperationConverter.Instance: TatQueryLogicOperationConverter;
 {* Метод получения экземпляра синглетона TatQueryLogicOperationConverter }
begin
 if (g_TatQueryLogicOperationConverter = nil) then
 begin
  l3System.AddExitProc(TatQueryLogicOperationConverterFree);
  g_TatQueryLogicOperationConverter := Create;
 end;
 Result := g_TatQueryLogicOperationConverter;
end;//TatQueryLogicOperationConverter.Instance

end.
