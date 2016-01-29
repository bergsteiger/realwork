unit evStandardStyles;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evStandardStyles.pas"
// �����: 24.08.2011 14:16
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StyleTable::TevStandardStyles
//
// ����������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  afwInterfaces,
  evdStyles,
  l3ProtoObject,
  evStandardStylesListPrim,
  evStandardStylesList,
  evResultFontInterfaces,
  l3Variant
  ;

type
 TevStandardStylesCacheByID = array [TevStandardCachedStyle] of TevStandardStylesCacheByJustification;

 _evStyleTableListener_Parent_ = Tl3ProtoObject;
 {$Include ..\Everest\evStyleTableListener.imp.pas}
 TevStandardStyles = class(_evStyleTableListener_, IafwFontCache)
  {* ����������� ����� }
 private
 // private fields
   f_StandardFont : TevStandardStylesCacheByID;
   f_StylesList : TevStandardStylesList;
 private
 // private methods
   procedure FreeFonts;
   procedure CheckFontInCache(anObj: Tl3Variant;
     anID: Integer;
     aJust: Boolean;
     aVis: Boolean;
     aFixedFont: Boolean;
     out theFont: IevResultFont);
 protected
 // realized methods
   {$If not defined(DesignTimeLibrary)}
   procedure DoStyleTableChanged; override;
   {$IfEnd} //not DesignTimeLibrary
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   {$If not defined(DesignTimeLibrary)}
   function AtEnd: Boolean; override;
     {* ������������� � ����� ������ ����������� }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   function GetStandardStyleFont(aPara: Tl3Variant;
     aFixedFont: Boolean;
     out theFont: IevResultFont): Boolean;
   function GetStyleFont(aStyle: Tl3Variant;
     aPrinting: Boolean): IevResultFont;
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TevStandardStyles;
    {- ���������� ��������� ����������. }
 end;//TevStandardStyles

implementation

uses
  l3Base {a},
  k2Tags,
  evdTypes,
  evDefaultStylesFontSizes,
  SysUtils,
  evStyleInterface,
  k2Const,
  evResultFontHolder
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  
  ;


// start class TevStandardStyles

var g_TevStandardStyles : TevStandardStyles = nil;

procedure TevStandardStylesFree;
begin
 l3Free(g_TevStandardStyles);
end;

class function TevStandardStyles.Instance: TevStandardStyles;
begin
 if (g_TevStandardStyles = nil) then
 begin
  l3System.AddExitProc(TevStandardStylesFree);
  g_TevStandardStyles := Create;
 end;
 Result := g_TevStandardStyles;
end;


{$Include ..\Everest\evStyleTableListener.imp.pas}

// start class TevStandardStyles

procedure TevStandardStyles.FreeFonts;
//#UC START# *4E54D0F101B3_4E54CF7E0143_var*
var
 i : TevStandardCachedStyle;
//#UC END# *4E54D0F101B3_4E54CF7E0143_var*
begin
//#UC START# *4E54D0F101B3_4E54CF7E0143_impl*
 for i := Low(i) to High(i) do
  TevStandardStylesListPrim.EvFreeStandardStylesCache(f_StandardFont[i]);
 FreeAndNil(f_StylesList);
//#UC END# *4E54D0F101B3_4E54CF7E0143_impl*
end;//TevStandardStyles.FreeFonts

procedure TevStandardStyles.CheckFontInCache(anObj: Tl3Variant;
  anID: Integer;
  aJust: Boolean;
  aVis: Boolean;
  aFixedFont: Boolean;
  out theFont: IevResultFont);
//#UC START# *4E5F9ADA02CE_4E54CF7E0143_var*

 procedure GetStandard;
 begin//GetStandard
  theFont := f_StandardFont[anID, aJust, aVis, aFixedFont];
  if (theFont = nil) then
  begin
   theFont := TevResultFontHolder.Make;
   theFont.AddStyledTag(anObj.AsObject);
   f_StandardFont[anID, aJust, aVis, aFixedFont] := theFont;
  end;//theFont = nil
 end;//GetStandard

 procedure GetExtended;
 begin//GetExtended
  if (f_StylesList = nil) then
   f_StylesList := TevStandardStylesList.Create;
  theFont := f_StylesList.StyleByID(anID, aJust, aVis, aFixedFont);
  if (theFont = nil) then
  begin
   theFont := TevResultFontHolder.Make;
   theFont.AddStyledTag(anObj.AsObject);
   f_StylesList.AddStyleByID(anID, aJust, aVis, aFixedFont, theFont);
  end;//theFont = nil
 end;//GetExtended

//#UC END# *4E5F9ADA02CE_4E54CF7E0143_var*
begin
//#UC START# *4E5F9ADA02CE_4E54CF7E0143_impl*
 if (anID >= Low(TevStandardCachedStyle)) AND
    (anID <= High(TevStandardCachedStyle)) then
  GetStandard
 else
  GetExtended;
 Assert(theFont <> nil);
 if aFixedFont then
 begin
  if not theFont.IsTransparent(k2_tiSize) then
  begin
   //assert(false, '����������');
   theFont.SetItem(k2_tiSize, TevDefaultStylesFontSizes.Instance.FontSizeForStyle(anID));
  end;//not theFont.IsTransparent(k2_tiSize)
 end;//aFixedFont
//#UC END# *4E5F9ADA02CE_4E54CF7E0143_impl*
end;//TevStandardStyles.CheckFontInCache

function TevStandardStyles.GetStandardStyleFont(aPara: Tl3Variant;
  aFixedFont: Boolean;
  out theFont: IevResultFont): Boolean;
//#UC START# *4E54D081006C_4E54CF7E0143_var*
var
 l_St        : Tl3Variant;
 l_StH       : Integer;
 l_StyleVis  : Boolean;
 l_ParaVis   : Boolean;
 l_ParaJust  : TevIndentType;
 l_StyleJust : TevIndentType;
//#UC END# *4E54D081006C_4E54CF7E0143_var*
begin
//#UC START# *4E54D081006C_4E54CF7E0143_impl*
 Result := true;
 l_St := aPara.Attr[k2_tiStyle];
 l_StH := l_St.IntA[k2_tiHandle];
 l_StyleJust := TevIndentType(l_St.rLong(k2_tiJustification, Ord(ev_itNone)));
 l_ParaJust := TevIndentType(aPara.rLong(k2_tiJustification, Ord(ev_itNone)));
 l_StyleVis := l_St.BoolA[k2_tiVisible];
 l_ParaVis := aPara.BoolA[k2_tiVisible];
 if (l_ParaJust <> l_StyleJust) OR (l_StyleVis <> l_ParaVis) then
  CheckFontInCache(aPara, l_StH, l_ParaJust = ev_itPreformatted, l_ParaVis, aFixedFont, theFont)
 else
  CheckFontInCache(l_St, l_StH, l_StyleJust = ev_itPreformatted, l_StyleVis, aFixedFont, theFont);
//#UC END# *4E54D081006C_4E54CF7E0143_impl*
end;//TevStandardStyles.GetStandardStyleFont

function TevStandardStyles.GetStyleFont(aStyle: Tl3Variant;
  aPrinting: Boolean): IevResultFont;
//#UC START# *4E5F9A5E02A3_4E54CF7E0143_var*
//#UC END# *4E5F9A5E02A3_4E54CF7E0143_var*
begin
//#UC START# *4E5F9A5E02A3_4E54CF7E0143_impl*
 CheckFontInCache(aStyle,
                  aStyle.IntA[k2_tiHandle],
                  TevIndentType(aStyle.rLong(k2_tiJustification, Ord(ev_itNone))) = ev_itPreformatted,
                  aStyle.BoolA[k2_tiVisible],
                  aPrinting AND (TevStyleInterface.PrintAndExportFontSize > 0){DocumentUseFixedFontForPrintAndExportSetting},
                  Result);
//#UC END# *4E5F9A5E02A3_4E54CF7E0143_impl*
end;//TevStandardStyles.GetStyleFont

class function TevStandardStyles.Exists: Boolean;
 {-}
begin
 Result := g_TevStandardStyles <> nil;
end;//TevStandardStyles.Exists

{$If not defined(DesignTimeLibrary)}
procedure TevStandardStyles.DoStyleTableChanged;
//#UC START# *4A485B710126_4E54CF7E0143_var*
//#UC END# *4A485B710126_4E54CF7E0143_var*
begin
//#UC START# *4A485B710126_4E54CF7E0143_impl*
 FreeFonts;
//#UC END# *4A485B710126_4E54CF7E0143_impl*
end;//TevStandardStyles.DoStyleTableChanged
{$IfEnd} //not DesignTimeLibrary

procedure TevStandardStyles.Cleanup;
//#UC START# *479731C50290_4E54CF7E0143_var*
//#UC END# *479731C50290_4E54CF7E0143_var*
begin
//#UC START# *479731C50290_4E54CF7E0143_impl*
 FreeFonts;
 inherited;
//#UC END# *479731C50290_4E54CF7E0143_impl*
end;//TevStandardStyles.Cleanup

{$If not defined(DesignTimeLibrary)}
function TevStandardStyles.AtEnd: Boolean;
//#UC START# *4A4867A20049_4E54CF7E0143_var*
//#UC END# *4A4867A20049_4E54CF7E0143_var*
begin
//#UC START# *4A4867A20049_4E54CF7E0143_impl*
 Result := false;
//#UC END# *4A4867A20049_4E54CF7E0143_impl*
end;//TevStandardStyles.AtEnd
{$IfEnd} //not DesignTimeLibrary

end.