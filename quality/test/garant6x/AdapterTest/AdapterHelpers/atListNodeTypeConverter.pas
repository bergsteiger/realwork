unit atListNodeTypeConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atListNodeTypeConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatListNodeTypeConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  BaseTypesUnit,
  SysUtils
  ;

type
 _EnumType_ = TListNodeType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatListNodeTypeConverter = class(_atEnumConverter_)
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TatListNodeTypeConverter;
    {- возвращает экземпляр синглетона. }
 end;//TatListNodeTypeConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatListNodeTypeConverter

var g_TatListNodeTypeConverter : TatListNodeTypeConverter = nil;

procedure TatListNodeTypeConverterFree;
begin
 l3Free(g_TatListNodeTypeConverter);
end;

class function TatListNodeTypeConverter.Instance: TatListNodeTypeConverter;
begin
 if (g_TatListNodeTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatListNodeTypeConverterFree);
  g_TatListNodeTypeConverter := Create;
 end;
 Result := g_TatListNodeTypeConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

// start class TatListNodeTypeConverter

class function TatListNodeTypeConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatListNodeTypeConverter <> nil;
end;//TatListNodeTypeConverter.Exists

end.