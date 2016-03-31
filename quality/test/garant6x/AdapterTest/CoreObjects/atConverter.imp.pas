{$IfNDef atConverter_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atConverter.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "atConverter" MUID: (503E2BCA01E8)
// Имя типа: "_atConverter_"

{$Define atConverter_imp}

type
 Synonyms = record
  First: _FirstType_;
  Second: _SecondType_;
 end;//Synonyms

 ConvertMap = array of Synonyms;

 EConvertError = class(Exception)
 end;//EConvertError

 _atConverter_ = class(TObject)
  protected
   f_ConvertMap: ConvertMap;
  protected
   procedure InitConvertMap; overload; virtual; abstract;
   procedure Error1st(const aFirst: _FirstType_); virtual;
   procedure Error2nd(const aSecond: _SecondType_); virtual;
   procedure InitConvertMap(const anArray: array of Synonyms); overload;
  public
   function FirstToSecond(const aFirst: _FirstType_): _SecondType_; overload;
   function SecondToFirst(const aSecond: _SecondType_): _FirstType_; overload;
   constructor Create; reintroduce;
 end;//_atConverter_

{$Else atConverter_imp}

{$IfNDef atConverter_imp_impl}

{$Define atConverter_imp_impl}

function _atConverter_.FirstToSecond(const aFirst: _FirstType_): _SecondType_;
//#UC START# *503E2F000018_503E2BCA01E8_var*
  var
    i : Integer;
//#UC END# *503E2F000018_503E2BCA01E8_var*
begin
//#UC START# *503E2F000018_503E2BCA01E8_impl*
  for i := Low(f_ConvertMap) to High(f_ConvertMap) do
    if aFirst = f_ConvertMap[i].First then
    begin
      Result := f_ConvertMap[i].Second;
      Exit;
    end;
  Error1st(aFirst);
//#UC END# *503E2F000018_503E2BCA01E8_impl*
end;//_atConverter_.FirstToSecond

function _atConverter_.SecondToFirst(const aSecond: _SecondType_): _FirstType_;
//#UC START# *503E2F1B035E_503E2BCA01E8_var*
  var
    i : Integer;
//#UC END# *503E2F1B035E_503E2BCA01E8_var*
begin
//#UC START# *503E2F1B035E_503E2BCA01E8_impl*
  for i := Low(f_ConvertMap) to High(f_ConvertMap) do
    if aSecond = f_ConvertMap[i].Second then
    begin
      Result := f_ConvertMap[i].First;
      Exit;
    end;
  Error2nd(aSecond);
//#UC END# *503E2F1B035E_503E2BCA01E8_impl*
end;//_atConverter_.SecondToFirst

procedure _atConverter_.Error1st(const aFirst: _FirstType_);
//#UC START# *503E3C86007D_503E2BCA01E8_var*
  var
    l_FirstTI, l_SecondTI : PTypeInfo;
//#UC END# *503E3C86007D_503E2BCA01E8_var*
begin
//#UC START# *503E3C86007D_503E2BCA01E8_impl*
  l_FirstTI := TypeInfo(_FirstType_);
  l_SecondTI := TypeInfo(_SecondType_);
  Raise EConvertError.CreateFmt('Ошибка конвертации из типа %s в тип %s : для переданного значения не найдено соответствие!', [l_FirstTI^.Name, l_SecondTI^.Name]);
//#UC END# *503E3C86007D_503E2BCA01E8_impl*
end;//_atConverter_.Error1st

procedure _atConverter_.Error2nd(const aSecond: _SecondType_);
//#UC START# *503E3CC102AE_503E2BCA01E8_var*
  var
    l_FirstTI, l_SecondTI : PTypeInfo;
//#UC END# *503E3CC102AE_503E2BCA01E8_var*
begin
//#UC START# *503E3CC102AE_503E2BCA01E8_impl*
  l_FirstTI := TypeInfo(_FirstType_);
  l_SecondTI := TypeInfo(_SecondType_);
  Raise EConvertError.CreateFmt('Ошибка конвертации из типа %s в тип %s : для переданного значения не найдено соответствие!', [l_SecondTI^.Name, l_FirstTI^.Name]);
//#UC END# *503E3CC102AE_503E2BCA01E8_impl*
end;//_atConverter_.Error2nd

constructor _atConverter_.Create;
//#UC START# *503E4FF00107_503E2BCA01E8_var*
//#UC END# *503E4FF00107_503E2BCA01E8_var*
begin
//#UC START# *503E4FF00107_503E2BCA01E8_impl*
  inherited;
  InitConvertMap;
//#UC END# *503E4FF00107_503E2BCA01E8_impl*
end;//_atConverter_.Create

procedure _atConverter_.InitConvertMap(const anArray: array of Synonyms);
//#UC START# *503E5D3102F3_503E2BCA01E8_var*
  var
    i, j : Integer;
//#UC END# *503E5D3102F3_503E2BCA01E8_var*
begin
//#UC START# *503E5D3102F3_503E2BCA01E8_impl*
  SetLength(f_ConvertMap, Length(anArray));
  j := Low(f_ConvertMap);
  for i := Low(anArray) to High(anArray) do
  begin
    f_ConvertMap[j] := anArray[i];
    Inc(j);
  end;
//#UC END# *503E5D3102F3_503E2BCA01E8_impl*
end;//_atConverter_.InitConvertMap

{$EndIf atConverter_imp_impl}

{$EndIf atConverter_imp}

