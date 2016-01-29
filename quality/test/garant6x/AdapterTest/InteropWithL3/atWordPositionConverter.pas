unit atWordPositionConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/InteropWithL3/atWordPositionConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::InteropWithL3::TatWordPositionConverter
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
 _FirstType_ = Tl3WordPosition;
 _SecondType_ = TContextPlace;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}
 TatWordPositionConverter = class(_atEnumToEnumConverter_)
 protected
 // realized methods
   procedure InitConvertMap; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TatWordPositionConverter;
    {- возвращает экземпляр синглетона. }
 end;//TatWordPositionConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatWordPositionConverter

var g_TatWordPositionConverter : TatWordPositionConverter = nil;

procedure TatWordPositionConverterFree;
begin
 l3Free(g_TatWordPositionConverter);
end;

class function TatWordPositionConverter.Instance: TatWordPositionConverter;
begin
 if (g_TatWordPositionConverter = nil) then
 begin
  l3System.AddExitProc(TatWordPositionConverterFree);
  g_TatWordPositionConverter := Create;
 end;
 Result := g_TatWordPositionConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}

// start class TatWordPositionConverter

class function TatWordPositionConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatWordPositionConverter <> nil;
end;//TatWordPositionConverter.Exists

procedure TatWordPositionConverter.InitConvertMap;
//#UC START# *503E3A040395_503E65B1032E_var*
  const
    CONVERT_MAP : array [Tl3WordPosition] of Synonyms = (
      (First: wpAnyPathWord; Second: CP_ANY),
      (First: wpAtBeginWord; Second: CP_BEGIN_OF_WORD),
      (First: wpAtBeginString; Second: CP_BEGIN_OF_PHRASE)
    );
//#UC END# *503E3A040395_503E65B1032E_var*
begin
//#UC START# *503E3A040395_503E65B1032E_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_503E65B1032E_impl*
end;//TatWordPositionConverter.InitConvertMap

end.