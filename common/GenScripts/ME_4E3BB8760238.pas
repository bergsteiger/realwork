unit evAlignBySeparatorUtils;
 {* Утилиты работы с выравниванием по точке. }

// Модуль: "w:\common\components\gui\Garant\Everest\evAlignBySeparatorUtils.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , l3Interfaces
 , l3Variant
 , nevTools
 , nevBase
 , l3Types
 , evdTypes
 , l3InternalInterfaces
 , k2Interfaces
;

function evGetDecimalTabIndentTag(aPara: Tl3Variant;
 out aTag: Tl3Variant): Boolean;
function evHasDecimalTabIndent(aPara: Tl3Variant): Boolean;
function evDeleteIndentMarker(const aPara: InevPara;
 const anOpPack: InevOp): Boolean;
function evNewIndentMarker(const aView: InevView;
 aValue: Integer;
 const aPara: InevPara;
 const anOpPack: InevOp): Boolean;
function evCalcDecimalTabIndent(const aPara: InevTextPara;
 const aText: Tl3PCharLen;
 aJustification: TevIndentType;
 aLineCount: Integer;
 const aCanvas: Il3InfoCanvas;
 const aGen: Ik2TagGenerator = nil): Integer;
function evGetSeparatorPos(const aTextPara: InevPara;
 aMap: TnevFormatInfoPrim): Integer;
function evCanInsertSeparator(const aTextPara: InevPara;
 aMap: TnevFormatInfoPrim): Boolean;
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
 , k2Base
 , l3Units
 , l3Base
 , l3String
 , SysUtils
 , l3Chars
 , evTextParaTools
;

var g_AllowChars: TCharSet;

const
 evAllowJustify4DecimalIndent = [ev_itLeft, ev_itWidth];

function evGetDecimalTabIndentTag(aPara: Tl3Variant;
 out aTag: Tl3Variant): Boolean;
//#UC START# *4E3A50710388_4E3BB8760238_var*
var
 l_TabStops : Tl3Variant;
//#UC END# *4E3A50710388_4E3BB8760238_var*
begin
//#UC START# *4E3A50710388_4E3BB8760238_impl*
 Result := False;
 aTag := nil;
 l_TabStops := aPara.Attr[k2_tiTabStops];
 if l_TabStops.IsValid and (l_TabStops.ChildrenCount > 0) then
 begin
  aTag := l_TabStops.Child[0];
  Result := aTag.IsValid and (Tl3TabStopStyle(aTag.IntA[k2_tiType]) = l3_tssDecimal);
 end; // if l_TabStops.IsValid and (l_TabStops.ChildrenCount > 0) then
//#UC END# *4E3A50710388_4E3BB8760238_impl*
end;//evGetDecimalTabIndentTag

function evHasDecimalTabIndent(aPara: Tl3Variant): Boolean;
//#UC START# *4E3BB9360103_4E3BB8760238_var*
var
 l_TabStops : Tl3Variant;
 l_TabStop  : Tl3Variant;
//#UC END# *4E3BB9360103_4E3BB8760238_var*
begin
//#UC START# *4E3BB9360103_4E3BB8760238_impl*
 Result := False;
 l_TabStops := aPara.Attr[k2_tiTabStops];
 if l_TabStops.IsValid and (l_TabStops.ChildrenCount > 0) then
 begin
  l_TabStop := l_TabStops.Child[0];
  Result := l_TabStop.IsValid and (Tl3TabStopStyle(l_TabStop.IntA[k2_tiType]) = l3_tssDecimal);
 end;
//#UC END# *4E3BB9360103_4E3BB8760238_impl*
end;//evHasDecimalTabIndent

function evDeleteIndentMarker(const aPara: InevPara;
 const anOpPack: InevOp): Boolean;
//#UC START# *4E3BB95C01B5_4E3BB8760238_var*
//#UC END# *4E3BB95C01B5_4E3BB8760238_var*
begin
//#UC START# *4E3BB95C01B5_4E3BB8760238_impl*
 Result := True;
 aPara.AsObject.AttrW[k2_tiTabStops, anOpPack] := nil;
//#UC END# *4E3BB95C01B5_4E3BB8760238_impl*
end;//evDeleteIndentMarker

function evNewIndentMarker(const aView: InevView;
 aValue: Integer;
 const aPara: InevPara;
 const anOpPack: InevOp): Boolean;
//#UC START# *4E3BB98B003F_4E3BB8760238_var*
var
 l_Map      : TnevFormatInfoPrim;
 l_TabStops : Tl3Variant;
 l_TabStop  : Tl3Variant;
//#UC END# *4E3BB98B003F_4E3BB8760238_var*
begin
//#UC START# *4E3BB98B003F_4E3BB8760238_impl*
 if (TevIndentType(aPara.AsObject.IntA[k2_tiJustification]) in evAllowJustify4DecimalIndent) then
 begin
  Result := True;
  l_TabStops := aPara.AsObject.Attr[k2_tiTabStops];
  if not l_TabStops.IsValid or (l_TabStops.ChildrenCount = 0) then
  begin
   l_Map := aView.FormatInfoByPara(aPara);
   if evCanInsertSeparator(aPara, l_Map) then
   begin
    if not l_TabStops.IsValid then
    begin
     l_TabStops := Tk2Type(aPara.AsObject.TagType).Prop[k2_tiTabStops].MakeTag.AsObject;
     aPara.AsObject.AttrW[k2_tiTabStops, anOpPack] := l_TabStops;
    end;//if not l_TabStops.IsValid then
    l_TabStop := Tk2Type(l_TabStops.TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
    try
     with l_TabStop do
     begin
      IntW[k2_tiType, anOpPack] := Ord(l3_tssDecimal);
      IntW[k2_tiStart, anOpPack] := l_Map.ParentToClient(l3PointX(aValue)).X;
     end;//with l_TabStop do
     l_TabStops.AddChild(l_TabStop, anOpPack);
    finally
     l_TabStop := nil;
    end;
   end; // if evCanInsertSeparator(aPara, l_Map) then
  end;//if not l_TabStops.IsValid or (l_TabStops.ChildrenCount = 0) then
 end//if aStyle = ev_pmsTabIndent then
 else
  Result := False;
//#UC END# *4E3BB98B003F_4E3BB8760238_impl*
end;//evNewIndentMarker

function evCalcDecimalTabIndent(const aPara: InevTextPara;
 const aText: Tl3PCharLen;
 aJustification: TevIndentType;
 aLineCount: Integer;
 const aCanvas: Il3InfoCanvas;
 const aGen: Ik2TagGenerator = nil): Integer;
//#UC START# *4E3BB9C7005A_4E3BB8760238_var*
var
 l_TabStop   : Tl3TabStop;
 l_ParaS1    : Il3CString;
 l_DecSepPos : Integer;
//#UC END# *4E3BB9C7005A_4E3BB8760238_var*
begin
//#UC START# *4E3BB9C7005A_4E3BB8760238_impl*
 Result := 0;
 if (aJustification in evAllowJustify4DecimalIndent) AND
    (aPara.TabStops <> nil) then
 begin
  l_TabStop := aPara.TabStops.Next;
  if (l_TabStop.rStyle = l3_tssDecimal) then
  begin
   l_ParaS1 := l3CStr(aText);
   l_DecSepPos := l3Pos(l_ParaS1, {$IfDef XE}FormatSettings.{$EndIf}DecimalSeparator);
   if l_DecSepPos >= 0 then
    l_ParaS1 := l3Copy(l_ParaS1, 0, l_DecSepPos);
    if aCanvas <> nil then // Это ветка для отрисовки...
    begin
     Result := l_TabStop.rPosition;
     if l_ParaS1 <> nil then
      Dec(Result, aCanvas.TextExtent(l_ParaS1.AsWStr).X);
    end; //if aCanvas <> nil then
    if (aGen <> nil) then // ... а эта - для выливки.
    begin
     Result := aGen.Pixel2Char(l_TabStop.rPosition);
     if l_ParaS1 <> nil then
      Dec(Result, l3Len(l_ParaS1));
    end; // if (aGen <> nil) then
    if Result < 0 then
     Result := 0;
  end; // if (l_TabStop.rStyle = l3_tssDecimal) then
 end; // if (aPara.TabStops <> nil) and (aJustification in evAllowJustify4DecimalIndent) then
//#UC END# *4E3BB9C7005A_4E3BB8760238_impl*
end;//evCalcDecimalTabIndent

function evGetSeparatorPos(const aTextPara: InevPara;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *508FC8CA018C_4E3BB8760238_var*
//#UC END# *508FC8CA018C_4E3BB8760238_var*
begin
//#UC START# *508FC8CA018C_4E3BB8760238_impl*
 Result := 0;
 if EvCanInsertSeparator(aTextPara, aMap) then
  Result := ev_lpCharIndex(AnsiChar({$IfDef XE}FormatSettings.{$EndIf}DecimalSeparator), aTextPara.Text) + 1;
//#UC END# *508FC8CA018C_4E3BB8760238_impl*
end;//evGetSeparatorPos

function evCanInsertSeparator(const aTextPara: InevPara;
 aMap: TnevFormatInfoPrim): Boolean;
//#UC START# *5090CDD80266_4E3BB8760238_var*
var
 l_Text: Tl3PCharLen;
//#UC END# *5090CDD80266_4E3BB8760238_var*
begin
//#UC START# *5090CDD80266_4E3BB8760238_impl*
 l_Text := aTextPara.Text;
 Result := (evTextParaLineCount(aMap) = 1) and (l3Trim(l_Text, g_AllowChars).SLen = 0) and (l_Text.SLen > 0);
//#UC END# *5090CDD80266_4E3BB8760238_impl*
end;//evCanInsertSeparator

initialization
//#UC START# *5090C942039A*
 g_AllowChars := cc_Digits
 {$IfDef XE}
 + ['.'];
 {$Else}
 + [DecimalSeparator]
 {$EndIf};
//#UC END# *5090C942039A*
{$IfEnd} // Defined(k2ForEditor)

end.
