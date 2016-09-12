unit msmModelElement;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElement.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElement" MUID: (57A9F5170275)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmBaseModelElement
 , msmModelElements
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Interfaces
;

type
 TmsmModelElement = class(TmsmBaseModelElement, ImsmModelElement)
  private
   f_Children: ImsmModelElementList;
  protected
   function Get_Parent: ImsmModelElement;
   function Get_Children: ImsmModelElementList;
   function IsSameElement(const anOther: ImsmModelElement): Boolean;
   function Get_List(const aName: AnsiString): ImsmModelElementList;
   function Get_StringProp(const aName: AnsiString): Il3CString;
   function Get_IntProp(const aName: AnsiString): Integer;
   function Get_BoolProp(const aName: AnsiString): Boolean;
   function Get_ElementProp(const aName: AnsiString): ImsmModelElement;
   function Get_MainWord: TtfwWord;
   function IsView: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(aMainWord: TtfwWord); reintroduce;
 end;//TmsmModelElement

implementation

uses
 l3ImplUses
 , msmModelElementMethodCaller
 , msmModelElementList
 , msmModelElementFactory
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

function TmsmModelElement.Get_Parent: ImsmModelElement;
//#UC START# *57AA0B890200_57A9F5170275get_var*
var
 l_P : TObject;
 l_Parent: TtfwWord;
//#UC END# *57AA0B890200_57A9F5170275get_var*
begin
//#UC START# *57AA0B890200_57A9F5170275get_impl*
 l_P := TmsmModelElementMethodCaller.CallAndGetObj(MainWord, 'Parent');
 if (l_P = nil) then
  l_Parent := nil
 else
  l_Parent := l_P As TtfwWord;
 if (l_Parent = nil) then
  Result := nil
 else
  Result := TmsmModelElementFactory.Make(l_Parent);
//#UC END# *57AA0B890200_57A9F5170275get_impl*
end;//TmsmModelElement.Get_Parent

function TmsmModelElement.Get_Children: ImsmModelElementList;
//#UC START# *57AAD9CA008A_57A9F5170275get_var*
const
 cChildren = 'Children';
//#UC END# *57AAD9CA008A_57A9F5170275get_var*
begin
//#UC START# *57AAD9CA008A_57A9F5170275get_impl*
 if (f_Children = nil) then
  f_Children := TmsmModelElementList.Make(MainWord, TmsmModelElementMethodCaller.CallAndGetList(MainWord, cChildren), cChildren);
 Result := f_Children; 
//#UC END# *57AAD9CA008A_57A9F5170275get_impl*
end;//TmsmModelElement.Get_Children

function TmsmModelElement.IsSameElement(const anOther: ImsmModelElement): Boolean;
//#UC START# *57AC39AE0181_57A9F5170275_var*
var
 l_W : ITmsmBaseModelElementWrap;
 l_Other : ImsmModelElement;
//#UC END# *57AC39AE0181_57A9F5170275_var*
begin
//#UC START# *57AC39AE0181_57A9F5170275_impl*
 if (anOther = nil) then
  Result := false
 else
 begin
  l_Other := anOther;
  if l_Other.IsView then
   l_Other := l_Other.ElementProp['Original'];
  Result := l3IEQ(Self, l_Other);
  if not Result then
  begin
   if Supports(l_Other, ITmsmBaseModelElementWrap, l_W) then
    try
     Result := (Self.MainWord.GetRefForCompare = l_W.GetSelf.MainWord.GetRefForCompare);
    finally
     l_W := nil;
    end;//try..finally
  end;//not Result
  if not Result then
   if Self.IsView then
    Result := Self.Get_ElementProp('Original').IsSameElement(l_Other);
 end;//anOther = nil
//#UC END# *57AC39AE0181_57A9F5170275_impl*
end;//TmsmModelElement.IsSameElement

function TmsmModelElement.Get_List(const aName: AnsiString): ImsmModelElementList;
//#UC START# *57B2F55702DE_57A9F5170275get_var*
//#UC END# *57B2F55702DE_57A9F5170275get_var*
begin
//#UC START# *57B2F55702DE_57A9F5170275get_impl*
 if (aName = 'Children') then
  Result := Get_Children
 else
  Result := TmsmModelElementList.Make(MainWord, TmsmModelElementMethodCaller.CallAndGetList(MainWord, aName), aName);
//#UC END# *57B2F55702DE_57A9F5170275get_impl*
end;//TmsmModelElement.Get_List

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
var
 l_P : TObject;
//#UC END# *57B5E9BE022F_57A9F5170275get_var*
begin
//#UC START# *57B5E9BE022F_57A9F5170275get_impl*
 if (aName = 'Parent') then
  Result := Get_Parent
 else
 begin
  l_P := TmsmModelElementMethodCaller.CallAndGetObj(MainWord, aName);
  if (l_P = nil) then
   Result := nil
  else
   Result := TmsmModelElementFactory.Make(l_P As TtfwWord);
 end;//aName = 'Parent'
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

procedure TmsmModelElement.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57A9F5170275_var*
//#UC END# *479731C50290_57A9F5170275_var*
begin
//#UC START# *479731C50290_57A9F5170275_impl*
 f_Children := nil;
 inherited;
//#UC END# *479731C50290_57A9F5170275_impl*
end;//TmsmModelElement.Cleanup

procedure TmsmModelElement.ClearFields;
begin
 f_Children := nil;
 inherited;
end;//TmsmModelElement.ClearFields

end.
