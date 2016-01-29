unit atPositionTypeConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atPositionTypeConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatPositionTypeConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  DocumentUnit,
  SysUtils
  ;

type
 _EnumType_ = TPositionType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatPositionTypeConverter = class(_atEnumConverter_)
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TatPositionTypeConverter;
    {- возвращает экземпляр синглетона. }
 end;//TatPositionTypeConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatPositionTypeConverter

var g_TatPositionTypeConverter : TatPositionTypeConverter = nil;

procedure TatPositionTypeConverterFree;
begin
 l3Free(g_TatPositionTypeConverter);
end;

class function TatPositionTypeConverter.Instance: TatPositionTypeConverter;
begin
 if (g_TatPositionTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatPositionTypeConverterFree);
  g_TatPositionTypeConverter := Create;
 end;
 Result := g_TatPositionTypeConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

// start class TatPositionTypeConverter

class function TatPositionTypeConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatPositionTypeConverter <> nil;
end;//TatPositionTypeConverter.Exists

end.