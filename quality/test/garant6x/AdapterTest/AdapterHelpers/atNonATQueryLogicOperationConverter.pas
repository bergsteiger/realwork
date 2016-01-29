unit atNonATQueryLogicOperationConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atNonATQueryLogicOperationConverter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatNonATQueryLogicOperationConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  SearchUnit,
  SysUtils
  ;

type
 _SecondType_ = TQueryLogicOperation;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringConverter.imp.pas}
 TatNonATQueryLogicOperationConverter = class(_atStringConverter_)
 protected
 // realized methods
   procedure InitConvertMap; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TatNonATQueryLogicOperationConverter;
    {- возвращает экземпляр синглетона. }
 end;//TatNonATQueryLogicOperationConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatNonATQueryLogicOperationConverter

var g_TatNonATQueryLogicOperationConverter : TatNonATQueryLogicOperationConverter = nil;

procedure TatNonATQueryLogicOperationConverterFree;
begin
 l3Free(g_TatNonATQueryLogicOperationConverter);
end;

class function TatNonATQueryLogicOperationConverter.Instance: TatNonATQueryLogicOperationConverter;
begin
 if (g_TatNonATQueryLogicOperationConverter = nil) then
 begin
  l3System.AddExitProc(TatNonATQueryLogicOperationConverterFree);
  g_TatNonATQueryLogicOperationConverter := Create;
 end;
 Result := g_TatNonATQueryLogicOperationConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringConverter.imp.pas}

// start class TatNonATQueryLogicOperationConverter

class function TatNonATQueryLogicOperationConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatNonATQueryLogicOperationConverter <> nil;
end;//TatNonATQueryLogicOperationConverter.Exists

procedure TatNonATQueryLogicOperationConverter.InitConvertMap;
//#UC START# *503E3A040395_503E51C002D7_var*
  const
    CONVERT_MAP : array [_SecondType_] of Synonyms = (
      (First : 'LO_OR'; Second : QLO_OR),
      (First : 'LO_AND'; Second : QLO_AND),
      (First : 'LO_NOT'; Second : QLO_AND_NOT)
    );
//#UC END# *503E3A040395_503E51C002D7_var*
begin
//#UC START# *503E3A040395_503E51C002D7_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_503E51C002D7_impl*
end;//TatNonATQueryLogicOperationConverter.InitConvertMap

end.