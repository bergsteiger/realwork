unit nevParaPrim;
 {* Пустой параграф }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevParaPrim.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , k2TagTool
 , nevTools
 , nevBase
 , l3Variant
;

type
 TnevParaPrim = class(Tk2TagTool, InevPara, InevObject, InevObjectModify)
  {* Пустой параграф }
  protected
   function TreatCollapsedAsHidden: Boolean; virtual;
   function GetText: TnevStr; virtual;
   function DoGetBackColor: TnevColor; virtual;
   function GetNeedIncludeHeight(aCheckType: Boolean): Boolean; virtual;
   function GetOffsetX: Integer; virtual;
   function GetOverlapType: TOverlapType; virtual;
   function GetOwnerPara: InevParaList; virtual;
   function GetIsList: Boolean; virtual;
   function GetToList: InevObjectList; virtual;
   function GetAsList: InevParaList; virtual;
   function GetIsVertical: Boolean; virtual;
   function GetIsEmpty: Boolean; virtual;
   function GetAppliesToMaxWidth: Boolean; virtual;
   function GetIsHiddenPrim(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean; virtual;
   function GetDocumentContainer: InevDocumentContainer; virtual;
   function GetPID: TnevParaIndex; virtual;
   function GetPrev: InevPara; virtual;
   function GetNext: InevPara; virtual;
   function GetOwnerTag: Tl3Variant; virtual;
   function DoDelete(anInMerge: Boolean;
    const anOp: InevOp): Boolean; virtual;
   function GetAnchorID: Integer; virtual;
   function GetHolder: InevObjectHolder; virtual;
   function Range(const aStart: InevBasePoint = nil;
    const aFinish: InevBasePoint = nil;
    aSharp: Boolean = False): InevRange;
    {* выделение на данном объекте. }
   function SubRange(const aView: InevView;
    aStart: Integer;
    aFinish: Integer): InevRange;
    {* возвращает выделение на данном объекте от aStart до aFinish. }
   function MakePoint(const aParent: InevBasePoint = nil): InevPoint;
    {* точка в объекте. }
   function CloneObj: InevObject;
   function OwnerObj: InevObjectList;
    {* родительский объект данного объекта. }
   function IsPara: Boolean;
   function AsPara: InevPara;
    {* преобразует объект к параграфу, если это возможно, иначе - исключение. }
   function ToList: InevObjectList;
   function MakeAnchor: InevAnchor;
   function Delete(anInMerge: Boolean;
    const anOp: InevOp = nil): Boolean;
    {* удаляет параграф aPara. }
   function Edit: InevObjectModify;
   function pm_GetHolder: InevObjectHolder;
   function pm_GetIsEmpty: Boolean;
   function pm_GetAnchorID: Integer;
   function OwnerTag: Tl3Variant;
    {* родительский тег данного параграфа. }
   function OwnerPara: InevParaList;
    {* родительский параграф данного параграфа. }
   function AsList: InevParaList;
   function IsComment: Boolean;
   function pm_GetDocumentContainer: InevDocumentContainer;
   function pm_GetPrev: InevPara;
   function pm_GetNext: InevPara;
   function pm_GetMainSubList: InevSubList;
   function pm_GetText: TnevStr;
   function pm_GetTabStops: InevTabStops;
   function pm_GetBackColor: TnevColor;
   function pm_GetOffsetX: Integer;
   function pm_GetPID: TnevParaIndex;
   function pm_GetIsVertical: Boolean;
   function Get_OverlapType: TOverlapType;
   function IsLegalComment: Boolean;
    {* Юридический комментарий? }
   function IsCollapsed(const aView: InevView): Boolean;
   function BaseLine4Anchor: InevBaseLine4Anchor;
   function BaseLine4Print: InevBaseLine4Print;
   function IsDecorationElement: Boolean;
   function DecorObj(aType: TnevDecorType): Tl3Variant;
   function Get_HolderPrim: InevObjectHolderPrim;
   function Get_TreatCollapsedAsHidden: Boolean;
  public
   constructor Create(aTag: Tl3Variant); reintroduce;
   function AppliesToMaxWidth: Boolean;
   function IsHiddenPrim(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean;
   procedure Invalidate(aParts: TnevShapeParts);
    {* Сообщает о необходимости перерисовать форму, если она отображается в каком-нибудь View. }
   function IsList: Boolean;
   function NeedIncludeHeight(aCheckType: Boolean = True): Boolean;
    {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
 end;//TnevParaPrim
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevFacade
 , k2Base
 , k2Tags
 , evdStyles
 , k2Const
 , evdTextStyle_Const
 , l3String
 , evTabStops
 , k2NullTagImpl
 {$If NOT Defined(NoScripts)}
 , evParaWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

function TnevParaPrim.TreatCollapsedAsHidden: Boolean;
//#UC START# *4D596369028C_48CE0A490377_var*
//#UC END# *4D596369028C_48CE0A490377_var*
begin
//#UC START# *4D596369028C_48CE0A490377_impl*
 Result := true;
//#UC END# *4D596369028C_48CE0A490377_impl*
end;//TnevParaPrim.TreatCollapsedAsHidden

function TnevParaPrim.GetText: TnevStr;
//#UC START# *4D7255870102_48CE0A490377_var*
//#UC END# *4D7255870102_48CE0A490377_var*
begin
//#UC START# *4D7255870102_48CE0A490377_impl*
 l3AssignNil(Result);
//#UC END# *4D7255870102_48CE0A490377_impl*
end;//TnevParaPrim.GetText

function TnevParaPrim.DoGetBackColor: TnevColor;
//#UC START# *52B29B2E013C_48CE0A490377_var*
//#UC END# *52B29B2E013C_48CE0A490377_var*
begin
//#UC START# *52B29B2E013C_48CE0A490377_impl*
 Result := rLong(k2_tiBackColor, nevDefaultColor);
 if (Result = k2_TransparentValue) then
  Result := nevDefaultColor;
 if (Result = nevDefaultColor) then
 begin
  with pm_GetAttr(k2_tiStyle).Attr[k2_tiFont] do
  begin
   if HasSubAtom(k2_tiBackColor) then
   begin
    Result := IntA[k2_tiBackColor];
    if (Result = k2_TransparentValue) then
     Result := nevDefaultColor;
   end;//HasSubAtom(k2_tiBackColor)
  end;//Attr[k2_tiStyle].Attr[k2_tiFont]
 end;//Result = nevDefaultColor
//#UC END# *52B29B2E013C_48CE0A490377_impl*
end;//TnevParaPrim.DoGetBackColor

function TnevParaPrim.GetNeedIncludeHeight(aCheckType: Boolean): Boolean;
//#UC START# *48CE16E30320_48CE0A490377_var*
//#UC END# *48CE16E30320_48CE0A490377_var*
begin
//#UC START# *48CE16E30320_48CE0A490377_impl*
 Result := True;
//#UC END# *48CE16E30320_48CE0A490377_impl*
end;//TnevParaPrim.GetNeedIncludeHeight

function TnevParaPrim.GetOffsetX: Integer;
//#UC START# *48CE1AD90102_48CE0A490377_var*
//#UC END# *48CE1AD90102_48CE0A490377_var*
begin
//#UC START# *48CE1AD90102_48CE0A490377_impl*
 Result := 0;
//#UC END# *48CE1AD90102_48CE0A490377_impl*
end;//TnevParaPrim.GetOffsetX

function TnevParaPrim.GetOverlapType: TOverlapType;
//#UC START# *48CE1B22020E_48CE0A490377_var*
//#UC END# *48CE1B22020E_48CE0A490377_var*
begin
//#UC START# *48CE1B22020E_48CE0A490377_impl*
 Result := otNone;
//#UC END# *48CE1B22020E_48CE0A490377_impl*
end;//TnevParaPrim.GetOverlapType

function TnevParaPrim.GetOwnerPara: InevParaList;
//#UC START# *48CE65BC021C_48CE0A490377_var*
//#UC END# *48CE65BC021C_48CE0A490377_var*
begin
//#UC START# *48CE65BC021C_48CE0A490377_impl*
 Result := nev.NullParaList;
//#UC END# *48CE65BC021C_48CE0A490377_impl*
end;//TnevParaPrim.GetOwnerPara

function TnevParaPrim.GetIsList: Boolean;
//#UC START# *48CE681402F4_48CE0A490377_var*
//#UC END# *48CE681402F4_48CE0A490377_var*
begin
//#UC START# *48CE681402F4_48CE0A490377_impl*
 Result := false;
//#UC END# *48CE681402F4_48CE0A490377_impl*
end;//TnevParaPrim.GetIsList

function TnevParaPrim.GetToList: InevObjectList;
//#UC START# *48CE699100FE_48CE0A490377_var*
//#UC END# *48CE699100FE_48CE0A490377_var*
begin
//#UC START# *48CE699100FE_48CE0A490377_impl*
 Result := AsList.ToList;
//#UC END# *48CE699100FE_48CE0A490377_impl*
end;//TnevParaPrim.GetToList

function TnevParaPrim.GetAsList: InevParaList;
//#UC START# *48CE69D3015A_48CE0A490377_var*
//#UC END# *48CE69D3015A_48CE0A490377_var*
begin
//#UC START# *48CE69D3015A_48CE0A490377_impl*
 Result := nil;
 Assert(false);
//#UC END# *48CE69D3015A_48CE0A490377_impl*
end;//TnevParaPrim.GetAsList

function TnevParaPrim.GetIsVertical: Boolean;
//#UC START# *48CF9EB2030B_48CE0A490377_var*
//#UC END# *48CF9EB2030B_48CE0A490377_var*
begin
//#UC START# *48CF9EB2030B_48CE0A490377_impl*
 Result := true;
//#UC END# *48CF9EB2030B_48CE0A490377_impl*
end;//TnevParaPrim.GetIsVertical

function TnevParaPrim.GetIsEmpty: Boolean;
//#UC START# *48CF9F4F01D0_48CE0A490377_var*
//#UC END# *48CF9F4F01D0_48CE0A490377_var*
begin
//#UC START# *48CF9F4F01D0_48CE0A490377_impl*
 Result := true;
//#UC END# *48CF9F4F01D0_48CE0A490377_impl*
end;//TnevParaPrim.GetIsEmpty

function TnevParaPrim.GetAppliesToMaxWidth: Boolean;
//#UC START# *48CFB17F03A2_48CE0A490377_var*
//#UC END# *48CFB17F03A2_48CE0A490377_var*
begin
//#UC START# *48CFB17F03A2_48CE0A490377_impl*
 Result := false;
//#UC END# *48CFB17F03A2_48CE0A490377_impl*
end;//TnevParaPrim.GetAppliesToMaxWidth

function TnevParaPrim.GetIsHiddenPrim(aMap: TnevFormatInfoPrim;
 aHiddenStyles: TnevStandardStyles): Boolean;
//#UC START# *48CFB1F5024F_48CE0A490377_var*
//#UC END# *48CFB1F5024F_48CE0A490377_var*
begin
//#UC START# *48CFB1F5024F_48CE0A490377_impl*
 Result := true;
//#UC END# *48CFB1F5024F_48CE0A490377_impl*
end;//TnevParaPrim.GetIsHiddenPrim

function TnevParaPrim.GetDocumentContainer: InevDocumentContainer;
//#UC START# *48CFB5700290_48CE0A490377_var*
//#UC END# *48CFB5700290_48CE0A490377_var*
begin
//#UC START# *48CFB5700290_48CE0A490377_impl*
 Result := nil;
//#UC END# *48CFB5700290_48CE0A490377_impl*
end;//TnevParaPrim.GetDocumentContainer

function TnevParaPrim.GetPID: TnevParaIndex;
//#UC START# *48CFB61F01FA_48CE0A490377_var*
//#UC END# *48CFB61F01FA_48CE0A490377_var*
begin
//#UC START# *48CFB61F01FA_48CE0A490377_impl*
 Result := nev_piNull;
//#UC END# *48CFB61F01FA_48CE0A490377_impl*
end;//TnevParaPrim.GetPID

function TnevParaPrim.GetPrev: InevPara;
//#UC START# *48D0B73C0009_48CE0A490377_var*
//#UC END# *48D0B73C0009_48CE0A490377_var*
begin
//#UC START# *48D0B73C0009_48CE0A490377_impl*
 Result := Self;
//#UC END# *48D0B73C0009_48CE0A490377_impl*
end;//TnevParaPrim.GetPrev

function TnevParaPrim.GetNext: InevPara;
//#UC START# *48D0B77A02E5_48CE0A490377_var*
//#UC END# *48D0B77A02E5_48CE0A490377_var*
begin
//#UC START# *48D0B77A02E5_48CE0A490377_impl*
 Result := Self;
//#UC END# *48D0B77A02E5_48CE0A490377_impl*
end;//TnevParaPrim.GetNext

function TnevParaPrim.GetOwnerTag: Tl3Variant;
//#UC START# *48D0BC1D0099_48CE0A490377_var*
//#UC END# *48D0BC1D0099_48CE0A490377_var*
begin
//#UC START# *48D0BC1D0099_48CE0A490377_impl*
 Result := Tk2NullTagImpl.Instance;
//#UC END# *48D0BC1D0099_48CE0A490377_impl*
end;//TnevParaPrim.GetOwnerTag

function TnevParaPrim.DoDelete(anInMerge: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *48D0BFEF01CE_48CE0A490377_var*
//#UC END# *48D0BFEF01CE_48CE0A490377_var*
begin
//#UC START# *48D0BFEF01CE_48CE0A490377_impl*
 Result := false;
//#UC END# *48D0BFEF01CE_48CE0A490377_impl*
end;//TnevParaPrim.DoDelete

function TnevParaPrim.GetAnchorID: Integer;
//#UC START# *48D0EA69031F_48CE0A490377_var*
//#UC END# *48D0EA69031F_48CE0A490377_var*
begin
//#UC START# *48D0EA69031F_48CE0A490377_impl*
 Result := 0;
//#UC END# *48D0EA69031F_48CE0A490377_impl*
end;//TnevParaPrim.GetAnchorID

function TnevParaPrim.GetHolder: InevObjectHolder;
//#UC START# *48D0EC2001E5_48CE0A490377_var*
//#UC END# *48D0EC2001E5_48CE0A490377_var*
begin
//#UC START# *48D0EC2001E5_48CE0A490377_impl*
 Result := pm_GetDocumentContainer;
//#UC END# *48D0EC2001E5_48CE0A490377_impl*
end;//TnevParaPrim.GetHolder

constructor TnevParaPrim.Create(aTag: Tl3Variant);
//#UC START# *49E59CA40239_48CE0A490377_var*
//#UC END# *49E59CA40239_48CE0A490377_var*
begin
//#UC START# *49E59CA40239_48CE0A490377_impl*
 inherited Create(aTag);
//#UC END# *49E59CA40239_48CE0A490377_impl*
end;//TnevParaPrim.Create

function TnevParaPrim.Range(const aStart: InevBasePoint = nil;
 const aFinish: InevBasePoint = nil;
 aSharp: Boolean = False): InevRange;
 {* выделение на данном объекте. }
//#UC START# *47C698710396_48CE0A490377_var*
var
 l_Sel : InevRangeFactory;
//#UC END# *47C698710396_48CE0A490377_var*
begin
//#UC START# *47C698710396_48CE0A490377_impl*
 if QT(InevRangeFactory, l_Sel) then
  try
   if (aStart <> nil) OR (aFinish <> nil) OR aSharp then
   begin
    {$IfDef Nemesis}
    if (aStart <> nil) and not Self.IsSame(aStart.Obj^.AsObject.Box) then
     raise EnevMaybeBaseSwitched.Create('Наверное переключили базы. <K>: 602951122');
    if (aFinish <> nil) and not Self.IsSame(aFinish.Obj^.AsObject.Box) then
     raise EnevMaybeBaseSwitched.Create('Наверное переключили базы. <K>: 602951122');
    {$Else  Nemesis}
    Assert((aStart = nil) OR Self.IsSame(aStart.Obj^.AsObject.Box));
    Assert((aFinish = nil) OR Self.IsSame(aFinish.Obj^.AsObject.Box));
    {$EndIf Nemesis}
    l_Sel.Init(aStart, aFinish, aSharp);
   end;//aStart <> nil
   Result := l_Sel;
  finally
   l_Sel := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *47C698710396_48CE0A490377_impl*
end;//TnevParaPrim.Range

function TnevParaPrim.SubRange(const aView: InevView;
 aStart: Integer;
 aFinish: Integer): InevRange;
 {* возвращает выделение на данном объекте от aStart до aFinish. }
//#UC START# *47C698A301FE_48CE0A490377_var*
var
 l_Start  : InevPoint;
 l_Finish : InevPoint;
//#UC END# *47C698A301FE_48CE0A490377_var*
begin
//#UC START# *47C698A301FE_48CE0A490377_impl*
 l_Start := MakePoint;
 try
  l_Start.PositionW := aStart;
  if l_Start.HasInner then
   l_Start.Inner.SetAtStart(aView, true);
  l_Finish := MakePoint;
  try
   l_Finish.PositionW := aFinish;
   if l_Finish.HasInner then
    l_Finish.Inner.SetAtEnd(aView, true);
   Result := Range(l_Start, l_Finish);
  finally
   l_Finish := nil;
  end;//try..finally
 finally
  l_Start := nil;
 end;//try..finally
//#UC END# *47C698A301FE_48CE0A490377_impl*
end;//TnevParaPrim.SubRange

function TnevParaPrim.MakePoint(const aParent: InevBasePoint = nil): InevPoint;
 {* точка в объекте. }
//#UC START# *47C698BA017B_48CE0A490377_var*
//#UC END# *47C698BA017B_48CE0A490377_var*
begin
//#UC START# *47C698BA017B_48CE0A490377_impl*
 if QT(InevPoint, Result) then
  Result.Outer := aParent
 else
  Result := nil;
//#UC END# *47C698BA017B_48CE0A490377_impl*
end;//TnevParaPrim.MakePoint

function TnevParaPrim.CloneObj: InevObject;
//#UC START# *47C698CF0004_48CE0A490377_var*
//#UC END# *47C698CF0004_48CE0A490377_var*
begin
//#UC START# *47C698CF0004_48CE0A490377_impl*
 if not CloneTag.AsObject.QT(InevObject, Result) then
  Assert(false);
//#UC END# *47C698CF0004_48CE0A490377_impl*
end;//TnevParaPrim.CloneObj

function TnevParaPrim.OwnerObj: InevObjectList;
 {* родительский объект данного объекта. }
//#UC START# *47C698D801BE_48CE0A490377_var*
//#UC END# *47C698D801BE_48CE0A490377_var*
begin
//#UC START# *47C698D801BE_48CE0A490377_impl*
 Result := OwnerPara.ToList;
//#UC END# *47C698D801BE_48CE0A490377_impl*
end;//TnevParaPrim.OwnerObj

function TnevParaPrim.IsPara: Boolean;
//#UC START# *47C698EB028A_48CE0A490377_var*
//#UC END# *47C698EB028A_48CE0A490377_var*
begin
//#UC START# *47C698EB028A_48CE0A490377_impl*
 Result := true;
//#UC END# *47C698EB028A_48CE0A490377_impl*
end;//TnevParaPrim.IsPara

function TnevParaPrim.AsPara: InevPara;
 {* преобразует объект к параграфу, если это возможно, иначе - исключение. }
//#UC START# *47C698F503AE_48CE0A490377_var*
//#UC END# *47C698F503AE_48CE0A490377_var*
begin
//#UC START# *47C698F503AE_48CE0A490377_impl*
 Result := Self;
//#UC END# *47C698F503AE_48CE0A490377_impl*
end;//TnevParaPrim.AsPara

function TnevParaPrim.ToList: InevObjectList;
//#UC START# *47C699320128_48CE0A490377_var*
//#UC END# *47C699320128_48CE0A490377_var*
begin
//#UC START# *47C699320128_48CE0A490377_impl*
 Result := GetToList;
//#UC END# *47C699320128_48CE0A490377_impl*
end;//TnevParaPrim.ToList

function TnevParaPrim.MakeAnchor: InevAnchor;
//#UC START# *47C6994400E7_48CE0A490377_var*
//#UC END# *47C6994400E7_48CE0A490377_var*
begin
//#UC START# *47C6994400E7_48CE0A490377_impl*
 if QT(InevAnchor, Result) then
  Result.Outer := nil
 else
  Result := nil;
//#UC END# *47C6994400E7_48CE0A490377_impl*
end;//TnevParaPrim.MakeAnchor

function TnevParaPrim.Delete(anInMerge: Boolean;
 const anOp: InevOp = nil): Boolean;
 {* удаляет параграф aPara. }
//#UC START# *47C6996603B1_48CE0A490377_var*
//#UC END# *47C6996603B1_48CE0A490377_var*
begin
//#UC START# *47C6996603B1_48CE0A490377_impl*
 Result := DoDelete(anInMerge, anOp);
//#UC END# *47C6996603B1_48CE0A490377_impl*
end;//TnevParaPrim.Delete

function TnevParaPrim.Edit: InevObjectModify;
//#UC START# *47C6997B0362_48CE0A490377_var*
//#UC END# *47C6997B0362_48CE0A490377_var*
begin
//#UC START# *47C6997B0362_48CE0A490377_impl*
 Result := Self;
//#UC END# *47C6997B0362_48CE0A490377_impl*
end;//TnevParaPrim.Edit

function TnevParaPrim.pm_GetHolder: InevObjectHolder;
//#UC START# *47C699DF01D3_48CE0A490377get_var*
//#UC END# *47C699DF01D3_48CE0A490377get_var*
begin
//#UC START# *47C699DF01D3_48CE0A490377get_impl*
 Result := GetHolder;
//#UC END# *47C699DF01D3_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetHolder

function TnevParaPrim.pm_GetIsEmpty: Boolean;
//#UC START# *47C699EF00DB_48CE0A490377get_var*
//#UC END# *47C699EF00DB_48CE0A490377get_var*
begin
//#UC START# *47C699EF00DB_48CE0A490377get_impl*
 Result := GetIsEmpty;
//#UC END# *47C699EF00DB_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetIsEmpty

function TnevParaPrim.pm_GetAnchorID: Integer;
//#UC START# *47C69A1B02C8_48CE0A490377get_var*
//#UC END# *47C69A1B02C8_48CE0A490377get_var*
begin
//#UC START# *47C69A1B02C8_48CE0A490377get_impl*
 Result := GetAnchorID;
//#UC END# *47C69A1B02C8_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetAnchorID

function TnevParaPrim.OwnerTag: Tl3Variant;
 {* родительский тег данного параграфа. }
//#UC START# *47C6A62A0257_48CE0A490377_var*
//#UC END# *47C6A62A0257_48CE0A490377_var*
begin
//#UC START# *47C6A62A0257_48CE0A490377_impl*
 Result := GetOwnerTag;
//#UC END# *47C6A62A0257_48CE0A490377_impl*
end;//TnevParaPrim.OwnerTag

function TnevParaPrim.OwnerPara: InevParaList;
 {* родительский параграф данного параграфа. }
//#UC START# *47C6A66F0255_48CE0A490377_var*
//#UC END# *47C6A66F0255_48CE0A490377_var*
begin
//#UC START# *47C6A66F0255_48CE0A490377_impl*
 Result := GetOwnerPara;
//#UC END# *47C6A66F0255_48CE0A490377_impl*
end;//TnevParaPrim.OwnerPara

function TnevParaPrim.AsList: InevParaList;
//#UC START# *47C6A6DA0233_48CE0A490377_var*
//#UC END# *47C6A6DA0233_48CE0A490377_var*
begin
//#UC START# *47C6A6DA0233_48CE0A490377_impl*
 Result := GetAsList;
//#UC END# *47C6A6DA0233_48CE0A490377_impl*
end;//TnevParaPrim.AsList

function TnevParaPrim.IsComment: Boolean;
//#UC START# *47C6A6F20262_48CE0A490377_var*
//#UC END# *47C6A6F20262_48CE0A490377_var*
begin
//#UC START# *47C6A6F20262_48CE0A490377_impl*
 Result := (IntA[k2_tiStyle] = ev_saTxtComment) OR
           (IntA[k2_tiStyle] = ev_saContents);
//#UC END# *47C6A6F20262_48CE0A490377_impl*
end;//TnevParaPrim.IsComment

function TnevParaPrim.pm_GetDocumentContainer: InevDocumentContainer;
//#UC START# *47C6A7010307_48CE0A490377get_var*
//#UC END# *47C6A7010307_48CE0A490377get_var*
begin
//#UC START# *47C6A7010307_48CE0A490377get_impl*
 Result := GetDocumentContainer;
//#UC END# *47C6A7010307_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetDocumentContainer

function TnevParaPrim.pm_GetPrev: InevPara;
//#UC START# *47C6A725004C_48CE0A490377get_var*
//#UC END# *47C6A725004C_48CE0A490377get_var*
begin
//#UC START# *47C6A725004C_48CE0A490377get_impl*
 Result := GetPrev;
//#UC END# *47C6A725004C_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetPrev

function TnevParaPrim.pm_GetNext: InevPara;
//#UC START# *47C6A73700F5_48CE0A490377get_var*
//#UC END# *47C6A73700F5_48CE0A490377get_var*
begin
//#UC START# *47C6A73700F5_48CE0A490377get_impl*
 Result := GetNext;
//#UC END# *47C6A73700F5_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetNext

function TnevParaPrim.pm_GetMainSubList: InevSubList;
//#UC START# *47C6A7AC000D_48CE0A490377get_var*
var
 l_Container : InevDocumentContainer;
//#UC END# *47C6A7AC000D_48CE0A490377get_var*
begin
//#UC START# *47C6A7AC000D_48CE0A490377get_impl*
 l_Container := pm_GetDocumentContainer;
 if (l_Container = nil) then
  Result := nil
 else
  Result := l_Container.SubList; 
//#UC END# *47C6A7AC000D_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetMainSubList

function TnevParaPrim.pm_GetText: TnevStr;
//#UC START# *47C6AB1D02C0_48CE0A490377get_var*
//#UC END# *47C6AB1D02C0_48CE0A490377get_var*
begin
//#UC START# *47C6AB1D02C0_48CE0A490377get_impl*
 Result := GetText;
//#UC END# *47C6AB1D02C0_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetText

function TnevParaPrim.pm_GetTabStops: InevTabStops;
//#UC START# *47C6AB2A0082_48CE0A490377get_var*
//#UC END# *47C6AB2A0082_48CE0A490377get_var*
begin
//#UC START# *47C6AB2A0082_48CE0A490377get_impl*
 Result := TevTabStops.Make(Self);
//#UC END# *47C6AB2A0082_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetTabStops

function TnevParaPrim.pm_GetBackColor: TnevColor;
//#UC START# *48E0CBBD0016_48CE0A490377get_var*
//#UC END# *48E0CBBD0016_48CE0A490377get_var*
begin
//#UC START# *48E0CBBD0016_48CE0A490377get_impl*
 Result := DoGetBackColor;
//#UC END# *48E0CBBD0016_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetBackColor

function TnevParaPrim.AppliesToMaxWidth: Boolean;
//#UC START# *49D0BB6B0066_48CE0A490377_var*
//#UC END# *49D0BB6B0066_48CE0A490377_var*
begin
//#UC START# *49D0BB6B0066_48CE0A490377_impl*
 Result := GetAppliesToMaxWidth;
//#UC END# *49D0BB6B0066_48CE0A490377_impl*
end;//TnevParaPrim.AppliesToMaxWidth

function TnevParaPrim.IsHiddenPrim(aMap: TnevFormatInfoPrim;
 aHiddenStyles: TnevStandardStyles): Boolean;
//#UC START# *49D0BBEE0383_48CE0A490377_var*
//#UC END# *49D0BBEE0383_48CE0A490377_var*
begin
//#UC START# *49D0BBEE0383_48CE0A490377_impl*
 Result := GetIsHiddenPrim(aMap, aHiddenStyles);
//#UC END# *49D0BBEE0383_48CE0A490377_impl*
end;//TnevParaPrim.IsHiddenPrim

function TnevParaPrim.pm_GetOffsetX: Integer;
//#UC START# *49D0C441019B_48CE0A490377get_var*
//#UC END# *49D0C441019B_48CE0A490377get_var*
begin
//#UC START# *49D0C441019B_48CE0A490377get_impl*
 Result := GetOffsetX;
//#UC END# *49D0C441019B_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetOffsetX

procedure TnevParaPrim.Invalidate(aParts: TnevShapeParts);
 {* Сообщает о необходимости перерисовать форму, если она отображается в каком-нибудь View. }
//#UC START# *49D0CBFC02D9_48CE0A490377_var*
var
 l_Container : InevDocumentContainer;
//#UC END# *49D0CBFC02D9_48CE0A490377_var*
begin
//#UC START# *49D0CBFC02D9_48CE0A490377_impl*
 l_Container := pm_GetDocumentContainer;
 if (l_Container <> nil) then
  l_Container.InvalidateShape(Self, aParts);
//#UC END# *49D0CBFC02D9_48CE0A490377_impl*
end;//TnevParaPrim.Invalidate

function TnevParaPrim.IsList: Boolean;
//#UC START# *49D0E3CE00F5_48CE0A490377_var*
//#UC END# *49D0E3CE00F5_48CE0A490377_var*
begin
//#UC START# *49D0E3CE00F5_48CE0A490377_impl*
 Result := GetIsList;
//#UC END# *49D0E3CE00F5_48CE0A490377_impl*
end;//TnevParaPrim.IsList

function TnevParaPrim.pm_GetPID: TnevParaIndex;
//#UC START# *49D0E4E7009C_48CE0A490377get_var*
//#UC END# *49D0E4E7009C_48CE0A490377get_var*
begin
//#UC START# *49D0E4E7009C_48CE0A490377get_impl*
 Result := GetPID;
//#UC END# *49D0E4E7009C_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetPID

function TnevParaPrim.pm_GetIsVertical: Boolean;
//#UC START# *49D0E75F00E4_48CE0A490377get_var*
//#UC END# *49D0E75F00E4_48CE0A490377get_var*
begin
//#UC START# *49D0E75F00E4_48CE0A490377get_impl*
 Result := GetIsVertical;
//#UC END# *49D0E75F00E4_48CE0A490377get_impl*
end;//TnevParaPrim.pm_GetIsVertical

function TnevParaPrim.Get_OverlapType: TOverlapType;
//#UC START# *49D104BB01AF_48CE0A490377get_var*
//#UC END# *49D104BB01AF_48CE0A490377get_var*
begin
//#UC START# *49D104BB01AF_48CE0A490377get_impl*
  Result := GetOverlapType;
//#UC END# *49D104BB01AF_48CE0A490377get_impl*
end;//TnevParaPrim.Get_OverlapType

function TnevParaPrim.NeedIncludeHeight(aCheckType: Boolean = True): Boolean;
 {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
//#UC START# *49D105D10274_48CE0A490377_var*
//#UC END# *49D105D10274_48CE0A490377_var*
begin
//#UC START# *49D105D10274_48CE0A490377_impl*
 Result := GetNeedIncludeHeight(aCheckType);
//#UC END# *49D105D10274_48CE0A490377_impl*
end;//TnevParaPrim.NeedIncludeHeight

function TnevParaPrim.IsLegalComment: Boolean;
 {* Юридический комментарий? }
//#UC START# *4B7BDCA502F7_48CE0A490377_var*
//#UC END# *4B7BDCA502F7_48CE0A490377_var*
begin
//#UC START# *4B7BDCA502F7_48CE0A490377_impl*
 Result := IsComment OR
           (IntA[k2_tiStyle] = ev_saVersionInfo);
//#UC END# *4B7BDCA502F7_48CE0A490377_impl*
end;//TnevParaPrim.IsLegalComment

function TnevParaPrim.IsCollapsed(const aView: InevView): Boolean;
//#UC START# *4D5A42F502E3_48CE0A490377_var*
//#UC END# *4D5A42F502E3_48CE0A490377_var*
begin
//#UC START# *4D5A42F502E3_48CE0A490377_impl*
 if (aView = nil) then
  Result := BoolA[k2_tiCollapsed]
 else
  Result := aView.IsObjectCollapsed[Self];
//#UC END# *4D5A42F502E3_48CE0A490377_impl*
end;//TnevParaPrim.IsCollapsed

function TnevParaPrim.BaseLine4Anchor: InevBaseLine4Anchor;
//#UC START# *4DDBD42C0191_48CE0A490377_var*
//#UC END# *4DDBD42C0191_48CE0A490377_var*
begin
//#UC START# *4DDBD42C0191_48CE0A490377_impl*
 if QT(InevBaseLine4Anchor, Result) then
  Result.Outer := nil
 else
  Result := nil;
//#UC END# *4DDBD42C0191_48CE0A490377_impl*
end;//TnevParaPrim.BaseLine4Anchor

function TnevParaPrim.BaseLine4Print: InevBaseLine4Print;
//#UC START# *4DDBD45E0100_48CE0A490377_var*
//#UC END# *4DDBD45E0100_48CE0A490377_var*
begin
//#UC START# *4DDBD45E0100_48CE0A490377_impl*
 if QT(InevBaseLine4Print, Result) then
  Result.Outer := nil
 else
  Result := nil;
//#UC END# *4DDBD45E0100_48CE0A490377_impl*
end;//TnevParaPrim.BaseLine4Print

function TnevParaPrim.IsDecorationElement: Boolean;
//#UC START# *4E1AFECA025B_48CE0A490377_var*
var
 l_TT : Tl3Type;
//#UC END# *4E1AFECA025B_48CE0A490377_var*
begin
//#UC START# *4E1AFECA025B_48CE0A490377_impl*
 l_TT := Box.Owner.TagType;
 Result := l_TT.IsKindOf(k2_typTextStyle_Header) OR
           l_TT.IsKindOf(k2_typTextStyle_Footer);
//#UC END# *4E1AFECA025B_48CE0A490377_impl*
end;//TnevParaPrim.IsDecorationElement

function TnevParaPrim.DecorObj(aType: TnevDecorType): Tl3Variant;
//#UC START# *4E243EF60356_48CE0A490377_var*
const
 cMap : array [TnevDecorType] of Integer = (k2Tags.k2_tiHeader, k2Tags.k2_tiFooter);
//#UC END# *4E243EF60356_48CE0A490377_var*
begin
//#UC START# *4E243EF60356_48CE0A490377_impl*
 Result := Self.rAtomEx([k2_tiStyle,
                         cMap[aType],
                         k2_tiChildren, k2_tiByIndex, 0]);
//#UC END# *4E243EF60356_48CE0A490377_impl*
end;//TnevParaPrim.DecorObj

function TnevParaPrim.Get_HolderPrim: InevObjectHolderPrim;
//#UC START# *4E5E1CB9007D_48CE0A490377get_var*
//#UC END# *4E5E1CB9007D_48CE0A490377get_var*
begin
//#UC START# *4E5E1CB9007D_48CE0A490377get_impl*
 Result := GetHolder;
//#UC END# *4E5E1CB9007D_48CE0A490377get_impl*
end;//TnevParaPrim.Get_HolderPrim

function TnevParaPrim.Get_TreatCollapsedAsHidden: Boolean;
//#UC START# *4E6F7B7902C4_48CE0A490377get_var*
//#UC END# *4E6F7B7902C4_48CE0A490377get_var*
begin
//#UC START# *4E6F7B7902C4_48CE0A490377get_impl*
 Result := TreatCollapsedAsHidden;
//#UC END# *4E6F7B7902C4_48CE0A490377get_impl*
end;//TnevParaPrim.Get_TreatCollapsedAsHidden
{$IfEnd} // Defined(k2ForEditor)

end.
