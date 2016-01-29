{$IfNDef atStringConverterImp_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atStringConverterImp.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::CoreObjects::atStringConverterImp
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atStringConverterImp_imp}
 _atStringConverterImp_ = {mixin} class(_atStringConverterImp_Parent_)
 protected
 // overridden protected methods
   procedure Error1st(const aFirst: _FirstType_); override;
 public
 // public methods
   function ToValue(const aName: AnsiString): _SecondType_; virtual;
   function ToName(const aValue: _SecondType_): AnsiString; overload;  virtual;
   function ToValueCI(const aName: AnsiString): _SecondType_; virtual;
 end;//_atStringConverterImp_

{$Else atStringConverterImp_imp}

// start class _atStringConverterImp_

function _atStringConverterImp_.ToValue(const aName: AnsiString): _SecondType_;
//#UC START# *503E318D00A7_503E313601ED_var*
//#UC END# *503E318D00A7_503E313601ED_var*
begin
//#UC START# *503E318D00A7_503E313601ED_impl*
  Result := FirstToSecond(aName);
//#UC END# *503E318D00A7_503E313601ED_impl*
end;//_atStringConverterImp_.ToValue

function _atStringConverterImp_.ToName(const aValue: _SecondType_): AnsiString;
//#UC START# *503E31BD027C_503E313601ED_var*
//#UC END# *503E31BD027C_503E313601ED_var*
begin
//#UC START# *503E31BD027C_503E313601ED_impl*
  Result := SecondToFirst(aValue);
//#UC END# *503E31BD027C_503E313601ED_impl*
end;//_atStringConverterImp_.ToName

function _atStringConverterImp_.ToValueCI(const aName: AnsiString): _SecondType_;
//#UC START# *503E37A40321_503E313601ED_var*
  var
    i : Integer;
//#UC END# *503E37A40321_503E313601ED_var*
begin
//#UC START# *503E37A40321_503E313601ED_impl*
  for i := Low(f_ConvertMap) to High(f_ConvertMap) do
    if AnsiSameText(aName, f_ConvertMap[i].First) then
    begin
      Result := f_ConvertMap[i].Second;
      Exit;
    end;
  Error1St(aName);  
//#UC END# *503E37A40321_503E313601ED_impl*
end;//_atStringConverterImp_.ToValueCI

procedure _atStringConverterImp_.Error1st(const aFirst: _FirstType_);
//#UC START# *503E3C86007D_503E313601ED_var*
  var
    l_TI : PTypeInfo;
//#UC END# *503E3C86007D_503E313601ED_var*
begin
//#UC START# *503E3C86007D_503E313601ED_impl*
  l_TI := TypeInfo(_SecondType_);
  Raise EConvertError.CreateFmt('Ошибка конвертации из имени в тип %s: не найдено соответствия для имени "%s"!', [l_TI^.Name, aFirst]);
//#UC END# *503E3C86007D_503E313601ED_impl*
end;//_atStringConverterImp_.Error1st

{$EndIf atStringConverterImp_imp}
