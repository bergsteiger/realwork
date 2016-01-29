{$IfNDef atEnumToEnumConverter_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atEnumToEnumConverter.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::CoreObjects::atEnumToEnumConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atEnumToEnumConverter_imp}
 {$Include ..\CoreObjects\atConverter.imp.pas}
 _atEnumToEnumConverter_ = {mixin} class(_atConverter_)
 public
 // public methods
   function FirstToSecond(const aFirstOrd: Integer): _SecondType_; overload;  virtual;
   function SecondToFirst(const aSecondOrd: Integer): _FirstType_; overload;  virtual;
 end;//_atEnumToEnumConverter_

{$Else atEnumToEnumConverter_imp}

{$Include ..\CoreObjects\atConverter.imp.pas}

// start class _atEnumToEnumConverter_

function _atEnumToEnumConverter_.FirstToSecond(const aFirstOrd: Integer): _SecondType_;
//#UC START# *503E671B03A4_503E66FA02FE_var*
//#UC END# *503E671B03A4_503E66FA02FE_var*
begin
//#UC START# *503E671B03A4_503E66FA02FE_impl*
  Result := FirstToSecond(_FirstType_(aFirstOrd));
//#UC END# *503E671B03A4_503E66FA02FE_impl*
end;//_atEnumToEnumConverter_.FirstToSecond

function _atEnumToEnumConverter_.SecondToFirst(const aSecondOrd: Integer): _FirstType_;
//#UC START# *503E67390123_503E66FA02FE_var*
//#UC END# *503E67390123_503E66FA02FE_var*
begin
//#UC START# *503E67390123_503E66FA02FE_impl*
  Result := SecondToFirst(_SecondType_(aSecondOrd));
//#UC END# *503E67390123_503E66FA02FE_impl*
end;//_atEnumToEnumConverter_.SecondToFirst

{$EndIf atEnumToEnumConverter_imp}
