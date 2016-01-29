{$IfNDef atEnumConverter_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atEnumConverter.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::CoreObjects::atEnumConverter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atEnumConverter_imp}
 _SecondType_ = _EnumType_;
 {$Include ..\CoreObjects\atStringConverter.imp.pas}
 _atEnumConverter_ = {mixin} class(_atStringConverter_)
 protected
 // realized methods
   procedure InitConvertMap; override;
 protected
 // overridden protected methods
   procedure Error2nd(const aSecond: _SecondType_); override;
 public
 // public methods
   function ToName(const aValueOrd: Integer): AnsiString; overload;  virtual;
 end;//_atEnumConverter_

{$Else atEnumConverter_imp}

{$Include ..\CoreObjects\atStringConverter.imp.pas}

// start class _atEnumConverter_

function _atEnumConverter_.ToName(const aValueOrd: Integer): AnsiString;
//#UC START# *503E67610170_50005E6B0318_var*
//#UC END# *503E67610170_50005E6B0318_var*
begin
//#UC START# *503E67610170_50005E6B0318_impl*
  Result := ToName(_EnumType_(aValueOrd));
//#UC END# *503E67610170_50005E6B0318_impl*
end;//_atEnumConverter_.ToName

procedure _atEnumConverter_.InitConvertMap;
//#UC START# *503E3A040395_50005E6B0318_var*
 var
  l_TI : PTypeInfo;
  l_Value : _SecondType_;
  i : Integer;
//#UC END# *503E3A040395_50005E6B0318_var*
begin
//#UC START# *503E3A040395_50005E6B0318_impl*
  SetLength(f_ConvertMap, Ord(High(_SecondType_)) - Ord(Low(_SecondType_)) + 1);
  l_TI := TypeInfo(_SecondType_);
  i := 0;
  for l_Value := Low(_SecondType_) to High(_SecondType_) do
  begin
    f_ConvertMap[i].First := GetEnumName(l_TI, Ord(l_Value));
    f_ConvertMap[i].Second := l_Value;
    Inc(i);
  end;
//#UC END# *503E3A040395_50005E6B0318_impl*
end;//_atEnumConverter_.InitConvertMap

procedure _atEnumConverter_.Error2nd(const aSecond: _SecondType_);
//#UC START# *503E3CC102AE_50005E6B0318_var*
  var
    l_TI : PTypeInfo;
//#UC END# *503E3CC102AE_50005E6B0318_var*
begin
//#UC START# *503E3CC102AE_50005E6B0318_impl*
  l_TI := TypeInfo(_SecondType_);
  Raise EConvertError.CreateFmt('Ошибка конвертации перечисления типа %s в имя: не найдено соответствие для значения %d!', [l_TI^.Name, Ord(aSecond)]);
//#UC END# *503E3CC102AE_50005E6B0318_impl*
end;//_atEnumConverter_.Error2nd

{$EndIf atEnumConverter_imp}
