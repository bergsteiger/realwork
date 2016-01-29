unit atWordOrderConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/InteropWithL3/atWordOrderConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::InteropWithL3::TatWordOrderConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  DynamicTreeUnit,
  l3Interfaces,
  SysUtils
  ;

type
 _FirstType_ = Tl3WordOrder;
 _SecondType_ = TFindOrder;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}
 TatWordOrderConverter = class(_atEnumToEnumConverter_)
 protected
 // realized methods
   procedure InitConvertMap; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TatWordOrderConverter;
    {- возвращает экземпляр синглетона. }
 end;//TatWordOrderConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatWordOrderConverter

var g_TatWordOrderConverter : TatWordOrderConverter = nil;

procedure TatWordOrderConverterFree;
begin
 l3Free(g_TatWordOrderConverter);
end;

class function TatWordOrderConverter.Instance: TatWordOrderConverter;
begin
 if (g_TatWordOrderConverter = nil) then
 begin
  l3System.AddExitProc(TatWordOrderConverterFree);
  g_TatWordOrderConverter := Create;
 end;
 Result := g_TatWordOrderConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}

// start class TatWordOrderConverter

class function TatWordOrderConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatWordOrderConverter <> nil;
end;//TatWordOrderConverter.Exists

procedure TatWordOrderConverter.InitConvertMap;
//#UC START# *503E3A040395_503E615E0377_var*
  const
    CONVERT_MAP : array [Tl3WordOrder] of Synonyms = (
      (First : woAnyOrder; Second : FO_ANY),
      (First : woAsWrote; Second : FO_SEQUENCE)
    );
//#UC END# *503E3A040395_503E615E0377_var*
begin
//#UC START# *503E3A040395_503E615E0377_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_503E615E0377_impl*
end;//TatWordOrderConverter.InitConvertMap

end.