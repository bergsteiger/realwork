unit atTreeLevelConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/InteropWithL3/atTreeLevelConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::InteropWithL3::TatTreeLevelConverter
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
 _FirstType_ = Tl3TreeLevelDist;
 _SecondType_ = TSearchArea;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}
 TatTreeLevelConverter = class(_atEnumToEnumConverter_)
 protected
 // realized methods
   procedure InitConvertMap; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TatTreeLevelConverter;
    {- возвращает экземпляр синглетона. }
 end;//TatTreeLevelConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatTreeLevelConverter

var g_TatTreeLevelConverter : TatTreeLevelConverter = nil;

procedure TatTreeLevelConverterFree;
begin
 l3Free(g_TatTreeLevelConverter);
end;

class function TatTreeLevelConverter.Instance: TatTreeLevelConverter;
begin
 if (g_TatTreeLevelConverter = nil) then
 begin
  l3System.AddExitProc(TatTreeLevelConverterFree);
  g_TatTreeLevelConverter := Create;
 end;
 Result := g_TatTreeLevelConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}

// start class TatTreeLevelConverter

class function TatTreeLevelConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatTreeLevelConverter <> nil;
end;//TatTreeLevelConverter.Exists

procedure TatTreeLevelConverter.InitConvertMap;
//#UC START# *503E3A040395_503E65E30321_var*
  const
    CONVERT_MAP : array [Tl3TreeLevelDist] of Synonyms = (
      (First: tldAllLevels; Second: SA_ALL_LEVEL),
      (First: tldOneLevel; Second: SA_ONE_LEVEL)
    );
//#UC END# *503E3A040395_503E65E30321_var*
begin
//#UC START# *503E3A040395_503E65E30321_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_503E65E30321_impl*
end;//TatTreeLevelConverter.InitConvertMap

end.