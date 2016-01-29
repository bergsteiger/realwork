{$IfNDef atBitMaskConverter_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atBitMaskConverter.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::CoreObjects::atBitMaskConverter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atBitMaskConverter_imp}
 TBitMaskValues = array of _BitMaskValueType_;

 _SecondType_ = _BitMaskType_;
 _FirstType_ = _BitMaskValueType_;
 {$Include ..\CoreObjects\atConverter.imp.pas}
 _atBitMaskConverter_ = {mixin} class(_atConverter_)
 public
 // public methods
   function ToValues(const aMask: _BitMaskType_): TBitMaskValues; virtual;
   function ToMask(const aValues: array of _BitMaskValueType_): _BitMaskType_; virtual;
 end;//_atBitMaskConverter_

{$Else atBitMaskConverter_imp}

{$Include ..\CoreObjects\atConverter.imp.pas}

// start class _atBitMaskConverter_

function _atBitMaskConverter_.ToValues(const aMask: _BitMaskType_): TBitMaskValues;
//#UC START# *504F313903B0_504F22BD0284_var*
  const
    BITS_IN_TYPE = 8*SizeOf(_BitMaskType_);
  var
    i : Integer;
    l_Flag :  _BitMaskType_;
//#UC END# *504F313903B0_504F22BD0284_var*
begin
//#UC START# *504F313903B0_504F22BD0284_impl*
  Result := nil;
  for i := 0 to BITS_IN_TYPE-1 do
  begin
    l_Flag := (_BitMaskType_(1) shl i) AND aMask;
    if l_Flag <> 0 then
    begin
      SetLength(Result, Length(Result)+1);
      Result[High(Result)] := SecondToFirst(l_Flag); // ���� ���� ����������, �� ����� ����������
    end;
  end;
//#UC END# *504F313903B0_504F22BD0284_impl*
end;//_atBitMaskConverter_.ToValues

function _atBitMaskConverter_.ToMask(const aValues: array of _BitMaskValueType_): _BitMaskType_;
//#UC START# *504F319402B1_504F22BD0284_var*
  var
    i : Integer;
//#UC END# *504F319402B1_504F22BD0284_var*
begin
//#UC START# *504F319402B1_504F22BD0284_impl*
  Result := 0;
  for i := Low(aValues) to High(aValues) do
    Result := Result OR FirstToSecond(aValues[i]);
//#UC END# *504F319402B1_504F22BD0284_impl*
end;//_atBitMaskConverter_.ToMask

{$EndIf atBitMaskConverter_imp}
