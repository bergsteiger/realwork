unit msmModelElement;

// ������: "w:\common\components\gui\Garant\msm\msmModelElement.pas"
// ���������: "SimpleClass"
// ������� ������: "TmsmModelElement" MUID: (57A9F5170275)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmBaseModelElement
 , msmModelElements
 , msmModelElementMethodCaller
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Interfaces
;

type
 TmsmModelElement = class(TmsmBaseModelElement, ImsmModelElement)
  protected
   function Get_Parent: ImsmModelElement;
   function IsSameElement(const anOther: ImsmModelElement): Boolean;
   function Get_MEList(const aName: AnsiString): ImsmModelElementList;
   function Get_StringProp(const aName: AnsiString): Il3CString;
   function Get_IntProp(const aName: AnsiString): Integer;
   procedure Set_IntProp(const aName: AnsiString;
    aValue: Integer);
   function Get_BoolProp(const aName: AnsiString): Boolean;
   function Get_ElementProp(const aName: AnsiString): ImsmModelElement;
   function Get_MainWord: TtfwWord;
   function IsView: Boolean;
   function Get_ListProp(const aName: AnsiString): ItfwValueList;
   function IsSameElementView(const anOther: ImsmModelElement): Boolean;
   function IsViewLink: Boolean;
   function Call(const aParameters: array of TtfwStackValue;
    const aMethodName: AnsiString): TtfwStackValue;
   function CallAndGetList(const aParameters: array of TtfwStackValue;
    const aMethodName: AnsiString): ItfwArray;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(aMainWord: TtfwWord); reintroduce;
   class function MakeFromWord(aWord: TtfwWord): ImsmModelElement;
   class function MakeFromObj(anObject: TObject): ImsmModelElement;
   class function MakeFromValue(const aValue: TtfwStackValue): ImsmModelElement;
   class function tfwCatValueArray(const A: array of TtfwStackValue;
    const B: array of TtfwStackValue): TtfwStackValuesArray;
 end;//TmsmModelElement

implementation

uses
 l3ImplUses
 , msmModelElementList
 , msmModelElementFactory
 , msmElementViews
 //#UC START# *57A9F5170275impl_uses*
 , SysUtils
 , l3InterfacesMisc
 , l3String
 //#UC END# *57A9F5170275impl_uses*
;

constructor TmsmModelElement.Create(aMainWord: TtfwWord);
//#UC START# *57ACABF800A3_57A9F5170275_var*
//#UC END# *57ACABF800A3_57A9F5170275_var*
begin
//#UC START# *57ACABF800A3_57A9F5170275_impl*
 inherited Create(aMainWord);
//#UC END# *57ACABF800A3_57A9F5170275_impl*
end;//TmsmModelElement.Create

class function TmsmModelElement.MakeFromWord(aWord: TtfwWord): ImsmModelElement;
//#UC START# *57E30F7201EF_57A9F5170275_var*
//#UC END# *57E30F7201EF_57A9F5170275_var*
begin
//#UC START# *57E30F7201EF_57A9F5170275_impl*
 if (aWord = nil) then
  Result := nil
 else 
  Result := TmsmModelElementFactory.Make(aWord);
//#UC END# *57E30F7201EF_57A9F5170275_impl*
end;//TmsmModelElement.MakeFromWord

class function TmsmModelElement.MakeFromObj(anObject: TObject): ImsmModelElement;
//#UC START# *57E30F9F0205_57A9F5170275_var*
//#UC END# *57E30F9F0205_57A9F5170275_var*
begin
//#UC START# *57E30F9F0205_57A9F5170275_impl*
 if (anObject = nil) then
  Result := nil
 else 
  Result := MakeFromWord(anObject As TtfwWord);
//#UC END# *57E30F9F0205_57A9F5170275_impl*
end;//TmsmModelElement.MakeFromObj

class function TmsmModelElement.MakeFromValue(const aValue: TtfwStackValue): ImsmModelElement;
//#UC START# *57E30FCD03DF_57A9F5170275_var*
//#UC END# *57E30FCD03DF_57A9F5170275_var*
begin
//#UC START# *57E30FCD03DF_57A9F5170275_impl*
 Result := MakeFromObj(aValue.AsObject);
//#UC END# *57E30FCD03DF_57A9F5170275_impl*
end;//TmsmModelElement.MakeFromValue

class function TmsmModelElement.tfwCatValueArray(const A: array of TtfwStackValue;
 const B: array of TtfwStackValue): TtfwStackValuesArray;
//#UC START# *57F4E41301BA_57A9F5170275_var*
var
 l_ALen  : Integer;
 l_BLen  : Integer;
 l_Index : Integer;
//#UC END# *57F4E41301BA_57A9F5170275_var*
begin
//#UC START# *57F4E41301BA_57A9F5170275_impl*
 l_ALen := Succ(High(A));
 l_BLen := Succ(High(B));
 SetLength(Result, l_ALen + l_BLen);
 for l_Index := 0 to Pred(l_ALen) do
  Result[l_Index] := A[l_Index];
 for l_Index := 0 to Pred(l_BLen) do
  Result[l_ALen + l_Index] := B[l_Index];
//#UC END# *57F4E41301BA_57A9F5170275_impl*
end;//TmsmModelElement.tfwCatValueArray

function TmsmModelElement.Get_Parent: ImsmModelElement;
//#UC START# *57AA0B890200_57A9F5170275get_var*
//#UC END# *57AA0B890200_57A9F5170275get_var*
begin
//#UC START# *57AA0B890200_57A9F5170275get_impl*
 Result := Get_ElementProp('Parent');
//#UC END# *57AA0B890200_57A9F5170275get_impl*
end;//TmsmModelElement.Get_Parent

function TmsmModelElement.IsSameElement(const anOther: ImsmModelElement): Boolean;
//#UC START# *57AC39AE0181_57A9F5170275_var*
//#UC END# *57AC39AE0181_57A9F5170275_var*
begin
//#UC START# *57AC39AE0181_57A9F5170275_impl*
 if (anOther = nil) then
  Result := false
 else
 begin
  Result := l3IEQ(Self, anOther);
  if not Result then
   Result := (Self.MainWord.GetRefForCompare = anOther.MainWord.GetRefForCompare);
 end;//anOther = nil
//#UC END# *57AC39AE0181_57A9F5170275_impl*
end;//TmsmModelElement.IsSameElement

function TmsmModelElement.Get_MEList(const aName: AnsiString): ImsmModelElementList;
//#UC START# *57B2F55702DE_57A9F5170275get_var*
//#UC END# *57B2F55702DE_57A9F5170275get_var*
begin
//#UC START# *57B2F55702DE_57A9F5170275get_impl*
 Result := TmsmModelElementList.Make(TmsmModelElementView_C(Self, aName));
//#UC END# *57B2F55702DE_57A9F5170275get_impl*
end;//TmsmModelElement.Get_MEList

function TmsmModelElement.Get_StringProp(const aName: AnsiString): Il3CString;
//#UC START# *57B301FD025C_57A9F5170275get_var*
//#UC END# *57B301FD025C_57A9F5170275get_var*
begin
//#UC START# *57B301FD025C_57A9F5170275get_impl*
 if (aName = 'NameInModel') then
  Result := Get_Name
 else
  Result := TmsmModelElementMethodCaller.CallAndGetString(MainWord, aName);
//#UC END# *57B301FD025C_57A9F5170275get_impl*
end;//TmsmModelElement.Get_StringProp

function TmsmModelElement.Get_IntProp(const aName: AnsiString): Integer;
//#UC START# *57B47A88013F_57A9F5170275get_var*
//#UC END# *57B47A88013F_57A9F5170275get_var*
begin
//#UC START# *57B47A88013F_57A9F5170275get_impl*
 Result := TmsmModelElementMethodCaller.CallAndGetInt(MainWord, aName);
//#UC END# *57B47A88013F_57A9F5170275get_impl*
end;//TmsmModelElement.Get_IntProp

procedure TmsmModelElement.Set_IntProp(const aName: AnsiString;
 aValue: Integer);
//#UC START# *57B47A88013F_57A9F5170275set_var*
//#UC END# *57B47A88013F_57A9F5170275set_var*
begin
//#UC START# *57B47A88013F_57A9F5170275set_impl*
 TmsmModelElementMethodCaller.CallIntSetter(MainWord, aName, aValue);
//#UC END# *57B47A88013F_57A9F5170275set_impl*
end;//TmsmModelElement.Set_IntProp

function TmsmModelElement.Get_BoolProp(const aName: AnsiString): Boolean;
//#UC START# *57B47AB0030F_57A9F5170275get_var*
//#UC END# *57B47AB0030F_57A9F5170275get_var*
begin
//#UC START# *57B47AB0030F_57A9F5170275get_impl*
 Result := TmsmModelElementMethodCaller.CallAndGetBool(MainWord, aName);
//#UC END# *57B47AB0030F_57A9F5170275get_impl*
end;//TmsmModelElement.Get_BoolProp

function TmsmModelElement.Get_ElementProp(const aName: AnsiString): ImsmModelElement;
//#UC START# *57B5E9BE022F_57A9F5170275get_var*
//#UC END# *57B5E9BE022F_57A9F5170275get_var*
begin
//#UC START# *57B5E9BE022F_57A9F5170275get_impl*
 Result := MakeFromObj(TmsmModelElementMethodCaller.CallAndGetObj(MainWord, aName));
//#UC END# *57B5E9BE022F_57A9F5170275get_impl*
end;//TmsmModelElement.Get_ElementProp

function TmsmModelElement.Get_MainWord: TtfwWord;
//#UC START# *57C3E90C0177_57A9F5170275get_var*
//#UC END# *57C3E90C0177_57A9F5170275get_var*
begin
//#UC START# *57C3E90C0177_57A9F5170275get_impl*
 Result := MainWord;
//#UC END# *57C3E90C0177_57A9F5170275get_impl*
end;//TmsmModelElement.Get_MainWord

function TmsmModelElement.IsView: Boolean;
//#UC START# *57D1435E002F_57A9F5170275_var*
//#UC END# *57D1435E002F_57A9F5170275_var*
begin
//#UC START# *57D1435E002F_57A9F5170275_impl*
 Result := Get_BoolProp('IsView');
//#UC END# *57D1435E002F_57A9F5170275_impl*
end;//TmsmModelElement.IsView

function TmsmModelElement.Get_ListProp(const aName: AnsiString): ItfwValueList;
//#UC START# *57E30E3802C5_57A9F5170275get_var*
//#UC END# *57E30E3802C5_57A9F5170275get_var*
begin
//#UC START# *57E30E3802C5_57A9F5170275get_impl*
 Result := TmsmModelElementMethodCaller.CallAndGetList(MainWord, aName);
//#UC END# *57E30E3802C5_57A9F5170275get_impl*
end;//TmsmModelElement.Get_ListProp

function TmsmModelElement.IsSameElementView(const anOther: ImsmModelElement): Boolean;
//#UC START# *57E3F150013E_57A9F5170275_var*
//#UC END# *57E3F150013E_57A9F5170275_var*
begin
//#UC START# *57E3F150013E_57A9F5170275_impl*
 if (anOther = nil) then
  Result := false
 else
 begin
  Result := l3IEQ(Self, anOther);
  if not Result then
   Result := (Self.MainWord.GetRefForCompare = anOther.MainWord.GetRefForCompare);
  if not Result then
   Result := Self.Get_ElementProp('Viewed').IsSameElement(anOther.ElementProp['Viewed']);
 end;//anOther = nil
//#UC END# *57E3F150013E_57A9F5170275_impl*
end;//TmsmModelElement.IsSameElementView

function TmsmModelElement.IsViewLink: Boolean;
//#UC START# *57E3F1660281_57A9F5170275_var*
//#UC END# *57E3F1660281_57A9F5170275_var*
begin
//#UC START# *57E3F1660281_57A9F5170275_impl*
 Result := Get_BoolProp('IsViewLink');
//#UC END# *57E3F1660281_57A9F5170275_impl*
end;//TmsmModelElement.IsViewLink

function TmsmModelElement.Call(const aParameters: array of TtfwStackValue;
 const aMethodName: AnsiString): TtfwStackValue;
//#UC START# *57E3F2E600D8_57A9F5170275_var*
//#UC END# *57E3F2E600D8_57A9F5170275_var*
begin
//#UC START# *57E3F2E600D8_57A9F5170275_impl*
 Result := TmsmModelElementMethodCaller.Call(tfwCatValueArray([TtfwStackValue_C(MainWord)], aParameters), aMethodName);
//#UC END# *57E3F2E600D8_57A9F5170275_impl*
end;//TmsmModelElement.Call

function TmsmModelElement.CallAndGetList(const aParameters: array of TtfwStackValue;
 const aMethodName: AnsiString): ItfwArray;
//#UC START# *57F4E3E001E9_57A9F5170275_var*
//#UC END# *57F4E3E001E9_57A9F5170275_var*
begin
//#UC START# *57F4E3E001E9_57A9F5170275_impl*
 Result := TmsmModelElementMethodCaller.CallAndGetList(tfwCatValueArray([TtfwStackValue_C(MainWord)], aParameters), aMethodName);
//#UC END# *57F4E3E001E9_57A9F5170275_impl*
end;//TmsmModelElement.CallAndGetList

procedure TmsmModelElement.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_57A9F5170275_var*
//#UC END# *479731C50290_57A9F5170275_var*
begin
//#UC START# *479731C50290_57A9F5170275_impl*
 inherited;
//#UC END# *479731C50290_57A9F5170275_impl*
end;//TmsmModelElement.Cleanup

end.
