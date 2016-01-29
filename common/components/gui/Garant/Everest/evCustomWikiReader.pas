unit evCustomWikiReader;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomWikiReader.pas"
// Начат: 28.02.2011 17:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Readers::TevCustomWikiReader
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCustomTxtReader,
  l3ProtoDataContainer,
  l3ProtoIntegerList,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes,
  l3Base
  ;

type
 TevFormatInfo = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rStart : Integer;
   rName : AnsiString;
   rValue : AnsiString;
 end;//TevFormatInfo

 _ItemType_ = TevFormatInfo;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TevFormatInfoList = class(_l3RecordListPrim_)
 end;//TevFormatInfoList

 TevCustomWikiReader = class(TevCustomTxtReader)
 private
 // private fields
   f_ListLevel : Integer;
   f_SmallLevel : Integer;
   f_FontSizes : Tl3ProtoIntegerList;
   f_CloakLevel : Integer;
   f_IndentLevel : Integer;
   f_Justification : Tl3ProtoIntegerList;
   f_DefaultStyle : Integer;
    {* Поле для свойства DefaultStyle}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure DoText(aText: Tl3String); override;
   function NeedOpenDefaultChild(aText: Tl3String): Boolean; override;
 public
 // public properties
   property DefaultStyle: Integer
     read f_DefaultStyle
     write f_DefaultStyle;
     {* Стиль текста по-умолчанию }
 end;//TevCustomWikiReader

implementation

uses
  l3MinMax,
  RTLConsts,
  SysUtils,
  l3String,
  k2Tags,
  TextSegment_Const,
  l3Const,
  evdStyles
  {$If defined(k2ForEditor)}
  ,
  evSegLst
  {$IfEnd} //k2ForEditor
  ,
  ControlsBlock_Const,
  evStyleTableTools,
  afwFont,
  StrUtils,
  Cloak_Const,
  Graphics,
  HyperLink_Const,
  evdTypes,
  k2Base,
  TypInfo,
  k2Attributes
  ;

// start class TevFormatInfoList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4D6BD8CF022A_var*
//#UC END# *47B07CF403D0_4D6BD8CF022A_var*
begin
//#UC START# *47B07CF403D0_4D6BD8CF022A_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4D6BD8CF022A_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D6BD8CF022A_var*
//#UC END# *47B2C42A0163_4D6BD8CF022A_var*
begin
//#UC START# *47B2C42A0163_4D6BD8CF022A_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D6BD8CF022A_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4D6BD8CF022A_var*
//#UC END# *47B99D4503A2_4D6BD8CF022A_var*
begin
//#UC START# *47B99D4503A2_4D6BD8CF022A_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4D6BD8CF022A_impl*
end;//CompareExistingItems

type _Instance_R_ = TevFormatInfoList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

// start class TevCustomWikiReader

procedure TevCustomWikiReader.Cleanup;
//#UC START# *479731C50290_4D6BB1E0012D_var*
//#UC END# *479731C50290_4D6BB1E0012D_var*
begin
//#UC START# *479731C50290_4D6BB1E0012D_impl*
 FreeAndNil(f_FontSizes);
 FreeAndNil(f_Justification);
 inherited;
//#UC END# *479731C50290_4D6BB1E0012D_impl*
end;//TevCustomWikiReader.Cleanup

procedure TevCustomWikiReader.InitFields;
//#UC START# *47A042E100E2_4D6BB1E0012D_var*
//#UC END# *47A042E100E2_4D6BB1E0012D_var*
begin
//#UC START# *47A042E100E2_4D6BB1E0012D_impl*
 inherited;
 PlainText := true;
 DefaultStyle := ev_saEmpty;
//#UC END# *47A042E100E2_4D6BB1E0012D_impl*
end;//TevCustomWikiReader.InitFields

procedure TevCustomWikiReader.DoText(aText: Tl3String);
//#UC START# *4D6BB62C01C8_4D6BB1E0012D_var*
var
 l_Text   : Tl3String;
 l_S      : Tl3WString;
 l_Poses  : TevFormatInfoList;

 function DoTag(const aStr: Tl3PCharLen; IsLast: Boolean): Boolean;

  procedure TryHyperlinks;

   function DoHyperlink(const aHLStr: Tl3PCharLen; IsLast: Boolean): Boolean;

    procedure DoAppend1(const aStr: Tl3PCharLen);
    var
     l_S : Tl3PCharLen;
    begin//DoAppend1
     if l3Ends(l3PCharLen('\', -1, aStr.SCodePage), aStr) then
     begin
      l_S := aStr;
      Dec(l_S.SLen);
      l_Text.Append(l_S);
     end//l3Ends()
     else
      l_Text.Append(aStr);
    end;//DoAppend1

    procedure DoAppend(const aStr: Tl3PCharLen);
    var
     l_S : Tl3PCharLen;
    begin//DoAppend
     if l3Ends(l3PCharLen('\\', -1, aStr.SCodePage), aStr) then
     begin
      l_S := aStr;
      Dec(l_S.SLen);
      l_Text.Append(l_S);
     end//l3Ends()
     else
      l_Text.Append(aStr);
    end;//DoAppend

    function SkipSlash: Boolean;
    var
     l_HStr : Tl3PCharLen;
    begin//SkipSlash
     Result := false;
     if //(aHLStr.S - 2 <> aStr.S) AND
        (aHLStr.S - 1 <> aStr.S) then
     begin
      if (PAnsiChar(aHLStr.S - 2)^ = '\') then
      begin
       if (aHLStr.S - 2 = aStr.S) OR
          (PAnsiChar(aHLStr.S - 3)^ <> '\') then
       begin
        l_HStr := aHLStr;
        Dec(l_HStr.S);
        Inc(l_HStr.SLen);
        l_Text.Append(l_HStr);
        Result := true;
        Exit;
       end;//aHLStr.S - 2 = aStr.S
      end;//PAnsiChar(aHLStr.S - 2)^ = '\'
     end;//aStr.S - 2 <> aHLStr.S
    end;//SkipSlash

   const
    cClose = ']';
   var
    l_LinkStr : Tl3PCharLen;
    l_Rest    : Tl3PCharLen;
    l_Start   : Integer;
    l_SA      : Tl3CStringArray;
    l_SA1     : Tl3CStringArray;
    l_Val     : Integer;
    l_IsScript : Boolean;
   begin//DoHyperlink
    Result := true;
    if (aStr.S = aHLStr.S) then
    begin
    // - начало строки
     //if not SkipSlash then
     if (aHLStr.SLen < aStr.SLen) then
      DoAppend1(aHLStr)
     else
      DoAppend(aHLStr);
    end//Str.S = aHLStr.S
    else
    begin
     if SkipSlash then
      Exit;
     l_LinkStr := aHLStr;
     l_Rest := l3FindChar(cClose, l_LinkStr);
     l_Start := l_Text.Len + 1;
     Assert(not l3IsNil(l_LinkStr));
     if (l_LinkStr.S[l_LinkStr.SLen - 1] = cClose) then
      Dec(l_LinkStr.SLen);
     l_SA := l3Split(l3CStr(l_LinkStr), '|');
     l_Text.Append(l3PCharLen(l_SA[0]));
     StartTag(k2_tiSegments);
     try
      StartChild(k2_typHyperlink);
      try
       AddIntegerAtom(k2_tiStart, l_Start);
       AddIntegerAtom(k2_tiFinish, l_Text.Len);
       l_IsScript := false;
       if (Length(l_SA) > 1) then
       // - не надо падать на неверных данных
       begin
        l_IsScript := l3Starts('script:', l3PCharLen(l_SA[1]));
        if l_IsScript OR
           l3Starts('http:', l3PCharLen(l_SA[1])) OR
           l3Starts('mailto:', l3PCharLen(l_SA[1])) then
        begin
         AddStringAtom(k2_tiURL, l3PCharLen(l_SA[1]));
        end//l3Starts('script:', l3PCharLen(l_SA[1]))
        else
         l_SA1 := l3Split(l_SA[1], '.');
       end;//(Length(l_SA) > 1)
       if (Length(l_SA) > 2) OR (Length(l_SA1) > 0) then
       begin
        StartDefaultChild;
        try
         if (Length(l_SA1) > 0) then
         begin
          if TryStrToInt(l3Str(l_SA1[0]), l_Val) then
           AddIntegerAtom(k2_tiDocID, l_Val {$IfDef Nemesis} + 100000{$EndIf});
          if (Length(l_SA1) > 1) then
           if TryStrToInt(l3Str(l_SA1[1]), l_Val) then
            AddIntegerAtom(k2_tiSubID, l_Val);
          if (Length(l_SA1) > 2) then
          begin
           if TryStrToInt(l3Str(l_SA1[2]), l_Val) then
            AddIntegerAtom(k2_tiType, l_Val)
           else
            AddIntegerAtom(k2_tiType, CI_SCRIPT);
          end//Length(l_SA1) > 2
          else
           AddIntegerAtom(k2_tiType, CI_SCRIPT);
         end;//Length(l_SA1) > 0
         if (Length(l_SA) > 2) then
          AddStringAtom(k2_tiShortName, l3PCharLen(l_SA[2]));
        finally
         Finish;
        end;//try..finally
       end//Length(l_SA) > 2
       else
       if l_IsScript then
       begin
        StartDefaultChild;
        try
         AddIntegerAtom(k2_tiType, CI_SCRIPT);
        finally
         Finish;
        end;//try..finally
       end;//l_IsScript
      finally
       Finish;
      end;//try..finally
     finally
      Finish;
     end;//try..finally
     DoAppend(l_Rest);
    end;//aStr.S = aHLStr.S
   end;//DoHyperlink

  begin//TryHyperlinks
   l3ParseWordsExF(aStr, l3L2WA(@DoHyperlink), ['[']);
  end;//TryHyperlinks

 const
  cClose = '}';

  procedure StartMacro;
  var
   l_Pos : Integer;
   l_F : TevFormatInfo;
  begin//StartMacro
   l_Pos := ev_lpCharIndex(':', aStr);
   Assert(l_Pos <> l3NotFound);
   l_F.rName := l3Str(l3PCharLen(aStr.S, l_Pos, aStr.SCodePage));
   aStr.Shift(l_Pos + 1);
   l_Pos := ev_lpCharIndex(cClose, aStr);
   Assert(l_Pos <> l3NotFound);
   l_F.rValue := l3Str(l3PCharLen(aStr.S, l_Pos, aStr.SCodePage));
   aStr.Shift(l_Pos + 1);
   l_F.rStart := l_Text.Len;
   l_Poses.Add(l_F);
   TryHyperlinks;
  end;//StartMacro

  procedure FinishMacro;

   function AtomID(const aName : AnsiString): Integer;
   begin//AtomID
    if ANSISameText(aName, 'color') then
     Result := k2_tiForeColor
    else
     Result := GetObjectID(aName, false);
   end;//AtomID

  var
   l_F : TevFormatInfo;
  begin//FinishMacro
   l_F := l_Poses.Last;
   StartTag(k2_tiSegments);
   try
    StartChild(k2_typTextSegment);
    try
     AddIntegerAtom(k2_tiStart, l_F.rStart);
     AddIntegerAtom(k2_tiFinish, l_Text.Len);
     AddIntegerAtom(k2_tiStyle, ev_saColorSelection);
     StartTag(k2_tiFont);
     try
      AddStringAtom(AtomID(l_F.rName), l_F.rValue);
     finally
      Finish;
     end;//try..finally
    finally
     Finish;
    end;//try..finally
   finally
    Finish;
   end;//try..finally
   l_Poses.Delete(l_Poses.Hi);
   TryHyperlinks;
  end;//FinishMacro

 var
  l_MN : AnsiString;
 begin//DoTag
  Result := true;
  if (aStr.S = l_S.S) then
  // - начало строки
   TryHyperlinks
  else
  begin
   if (l_Poses.Count > 0) then
   begin
    l_MN := l_Poses.Last.rName + cClose;
    if l3Starts(l_MN, aStr, true) then
    begin
     aStr.Shift(Length(l_MN));
     FinishMacro;
     Exit;
    end//l3Starts(l_MN, aStr, true)
   end;//l_Poses.Count > 0
   StartMacro;
  end;//aStr.S = l_S.S
 end;//DoTag

var
 l_Style : Integer;
 l_ForeColor : TColor;

 function TryStyle(const aStarts: AnsiString; aStyle : Integer): Boolean;
 begin//TryStyle
  if l3Starts(aStarts, aText.AsWStr) then
  begin
   Result := true;
   l_Style := aStyle;
   aText.Delete(0, Length(aStarts));
   l_ForeColor := clBlack;
  end//l3Starts(aStarts, aText.AsWStr)
  else
   Result := false;
 end;//TryStyle

var
 l_Font : TafwFont;
 l_FontSize : Integer;
 l_IndentLevel : Integer;
//#UC END# *4D6BB62C01C8_4D6BB1E0012D_var*
begin
//#UC START# *4D6BB62C01C8_4D6BB1E0012D_impl*
 {$IfDef Nemesis}
 Inc(g_Hack112723038);
 try
 {$EndIf Nemesis}
  l_ForeColor := clDefault;
  l_FontSize := 0;
  l_Style := DefaultStyle;
  if not TryStyle('h4. ', ev_saTxtHeader4) then
  if not TryStyle('h3. ', ev_saTxtHeader3) then
  if not TryStyle('h2. ', ev_saTxtHeader2) then
  if not TryStyle('h1. ', ev_saTxtHeader1) then
  if not TryStyle('s#69. ', ev_saWriteToUs) then
   ;
  l_Poses := TevFormatInfoList.Create;
  try
   l_S := aText.AsWStr;
   l_Text := Tl3String.Create;
   try
    l3ParseWordsExF(l_S, l3L2WA(@DoTag), ['{']);
    AddStringAtom(k2_tiText, l_Text.AsWStr);
   finally
    FreeAndNil(l_Text);
   end;//try..finally
   Assert(l_Poses.Empty);
  finally
   FreeAndNil(l_Poses);
  end;//try..finally
  if (l_Style <> ev_saEmpty) then
   AddIntegerAtom(k2_tiStyle, l_Style);
  if (f_ListLevel > 0) then
   AddIntegerAtom(k2_tiBullet, 1);
  l_IndentLevel := f_ListLevel + f_IndentLevel; 
  if (l_Style = ev_saEmpty{<> ev_saWriteToUs}) OR
     (l_Style = DefaultStyle) OR
     // http://mdp.garant.ru/pages/viewpage.action?pageId=378561417
     (l_IndentLevel <> 0) then
  begin
   AddIntegerAtom(k2_tiFirstIndent, (l3Inch div 4) * l_IndentLevel);
   AddIntegerAtom(k2_tiLeftIndent, (l3Inch div 4) * l_IndentLevel);
  end;//l_Style <> ev_saWriteToUs
  if not f_Justification.Empty then
   AddIntegerAtom(k2_tiJustification, f_Justification.Last);
  if not f_FontSizes.Empty then
   l_FontSize := f_FontSizes.Last;
  if (l_Style <= ev_saTxtHeader1) AND (l_Style >= ev_saTxtHeader4) then
  begin
   if (l_FontSize = 0) then
    l_FontSize := 11;
   Inc(l_FontSize, Abs(ev_saTxtHeader4) - Abs(l_Style));
  end;//l_Style <= ev_saTxtHeader1
  if (f_SmallLevel > 0) then
  begin
   if (l_FontSize = 0) then
   begin
    l_Font := TafwFont.Create;
    try
     if (l_Style = ev_saEmpty) then
      if (DefaultStyle = ev_saEmpty) then
       l_Style := ev_saTxtNormalANSI
      else 
       l_Style := DefaultStyle;
     evGetStyleFont(l_Font, l_Style);
     l_FontSize := l_Font.Size;
    finally
     FreeAndNil(l_Font);
    end;//try..finally
   end;//l_FontSize = 0
   l_FontSize := Max(l_FontSize - f_SmallLevel, 5);
  end;//f_SmallLevel > 0
  if (l_FontSize > 0) OR
     (
      (l_ForeColor <> clDefault) AND
      ((l_Style = ev_saEmpty) OR (l_ForeColor <> clBlack))
     ) then
  begin
   StartTag(k2_tiFont);
   try
    if (l_FontSize > 0) then
     AddIntegerAtom(k2_tiSize, l_FontSize);
    if (l_ForeColor <> clDefault) then
     AddIntegerAtom(k2_tiForeColor, l_ForeColor);
   finally
    Finish;
   end;//try..finally
  end;//l_FontSize > 0
 {$IfDef Nemesis}
 finally
  Dec(g_Hack112723038);
 end;//try..finally
 {$EndIf Nemesis}
//#UC END# *4D6BB62C01C8_4D6BB1E0012D_impl*
end;//TevCustomWikiReader.DoText

function TevCustomWikiReader.NeedOpenDefaultChild(aText: Tl3String): Boolean;
//#UC START# *4E0B6520020B_4D6BB1E0012D_var*
var
 l_S : AnsiString;

 function IsOpenParam(const aSt: AnsiString; var aList : Tl3ProtoIntegerList): Boolean;

  function ParseAttrValue(const sConst: AnsiString): Integer;
  var
   l_Err: Integer;
   l_TagID: Integer;
   l_AType: Tk2TypePrim;
  begin
   Val(sConst, Result, l_Err);
   if l_Err <> 0 then // не число. Ищем константу.
   begin
    l_TagID := Tk2Attributes.Instance.IDByName(aSt);
//    l_TagID := GetEnumValue(TypeInfo(_Tk2TagID), '_k2_ti' + aSt);
    l_AType := Tk2TypePrim(CurrentType.ArrayProp[k2_tiChildren].DefaultChildType.Prop[l_TagID].AtomType);
    Assert(l_AType is Tk2Type);
    Result := Tk2Type(l_AType).StrToTag(l_S).AsLong;
   end;
  end;

 var
  l_Starts: AnsiString;
 begin//IsOpenParam
  l_Starts := '{' + aSt + ':';
  Result := AnsiStartsStr(l_Starts, l_S);
  if Result then
  begin
   if (aList = nil) then
    aList := Tl3ProtoIntegerList.Create;
   Delete(l_S, 1, Length(l_Starts));
   Assert(l_S[Length(l_S)] = '}');
   Delete(l_S, Length(l_S), 1);
   aList.Add(ParseAttrValue(l_S));
  end;//Result
 end;//IsOpenParam

 function IsCloseTagPrim(const aSt: AnsiString): Boolean;
 begin//IsCloseTagPrim
  Result := (l_S = '{/' + aSt + '}');
 end;//IsCloseTagPrim

 function IsCloseTag(const aSt: AnsiString; var theLevel : Integer): Boolean;
 begin//IsCloseTag
  Result := IsCloseTagPrim(aSt);
  if Result then
  begin
   Dec(theLevel);
   Assert(theLevel >= 0);
  end;//Result
 end;//IsCloseTag

 function IsCloseParam(const aSt: AnsiString; aList : Tl3ProtoIntegerList): Boolean;
 begin//IsCloseParam
  Result := IsCloseTagPrim(aSt);
  if Result then
   aList.Delete(aList.Hi);
 end;//IsCloseParam

 function IsOpenTag(const aSt: AnsiString; var theLevel : Integer): Boolean;
 begin//IsOpenTag
  Result := (l_S = '{' + aSt + '}');
  if Result then
   Inc(theLevel);
 end;//IsOpenTag

 function TryTag(const aTag : AnsiString;
                 var theLevel : Integer;
                 aChildID : Tk2Type = nil;
                 anAtom   : Integer = -1): Boolean;
 begin//TryTag
  Result := IsOpenTag(aTag, theLevel);
  if Result then
  begin
   if (aChildID <> nil) then
   begin
    StartChild(aChildID);
    if (anAtom > 0) then
     AddStringAtom(anAtom, Filer.ReadLn);
    if (aChildID = k2_typCloak) then
     AddBoolAtom(k2_tiCollapsed, true);
   end;//aChildID > 0
  end//Result
  else
  begin
   Result := IsCloseTag(aTag, theLevel);
   if Result then
   begin
    if (aChildID <> nil) then
     Finish;
   end//Result
  end;//Result
 end;//TryTag

 function TryParam(const aSt: AnsiString; var aList : Tl3ProtoIntegerList): Boolean;
 begin//TryParam
  Result := IsOpenParam(aSt, aList);
  if not Result then
   Result := IsCloseParam(aSt, aList);
 end;//TryParam

//#UC END# *4E0B6520020B_4D6BB1E0012D_var*
begin
//#UC START# *4E0B6520020B_4D6BB1E0012D_impl*
 l_S := aText.AsString;
 Result := false;
 if not TryTag('cloak', f_CloakLevel, k2_typCloak, k2_tiShortName) then
 if not TryTag('list', f_ListLevel) then
 if not TryTag('small', f_SmallLevel) then
 if not TryTag('indent', f_IndentLevel) then
 if not TryParam('justification', f_Justification) then
 if not TryParam('fontsize', f_FontSizes) then
  Result := true;
//#UC END# *4E0B6520020B_4D6BB1E0012D_impl*
end;//TevCustomWikiReader.NeedOpenDefaultChild

end.