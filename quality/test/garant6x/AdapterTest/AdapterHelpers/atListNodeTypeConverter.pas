unit atListNodeTypeConverter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atListNodeTypeConverter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatListNodeTypeConverter" MUID: (539700E901EB)

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , SysUtils
;

type
 _EnumType_ = TListNodeType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatListNodeTypeConverter = class(_atEnumConverter_)
  public
   class function Instance: TatListNodeTypeConverter;
    {* Метод получения экземпляра синглетона TatListNodeTypeConverter }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TatListNodeTypeConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , l3Base
 //#UC START# *539700E901EBimpl_uses*
 //#UC END# *539700E901EBimpl_uses*
;

var g_TatListNodeTypeConverter: TatListNodeTypeConverter = nil;
 {* Экземпляр синглетона TatListNodeTypeConverter }

procedure TatListNodeTypeConverterFree;
 {* Метод освобождения экземпляра синглетона TatListNodeTypeConverter }
begin
 l3Free(g_TatListNodeTypeConverter);
end;//TatListNodeTypeConverterFree

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

class function TatListNodeTypeConverter.Instance: TatListNodeTypeConverter;
 {* Метод получения экземпляра синглетона TatListNodeTypeConverter }
begin
 if (g_TatListNodeTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatListNodeTypeConverterFree);
  g_TatListNodeTypeConverter := Create;
 end;
 Result := g_TatListNodeTypeConverter;
end;//TatListNodeTypeConverter.Instance

class function TatListNodeTypeConverter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TatListNodeTypeConverter <> nil;
end;//TatListNodeTypeConverter.Exists

initialization
{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}


end.
