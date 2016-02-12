unit atTreeLevelConverter;

// Модуль: "w:\quality\test\garant6x\AdapterTest\InteropWithL3\atTreeLevelConverter.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , l3Interfaces
 , DynamicTreeUnit
;

type
 _FirstType_ = Tl3TreeLevelDist;
 _SecondType_ = TSearchArea;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}
 TatTreeLevelConverter = class(_atEnumToEnumConverter_)
  protected
   procedure InitConvertMap; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TatTreeLevelConverter;
    {* Метод получения экземпляра синглетона TatTreeLevelConverter }
 end;//TatTreeLevelConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , l3Base
;

var g_TatTreeLevelConverter: TatTreeLevelConverter = nil;
 {* Экземпляр синглетона TatTreeLevelConverter }

procedure TatTreeLevelConverterFree;
 {* Метод освобождения экземпляра синглетона TatTreeLevelConverter }
begin
 l3Free(g_TatTreeLevelConverter);
end;//TatTreeLevelConverterFree

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}

class function TatTreeLevelConverter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
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

class function TatTreeLevelConverter.Instance: TatTreeLevelConverter;
 {* Метод получения экземпляра синглетона TatTreeLevelConverter }
begin
 if (g_TatTreeLevelConverter = nil) then
 begin
  l3System.AddExitProc(TatTreeLevelConverterFree);
  g_TatTreeLevelConverter := Create;
 end;
 Result := g_TatTreeLevelConverter;
end;//TatTreeLevelConverter.Instance

end.
