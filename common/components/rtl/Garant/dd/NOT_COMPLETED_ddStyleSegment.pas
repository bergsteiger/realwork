unit NOT_COMPLETED_ddStyleSegment;

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_COMPLETED_ddStyleSegment.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddStyleSegment" MUID: (54D9B8E801EA)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddTextSegment
 , k2Interfaces
 , ddCharacterProperty
 , ddTypes
;

type
 TddStyleSegment = class(TddTextSegment)
  protected
   procedure DoWriteSegmentProps(const Generator: Ik2TagGenerator;
    aCHP: TddCharacterProperty;
    aParentCHP: TddCharacterProperty;
    aLiteVersion: TddLiteVersion); override;
  public
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aCHP: TddCharacterProperty;
    aParentCHP: TddCharacterProperty;
    aLiteVersion: TddLiteVersion); override;
   function Clone: TddTextSegment; override;
   function SkipSegment(aDiffCHP: TddCharacterProperty;
    aLiteVersion: TddLiteVersion): Boolean; override;
 end;//TddStyleSegment

implementation

uses
 l3ImplUses
 , ddRTFConst
 , l3String
 , l3Types
 , l3LogFont
 , l3FontManager
 , Windows
 , RTFtypes
 , l3Interfaces
 , evdStyles
;

procedure TddStyleSegment.Write2Generator(const Generator: Ik2TagGenerator;
 aCHP: TddCharacterProperty;
 aParentCHP: TddCharacterProperty;
 aLiteVersion: TddLiteVersion);
//#UC START# *54D888450259_54D9B8E801EA_var*
//#UC END# *54D888450259_54D9B8E801EA_var*
begin
//#UC START# *54D888450259_54D9B8E801EA_impl*
 StartTextSegment(Generator);
 try
  DoWriteSegmentProps(Generator, aCHP, aParentCHP, aLiteVersion);
 finally
  Generator.Finish;
 end; // k2_idTextSegment
//#UC END# *54D888450259_54D9B8E801EA_impl*
end;//TddStyleSegment.Write2Generator

function TddStyleSegment.Clone: TddTextSegment;
//#UC START# *54DC46B50110_54D9B8E801EA_var*
//#UC END# *54DC46B50110_54D9B8E801EA_var*
begin
//#UC START# *54DC46B50110_54D9B8E801EA_impl*
 Result := TddStyleSegment.Create;
 Result.Assign(Self);
//#UC END# *54DC46B50110_54D9B8E801EA_impl*
end;//TddStyleSegment.Clone

function TddStyleSegment.SkipSegment(aDiffCHP: TddCharacterProperty;
 aLiteVersion: TddLiteVersion): Boolean;
//#UC START# *54E4325C00BE_54D9B8E801EA_var*

 procedure lp_ConvertkBold2Style;
 begin
  if (CHP.Style <> ev_saBoldSelection) and CHP.Bold then
  begin
   CHP.Style := ev_saBoldSelection;
   CHP.ClearProp(ddBold);
  end; // if (l_CHP.Style <> ev_saBoldSelection) and (l_CHP.Bold <> propUndefined)) then
 end;

//#UC END# *54E4325C00BE_54D9B8E801EA_var*
begin
//#UC START# *54E4325C00BE_54D9B8E801EA_impl*
 if aLiteVersion > dd_lvNone then
  lp_ConvertkBold2Style;
 Result := ((CHP.Style = 0) or (CHP.Style = propUndefined)) and ((aLiteVersion > dd_lvNone) or (aDiffCHP = nil));
//#UC END# *54E4325C00BE_54D9B8E801EA_impl*
end;//TddStyleSegment.SkipSegment

procedure TddStyleSegment.DoWriteSegmentProps(const Generator: Ik2TagGenerator;
 aCHP: TddCharacterProperty;
 aParentCHP: TddCharacterProperty;
 aLiteVersion: TddLiteVersion);
//#UC START# *54D9B0300325_54D9B8E801EA_var*
var
 l_CharSet: LongInt;
 l_LogFont: Tl3LogFont;
//#UC END# *54D9B0300325_54D9B8E801EA_var*
begin
//#UC START# *54D9B0300325_54D9B8E801EA_impl*
 Generator.AddIntegerAtom(k2_tiStart, Start);
 Generator.AddIntegerAtom(k2_tiFinish, Stop);
 if (CHP.Style <> 0) and (CHP.Style <> propUndefined) then
  Generator.AddIntegerAtom(k2_tiStyle, CHP.Style)
 else
  if (aLiteVersion = dd_lvNone) and (aCHP <> nil) then
  begin
   if aCHP.Hidden then
    Generator.AddBoolAtom(k2_tiVisible, ByteBool(False));
   Generator.StartTag(k2_tiFont);
   try
    { here font properties }
    with aCHP do
    begin { Вываливаем шрифтовое оформление }
     if Bold then
      Generator.AddBoolAtom(k2_tiBold, ByteBool(Bold))
     else
      if aParentCHP.Bold then
       Generator.AddBoolAtom(k2_tiBold, ByteBool(Bold));
     if Italic then
      Generator.AddBoolAtom(k2_tiItalic, ByteBool(Italic))
     else
      if aParentCHP.Italic then
       Generator.AddBoolAtom(k2_tiItalic, ByteBool(Italic));
     if Strikeout then
      Generator.AddBoolAtom(k2_tiStrikeout, ByteBool(Strikeout))
     else
      if aParentCHP.Strikeout then
       Generator.AddBoolAtom(k2_tiStrikeout, ByteBool(Strikeout));
     if (FontName <> '') and (FontNumber > -1) then
     begin
      if (Language = langRussian) and
         ((Length(FontName) < 4) OR
          (l3Compare(PAnsiChar(FontName) + Length(FontName) - 4,
                     ' CYR', l3_siCaseUnsensitive) <> 0)) then
      begin
       l_LogFont := l3FontManager.Fonts.DRByName[FontName];
       if (l_LogFont <> nil) then
        l_CharSet := l_LogFont.LogFont.elfLogFont.lfCharSet
       else
        l_CharSet := DEFAULT_CHARSET;
       if not (l_CharSet in [SYMBOL_CHARSET, RUSSIAN_CHARSET]) then
        FontName := FontName + ' CYR';
      end;
      Generator.AddStringAtom(k2_tiName, FontName);
     end; // FontNumber > -1
     if (FontSize <> propUndefined) and (FontSize <> aParentCHP.FontSize) then
      Generator.AddIntegerAtom(k2_tiSize, FontSize div 2);
     if (fColor <> propUndefined) and (aParentCHP.fColor <> fColor) then
      Generator.AddIntegerAtom(k2_tiForeColor, FColor);
     if (bColor <> propUndefined) and (aParentCHP.bColor <> bColor) then
      Generator.AddIntegerAtom(k2_tiBackColor, BColor);
     if (Highlight <> propUndefined) and (aParentCHP.Highlight <> Highlight) then
      Generator.AddIntegerAtom(k2_tiBackColor, Highlight);
     case Pos of
      cpSuperScript: Generator.AddIntegerAtom(k2_tiIndex,
                                              ord(l3_fiSuper));
      cpSubScript: Generator.AddIntegerAtom(k2_tiIndex,
                                            ord(l3_fiSub));
     end;
     if (Underline <> aParentCHP.Underline) and (Underline <> utNotDefined) then
      Generator.AddBoolAtom(k2_tiUnderline,
                            (Underline <> utNone) and
                            (Underline <> utNotDefined));
    end; // with l_CHP
   finally
    Generator.Finish; { font }
   end; // k2_tiFont
  end;
//#UC END# *54D9B0300325_54D9B8E801EA_impl*
end;//TddStyleSegment.DoWriteSegmentProps

end.
