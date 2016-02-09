unit nevTextPara;
 {* Реализация инструмента InevTextPara }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTextPara.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevLeafPara
 , nevTools
 , l3Variant
 , nevBase
 , l3CacheableBase
 , l3Interfaces
;

type
 TnevTextPara = class(TnevLeafPara, InevTextPara)
  {* Реализация инструмента InevTextPara }
  protected
   function SegmentIsHidden(aSegment: Tl3Variant;
    aHiddenStyles: TnevStandardStyles): Boolean;
   function pm_GetFormatting(aPosition: Integer): InevDataFormatting;
   function GetIsEmpty: Boolean; override;
   function GetAppliesToMaxWidth: Boolean; override;
   function GetIsHidden(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean; override;
   function GetText: TnevStr; override;
  public
   class function Make(aTag: Tl3Variant): InevTextPara; reintroduce;
 end;//TnevTextPara
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , evTabStops
 , l3String
 , k2Base
 , evSegLst
 , nevFontPrim
 , l3Types
 , nevSegmentObject
;

type
 TnevTextParaFormatting = class(Tl3CacheableBase, InevDataFormatting)
  private
   f_Position: Integer;
   f_Para: InevTextPara;
  protected
   function GetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger = nil): InevFontPrim;
   function GetStyle(Stop: PInteger = nil): Tl3Variant;
   function Modify(const aView: InevView): InevDataFormattingModify;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aPara: InevTextPara;
    aPosition: Integer); reintroduce;
   class function Make(const aPara: InevTextPara;
    aPosition: Integer): InevDataFormatting; reintroduce;
 end;//TnevTextParaFormatting

constructor TnevTextParaFormatting.Create(const aPara: InevTextPara;
 aPosition: Integer);
//#UC START# *48D10D19009B_48D103950150_var*
//#UC END# *48D10D19009B_48D103950150_var*
begin
//#UC START# *48D10D19009B_48D103950150_impl*
 inherited Create;
 f_Para := aPara;
 f_Position := aPosition;
//#UC END# *48D10D19009B_48D103950150_impl*
end;//TnevTextParaFormatting.Create

class function TnevTextParaFormatting.Make(const aPara: InevTextPara;
 aPosition: Integer): InevDataFormatting;
var
 l_Inst : TnevTextParaFormatting;
begin
 l_Inst := Create(aPara, aPosition);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevTextParaFormatting.Make

function TnevTextParaFormatting.GetFont(const aView: InevView;
 aMap: TnevFormatInfoPrim;
 Stop: PInteger = nil): InevFontPrim;
//#UC START# *47C68E0C02E2_48D103950150_var*
var
 l_Segment : Tl3Variant;
//#UC END# *47C68E0C02E2_48D103950150_var*
begin
//#UC START# *47C68E0C02E2_48D103950150_impl*
 l_Segment := aMap.ViewSegments.rAtomEx([k2_tiChildren, l3_siNative, f_Position]);
 if l_Segment.IsValid then
  Result := TnevFontPrim.Make(aMap.InfoForChild(TnevSegmentObject.Make(l_Segment)).GetObjFont(false).Font)
 else
  Result := TnevFontPrim.Make(aMap.GetObjFont(false).Font);
//#UC END# *47C68E0C02E2_48D103950150_impl*
end;//TnevTextParaFormatting.GetFont

function TnevTextParaFormatting.GetStyle(Stop: PInteger = nil): Tl3Variant;
//#UC START# *47C68E3402A5_48D103950150_var*
//#UC END# *47C68E3402A5_48D103950150_var*
begin
//#UC START# *47C68E3402A5_48D103950150_impl*
 Result := f_Para.AsObject.Attr[k2_tiStyle];
//#UC END# *47C68E3402A5_48D103950150_impl*
end;//TnevTextParaFormatting.GetStyle

function TnevTextParaFormatting.Modify(const aView: InevView): InevDataFormattingModify;
//#UC START# *47C68E3D0279_48D103950150_var*
//#UC END# *47C68E3D0279_48D103950150_var*
begin
//#UC START# *47C68E3D0279_48D103950150_impl*
 Result := nil;
//#UC END# *47C68E3D0279_48D103950150_impl*
end;//TnevTextParaFormatting.Modify

procedure TnevTextParaFormatting.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48D103950150_var*
//#UC END# *479731C50290_48D103950150_var*
begin
//#UC START# *479731C50290_48D103950150_impl*
 f_Para := nil;
 inherited; 
//#UC END# *479731C50290_48D103950150_impl*
end;//TnevTextParaFormatting.Cleanup

function TnevTextPara.SegmentIsHidden(aSegment: Tl3Variant;
 aHiddenStyles: TnevStandardStyles): Boolean;
var l_Layer: Tl3Tag;
var l_Child: Tl3Tag;
//#UC START# *49E59D7F009F_48D100920185_var*
//#UC END# *49E59D7F009F_48D100920185_var*
begin
//#UC START# *49E59D7F009F_48D100920185_impl*
 Result := false;
 if (aHiddenStyles <> []) then
 begin
  if (-aSegment.IntA[k2_tiStyle] in aHiddenStyles) then
  begin
   Result := true;
  end//-aSegment.IntA[k2_tiStyle]..
  else
  begin
   // - заплатка для отключения ссылок в комментариях юристов
   l_Layer := evSegments_GetLayer(TagInst.Attr[k2_tiSegments], ev_slView);
   if l_Layer.IsValid AND (l_Layer.ChildrenCount >= 1) then
   begin
    l_Child := l_Layer.Child[0];
    if (l_Child.IntA[k2_tiStart] <= 1) AND
       TagIsHidden(l_Child, aHiddenStyles) then
    begin
     Result := true;
    end;//IntA[k2_tiStart] <= 1..
   end;//l_Layer.IsValid
  end;//aSegment.IntA[k2_tiStyle]..
 end;//aHiddenStyles <> []
//#UC END# *49E59D7F009F_48D100920185_impl*
end;//TnevTextPara.SegmentIsHidden

class function TnevTextPara.Make(aTag: Tl3Variant): InevTextPara;
var
 l_Inst : TnevTextPara;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevTextPara.Make

function TnevTextPara.pm_GetFormatting(aPosition: Integer): InevDataFormatting;
//#UC START# *47C6AB76032D_48D100920185get_var*
//#UC END# *47C6AB76032D_48D100920185get_var*
begin
//#UC START# *47C6AB76032D_48D100920185get_impl*
 Result := TnevTextParaFormatting.Make(Self, aPosition);
//#UC END# *47C6AB76032D_48D100920185get_impl*
end;//TnevTextPara.pm_GetFormatting

function TnevTextPara.GetIsEmpty: Boolean;
//#UC START# *48CF9F4F01D0_48D100920185_var*
//#UC END# *48CF9F4F01D0_48D100920185_var*
begin
//#UC START# *48CF9F4F01D0_48D100920185_impl*
 Result := l3IsNil(pm_GetText);
//#UC END# *48CF9F4F01D0_48D100920185_impl*
end;//TnevTextPara.GetIsEmpty

function TnevTextPara.GetAppliesToMaxWidth: Boolean;
//#UC START# *48CFB17F03A2_48D100920185_var*
//#UC END# *48CFB17F03A2_48D100920185_var*
begin
//#UC START# *48CFB17F03A2_48D100920185_impl*
 Result := (GetRedirect.IntA[k2_tiJustification] = Ord(ev_itPreformatted));
//#UC END# *48CFB17F03A2_48D100920185_impl*
end;//TnevTextPara.GetAppliesToMaxWidth

function TnevTextPara.GetIsHidden(aMap: TnevFormatInfoPrim;
 aHiddenStyles: TnevStandardStyles): Boolean;
//#UC START# *48D0F8DF01AF_48D100920185_var*
var
 l_Hidden : Boolean absolute Result;

 function CheckSegment(aSegment: Tl3Variant; Index: Integer): Boolean;
 begin//CheckSegment
  Result := false;
  l_Hidden := (Pred(aSegment.IntA[k2_tiStart]) <= 0) AND
              SegmentIsHidden(aSegment, aHiddenStyles);
 end;//CheckSegment

//#UC END# *48D0F8DF01AF_48D100920185_var*
begin
//#UC START# *48D0F8DF01AF_48D100920185_impl*
 if (aHiddenStyles <> []) then
 begin
  Result := inherited GetIsHidden(aMap, aHiddenStyles);
  if not Result then
  begin
   if (aMap <> nil) then
    with aMap.ViewSegments do
     if IsValid then
      IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckSegment));
  end;//not Result
 end//aHiddenStyles <> []
 else
  Result := false;
//#UC END# *48D0F8DF01AF_48D100920185_impl*
end;//TnevTextPara.GetIsHidden

function TnevTextPara.GetText: TnevStr;
//#UC START# *4D7255870102_48D100920185_var*
//#UC END# *4D7255870102_48D100920185_var*
begin
//#UC START# *4D7255870102_48D100920185_impl*
 Result := TagInst.PCharLenA[k2_tiText];
//#UC END# *4D7255870102_48D100920185_impl*
end;//TnevTextPara.GetText
{$IfEnd} // Defined(k2ForEditor)

end.
