{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Globalization;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  // Internal Uses...
  Winapi.Foundation.Collections,
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Globalization Class Names
  // Windows.Globalization.Fonts.LanguageFont
  // DualAPI
  SFonts_LanguageFont = 'Windows.Globalization.Fonts.LanguageFont';
  // Windows.Globalization.Fonts.LanguageFontGroup
  // DualAPI
  SFonts_LanguageFontGroup = 'Windows.Globalization.Fonts.LanguageFontGroup';
  // Windows.Globalization.CalendarIdentifiers
  // DualAPI
  SCalendarIdentifiers = 'Windows.Globalization.CalendarIdentifiers';
  // Windows.Globalization.ClockIdentifiers
  // DualAPI
  SClockIdentifiers = 'Windows.Globalization.ClockIdentifiers';
  // Windows.Globalization.NumeralSystemIdentifiers
  // DualAPI
  SNumeralSystemIdentifiers = 'Windows.Globalization.NumeralSystemIdentifiers';
  // Windows.Globalization.CurrencyIdentifiers
  // DualAPI
  SCurrencyIdentifiers = 'Windows.Globalization.CurrencyIdentifiers';
  // Windows.Globalization.GeographicRegion
  // DualAPI
  SGeographicRegion = 'Windows.Globalization.GeographicRegion';
  // Windows.Globalization.Language
  // DualAPI
  SLanguage = 'Windows.Globalization.Language';
  // Windows.Globalization.DateTimeFormatting.DateTimeFormatter
  // DualAPI
  SDateTimeFormatting_DateTimeFormatter = 'Windows.Globalization.DateTimeFormatting.DateTimeFormatter';
  // Windows.Globalization.Calendar
  // DualAPI
  SCalendar = 'Windows.Globalization.Calendar';
  // Windows.Globalization.NumberFormatting.SignificantDigitsNumberRounder
  // DualAPI
  SNumberFormatting_SignificantDigitsNumberRounder = 'Windows.Globalization.NumberFormatting.SignificantDigitsNumberRounder';
  // Windows.Globalization.NumberFormatting.IncrementNumberRounder
  // DualAPI
  SNumberFormatting_IncrementNumberRounder = 'Windows.Globalization.NumberFormatting.IncrementNumberRounder';
  // Windows.Globalization.NumberFormatting.DecimalFormatter
  // DualAPI
  SNumberFormatting_DecimalFormatter = 'Windows.Globalization.NumberFormatting.DecimalFormatter';
  // Windows.Globalization.NumberFormatting.PercentFormatter
  // DualAPI
  SNumberFormatting_PercentFormatter = 'Windows.Globalization.NumberFormatting.PercentFormatter';
  // Windows.Globalization.NumberFormatting.PermilleFormatter
  // DualAPI
  SNumberFormatting_PermilleFormatter = 'Windows.Globalization.NumberFormatting.PermilleFormatter';
  // Windows.Globalization.NumberFormatting.CurrencyFormatter
  // DualAPI
  SNumberFormatting_CurrencyFormatter = 'Windows.Globalization.NumberFormatting.CurrencyFormatter';
  // Windows.Globalization.NumberFormatting.NumeralSystemTranslator
  // DualAPI
  SNumberFormatting_NumeralSystemTranslator = 'Windows.Globalization.NumberFormatting.NumeralSystemTranslator';
  // Windows.Globalization.Collation.CharacterGrouping
  // DualAPI
  SCollation_CharacterGrouping = 'Windows.Globalization.Collation.CharacterGrouping';
  // Windows.Globalization.Collation.CharacterGroupings
  // DualAPI
  SCollation_CharacterGroupings = 'Windows.Globalization.Collation.CharacterGroupings';


type
  // Forward declare interfaces
  // Windows.Globalization.ILanguage
  ILanguage = interface;
  PILanguage = ^ILanguage;

  // Windows.Foundation.Collections.IIterator`1<Windows.Globalization.ILanguage>
  IIterator_1__ILanguage = interface;
  PIIterator_1__ILanguage = ^IIterator_1__ILanguage;

  // Windows.Foundation.Collections.IIterable`1<Windows.Globalization.ILanguage>
  IIterable_1__ILanguage = interface;
  PIIterable_1__ILanguage = ^IIterable_1__ILanguage;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Globalization.ILanguage>
  IVectorView_1__ILanguage = interface;
  PIVectorView_1__ILanguage = ^IVectorView_1__ILanguage;

  // Windows.Globalization.Fonts.ILanguageFont
  Fonts_ILanguageFont = interface;
  PFonts_ILanguageFont = ^Fonts_ILanguageFont;

  // Windows.Globalization.Fonts.ILanguageFontGroup
  Fonts_ILanguageFontGroup = interface;
  PFonts_ILanguageFontGroup = ^Fonts_ILanguageFontGroup;

  // Windows.Globalization.Fonts.ILanguageFontGroupFactory
  Fonts_ILanguageFontGroupFactory = interface;
  PFonts_ILanguageFontGroupFactory = ^Fonts_ILanguageFontGroupFactory;

  // Windows.Globalization.ICalendarIdentifiersStatics
  ICalendarIdentifiersStatics = interface;
  PICalendarIdentifiersStatics = ^ICalendarIdentifiersStatics;

  // Windows.Globalization.ICalendarIdentifiersStatics2
  ICalendarIdentifiersStatics2 = interface;
  PICalendarIdentifiersStatics2 = ^ICalendarIdentifiersStatics2;

  // Windows.Globalization.IClockIdentifiersStatics
  IClockIdentifiersStatics = interface;
  PIClockIdentifiersStatics = ^IClockIdentifiersStatics;

  // Windows.Globalization.INumeralSystemIdentifiersStatics
  INumeralSystemIdentifiersStatics = interface;
  PINumeralSystemIdentifiersStatics = ^INumeralSystemIdentifiersStatics;

  // Windows.Globalization.INumeralSystemIdentifiersStatics2
  INumeralSystemIdentifiersStatics2 = interface;
  PINumeralSystemIdentifiersStatics2 = ^INumeralSystemIdentifiersStatics2;

  // Windows.Globalization.ICurrencyIdentifiersStatics
  ICurrencyIdentifiersStatics = interface;
  PICurrencyIdentifiersStatics = ^ICurrencyIdentifiersStatics;

  // Windows.Globalization.IGeographicRegion
  IGeographicRegion = interface;
  PIGeographicRegion = ^IGeographicRegion;

  // Windows.Globalization.IGeographicRegionFactory
  IGeographicRegionFactory = interface;
  PIGeographicRegionFactory = ^IGeographicRegionFactory;

  // Windows.Globalization.IGeographicRegionStatics
  IGeographicRegionStatics = interface;
  PIGeographicRegionStatics = ^IGeographicRegionStatics;

  // Windows.Globalization.ILanguageExtensionSubtags
  ILanguageExtensionSubtags = interface;
  PILanguageExtensionSubtags = ^ILanguageExtensionSubtags;

  // Windows.Globalization.ILanguageFactory
  ILanguageFactory = interface;
  PILanguageFactory = ^ILanguageFactory;

  // Windows.Globalization.ILanguageStatics
  ILanguageStatics = interface;
  PILanguageStatics = ^ILanguageStatics;

  // Windows.Globalization.ILanguageStatics2
  ILanguageStatics2 = interface;
  PILanguageStatics2 = ^ILanguageStatics2;

  // Windows.Globalization.DateTimeFormatting.IDateTimeFormatter
  DateTimeFormatting_IDateTimeFormatter = interface;
  PDateTimeFormatting_IDateTimeFormatter = ^DateTimeFormatting_IDateTimeFormatter;

  // Windows.Globalization.DateTimeFormatting.IDateTimeFormatterFactory
  DateTimeFormatting_IDateTimeFormatterFactory = interface;
  PDateTimeFormatting_IDateTimeFormatterFactory = ^DateTimeFormatting_IDateTimeFormatterFactory;

  // Windows.Globalization.DateTimeFormatting.IDateTimeFormatterStatics
  DateTimeFormatting_IDateTimeFormatterStatics = interface;
  PDateTimeFormatting_IDateTimeFormatterStatics = ^DateTimeFormatting_IDateTimeFormatterStatics;

  // Windows.Globalization.DateTimeFormatting.IDateTimeFormatter2
  DateTimeFormatting_IDateTimeFormatter2 = interface;
  PDateTimeFormatting_IDateTimeFormatter2 = ^DateTimeFormatting_IDateTimeFormatter2;

  // Windows.Globalization.ICalendar
  ICalendar = interface;
  PICalendar = ^ICalendar;

  // Windows.Globalization.ICalendarFactory2
  ICalendarFactory2 = interface;
  PICalendarFactory2 = ^ICalendarFactory2;

  // Windows.Globalization.ITimeZoneOnCalendar
  ITimeZoneOnCalendar = interface;
  PITimeZoneOnCalendar = ^ITimeZoneOnCalendar;

  // Windows.Globalization.ICalendarFactory
  ICalendarFactory = interface;
  PICalendarFactory = ^ICalendarFactory;

  // Windows.Globalization.NumberFormatting.INumberRounder
  NumberFormatting_INumberRounder = interface;
  PNumberFormatting_INumberRounder = ^NumberFormatting_INumberRounder;

  // Windows.Globalization.NumberFormatting.ISignificantDigitsNumberRounder
  NumberFormatting_ISignificantDigitsNumberRounder = interface;
  PNumberFormatting_ISignificantDigitsNumberRounder = ^NumberFormatting_ISignificantDigitsNumberRounder;

  // Windows.Globalization.NumberFormatting.IIncrementNumberRounder
  NumberFormatting_IIncrementNumberRounder = interface;
  PNumberFormatting_IIncrementNumberRounder = ^NumberFormatting_IIncrementNumberRounder;

  // Windows.Globalization.NumberFormatting.INumberFormatter
  NumberFormatting_INumberFormatter = interface;
  PNumberFormatting_INumberFormatter = ^NumberFormatting_INumberFormatter;

  // Windows.Globalization.NumberFormatting.INumberFormatter2
  NumberFormatting_INumberFormatter2 = interface;
  PNumberFormatting_INumberFormatter2 = ^NumberFormatting_INumberFormatter2;

  // Windows.Globalization.NumberFormatting.INumberParser
  NumberFormatting_INumberParser = interface;
  PNumberFormatting_INumberParser = ^NumberFormatting_INumberParser;

  // Windows.Globalization.NumberFormatting.INumberFormatterOptions
  NumberFormatting_INumberFormatterOptions = interface;
  PNumberFormatting_INumberFormatterOptions = ^NumberFormatting_INumberFormatterOptions;

  // Windows.Globalization.NumberFormatting.ISignificantDigitsOption
  NumberFormatting_ISignificantDigitsOption = interface;
  PNumberFormatting_ISignificantDigitsOption = ^NumberFormatting_ISignificantDigitsOption;

  // Windows.Globalization.NumberFormatting.INumberRounderOption
  NumberFormatting_INumberRounderOption = interface;
  PNumberFormatting_INumberRounderOption = ^NumberFormatting_INumberRounderOption;

  // Windows.Globalization.NumberFormatting.ISignedZeroOption
  NumberFormatting_ISignedZeroOption = interface;
  PNumberFormatting_ISignedZeroOption = ^NumberFormatting_ISignedZeroOption;

  // Windows.Globalization.NumberFormatting.IDecimalFormatterFactory
  NumberFormatting_IDecimalFormatterFactory = interface;
  PNumberFormatting_IDecimalFormatterFactory = ^NumberFormatting_IDecimalFormatterFactory;

  // Windows.Globalization.NumberFormatting.IPercentFormatterFactory
  NumberFormatting_IPercentFormatterFactory = interface;
  PNumberFormatting_IPercentFormatterFactory = ^NumberFormatting_IPercentFormatterFactory;

  // Windows.Globalization.NumberFormatting.IPermilleFormatterFactory
  NumberFormatting_IPermilleFormatterFactory = interface;
  PNumberFormatting_IPermilleFormatterFactory = ^NumberFormatting_IPermilleFormatterFactory;

  // Windows.Globalization.NumberFormatting.ICurrencyFormatter
  NumberFormatting_ICurrencyFormatter = interface;
  PNumberFormatting_ICurrencyFormatter = ^NumberFormatting_ICurrencyFormatter;

  // Windows.Globalization.NumberFormatting.ICurrencyFormatterFactory
  NumberFormatting_ICurrencyFormatterFactory = interface;
  PNumberFormatting_ICurrencyFormatterFactory = ^NumberFormatting_ICurrencyFormatterFactory;

  // Windows.Globalization.NumberFormatting.ICurrencyFormatter2
  NumberFormatting_ICurrencyFormatter2 = interface;
  PNumberFormatting_ICurrencyFormatter2 = ^NumberFormatting_ICurrencyFormatter2;

  // Windows.Globalization.NumberFormatting.INumeralSystemTranslator
  NumberFormatting_INumeralSystemTranslator = interface;
  PNumberFormatting_INumeralSystemTranslator = ^NumberFormatting_INumeralSystemTranslator;

  // Windows.Globalization.NumberFormatting.INumeralSystemTranslatorFactory
  NumberFormatting_INumeralSystemTranslatorFactory = interface;
  PNumberFormatting_INumeralSystemTranslatorFactory = ^NumberFormatting_INumeralSystemTranslatorFactory;

  // Windows.Globalization.Collation.ICharacterGrouping
  Collation_ICharacterGrouping = interface;
  PCollation_ICharacterGrouping = ^Collation_ICharacterGrouping;

  // Windows.Foundation.Collections.IIterator`1<Windows.Globalization.Collation.ICharacterGrouping>
  IIterator_1__Collation_ICharacterGrouping = interface;
  PIIterator_1__Collation_ICharacterGrouping = ^IIterator_1__Collation_ICharacterGrouping;

  // Windows.Foundation.Collections.IIterable`1<Windows.Globalization.Collation.ICharacterGrouping>
  IIterable_1__Collation_ICharacterGrouping = interface;
  PIIterable_1__Collation_ICharacterGrouping = ^IIterable_1__Collation_ICharacterGrouping;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Globalization.Collation.ICharacterGrouping>
  IVectorView_1__Collation_ICharacterGrouping = interface;
  PIVectorView_1__Collation_ICharacterGrouping = ^IVectorView_1__Collation_ICharacterGrouping;

  // Windows.Globalization.Collation.ICharacterGroupings
  Collation_ICharacterGroupings = interface;
  PCollation_ICharacterGroupings = ^Collation_ICharacterGroupings;

  // Windows.Foundation.Collections.IVector`1<Windows.Globalization.ILanguage>
  IVector_1__ILanguage = interface;
  PIVector_1__ILanguage = ^IVector_1__ILanguage;


  // Emit Forwarded interfaces
  // Windows.Globalization Interfaces
  // DualAPI Interface
  // Windows.Globalization.ILanguage
  [WinRTClassNameAttribute(SLanguage)]
  ILanguage = interface(IInspectable)
  ['{EA79A752-F7C2-4265-B1BD-C4DEC4E4F080}']
    function get_LanguageTag: HSTRING; safecall;
    function get_DisplayName: HSTRING; safecall;
    function get_NativeName: HSTRING; safecall;
    function get_Script: HSTRING; safecall;
    property DisplayName: HSTRING read get_DisplayName;
    property LanguageTag: HSTRING read get_LanguageTag;
    property NativeName: HSTRING read get_NativeName;
    property Script: HSTRING read get_Script;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Globalization.ILanguage>
  IIterator_1__ILanguage = interface(IInspectable)
  ['{C694EAFE-7DDE-5F3B-8EEB-6CAEC9334596}']
    function get_Current: ILanguage; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PILanguage): Cardinal; safecall;
    property Current: ILanguage read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Globalization.ILanguage>
  IIterable_1__ILanguage_Base = interface(IInspectable)
  ['{48409A10-61B6-5DB1-A69D-8ABC46AC608A}']
  end;
  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Globalization.ILanguage>
  IIterable_1__ILanguage = interface(IIterable_1__ILanguage_Base)
  ['{D2AC9471-BA9D-5DE8-8E64-8B7FE5FBBA15}']
    function First: IIterator_1__ILanguage; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Globalization.ILanguage>
  IVectorView_1__ILanguage = interface(IInspectable)
  ['{9026F0A6-FDC5-55A7-BEE7-500E55ECBC3F}']
    function GetAt(index: Cardinal): ILanguage; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: ILanguage; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PILanguage): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Globalization.Fonts.ILanguageFont
  [WinRTClassNameAttribute(SFonts_LanguageFont)]
  Fonts_ILanguageFont = interface(IInspectable)
  ['{B12E5C3A-B76D-459B-BEEB-901151CD77D1}']
    function get_FontFamily: HSTRING; safecall;
    function get_FontWeight: FontWeight; safecall;
    function get_FontStretch: FontStretch; safecall;
    function get_FontStyle: FontStyle; safecall;
    function get_ScaleFactor: Double; safecall;
    property FontFamily: HSTRING read get_FontFamily;
    property FontStretch: FontStretch read get_FontStretch;
    property FontStyle: FontStyle read get_FontStyle;
    property FontWeight: FontWeight read get_FontWeight;
    property ScaleFactor: Double read get_ScaleFactor;
  end;

  // DualAPI Interface
  // Windows.Globalization.Fonts.ILanguageFontGroup
  [WinRTClassNameAttribute(SFonts_LanguageFontGroup)]
  Fonts_ILanguageFontGroup = interface(IInspectable)
  ['{F33A7FC3-3A5C-4AEA-B9FF-B39FB242F7F6}']
    function get_UITextFont: Fonts_ILanguageFont; safecall;
    function get_UIHeadingFont: Fonts_ILanguageFont; safecall;
    function get_UITitleFont: Fonts_ILanguageFont; safecall;
    function get_UICaptionFont: Fonts_ILanguageFont; safecall;
    function get_UINotificationHeadingFont: Fonts_ILanguageFont; safecall;
    function get_TraditionalDocumentFont: Fonts_ILanguageFont; safecall;
    function get_ModernDocumentFont: Fonts_ILanguageFont; safecall;
    function get_DocumentHeadingFont: Fonts_ILanguageFont; safecall;
    function get_FixedWidthTextFont: Fonts_ILanguageFont; safecall;
    function get_DocumentAlternate1Font: Fonts_ILanguageFont; safecall;
    function get_DocumentAlternate2Font: Fonts_ILanguageFont; safecall;
    property DocumentAlternate1Font: Fonts_ILanguageFont read get_DocumentAlternate1Font;
    property DocumentAlternate2Font: Fonts_ILanguageFont read get_DocumentAlternate2Font;
    property DocumentHeadingFont: Fonts_ILanguageFont read get_DocumentHeadingFont;
    property FixedWidthTextFont: Fonts_ILanguageFont read get_FixedWidthTextFont;
    property ModernDocumentFont: Fonts_ILanguageFont read get_ModernDocumentFont;
    property TraditionalDocumentFont: Fonts_ILanguageFont read get_TraditionalDocumentFont;
    property UICaptionFont: Fonts_ILanguageFont read get_UICaptionFont;
    property UIHeadingFont: Fonts_ILanguageFont read get_UIHeadingFont;
    property UINotificationHeadingFont: Fonts_ILanguageFont read get_UINotificationHeadingFont;
    property UITextFont: Fonts_ILanguageFont read get_UITextFont;
    property UITitleFont: Fonts_ILanguageFont read get_UITitleFont;
  end;

  // DualAPI Interface
  // Windows.Globalization.Fonts.ILanguageFontGroupFactory
  [WinRTClassNameAttribute(SFonts_LanguageFontGroup)]
  Fonts_ILanguageFontGroupFactory = interface(IInspectable)
  ['{FCAEAC67-4E77-49C7-B856-DDE934FC735B}']
    function CreateLanguageFontGroup(languageTag: HSTRING): Fonts_ILanguageFontGroup; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.ICalendarIdentifiersStatics
  [WinRTClassNameAttribute(SCalendarIdentifiers)]
  ICalendarIdentifiersStatics = interface(IInspectable)
  ['{80653F68-2CB2-4C1F-B590-F0F52BF4FD1A}']
    function get_Gregorian: HSTRING; safecall;
    function get_Hebrew: HSTRING; safecall;
    function get_Hijri: HSTRING; safecall;
    function get_Japanese: HSTRING; safecall;
    function get_Julian: HSTRING; safecall;
    function get_Korean: HSTRING; safecall;
    function get_Taiwan: HSTRING; safecall;
    function get_Thai: HSTRING; safecall;
    function get_UmAlQura: HSTRING; safecall;
    property Gregorian: HSTRING read get_Gregorian;
    property Hebrew: HSTRING read get_Hebrew;
    property Hijri: HSTRING read get_Hijri;
    property Japanese: HSTRING read get_Japanese;
    property Julian: HSTRING read get_Julian;
    property Korean: HSTRING read get_Korean;
    property Taiwan: HSTRING read get_Taiwan;
    property Thai: HSTRING read get_Thai;
    property UmAlQura: HSTRING read get_UmAlQura;
  end;

  // DualAPI Interface
  // Windows.Globalization.ICalendarIdentifiersStatics2
  [WinRTClassNameAttribute(SCalendarIdentifiers)]
  ICalendarIdentifiersStatics2 = interface(IInspectable)
  ['{7DF4D488-5FD0-42A7-95B5-7D98D823075F}']
    function get_Persian: HSTRING; safecall;
    property Persian: HSTRING read get_Persian;
  end;

  // DualAPI Interface
  // Windows.Globalization.IClockIdentifiersStatics
  [WinRTClassNameAttribute(SClockIdentifiers)]
  IClockIdentifiersStatics = interface(IInspectable)
  ['{523805BB-12EC-4F83-BC31-B1B4376B0808}']
    function get_TwelveHour: HSTRING; safecall;
    function get_TwentyFourHour: HSTRING; safecall;
    property TwelveHour: HSTRING read get_TwelveHour;
    property TwentyFourHour: HSTRING read get_TwentyFourHour;
  end;

  // DualAPI Interface
  // Windows.Globalization.INumeralSystemIdentifiersStatics
  [WinRTClassNameAttribute(SNumeralSystemIdentifiers)]
  INumeralSystemIdentifiersStatics = interface(IInspectable)
  ['{A5C662C3-68C9-4D3D-B765-972029E21DEC}']
    function get_Arab: HSTRING; safecall;
    function get_ArabExt: HSTRING; safecall;
    function get_Bali: HSTRING; safecall;
    function get_Beng: HSTRING; safecall;
    function get_Cham: HSTRING; safecall;
    function get_Deva: HSTRING; safecall;
    function get_FullWide: HSTRING; safecall;
    function get_Gujr: HSTRING; safecall;
    function get_Guru: HSTRING; safecall;
    function get_HaniDec: HSTRING; safecall;
    function get_Java: HSTRING; safecall;
    function get_Kali: HSTRING; safecall;
    function get_Khmr: HSTRING; safecall;
    function get_Knda: HSTRING; safecall;
    function get_Lana: HSTRING; safecall;
    function get_LanaTham: HSTRING; safecall;
    function get_Laoo: HSTRING; safecall;
    function get_Latn: HSTRING; safecall;
    function get_Lepc: HSTRING; safecall;
    function get_Limb: HSTRING; safecall;
    function get_Mlym: HSTRING; safecall;
    function get_Mong: HSTRING; safecall;
    function get_Mtei: HSTRING; safecall;
    function get_Mymr: HSTRING; safecall;
    function get_MymrShan: HSTRING; safecall;
    function get_Nkoo: HSTRING; safecall;
    function get_Olck: HSTRING; safecall;
    function get_Orya: HSTRING; safecall;
    function get_Saur: HSTRING; safecall;
    function get_Sund: HSTRING; safecall;
    function get_Talu: HSTRING; safecall;
    function get_TamlDec: HSTRING; safecall;
    function get_Telu: HSTRING; safecall;
    function get_Thai: HSTRING; safecall;
    function get_Tibt: HSTRING; safecall;
    function get_Vaii: HSTRING; safecall;
    property Arab: HSTRING read get_Arab;
    property ArabExt: HSTRING read get_ArabExt;
    property Bali: HSTRING read get_Bali;
    property Beng: HSTRING read get_Beng;
    property Cham: HSTRING read get_Cham;
    property Deva: HSTRING read get_Deva;
    property FullWide: HSTRING read get_FullWide;
    property Gujr: HSTRING read get_Gujr;
    property Guru: HSTRING read get_Guru;
    property HaniDec: HSTRING read get_HaniDec;
    property Java: HSTRING read get_Java;
    property Kali: HSTRING read get_Kali;
    property Khmr: HSTRING read get_Khmr;
    property Knda: HSTRING read get_Knda;
    property Lana: HSTRING read get_Lana;
    property LanaTham: HSTRING read get_LanaTham;
    property Laoo: HSTRING read get_Laoo;
    property Latn: HSTRING read get_Latn;
    property Lepc: HSTRING read get_Lepc;
    property Limb: HSTRING read get_Limb;
    property Mlym: HSTRING read get_Mlym;
    property Mong: HSTRING read get_Mong;
    property Mtei: HSTRING read get_Mtei;
    property Mymr: HSTRING read get_Mymr;
    property MymrShan: HSTRING read get_MymrShan;
    property Nkoo: HSTRING read get_Nkoo;
    property Olck: HSTRING read get_Olck;
    property Orya: HSTRING read get_Orya;
    property Saur: HSTRING read get_Saur;
    property Sund: HSTRING read get_Sund;
    property Talu: HSTRING read get_Talu;
    property TamlDec: HSTRING read get_TamlDec;
    property Telu: HSTRING read get_Telu;
    property Thai: HSTRING read get_Thai;
    property Tibt: HSTRING read get_Tibt;
    property Vaii: HSTRING read get_Vaii;
  end;

  // DualAPI Interface
  // Windows.Globalization.INumeralSystemIdentifiersStatics2
  [WinRTClassNameAttribute(SNumeralSystemIdentifiers)]
  INumeralSystemIdentifiersStatics2 = interface(IInspectable)
  ['{7F003228-9DDB-4A34-9104-0260C091A7C7}']
    function get_Brah: HSTRING; safecall;
    function get_Osma: HSTRING; safecall;
    function get_MathBold: HSTRING; safecall;
    function get_MathDbl: HSTRING; safecall;
    function get_MathSans: HSTRING; safecall;
    function get_MathSanb: HSTRING; safecall;
    function get_MathMono: HSTRING; safecall;
    function get_ZmthBold: HSTRING; safecall;
    function get_ZmthDbl: HSTRING; safecall;
    function get_ZmthSans: HSTRING; safecall;
    function get_ZmthSanb: HSTRING; safecall;
    function get_ZmthMono: HSTRING; safecall;
    property Brah: HSTRING read get_Brah;
    property MathBold: HSTRING read get_MathBold;
    property MathDbl: HSTRING read get_MathDbl;
    property MathMono: HSTRING read get_MathMono;
    property MathSanb: HSTRING read get_MathSanb;
    property MathSans: HSTRING read get_MathSans;
    property Osma: HSTRING read get_Osma;
    property ZmthBold: HSTRING read get_ZmthBold;
    property ZmthDbl: HSTRING read get_ZmthDbl;
    property ZmthMono: HSTRING read get_ZmthMono;
    property ZmthSanb: HSTRING read get_ZmthSanb;
    property ZmthSans: HSTRING read get_ZmthSans;
  end;

  // DualAPI Interface
  // Windows.Globalization.ICurrencyIdentifiersStatics
  [WinRTClassNameAttribute(SCurrencyIdentifiers)]
  ICurrencyIdentifiersStatics = interface(IInspectable)
  ['{9F1D091B-D586-4913-9B6A-A9BD2DC12874}']
    function get_AED: HSTRING; safecall;
    function get_AFN: HSTRING; safecall;
    function get_ALL: HSTRING; safecall;
    function get_AMD: HSTRING; safecall;
    function get_ANG: HSTRING; safecall;
    function get_AOA: HSTRING; safecall;
    function get_ARS: HSTRING; safecall;
    function get_AUD: HSTRING; safecall;
    function get_AWG: HSTRING; safecall;
    function get_AZN: HSTRING; safecall;
    function get_BAM: HSTRING; safecall;
    function get_BBD: HSTRING; safecall;
    function get_BDT: HSTRING; safecall;
    function get_BGN: HSTRING; safecall;
    function get_BHD: HSTRING; safecall;
    function get_BIF: HSTRING; safecall;
    function get_BMD: HSTRING; safecall;
    function get_BND: HSTRING; safecall;
    function get_BOB: HSTRING; safecall;
    function get_BRL: HSTRING; safecall;
    function get_BSD: HSTRING; safecall;
    function get_BTN: HSTRING; safecall;
    function get_BWP: HSTRING; safecall;
    function get_BYR: HSTRING; safecall;
    function get_BZD: HSTRING; safecall;
    function get_CAD: HSTRING; safecall;
    function get_CDF: HSTRING; safecall;
    function get_CHF: HSTRING; safecall;
    function get_CLP: HSTRING; safecall;
    function get_CNY: HSTRING; safecall;
    function get_COP: HSTRING; safecall;
    function get_CRC: HSTRING; safecall;
    function get_CUP: HSTRING; safecall;
    function get_CVE: HSTRING; safecall;
    function get_CZK: HSTRING; safecall;
    function get_DJF: HSTRING; safecall;
    function get_DKK: HSTRING; safecall;
    function get_DOP: HSTRING; safecall;
    function get_DZD: HSTRING; safecall;
    function get_EGP: HSTRING; safecall;
    function get_ERN: HSTRING; safecall;
    function get_ETB: HSTRING; safecall;
    function get_EUR: HSTRING; safecall;
    function get_FJD: HSTRING; safecall;
    function get_FKP: HSTRING; safecall;
    function get_GBP: HSTRING; safecall;
    function get_GEL: HSTRING; safecall;
    function get_GHS: HSTRING; safecall;
    function get_GIP: HSTRING; safecall;
    function get_GMD: HSTRING; safecall;
    function get_GNF: HSTRING; safecall;
    function get_GTQ: HSTRING; safecall;
    function get_GYD: HSTRING; safecall;
    function get_HKD: HSTRING; safecall;
    function get_HNL: HSTRING; safecall;
    function get_HRK: HSTRING; safecall;
    function get_HTG: HSTRING; safecall;
    function get_HUF: HSTRING; safecall;
    function get_IDR: HSTRING; safecall;
    function get_ILS: HSTRING; safecall;
    function get_INR: HSTRING; safecall;
    function get_IQD: HSTRING; safecall;
    function get_IRR: HSTRING; safecall;
    function get_ISK: HSTRING; safecall;
    function get_JMD: HSTRING; safecall;
    function get_JOD: HSTRING; safecall;
    function get_JPY: HSTRING; safecall;
    function get_KES: HSTRING; safecall;
    function get_KGS: HSTRING; safecall;
    function get_KHR: HSTRING; safecall;
    function get_KMF: HSTRING; safecall;
    function get_KPW: HSTRING; safecall;
    function get_KRW: HSTRING; safecall;
    function get_KWD: HSTRING; safecall;
    function get_KYD: HSTRING; safecall;
    function get_KZT: HSTRING; safecall;
    function get_LAK: HSTRING; safecall;
    function get_LBP: HSTRING; safecall;
    function get_LKR: HSTRING; safecall;
    function get_LRD: HSTRING; safecall;
    function get_LSL: HSTRING; safecall;
    function get_LTL: HSTRING; safecall;
    function get_LVL: HSTRING; safecall;
    function get_LYD: HSTRING; safecall;
    function get_MAD: HSTRING; safecall;
    function get_MDL: HSTRING; safecall;
    function get_MGA: HSTRING; safecall;
    function get_MKD: HSTRING; safecall;
    function get_MMK: HSTRING; safecall;
    function get_MNT: HSTRING; safecall;
    function get_MOP: HSTRING; safecall;
    function get_MRO: HSTRING; safecall;
    function get_MUR: HSTRING; safecall;
    function get_MVR: HSTRING; safecall;
    function get_MWK: HSTRING; safecall;
    function get_MXN: HSTRING; safecall;
    function get_MYR: HSTRING; safecall;
    function get_MZN: HSTRING; safecall;
    function get_NAD: HSTRING; safecall;
    function get_NGN: HSTRING; safecall;
    function get_NIO: HSTRING; safecall;
    function get_NOK: HSTRING; safecall;
    function get_NPR: HSTRING; safecall;
    function get_NZD: HSTRING; safecall;
    function get_OMR: HSTRING; safecall;
    function get_PAB: HSTRING; safecall;
    function get_PEN: HSTRING; safecall;
    function get_PGK: HSTRING; safecall;
    function get_PHP: HSTRING; safecall;
    function get_PKR: HSTRING; safecall;
    function get_PLN: HSTRING; safecall;
    function get_PYG: HSTRING; safecall;
    function get_QAR: HSTRING; safecall;
    function get_RON: HSTRING; safecall;
    function get_RSD: HSTRING; safecall;
    function get_RUB: HSTRING; safecall;
    function get_RWF: HSTRING; safecall;
    function get_SAR: HSTRING; safecall;
    function get_SBD: HSTRING; safecall;
    function get_SCR: HSTRING; safecall;
    function get_SDG: HSTRING; safecall;
    function get_SEK: HSTRING; safecall;
    function get_SGD: HSTRING; safecall;
    function get_SHP: HSTRING; safecall;
    function get_SLL: HSTRING; safecall;
    function get_SOS: HSTRING; safecall;
    function get_SRD: HSTRING; safecall;
    function get_STD: HSTRING; safecall;
    function get_SYP: HSTRING; safecall;
    function get_SZL: HSTRING; safecall;
    function get_THB: HSTRING; safecall;
    function get_TJS: HSTRING; safecall;
    function get_TMT: HSTRING; safecall;
    function get_TND: HSTRING; safecall;
    function get_TOP: HSTRING; safecall;
    function get_TRY: HSTRING; safecall;
    function get_TTD: HSTRING; safecall;
    function get_TWD: HSTRING; safecall;
    function get_TZS: HSTRING; safecall;
    function get_UAH: HSTRING; safecall;
    function get_UGX: HSTRING; safecall;
    function get_USD: HSTRING; safecall;
    function get_UYU: HSTRING; safecall;
    function get_UZS: HSTRING; safecall;
    function get_VEF: HSTRING; safecall;
    function get_VND: HSTRING; safecall;
    function get_VUV: HSTRING; safecall;
    function get_WST: HSTRING; safecall;
    function get_XAF: HSTRING; safecall;
    function get_XCD: HSTRING; safecall;
    function get_XOF: HSTRING; safecall;
    function get_XPF: HSTRING; safecall;
    function get_XXX: HSTRING; safecall;
    function get_YER: HSTRING; safecall;
    function get_ZAR: HSTRING; safecall;
    function get_ZMW: HSTRING; safecall;
    function get_ZWL: HSTRING; safecall;
    property AED: HSTRING read get_AED;
    property AFN: HSTRING read get_AFN;
    property ALL: HSTRING read get_ALL;
    property AMD: HSTRING read get_AMD;
    property ANG: HSTRING read get_ANG;
    property AOA: HSTRING read get_AOA;
    property ARS: HSTRING read get_ARS;
    property AUD: HSTRING read get_AUD;
    property AWG: HSTRING read get_AWG;
    property AZN: HSTRING read get_AZN;
    property BAM: HSTRING read get_BAM;
    property BBD: HSTRING read get_BBD;
    property BDT: HSTRING read get_BDT;
    property BGN: HSTRING read get_BGN;
    property BHD: HSTRING read get_BHD;
    property BIF: HSTRING read get_BIF;
    property BMD: HSTRING read get_BMD;
    property BND: HSTRING read get_BND;
    property BOB: HSTRING read get_BOB;
    property BRL: HSTRING read get_BRL;
    property BSD: HSTRING read get_BSD;
    property BTN: HSTRING read get_BTN;
    property BWP: HSTRING read get_BWP;
    property BYR: HSTRING read get_BYR;
    property BZD: HSTRING read get_BZD;
    property CAD: HSTRING read get_CAD;
    property CDF: HSTRING read get_CDF;
    property CHF: HSTRING read get_CHF;
    property CLP: HSTRING read get_CLP;
    property CNY: HSTRING read get_CNY;
    property COP: HSTRING read get_COP;
    property CRC: HSTRING read get_CRC;
    property CUP: HSTRING read get_CUP;
    property CVE: HSTRING read get_CVE;
    property CZK: HSTRING read get_CZK;
    property DJF: HSTRING read get_DJF;
    property DKK: HSTRING read get_DKK;
    property DOP: HSTRING read get_DOP;
    property DZD: HSTRING read get_DZD;
    property EGP: HSTRING read get_EGP;
    property ERN: HSTRING read get_ERN;
    property ETB: HSTRING read get_ETB;
    property EUR: HSTRING read get_EUR;
    property FJD: HSTRING read get_FJD;
    property FKP: HSTRING read get_FKP;
    property GBP: HSTRING read get_GBP;
    property GEL: HSTRING read get_GEL;
    property GHS: HSTRING read get_GHS;
    property GIP: HSTRING read get_GIP;
    property GMD: HSTRING read get_GMD;
    property GNF: HSTRING read get_GNF;
    property GTQ: HSTRING read get_GTQ;
    property GYD: HSTRING read get_GYD;
    property HKD: HSTRING read get_HKD;
    property HNL: HSTRING read get_HNL;
    property HRK: HSTRING read get_HRK;
    property HTG: HSTRING read get_HTG;
    property HUF: HSTRING read get_HUF;
    property IDR: HSTRING read get_IDR;
    property ILS: HSTRING read get_ILS;
    property INR: HSTRING read get_INR;
    property IQD: HSTRING read get_IQD;
    property IRR: HSTRING read get_IRR;
    property ISK: HSTRING read get_ISK;
    property JMD: HSTRING read get_JMD;
    property JOD: HSTRING read get_JOD;
    property JPY: HSTRING read get_JPY;
    property KES: HSTRING read get_KES;
    property KGS: HSTRING read get_KGS;
    property KHR: HSTRING read get_KHR;
    property KMF: HSTRING read get_KMF;
    property KPW: HSTRING read get_KPW;
    property KRW: HSTRING read get_KRW;
    property KWD: HSTRING read get_KWD;
    property KYD: HSTRING read get_KYD;
    property KZT: HSTRING read get_KZT;
    property LAK: HSTRING read get_LAK;
    property LBP: HSTRING read get_LBP;
    property LKR: HSTRING read get_LKR;
    property LRD: HSTRING read get_LRD;
    property LSL: HSTRING read get_LSL;
    property LTL: HSTRING read get_LTL;
    property LVL: HSTRING read get_LVL;
    property LYD: HSTRING read get_LYD;
    property MAD: HSTRING read get_MAD;
    property MDL: HSTRING read get_MDL;
    property MGA: HSTRING read get_MGA;
    property MKD: HSTRING read get_MKD;
    property MMK: HSTRING read get_MMK;
    property MNT: HSTRING read get_MNT;
    property MOP: HSTRING read get_MOP;
    property MRO: HSTRING read get_MRO;
    property MUR: HSTRING read get_MUR;
    property MVR: HSTRING read get_MVR;
    property MWK: HSTRING read get_MWK;
    property MXN: HSTRING read get_MXN;
    property MYR: HSTRING read get_MYR;
    property MZN: HSTRING read get_MZN;
    property NAD: HSTRING read get_NAD;
    property NGN: HSTRING read get_NGN;
    property NIO: HSTRING read get_NIO;
    property NOK: HSTRING read get_NOK;
    property NPR: HSTRING read get_NPR;
    property NZD: HSTRING read get_NZD;
    property OMR: HSTRING read get_OMR;
    property PAB: HSTRING read get_PAB;
    property PEN: HSTRING read get_PEN;
    property PGK: HSTRING read get_PGK;
    property PHP: HSTRING read get_PHP;
    property PKR: HSTRING read get_PKR;
    property PLN: HSTRING read get_PLN;
    property PYG: HSTRING read get_PYG;
    property QAR: HSTRING read get_QAR;
    property RON: HSTRING read get_RON;
    property RSD: HSTRING read get_RSD;
    property RUB: HSTRING read get_RUB;
    property RWF: HSTRING read get_RWF;
    property SAR: HSTRING read get_SAR;
    property SBD: HSTRING read get_SBD;
    property SCR: HSTRING read get_SCR;
    property SDG: HSTRING read get_SDG;
    property SEK: HSTRING read get_SEK;
    property SGD: HSTRING read get_SGD;
    property SHP: HSTRING read get_SHP;
    property SLL: HSTRING read get_SLL;
    property SOS: HSTRING read get_SOS;
    property SRD: HSTRING read get_SRD;
    property STD: HSTRING read get_STD;
    property SYP: HSTRING read get_SYP;
    property SZL: HSTRING read get_SZL;
    property THB: HSTRING read get_THB;
    property TJS: HSTRING read get_TJS;
    property TMT: HSTRING read get_TMT;
    property TND: HSTRING read get_TND;
    property TOP: HSTRING read get_TOP;
    property &TRY: HSTRING read get_TRY;
    property TTD: HSTRING read get_TTD;
    property TWD: HSTRING read get_TWD;
    property TZS: HSTRING read get_TZS;
    property UAH: HSTRING read get_UAH;
    property UGX: HSTRING read get_UGX;
    property USD: HSTRING read get_USD;
    property UYU: HSTRING read get_UYU;
    property UZS: HSTRING read get_UZS;
    property VEF: HSTRING read get_VEF;
    property VND: HSTRING read get_VND;
    property VUV: HSTRING read get_VUV;
    property WST: HSTRING read get_WST;
    property XAF: HSTRING read get_XAF;
    property XCD: HSTRING read get_XCD;
    property XOF: HSTRING read get_XOF;
    property XPF: HSTRING read get_XPF;
    property XXX: HSTRING read get_XXX;
    property YER: HSTRING read get_YER;
    property ZAR: HSTRING read get_ZAR;
    property ZMW: HSTRING read get_ZMW;
    property ZWL: HSTRING read get_ZWL;
  end;

  // DualAPI Interface
  // Windows.Globalization.IGeographicRegion
  [WinRTClassNameAttribute(SGeographicRegion)]
  IGeographicRegion = interface(IInspectable)
  ['{01E9A621-4A64-4ED9-954F-9EDEB07BD903}']
    function get_Code: HSTRING; safecall;
    function get_CodeTwoLetter: HSTRING; safecall;
    function get_CodeThreeLetter: HSTRING; safecall;
    function get_CodeThreeDigit: HSTRING; safecall;
    function get_DisplayName: HSTRING; safecall;
    function get_NativeName: HSTRING; safecall;
    function get_CurrenciesInUse: IVectorView_1__HSTRING; safecall;
    property Code: HSTRING read get_Code;
    property CodeThreeDigit: HSTRING read get_CodeThreeDigit;
    property CodeThreeLetter: HSTRING read get_CodeThreeLetter;
    property CodeTwoLetter: HSTRING read get_CodeTwoLetter;
    property CurrenciesInUse: IVectorView_1__HSTRING read get_CurrenciesInUse;
    property DisplayName: HSTRING read get_DisplayName;
    property NativeName: HSTRING read get_NativeName;
  end;

  // DualAPI Interface
  // Windows.Globalization.IGeographicRegionFactory
  [WinRTClassNameAttribute(SGeographicRegion)]
  IGeographicRegionFactory = interface(IInspectable)
  ['{53425270-77B4-426B-859F-81E19D512546}']
    function CreateGeographicRegion(geographicRegionCode: HSTRING): IGeographicRegion; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.IGeographicRegionStatics
  [WinRTClassNameAttribute(SGeographicRegion)]
  IGeographicRegionStatics = interface(IInspectable)
  ['{29E28974-7AD9-4EF4-8799-B3B44FADEC08}']
    function IsSupported(geographicRegionCode: HSTRING): Boolean; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.ILanguageExtensionSubtags
  ILanguageExtensionSubtags = interface(IInspectable)
  ['{7D7DAF45-368D-4364-852B-DEC927037B85}']
    function GetExtensionSubtags(singleton: HSTRING): IVectorView_1__HSTRING; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.ILanguageFactory
  [WinRTClassNameAttribute(SLanguage)]
  ILanguageFactory = interface(IInspectable)
  ['{9B0252AC-0C27-44F8-B792-9793FB66C63E}']
    function CreateLanguage(languageTag: HSTRING): ILanguage; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.ILanguageStatics
  [WinRTClassNameAttribute(SLanguage)]
  ILanguageStatics = interface(IInspectable)
  ['{B23CD557-0865-46D4-89B8-D59BE8990F0D}']
    function IsWellFormed(languageTag: HSTRING): Boolean; safecall;
    function get_CurrentInputMethodLanguageTag: HSTRING; safecall;
    property CurrentInputMethodLanguageTag: HSTRING read get_CurrentInputMethodLanguageTag;
  end;

  // DualAPI Interface
  // Windows.Globalization.ILanguageStatics2
  [WinRTClassNameAttribute(SLanguage)]
  ILanguageStatics2 = interface(IInspectable)
  ['{30199F6E-914B-4B2A-9D6E-E3B0E27DBE4F}']
    function TrySetInputMethodLanguageTag(languageTag: HSTRING): Boolean; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.DateTimeFormatting.IDateTimeFormatter
  [WinRTClassNameAttribute(SDateTimeFormatting_DateTimeFormatter)]
  DateTimeFormatting_IDateTimeFormatter = interface(IInspectable)
  ['{95EECA10-73E0-4E4B-A183-3D6AD0BA35EC}']
    function get_Languages: IVectorView_1__HSTRING; safecall;
    function get_GeographicRegion: HSTRING; safecall;
    function get_Calendar: HSTRING; safecall;
    function get_Clock: HSTRING; safecall;
    function get_NumeralSystem: HSTRING; safecall;
    procedure put_NumeralSystem(value: HSTRING); safecall;
    function get_Patterns: IVectorView_1__HSTRING; safecall;
    function get_Template: HSTRING; safecall;
    function Format(value: DateTime): HSTRING; safecall;
    function get_IncludeYear: DateTimeFormatting_YearFormat; safecall;
    function get_IncludeMonth: DateTimeFormatting_MonthFormat; safecall;
    function get_IncludeDayOfWeek: DateTimeFormatting_DayOfWeekFormat; safecall;
    function get_IncludeDay: DateTimeFormatting_DayFormat; safecall;
    function get_IncludeHour: DateTimeFormatting_HourFormat; safecall;
    function get_IncludeMinute: DateTimeFormatting_MinuteFormat; safecall;
    function get_IncludeSecond: DateTimeFormatting_SecondFormat; safecall;
    function get_ResolvedLanguage: HSTRING; safecall;
    function get_ResolvedGeographicRegion: HSTRING; safecall;
    property Calendar: HSTRING read get_Calendar;
    property Clock: HSTRING read get_Clock;
    property GeographicRegion: HSTRING read get_GeographicRegion;
    property IncludeDay: DateTimeFormatting_DayFormat read get_IncludeDay;
    property IncludeDayOfWeek: DateTimeFormatting_DayOfWeekFormat read get_IncludeDayOfWeek;
    property IncludeHour: DateTimeFormatting_HourFormat read get_IncludeHour;
    property IncludeMinute: DateTimeFormatting_MinuteFormat read get_IncludeMinute;
    property IncludeMonth: DateTimeFormatting_MonthFormat read get_IncludeMonth;
    property IncludeSecond: DateTimeFormatting_SecondFormat read get_IncludeSecond;
    property IncludeYear: DateTimeFormatting_YearFormat read get_IncludeYear;
    property Languages: IVectorView_1__HSTRING read get_Languages;
    property NumeralSystem: HSTRING read get_NumeralSystem write put_NumeralSystem;
    property Patterns: IVectorView_1__HSTRING read get_Patterns;
    property ResolvedGeographicRegion: HSTRING read get_ResolvedGeographicRegion;
    property ResolvedLanguage: HSTRING read get_ResolvedLanguage;
    property Template: HSTRING read get_Template;
  end;

  // DualAPI Interface
  // Windows.Globalization.DateTimeFormatting.IDateTimeFormatterFactory
  [WinRTClassNameAttribute(SDateTimeFormatting_DateTimeFormatter)]
  DateTimeFormatting_IDateTimeFormatterFactory = interface(IInspectable)
  ['{EC8D8A53-1A2E-412D-8815-3B745FB1A2A0}']
    function CreateDateTimeFormatter(formatTemplate: HSTRING): DateTimeFormatting_IDateTimeFormatter; safecall;
    function CreateDateTimeFormatterLanguages(formatTemplate: HSTRING; languages: IIterable_1__HSTRING): DateTimeFormatting_IDateTimeFormatter; safecall;
    function CreateDateTimeFormatterContext(formatTemplate: HSTRING; languages: IIterable_1__HSTRING; geographicRegion: HSTRING; calendar: HSTRING; clock: HSTRING): DateTimeFormatting_IDateTimeFormatter; safecall;
    function CreateDateTimeFormatterDate(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat): DateTimeFormatting_IDateTimeFormatter; safecall;
    function CreateDateTimeFormatterTime(hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat): DateTimeFormatting_IDateTimeFormatter; safecall;
    function CreateDateTimeFormatterDateTimeLanguages(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat; hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat; languages: IIterable_1__HSTRING): DateTimeFormatting_IDateTimeFormatter; safecall;
    function CreateDateTimeFormatterDateTimeContext(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat; hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat; languages: IIterable_1__HSTRING; geographicRegion: HSTRING; calendar: HSTRING; clock: HSTRING): DateTimeFormatting_IDateTimeFormatter; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.DateTimeFormatting.IDateTimeFormatterStatics
  [WinRTClassNameAttribute(SDateTimeFormatting_DateTimeFormatter)]
  DateTimeFormatting_IDateTimeFormatterStatics = interface(IInspectable)
  ['{BFCDE7C0-DF4C-4A2E-9012-F47DAF3F1212}']
    function get_LongDate: DateTimeFormatting_IDateTimeFormatter; safecall;
    function get_LongTime: DateTimeFormatting_IDateTimeFormatter; safecall;
    function get_ShortDate: DateTimeFormatting_IDateTimeFormatter; safecall;
    function get_ShortTime: DateTimeFormatting_IDateTimeFormatter; safecall;
    property LongDate: DateTimeFormatting_IDateTimeFormatter read get_LongDate;
    property LongTime: DateTimeFormatting_IDateTimeFormatter read get_LongTime;
    property ShortDate: DateTimeFormatting_IDateTimeFormatter read get_ShortDate;
    property ShortTime: DateTimeFormatting_IDateTimeFormatter read get_ShortTime;
  end;

  // DualAPI Interface
  // Windows.Globalization.DateTimeFormatting.IDateTimeFormatter2
  DateTimeFormatting_IDateTimeFormatter2 = interface(IInspectable)
  ['{27C91A86-BDAA-4FD0-9E36-671D5AA5EE03}']
    function Format(datetime: DateTime; timeZoneId: HSTRING): HSTRING; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.ICalendar
  [WinRTClassNameAttribute(SCalendar)]
  ICalendar = interface(IInspectable)
  ['{CA30221D-86D9-40FB-A26B-D44EB7CF08EA}']
    function Clone: ICalendar; safecall;
    procedure SetToMin; safecall;
    procedure SetToMax; safecall;
    function get_Languages: IVectorView_1__HSTRING; safecall;
    function get_NumeralSystem: HSTRING; safecall;
    procedure put_NumeralSystem(value: HSTRING); safecall;
    function GetCalendarSystem: HSTRING; safecall;
    procedure ChangeCalendarSystem(value: HSTRING); safecall;
    function GetClock: HSTRING; safecall;
    procedure ChangeClock(value: HSTRING); safecall;
    function GetDateTime: DateTime; safecall;
    procedure SetDateTime(value: DateTime); safecall;
    procedure SetToNow; safecall;
    function get_FirstEra: Integer; safecall;
    function get_LastEra: Integer; safecall;
    function get_NumberOfEras: Integer; safecall;
    function get_Era: Integer; safecall;
    procedure put_Era(value: Integer); safecall;
    procedure AddEras(eras: Integer); safecall;
    function EraAsString: HSTRING; overload; safecall;
    function EraAsString(idealLength: Integer): HSTRING; overload; safecall;
    function get_FirstYearInThisEra: Integer; safecall;
    function get_LastYearInThisEra: Integer; safecall;
    function get_NumberOfYearsInThisEra: Integer; safecall;
    function get_Year: Integer; safecall;
    procedure put_Year(value: Integer); safecall;
    procedure AddYears(years: Integer); safecall;
    function YearAsString: HSTRING; safecall;
    function YearAsTruncatedString(remainingDigits: Integer): HSTRING; safecall;
    function YearAsPaddedString(minDigits: Integer): HSTRING; safecall;
    function get_FirstMonthInThisYear: Integer; safecall;
    function get_LastMonthInThisYear: Integer; safecall;
    function get_NumberOfMonthsInThisYear: Integer; safecall;
    function get_Month: Integer; safecall;
    procedure put_Month(value: Integer); safecall;
    procedure AddMonths(months: Integer); safecall;
    function MonthAsString: HSTRING; overload; safecall;
    function MonthAsString(idealLength: Integer): HSTRING; overload; safecall;
    function MonthAsSoloString: HSTRING; overload; safecall;
    function MonthAsSoloString(idealLength: Integer): HSTRING; overload; safecall;
    function MonthAsNumericString: HSTRING; safecall;
    function MonthAsPaddedNumericString(minDigits: Integer): HSTRING; safecall;
    procedure AddWeeks(weeks: Integer); safecall;
    function get_FirstDayInThisMonth: Integer; safecall;
    function get_LastDayInThisMonth: Integer; safecall;
    function get_NumberOfDaysInThisMonth: Integer; safecall;
    function get_Day: Integer; safecall;
    procedure put_Day(value: Integer); safecall;
    procedure AddDays(days: Integer); safecall;
    function DayAsString: HSTRING; safecall;
    function DayAsPaddedString(minDigits: Integer): HSTRING; safecall;
    function get_DayOfWeek: DayOfWeek; safecall;
    function DayOfWeekAsString: HSTRING; overload; safecall;
    function DayOfWeekAsString(idealLength: Integer): HSTRING; overload; safecall;
    function DayOfWeekAsSoloString: HSTRING; overload; safecall;
    function DayOfWeekAsSoloString(idealLength: Integer): HSTRING; overload; safecall;
    function get_FirstPeriodInThisDay: Integer; safecall;
    function get_LastPeriodInThisDay: Integer; safecall;
    function get_NumberOfPeriodsInThisDay: Integer; safecall;
    function get_Period: Integer; safecall;
    procedure put_Period(value: Integer); safecall;
    procedure AddPeriods(periods: Integer); safecall;
    function PeriodAsString: HSTRING; overload; safecall;
    function PeriodAsString(idealLength: Integer): HSTRING; overload; safecall;
    function get_FirstHourInThisPeriod: Integer; safecall;
    function get_LastHourInThisPeriod: Integer; safecall;
    function get_NumberOfHoursInThisPeriod: Integer; safecall;
    function get_Hour: Integer; safecall;
    procedure put_Hour(value: Integer); safecall;
    procedure AddHours(hours: Integer); safecall;
    function HourAsString: HSTRING; safecall;
    function HourAsPaddedString(minDigits: Integer): HSTRING; safecall;
    function get_Minute: Integer; safecall;
    procedure put_Minute(value: Integer); safecall;
    procedure AddMinutes(minutes: Integer); safecall;
    function MinuteAsString: HSTRING; safecall;
    function MinuteAsPaddedString(minDigits: Integer): HSTRING; safecall;
    function get_Second: Integer; safecall;
    procedure put_Second(value: Integer); safecall;
    procedure AddSeconds(seconds: Integer); safecall;
    function SecondAsString: HSTRING; safecall;
    function SecondAsPaddedString(minDigits: Integer): HSTRING; safecall;
    function get_Nanosecond: Integer; safecall;
    procedure put_Nanosecond(value: Integer); safecall;
    procedure AddNanoseconds(nanoseconds: Integer); safecall;
    function NanosecondAsString: HSTRING; safecall;
    function NanosecondAsPaddedString(minDigits: Integer): HSTRING; safecall;
    function Compare(other: ICalendar): Integer; safecall;
    function CompareDateTime(other: DateTime): Integer; safecall;
    procedure CopyTo(other: ICalendar); safecall;
    function get_FirstMinuteInThisHour: Integer; safecall;
    function get_LastMinuteInThisHour: Integer; safecall;
    function get_NumberOfMinutesInThisHour: Integer; safecall;
    function get_FirstSecondInThisMinute: Integer; safecall;
    function get_LastSecondInThisMinute: Integer; safecall;
    function get_NumberOfSecondsInThisMinute: Integer; safecall;
    function get_ResolvedLanguage: HSTRING; safecall;
    function get_IsDaylightSavingTime: Boolean; safecall;
    property Day: Integer read get_Day write put_Day;
    property DayOfWeek: DayOfWeek read get_DayOfWeek;
    property Era: Integer read get_Era write put_Era;
    property FirstDayInThisMonth: Integer read get_FirstDayInThisMonth;
    property FirstEra: Integer read get_FirstEra;
    property FirstHourInThisPeriod: Integer read get_FirstHourInThisPeriod;
    property FirstMinuteInThisHour: Integer read get_FirstMinuteInThisHour;
    property FirstMonthInThisYear: Integer read get_FirstMonthInThisYear;
    property FirstPeriodInThisDay: Integer read get_FirstPeriodInThisDay;
    property FirstSecondInThisMinute: Integer read get_FirstSecondInThisMinute;
    property FirstYearInThisEra: Integer read get_FirstYearInThisEra;
    property Hour: Integer read get_Hour write put_Hour;
    property IsDaylightSavingTime: Boolean read get_IsDaylightSavingTime;
    property Languages: IVectorView_1__HSTRING read get_Languages;
    property LastDayInThisMonth: Integer read get_LastDayInThisMonth;
    property LastEra: Integer read get_LastEra;
    property LastHourInThisPeriod: Integer read get_LastHourInThisPeriod;
    property LastMinuteInThisHour: Integer read get_LastMinuteInThisHour;
    property LastMonthInThisYear: Integer read get_LastMonthInThisYear;
    property LastPeriodInThisDay: Integer read get_LastPeriodInThisDay;
    property LastSecondInThisMinute: Integer read get_LastSecondInThisMinute;
    property LastYearInThisEra: Integer read get_LastYearInThisEra;
    property Minute: Integer read get_Minute write put_Minute;
    property Month: Integer read get_Month write put_Month;
    property Nanosecond: Integer read get_Nanosecond write put_Nanosecond;
    property NumberOfDaysInThisMonth: Integer read get_NumberOfDaysInThisMonth;
    property NumberOfEras: Integer read get_NumberOfEras;
    property NumberOfHoursInThisPeriod: Integer read get_NumberOfHoursInThisPeriod;
    property NumberOfMinutesInThisHour: Integer read get_NumberOfMinutesInThisHour;
    property NumberOfMonthsInThisYear: Integer read get_NumberOfMonthsInThisYear;
    property NumberOfPeriodsInThisDay: Integer read get_NumberOfPeriodsInThisDay;
    property NumberOfSecondsInThisMinute: Integer read get_NumberOfSecondsInThisMinute;
    property NumberOfYearsInThisEra: Integer read get_NumberOfYearsInThisEra;
    property NumeralSystem: HSTRING read get_NumeralSystem write put_NumeralSystem;
    property Period: Integer read get_Period write put_Period;
    property ResolvedLanguage: HSTRING read get_ResolvedLanguage;
    property Second: Integer read get_Second write put_Second;
    property Year: Integer read get_Year write put_Year;
  end;

  // DualAPI Interface
  // Windows.Globalization.ICalendarFactory2
  [WinRTClassNameAttribute(SCalendar)]
  ICalendarFactory2 = interface(IInspectable)
  ['{B44B378C-CA7E-4590-9E72-EA2BEC1A5115}']
    function CreateCalendarWithTimeZone(languages: IIterable_1__HSTRING; calendar: HSTRING; clock: HSTRING; timeZoneId: HSTRING): ICalendar; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.ITimeZoneOnCalendar
  ITimeZoneOnCalendar = interface(IInspectable)
  ['{BB3C25E5-46CF-4317-A3F5-02621AD54478}']
    function GetTimeZone: HSTRING; safecall;
    procedure ChangeTimeZone(timeZoneId: HSTRING); safecall;
    function TimeZoneAsString: HSTRING; overload; safecall;
    function TimeZoneAsString(idealLength: Integer): HSTRING; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.ICalendarFactory
  [WinRTClassNameAttribute(SCalendar)]
  ICalendarFactory = interface(IInspectable)
  ['{83F58412-E56B-4C75-A66E-0F63D57758A6}']
    function CreateCalendarDefaultCalendarAndClock(languages: IIterable_1__HSTRING): ICalendar; safecall;
    function CreateCalendar(languages: IIterable_1__HSTRING; calendar: HSTRING; clock: HSTRING): ICalendar; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.INumberRounder
  NumberFormatting_INumberRounder = interface(IInspectable)
  ['{5473C375-38ED-4631-B80C-EF34FC48B7F5}']
    function RoundInt32(value: Integer): Integer; safecall;
    function RoundUInt32(value: Cardinal): Cardinal; safecall;
    function RoundInt64(value: Int64): Int64; safecall;
    function RoundUInt64(value: UInt64): UInt64; safecall;
    function RoundSingle(value: Single): Single; safecall;
    function RoundDouble(value: Double): Double; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.ISignificantDigitsNumberRounder
  [WinRTClassNameAttribute(SNumberFormatting_SignificantDigitsNumberRounder)]
  NumberFormatting_ISignificantDigitsNumberRounder = interface(IInspectable)
  ['{F5941BCA-6646-4913-8C76-1B191FF94DFD}']
    function get_RoundingAlgorithm: NumberFormatting_RoundingAlgorithm; safecall;
    procedure put_RoundingAlgorithm(value: NumberFormatting_RoundingAlgorithm); safecall;
    function get_SignificantDigits: Cardinal; safecall;
    procedure put_SignificantDigits(value: Cardinal); safecall;
    property RoundingAlgorithm: NumberFormatting_RoundingAlgorithm read get_RoundingAlgorithm write put_RoundingAlgorithm;
    property SignificantDigits: Cardinal read get_SignificantDigits write put_SignificantDigits;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.IIncrementNumberRounder
  [WinRTClassNameAttribute(SNumberFormatting_IncrementNumberRounder)]
  NumberFormatting_IIncrementNumberRounder = interface(IInspectable)
  ['{70A64FF8-66AB-4155-9DA1-739E46764543}']
    function get_RoundingAlgorithm: NumberFormatting_RoundingAlgorithm; safecall;
    procedure put_RoundingAlgorithm(value: NumberFormatting_RoundingAlgorithm); safecall;
    function get_Increment: Double; safecall;
    procedure put_Increment(value: Double); safecall;
    property Increment: Double read get_Increment write put_Increment;
    property RoundingAlgorithm: NumberFormatting_RoundingAlgorithm read get_RoundingAlgorithm write put_RoundingAlgorithm;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.INumberFormatter
  NumberFormatting_INumberFormatter = interface(IInspectable)
  ['{A5007C49-7676-4DB7-8631-1B6FF265CAA9}']
    function Format(value: Int64): HSTRING; overload; safecall;
    function Format(value: UInt64): HSTRING; overload; safecall;
    function Format(value: Double): HSTRING; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.INumberFormatter2
  NumberFormatting_INumberFormatter2 = interface(IInspectable)
  ['{D4A8C1F0-80D0-4B0D-A89E-882C1E8F8310}']
    function FormatInt(value: Int64): HSTRING; safecall;
    function FormatUInt(value: UInt64): HSTRING; safecall;
    function FormatDouble(value: Double): HSTRING; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.INumberParser
  NumberFormatting_INumberParser = interface(IInspectable)
  ['{E6659412-4A13-4A53-83A1-392FBE4CFF9F}']
    function ParseInt(text: HSTRING): IReference_1__Int64; safecall;
    function ParseUInt(text: HSTRING): IReference_1__UInt64; safecall;
    function ParseDouble(text: HSTRING): IReference_1__Double; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.INumberFormatterOptions
  [WinRTClassNameAttribute(SNumberFormatting_PermilleFormatter)]
  NumberFormatting_INumberFormatterOptions = interface(IInspectable)
  ['{80332D21-AEE1-4A39-BAA2-07ED8C96DAF6}']
    function get_Languages: IVectorView_1__HSTRING; safecall;
    function get_GeographicRegion: HSTRING; safecall;
    function get_IntegerDigits: Integer; safecall;
    procedure put_IntegerDigits(value: Integer); safecall;
    function get_FractionDigits: Integer; safecall;
    procedure put_FractionDigits(value: Integer); safecall;
    function get_IsGrouped: Boolean; safecall;
    procedure put_IsGrouped(value: Boolean); safecall;
    function get_IsDecimalPointAlwaysDisplayed: Boolean; safecall;
    procedure put_IsDecimalPointAlwaysDisplayed(value: Boolean); safecall;
    function get_NumeralSystem: HSTRING; safecall;
    procedure put_NumeralSystem(value: HSTRING); safecall;
    function get_ResolvedLanguage: HSTRING; safecall;
    function get_ResolvedGeographicRegion: HSTRING; safecall;
    property FractionDigits: Integer read get_FractionDigits write put_FractionDigits;
    property GeographicRegion: HSTRING read get_GeographicRegion;
    property IntegerDigits: Integer read get_IntegerDigits write put_IntegerDigits;
    property IsDecimalPointAlwaysDisplayed: Boolean read get_IsDecimalPointAlwaysDisplayed write put_IsDecimalPointAlwaysDisplayed;
    property IsGrouped: Boolean read get_IsGrouped write put_IsGrouped;
    property Languages: IVectorView_1__HSTRING read get_Languages;
    property NumeralSystem: HSTRING read get_NumeralSystem write put_NumeralSystem;
    property ResolvedGeographicRegion: HSTRING read get_ResolvedGeographicRegion;
    property ResolvedLanguage: HSTRING read get_ResolvedLanguage;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.ISignificantDigitsOption
  NumberFormatting_ISignificantDigitsOption = interface(IInspectable)
  ['{1D4DFCDD-2D43-4EE8-BBF1-C1B26A711A58}']
    function get_SignificantDigits: Integer; safecall;
    procedure put_SignificantDigits(value: Integer); safecall;
    property SignificantDigits: Integer read get_SignificantDigits write put_SignificantDigits;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.INumberRounderOption
  NumberFormatting_INumberRounderOption = interface(IInspectable)
  ['{3B088433-646F-4EFE-8D48-66EB2E49E736}']
    function get_NumberRounder: NumberFormatting_INumberRounder; safecall;
    procedure put_NumberRounder(value: NumberFormatting_INumberRounder); safecall;
    property NumberRounder: NumberFormatting_INumberRounder read get_NumberRounder write put_NumberRounder;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.ISignedZeroOption
  NumberFormatting_ISignedZeroOption = interface(IInspectable)
  ['{FD1CDD31-0A3C-49C4-A642-96A1564F4F30}']
    function get_IsZeroSigned: Boolean; safecall;
    procedure put_IsZeroSigned(value: Boolean); safecall;
    property IsZeroSigned: Boolean read get_IsZeroSigned write put_IsZeroSigned;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.IDecimalFormatterFactory
  [WinRTClassNameAttribute(SNumberFormatting_DecimalFormatter)]
  NumberFormatting_IDecimalFormatterFactory = interface(IInspectable)
  ['{0D018C9A-E393-46B8-B830-7A69C8F89FBB}']
    function CreateDecimalFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.IPercentFormatterFactory
  [WinRTClassNameAttribute(SNumberFormatting_PercentFormatter)]
  NumberFormatting_IPercentFormatterFactory = interface(IInspectable)
  ['{B7828AEF-FED4-4018-A6E2-E09961E03765}']
    function CreatePercentFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.IPermilleFormatterFactory
  [WinRTClassNameAttribute(SNumberFormatting_PermilleFormatter)]
  NumberFormatting_IPermilleFormatterFactory = interface(IInspectable)
  ['{2B37B4AC-E638-4ED5-A998-62F6B06A49AE}']
    function CreatePermilleFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.ICurrencyFormatter
  [WinRTClassNameAttribute(SNumberFormatting_CurrencyFormatter)]
  NumberFormatting_ICurrencyFormatter = interface(IInspectable)
  ['{11730CA5-4B00-41B2-B332-73B12A497D54}']
    function get_Currency: HSTRING; safecall;
    procedure put_Currency(value: HSTRING); safecall;
    property Currency: HSTRING read get_Currency write put_Currency;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.ICurrencyFormatterFactory
  [WinRTClassNameAttribute(SNumberFormatting_CurrencyFormatter)]
  NumberFormatting_ICurrencyFormatterFactory = interface(IInspectable)
  ['{86C7537E-B938-4AA2-84B0-2C33DC5B1450}']
    function CreateCurrencyFormatterCode(currencyCode: HSTRING): NumberFormatting_ICurrencyFormatter; safecall;
    function CreateCurrencyFormatterCodeContext(currencyCode: HSTRING; languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_ICurrencyFormatter; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.ICurrencyFormatter2
  NumberFormatting_ICurrencyFormatter2 = interface(IInspectable)
  ['{072C2F1D-E7BA-4197-920E-247C92F7DEA6}']
    function get_Mode: NumberFormatting_CurrencyFormatterMode; safecall;
    procedure put_Mode(value: NumberFormatting_CurrencyFormatterMode); safecall;
    procedure ApplyRoundingForCurrency(roundingAlgorithm: NumberFormatting_RoundingAlgorithm); safecall;
    property Mode: NumberFormatting_CurrencyFormatterMode read get_Mode write put_Mode;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.INumeralSystemTranslator
  [WinRTClassNameAttribute(SNumberFormatting_NumeralSystemTranslator)]
  NumberFormatting_INumeralSystemTranslator = interface(IInspectable)
  ['{28F5BC2C-8C23-4234-AD2E-FA5A3A426E9B}']
    function get_Languages: IVectorView_1__HSTRING; safecall;
    function get_ResolvedLanguage: HSTRING; safecall;
    function get_NumeralSystem: HSTRING; safecall;
    procedure put_NumeralSystem(value: HSTRING); safecall;
    function TranslateNumerals(value: HSTRING): HSTRING; safecall;
    property Languages: IVectorView_1__HSTRING read get_Languages;
    property NumeralSystem: HSTRING read get_NumeralSystem write put_NumeralSystem;
    property ResolvedLanguage: HSTRING read get_ResolvedLanguage;
  end;

  // DualAPI Interface
  // Windows.Globalization.NumberFormatting.INumeralSystemTranslatorFactory
  [WinRTClassNameAttribute(SNumberFormatting_NumeralSystemTranslator)]
  NumberFormatting_INumeralSystemTranslatorFactory = interface(IInspectable)
  ['{9630C8DA-36EF-4D88-A85C-6F0D98D620A6}']
    function Create(languages: IIterable_1__HSTRING): NumberFormatting_INumeralSystemTranslator; safecall;
  end;

  // DualAPI Interface
  // Windows.Globalization.Collation.ICharacterGrouping
  [WinRTClassNameAttribute(SCollation_CharacterGrouping)]
  Collation_ICharacterGrouping = interface(IInspectable)
  ['{FAE761BB-805D-4BB0-95BB-C1F7C3E8EB8E}']
    function get_First: HSTRING; safecall;
    function get_Label: HSTRING; safecall;
    property First: HSTRING read get_First;
    property &Label: HSTRING read get_Label;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Globalization.Collation.ICharacterGrouping>
  IIterator_1__Collation_ICharacterGrouping = interface(IInspectable)
  ['{72DBD788-D8AC-5771-A0D3-8FE1310D6DA5}']
    function get_Current: Collation_ICharacterGrouping; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCollation_ICharacterGrouping): Cardinal; safecall;
    property Current: Collation_ICharacterGrouping read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Globalization.Collation.ICharacterGrouping>
  IIterable_1__Collation_ICharacterGrouping_Base = interface(IInspectable)
  ['{82E3ABF0-06E3-5609-BA39-C51EB2F5FAE6}']
  end;
  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Globalization.Collation.ICharacterGrouping>
  IIterable_1__Collation_ICharacterGrouping = interface(IIterable_1__Collation_ICharacterGrouping_Base)
  ['{E6888E87-68AA-5C9E-ABBF-C0679E2CB1E9}']
    function First: IIterator_1__Collation_ICharacterGrouping; safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IVectorView`1<Windows.Globalization.Collation.ICharacterGrouping>
  IVectorView_1__Collation_ICharacterGrouping = interface(IInspectable)
  ['{88F5643A-E4DB-58AE-8CF5-B6343D0B60F9}']
    function GetAt(index: Cardinal): Collation_ICharacterGrouping; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Collation_ICharacterGrouping; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCollation_ICharacterGrouping): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Globalization.Collation.ICharacterGroupings
  [WinRTClassNameAttribute(SCollation_CharacterGroupings)]
  Collation_ICharacterGroupings = interface(IInspectable)
  ['{B8D20A75-D4CF-4055-80E5-CE169C226496}']
    function Lookup(text: HSTRING): HSTRING; safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IVector`1<Windows.Globalization.ILanguage>
  IVector_1__ILanguage = interface(IInspectable)
  ['{8E7A7A79-0CC1-5193-90EA-55EE2A4D96DD}']
    function GetAt(index: Cardinal): ILanguage; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__ILanguage; safecall;
    function IndexOf(value: ILanguage; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: ILanguage); safecall;
    procedure InsertAt(index: Cardinal; value: ILanguage); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: ILanguage); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PILanguage): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PILanguage); safecall;
    property Size: Cardinal read get_Size;
  end;


  // Emit Forwarded classes
  // Windows.Globalization.Fonts.LanguageFont
  // DualAPI

  // Windows.Globalization.Fonts.LanguageFontGroup
  // DualAPI
  TFonts_LanguageFontGroup = class(TWinRTGenericImportF<Fonts_ILanguageFontGroupFactory>)
  public
    // -> Fonts_ILanguageFontGroupFactory
    class function CreateLanguageFontGroup(languageTag: HSTRING): Fonts_ILanguageFontGroup; static; inline;
  end;

  // Windows.Globalization.CalendarIdentifiers
  // DualAPI
  TCalendarIdentifiers = class(TWinRTGenericImportS2<ICalendarIdentifiersStatics, ICalendarIdentifiersStatics2>)
  public
    // -> ICalendarIdentifiersStatics
    class function get_Gregorian: HSTRING; static; inline;
    class function get_Hebrew: HSTRING; static; inline;
    class function get_Hijri: HSTRING; static; inline;
    class function get_Japanese: HSTRING; static; inline;
    class function get_Julian: HSTRING; static; inline;
    class function get_Korean: HSTRING; static; inline;
    class function get_Taiwan: HSTRING; static; inline;
    class function get_Thai: HSTRING; static; inline;
    class function get_UmAlQura: HSTRING; static; inline;
    class property Gregorian: HSTRING read get_Gregorian;
    class property Hebrew: HSTRING read get_Hebrew;
    class property Hijri: HSTRING read get_Hijri;
    class property Japanese: HSTRING read get_Japanese;
    class property Julian: HSTRING read get_Julian;
    class property Korean: HSTRING read get_Korean;
    class property Taiwan: HSTRING read get_Taiwan;
    class property Thai: HSTRING read get_Thai;
    class property UmAlQura: HSTRING read get_UmAlQura;

    // -> ICalendarIdentifiersStatics2
    class function get_Persian: HSTRING; static; inline;
    class property Persian: HSTRING read get_Persian;
  end;

  // Windows.Globalization.ClockIdentifiers
  // DualAPI
  TClockIdentifiers = class(TWinRTGenericImportS<IClockIdentifiersStatics>)
  public
    // -> IClockIdentifiersStatics
    class function get_TwelveHour: HSTRING; static; inline;
    class function get_TwentyFourHour: HSTRING; static; inline;
    class property TwelveHour: HSTRING read get_TwelveHour;
    class property TwentyFourHour: HSTRING read get_TwentyFourHour;
  end;

  // Windows.Globalization.NumeralSystemIdentifiers
  // DualAPI
  TNumeralSystemIdentifiers = class(TWinRTGenericImportS2<INumeralSystemIdentifiersStatics, INumeralSystemIdentifiersStatics2>)
  public
    // -> INumeralSystemIdentifiersStatics
    class function get_Arab: HSTRING; static; inline;
    class function get_ArabExt: HSTRING; static; inline;
    class function get_Bali: HSTRING; static; inline;
    class function get_Beng: HSTRING; static; inline;
    class function get_Cham: HSTRING; static; inline;
    class function get_Deva: HSTRING; static; inline;
    class function get_FullWide: HSTRING; static; inline;
    class function get_Gujr: HSTRING; static; inline;
    class function get_Guru: HSTRING; static; inline;
    class function get_HaniDec: HSTRING; static; inline;
    class function get_Java: HSTRING; static; inline;
    class function get_Kali: HSTRING; static; inline;
    class function get_Khmr: HSTRING; static; inline;
    class function get_Knda: HSTRING; static; inline;
    class function get_Lana: HSTRING; static; inline;
    class function get_LanaTham: HSTRING; static; inline;
    class function get_Laoo: HSTRING; static; inline;
    class function get_Latn: HSTRING; static; inline;
    class function get_Lepc: HSTRING; static; inline;
    class function get_Limb: HSTRING; static; inline;
    class function get_Mlym: HSTRING; static; inline;
    class function get_Mong: HSTRING; static; inline;
    class function get_Mtei: HSTRING; static; inline;
    class function get_Mymr: HSTRING; static; inline;
    class function get_MymrShan: HSTRING; static; inline;
    class function get_Nkoo: HSTRING; static; inline;
    class function get_Olck: HSTRING; static; inline;
    class function get_Orya: HSTRING; static; inline;
    class function get_Saur: HSTRING; static; inline;
    class function get_Sund: HSTRING; static; inline;
    class function get_Talu: HSTRING; static; inline;
    class function get_TamlDec: HSTRING; static; inline;
    class function get_Telu: HSTRING; static; inline;
    class function get_Thai: HSTRING; static; inline;
    class function get_Tibt: HSTRING; static; inline;
    class function get_Vaii: HSTRING; static; inline;
    class property Arab: HSTRING read get_Arab;
    class property ArabExt: HSTRING read get_ArabExt;
    class property Bali: HSTRING read get_Bali;
    class property Beng: HSTRING read get_Beng;
    class property Cham: HSTRING read get_Cham;
    class property Deva: HSTRING read get_Deva;
    class property FullWide: HSTRING read get_FullWide;
    class property Gujr: HSTRING read get_Gujr;
    class property Guru: HSTRING read get_Guru;
    class property HaniDec: HSTRING read get_HaniDec;
    class property Java: HSTRING read get_Java;
    class property Kali: HSTRING read get_Kali;
    class property Khmr: HSTRING read get_Khmr;
    class property Knda: HSTRING read get_Knda;
    class property Lana: HSTRING read get_Lana;
    class property LanaTham: HSTRING read get_LanaTham;
    class property Laoo: HSTRING read get_Laoo;
    class property Latn: HSTRING read get_Latn;
    class property Lepc: HSTRING read get_Lepc;
    class property Limb: HSTRING read get_Limb;
    class property Mlym: HSTRING read get_Mlym;
    class property Mong: HSTRING read get_Mong;
    class property Mtei: HSTRING read get_Mtei;
    class property Mymr: HSTRING read get_Mymr;
    class property MymrShan: HSTRING read get_MymrShan;
    class property Nkoo: HSTRING read get_Nkoo;
    class property Olck: HSTRING read get_Olck;
    class property Orya: HSTRING read get_Orya;
    class property Saur: HSTRING read get_Saur;
    class property Sund: HSTRING read get_Sund;
    class property Talu: HSTRING read get_Talu;
    class property TamlDec: HSTRING read get_TamlDec;
    class property Telu: HSTRING read get_Telu;
    class property Thai: HSTRING read get_Thai;
    class property Tibt: HSTRING read get_Tibt;
    class property Vaii: HSTRING read get_Vaii;

    // -> INumeralSystemIdentifiersStatics2
    class function get_Brah: HSTRING; static; inline;
    class function get_Osma: HSTRING; static; inline;
    class function get_MathBold: HSTRING; static; inline;
    class function get_MathDbl: HSTRING; static; inline;
    class function get_MathSans: HSTRING; static; inline;
    class function get_MathSanb: HSTRING; static; inline;
    class function get_MathMono: HSTRING; static; inline;
    class function get_ZmthBold: HSTRING; static; inline;
    class function get_ZmthDbl: HSTRING; static; inline;
    class function get_ZmthSans: HSTRING; static; inline;
    class function get_ZmthSanb: HSTRING; static; inline;
    class function get_ZmthMono: HSTRING; static; inline;
    class property Brah: HSTRING read get_Brah;
    class property MathBold: HSTRING read get_MathBold;
    class property MathDbl: HSTRING read get_MathDbl;
    class property MathMono: HSTRING read get_MathMono;
    class property MathSanb: HSTRING read get_MathSanb;
    class property MathSans: HSTRING read get_MathSans;
    class property Osma: HSTRING read get_Osma;
    class property ZmthBold: HSTRING read get_ZmthBold;
    class property ZmthDbl: HSTRING read get_ZmthDbl;
    class property ZmthMono: HSTRING read get_ZmthMono;
    class property ZmthSanb: HSTRING read get_ZmthSanb;
    class property ZmthSans: HSTRING read get_ZmthSans;
  end;

  // Windows.Globalization.CurrencyIdentifiers
  // DualAPI
  TCurrencyIdentifiers = class(TWinRTGenericImportS<ICurrencyIdentifiersStatics>)
  public
    // -> ICurrencyIdentifiersStatics
    class function get_AED: HSTRING; static; inline;
    class function get_AFN: HSTRING; static; inline;
    class function get_ALL: HSTRING; static; inline;
    class function get_AMD: HSTRING; static; inline;
    class function get_ANG: HSTRING; static; inline;
    class function get_AOA: HSTRING; static; inline;
    class function get_ARS: HSTRING; static; inline;
    class function get_AUD: HSTRING; static; inline;
    class function get_AWG: HSTRING; static; inline;
    class function get_AZN: HSTRING; static; inline;
    class function get_BAM: HSTRING; static; inline;
    class function get_BBD: HSTRING; static; inline;
    class function get_BDT: HSTRING; static; inline;
    class function get_BGN: HSTRING; static; inline;
    class function get_BHD: HSTRING; static; inline;
    class function get_BIF: HSTRING; static; inline;
    class function get_BMD: HSTRING; static; inline;
    class function get_BND: HSTRING; static; inline;
    class function get_BOB: HSTRING; static; inline;
    class function get_BRL: HSTRING; static; inline;
    class function get_BSD: HSTRING; static; inline;
    class function get_BTN: HSTRING; static; inline;
    class function get_BWP: HSTRING; static; inline;
    class function get_BYR: HSTRING; static; inline;
    class function get_BZD: HSTRING; static; inline;
    class function get_CAD: HSTRING; static; inline;
    class function get_CDF: HSTRING; static; inline;
    class function get_CHF: HSTRING; static; inline;
    class function get_CLP: HSTRING; static; inline;
    class function get_CNY: HSTRING; static; inline;
    class function get_COP: HSTRING; static; inline;
    class function get_CRC: HSTRING; static; inline;
    class function get_CUP: HSTRING; static; inline;
    class function get_CVE: HSTRING; static; inline;
    class function get_CZK: HSTRING; static; inline;
    class function get_DJF: HSTRING; static; inline;
    class function get_DKK: HSTRING; static; inline;
    class function get_DOP: HSTRING; static; inline;
    class function get_DZD: HSTRING; static; inline;
    class function get_EGP: HSTRING; static; inline;
    class function get_ERN: HSTRING; static; inline;
    class function get_ETB: HSTRING; static; inline;
    class function get_EUR: HSTRING; static; inline;
    class function get_FJD: HSTRING; static; inline;
    class function get_FKP: HSTRING; static; inline;
    class function get_GBP: HSTRING; static; inline;
    class function get_GEL: HSTRING; static; inline;
    class function get_GHS: HSTRING; static; inline;
    class function get_GIP: HSTRING; static; inline;
    class function get_GMD: HSTRING; static; inline;
    class function get_GNF: HSTRING; static; inline;
    class function get_GTQ: HSTRING; static; inline;
    class function get_GYD: HSTRING; static; inline;
    class function get_HKD: HSTRING; static; inline;
    class function get_HNL: HSTRING; static; inline;
    class function get_HRK: HSTRING; static; inline;
    class function get_HTG: HSTRING; static; inline;
    class function get_HUF: HSTRING; static; inline;
    class function get_IDR: HSTRING; static; inline;
    class function get_ILS: HSTRING; static; inline;
    class function get_INR: HSTRING; static; inline;
    class function get_IQD: HSTRING; static; inline;
    class function get_IRR: HSTRING; static; inline;
    class function get_ISK: HSTRING; static; inline;
    class function get_JMD: HSTRING; static; inline;
    class function get_JOD: HSTRING; static; inline;
    class function get_JPY: HSTRING; static; inline;
    class function get_KES: HSTRING; static; inline;
    class function get_KGS: HSTRING; static; inline;
    class function get_KHR: HSTRING; static; inline;
    class function get_KMF: HSTRING; static; inline;
    class function get_KPW: HSTRING; static; inline;
    class function get_KRW: HSTRING; static; inline;
    class function get_KWD: HSTRING; static; inline;
    class function get_KYD: HSTRING; static; inline;
    class function get_KZT: HSTRING; static; inline;
    class function get_LAK: HSTRING; static; inline;
    class function get_LBP: HSTRING; static; inline;
    class function get_LKR: HSTRING; static; inline;
    class function get_LRD: HSTRING; static; inline;
    class function get_LSL: HSTRING; static; inline;
    class function get_LTL: HSTRING; static; inline;
    class function get_LVL: HSTRING; static; inline;
    class function get_LYD: HSTRING; static; inline;
    class function get_MAD: HSTRING; static; inline;
    class function get_MDL: HSTRING; static; inline;
    class function get_MGA: HSTRING; static; inline;
    class function get_MKD: HSTRING; static; inline;
    class function get_MMK: HSTRING; static; inline;
    class function get_MNT: HSTRING; static; inline;
    class function get_MOP: HSTRING; static; inline;
    class function get_MRO: HSTRING; static; inline;
    class function get_MUR: HSTRING; static; inline;
    class function get_MVR: HSTRING; static; inline;
    class function get_MWK: HSTRING; static; inline;
    class function get_MXN: HSTRING; static; inline;
    class function get_MYR: HSTRING; static; inline;
    class function get_MZN: HSTRING; static; inline;
    class function get_NAD: HSTRING; static; inline;
    class function get_NGN: HSTRING; static; inline;
    class function get_NIO: HSTRING; static; inline;
    class function get_NOK: HSTRING; static; inline;
    class function get_NPR: HSTRING; static; inline;
    class function get_NZD: HSTRING; static; inline;
    class function get_OMR: HSTRING; static; inline;
    class function get_PAB: HSTRING; static; inline;
    class function get_PEN: HSTRING; static; inline;
    class function get_PGK: HSTRING; static; inline;
    class function get_PHP: HSTRING; static; inline;
    class function get_PKR: HSTRING; static; inline;
    class function get_PLN: HSTRING; static; inline;
    class function get_PYG: HSTRING; static; inline;
    class function get_QAR: HSTRING; static; inline;
    class function get_RON: HSTRING; static; inline;
    class function get_RSD: HSTRING; static; inline;
    class function get_RUB: HSTRING; static; inline;
    class function get_RWF: HSTRING; static; inline;
    class function get_SAR: HSTRING; static; inline;
    class function get_SBD: HSTRING; static; inline;
    class function get_SCR: HSTRING; static; inline;
    class function get_SDG: HSTRING; static; inline;
    class function get_SEK: HSTRING; static; inline;
    class function get_SGD: HSTRING; static; inline;
    class function get_SHP: HSTRING; static; inline;
    class function get_SLL: HSTRING; static; inline;
    class function get_SOS: HSTRING; static; inline;
    class function get_SRD: HSTRING; static; inline;
    class function get_STD: HSTRING; static; inline;
    class function get_SYP: HSTRING; static; inline;
    class function get_SZL: HSTRING; static; inline;
    class function get_THB: HSTRING; static; inline;
    class function get_TJS: HSTRING; static; inline;
    class function get_TMT: HSTRING; static; inline;
    class function get_TND: HSTRING; static; inline;
    class function get_TOP: HSTRING; static; inline;
    class function get_TRY: HSTRING; static; inline;
    class function get_TTD: HSTRING; static; inline;
    class function get_TWD: HSTRING; static; inline;
    class function get_TZS: HSTRING; static; inline;
    class function get_UAH: HSTRING; static; inline;
    class function get_UGX: HSTRING; static; inline;
    class function get_USD: HSTRING; static; inline;
    class function get_UYU: HSTRING; static; inline;
    class function get_UZS: HSTRING; static; inline;
    class function get_VEF: HSTRING; static; inline;
    class function get_VND: HSTRING; static; inline;
    class function get_VUV: HSTRING; static; inline;
    class function get_WST: HSTRING; static; inline;
    class function get_XAF: HSTRING; static; inline;
    class function get_XCD: HSTRING; static; inline;
    class function get_XOF: HSTRING; static; inline;
    class function get_XPF: HSTRING; static; inline;
    class function get_XXX: HSTRING; static; inline;
    class function get_YER: HSTRING; static; inline;
    class function get_ZAR: HSTRING; static; inline;
    class function get_ZMW: HSTRING; static; inline;
    class function get_ZWL: HSTRING; static; inline;
    class property AED: HSTRING read get_AED;
    class property AFN: HSTRING read get_AFN;
    class property ALL: HSTRING read get_ALL;
    class property AMD: HSTRING read get_AMD;
    class property ANG: HSTRING read get_ANG;
    class property AOA: HSTRING read get_AOA;
    class property ARS: HSTRING read get_ARS;
    class property AUD: HSTRING read get_AUD;
    class property AWG: HSTRING read get_AWG;
    class property AZN: HSTRING read get_AZN;
    class property BAM: HSTRING read get_BAM;
    class property BBD: HSTRING read get_BBD;
    class property BDT: HSTRING read get_BDT;
    class property BGN: HSTRING read get_BGN;
    class property BHD: HSTRING read get_BHD;
    class property BIF: HSTRING read get_BIF;
    class property BMD: HSTRING read get_BMD;
    class property BND: HSTRING read get_BND;
    class property BOB: HSTRING read get_BOB;
    class property BRL: HSTRING read get_BRL;
    class property BSD: HSTRING read get_BSD;
    class property BTN: HSTRING read get_BTN;
    class property BWP: HSTRING read get_BWP;
    class property BYR: HSTRING read get_BYR;
    class property BZD: HSTRING read get_BZD;
    class property CAD: HSTRING read get_CAD;
    class property CDF: HSTRING read get_CDF;
    class property CHF: HSTRING read get_CHF;
    class property CLP: HSTRING read get_CLP;
    class property CNY: HSTRING read get_CNY;
    class property COP: HSTRING read get_COP;
    class property CRC: HSTRING read get_CRC;
    class property CUP: HSTRING read get_CUP;
    class property CVE: HSTRING read get_CVE;
    class property CZK: HSTRING read get_CZK;
    class property DJF: HSTRING read get_DJF;
    class property DKK: HSTRING read get_DKK;
    class property DOP: HSTRING read get_DOP;
    class property DZD: HSTRING read get_DZD;
    class property EGP: HSTRING read get_EGP;
    class property ERN: HSTRING read get_ERN;
    class property ETB: HSTRING read get_ETB;
    class property EUR: HSTRING read get_EUR;
    class property FJD: HSTRING read get_FJD;
    class property FKP: HSTRING read get_FKP;
    class property GBP: HSTRING read get_GBP;
    class property GEL: HSTRING read get_GEL;
    class property GHS: HSTRING read get_GHS;
    class property GIP: HSTRING read get_GIP;
    class property GMD: HSTRING read get_GMD;
    class property GNF: HSTRING read get_GNF;
    class property GTQ: HSTRING read get_GTQ;
    class property GYD: HSTRING read get_GYD;
    class property HKD: HSTRING read get_HKD;
    class property HNL: HSTRING read get_HNL;
    class property HRK: HSTRING read get_HRK;
    class property HTG: HSTRING read get_HTG;
    class property HUF: HSTRING read get_HUF;
    class property IDR: HSTRING read get_IDR;
    class property ILS: HSTRING read get_ILS;
    class property INR: HSTRING read get_INR;
    class property IQD: HSTRING read get_IQD;
    class property IRR: HSTRING read get_IRR;
    class property ISK: HSTRING read get_ISK;
    class property JMD: HSTRING read get_JMD;
    class property JOD: HSTRING read get_JOD;
    class property JPY: HSTRING read get_JPY;
    class property KES: HSTRING read get_KES;
    class property KGS: HSTRING read get_KGS;
    class property KHR: HSTRING read get_KHR;
    class property KMF: HSTRING read get_KMF;
    class property KPW: HSTRING read get_KPW;
    class property KRW: HSTRING read get_KRW;
    class property KWD: HSTRING read get_KWD;
    class property KYD: HSTRING read get_KYD;
    class property KZT: HSTRING read get_KZT;
    class property LAK: HSTRING read get_LAK;
    class property LBP: HSTRING read get_LBP;
    class property LKR: HSTRING read get_LKR;
    class property LRD: HSTRING read get_LRD;
    class property LSL: HSTRING read get_LSL;
    class property LTL: HSTRING read get_LTL;
    class property LVL: HSTRING read get_LVL;
    class property LYD: HSTRING read get_LYD;
    class property MAD: HSTRING read get_MAD;
    class property MDL: HSTRING read get_MDL;
    class property MGA: HSTRING read get_MGA;
    class property MKD: HSTRING read get_MKD;
    class property MMK: HSTRING read get_MMK;
    class property MNT: HSTRING read get_MNT;
    class property MOP: HSTRING read get_MOP;
    class property MRO: HSTRING read get_MRO;
    class property MUR: HSTRING read get_MUR;
    class property MVR: HSTRING read get_MVR;
    class property MWK: HSTRING read get_MWK;
    class property MXN: HSTRING read get_MXN;
    class property MYR: HSTRING read get_MYR;
    class property MZN: HSTRING read get_MZN;
    class property NAD: HSTRING read get_NAD;
    class property NGN: HSTRING read get_NGN;
    class property NIO: HSTRING read get_NIO;
    class property NOK: HSTRING read get_NOK;
    class property NPR: HSTRING read get_NPR;
    class property NZD: HSTRING read get_NZD;
    class property OMR: HSTRING read get_OMR;
    class property PAB: HSTRING read get_PAB;
    class property PEN: HSTRING read get_PEN;
    class property PGK: HSTRING read get_PGK;
    class property PHP: HSTRING read get_PHP;
    class property PKR: HSTRING read get_PKR;
    class property PLN: HSTRING read get_PLN;
    class property PYG: HSTRING read get_PYG;
    class property QAR: HSTRING read get_QAR;
    class property RON: HSTRING read get_RON;
    class property RSD: HSTRING read get_RSD;
    class property RUB: HSTRING read get_RUB;
    class property RWF: HSTRING read get_RWF;
    class property SAR: HSTRING read get_SAR;
    class property SBD: HSTRING read get_SBD;
    class property SCR: HSTRING read get_SCR;
    class property SDG: HSTRING read get_SDG;
    class property SEK: HSTRING read get_SEK;
    class property SGD: HSTRING read get_SGD;
    class property SHP: HSTRING read get_SHP;
    class property SLL: HSTRING read get_SLL;
    class property SOS: HSTRING read get_SOS;
    class property SRD: HSTRING read get_SRD;
    class property STD: HSTRING read get_STD;
    class property SYP: HSTRING read get_SYP;
    class property SZL: HSTRING read get_SZL;
    class property THB: HSTRING read get_THB;
    class property TJS: HSTRING read get_TJS;
    class property TMT: HSTRING read get_TMT;
    class property TND: HSTRING read get_TND;
    class property TOP: HSTRING read get_TOP;
    class property &TRY: HSTRING read get_TRY;
    class property TTD: HSTRING read get_TTD;
    class property TWD: HSTRING read get_TWD;
    class property TZS: HSTRING read get_TZS;
    class property UAH: HSTRING read get_UAH;
    class property UGX: HSTRING read get_UGX;
    class property USD: HSTRING read get_USD;
    class property UYU: HSTRING read get_UYU;
    class property UZS: HSTRING read get_UZS;
    class property VEF: HSTRING read get_VEF;
    class property VND: HSTRING read get_VND;
    class property VUV: HSTRING read get_VUV;
    class property WST: HSTRING read get_WST;
    class property XAF: HSTRING read get_XAF;
    class property XCD: HSTRING read get_XCD;
    class property XOF: HSTRING read get_XOF;
    class property XPF: HSTRING read get_XPF;
    class property XXX: HSTRING read get_XXX;
    class property YER: HSTRING read get_YER;
    class property ZAR: HSTRING read get_ZAR;
    class property ZMW: HSTRING read get_ZMW;
    class property ZWL: HSTRING read get_ZWL;
  end;

  // Windows.Globalization.GeographicRegion
  // DualAPI
  TGeographicRegion = class(TWinRTGenericImportFSI<IGeographicRegionFactory, IGeographicRegionStatics, IGeographicRegion>)
  public
    // -> IGeographicRegionStatics
    class function IsSupported(geographicRegionCode: HSTRING): Boolean; static; inline;

    // -> IGeographicRegionFactory
    class function CreateGeographicRegion(geographicRegionCode: HSTRING): IGeographicRegion; static; inline;
  end;

  // Windows.Globalization.Language
  // DualAPI
  TLanguage = class(TWinRTGenericImportFS2<ILanguageFactory, ILanguageStatics, ILanguageStatics2>)
  public
    // -> ILanguageStatics2
    class function TrySetInputMethodLanguageTag(languageTag: HSTRING): Boolean; static; inline;

    // -> ILanguageStatics
    class function IsWellFormed(languageTag: HSTRING): Boolean; static; inline;
    class function get_CurrentInputMethodLanguageTag: HSTRING; static; inline;
    class property CurrentInputMethodLanguageTag: HSTRING read get_CurrentInputMethodLanguageTag;

    // -> ILanguageFactory
    class function CreateLanguage(languageTag: HSTRING): ILanguage; static; inline;
  end;

  // Windows.Globalization.DateTimeFormatting.DateTimeFormatter
  // DualAPI
  TDateTimeFormatting_DateTimeFormatter = class(TWinRTGenericImportFS<DateTimeFormatting_IDateTimeFormatterFactory, DateTimeFormatting_IDateTimeFormatterStatics>)
  public
    // -> DateTimeFormatting_IDateTimeFormatterStatics
    class function get_LongDate: DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function get_LongTime: DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function get_ShortDate: DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function get_ShortTime: DateTimeFormatting_IDateTimeFormatter; static; inline;
    class property LongDate: DateTimeFormatting_IDateTimeFormatter read get_LongDate;
    class property LongTime: DateTimeFormatting_IDateTimeFormatter read get_LongTime;
    class property ShortDate: DateTimeFormatting_IDateTimeFormatter read get_ShortDate;
    class property ShortTime: DateTimeFormatting_IDateTimeFormatter read get_ShortTime;

    // -> DateTimeFormatting_IDateTimeFormatterFactory
    class function CreateDateTimeFormatter(formatTemplate: HSTRING): DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function CreateDateTimeFormatterLanguages(formatTemplate: HSTRING; languages: IIterable_1__HSTRING): DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function CreateDateTimeFormatterContext(formatTemplate: HSTRING; languages: IIterable_1__HSTRING; geographicRegion: HSTRING; calendar: HSTRING; clock: HSTRING): DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function CreateDateTimeFormatterDate(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat): DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function CreateDateTimeFormatterTime(hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat): DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function CreateDateTimeFormatterDateTimeLanguages(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat; hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat; languages: IIterable_1__HSTRING): DateTimeFormatting_IDateTimeFormatter; static; inline;
    class function CreateDateTimeFormatterDateTimeContext(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat; hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat; languages: IIterable_1__HSTRING; geographicRegion: HSTRING; calendar: HSTRING; clock: HSTRING): DateTimeFormatting_IDateTimeFormatter; static; inline;
  end;

  // Windows.Globalization.Calendar
  // DualAPI
  TCalendar = class(TWinRTGenericImportF2I<ICalendarFactory, ICalendarFactory2, ICalendar>)
  public
    // -> ICalendarFactory2
    class function CreateCalendarWithTimeZone(languages: IIterable_1__HSTRING; calendar: HSTRING; clock: HSTRING; timeZoneId: HSTRING): ICalendar; static; inline;

    // -> ICalendarFactory
    class function CreateCalendarDefaultCalendarAndClock(languages: IIterable_1__HSTRING): ICalendar; static; inline;
    class function CreateCalendar(languages: IIterable_1__HSTRING; calendar: HSTRING; clock: HSTRING): ICalendar; static; inline;
  end;

  // Windows.Globalization.NumberFormatting.SignificantDigitsNumberRounder
  // DualAPI
  TNumberFormatting_SignificantDigitsNumberRounder = class(TWinRTGenericImportI<NumberFormatting_ISignificantDigitsNumberRounder>) end;

  // Windows.Globalization.NumberFormatting.IncrementNumberRounder
  // DualAPI
  TNumberFormatting_IncrementNumberRounder = class(TWinRTGenericImportI<NumberFormatting_IIncrementNumberRounder>) end;

  // Windows.Globalization.NumberFormatting.DecimalFormatter
  // DualAPI
  TNumberFormatting_DecimalFormatter = class(TWinRTGenericImportFI<NumberFormatting_IDecimalFormatterFactory, NumberFormatting_INumberFormatterOptions>)
  public
    // -> NumberFormatting_IDecimalFormatterFactory
    class function CreateDecimalFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions; static; inline;
  end;

  // Windows.Globalization.NumberFormatting.PercentFormatter
  // DualAPI
  TNumberFormatting_PercentFormatter = class(TWinRTGenericImportFI<NumberFormatting_IPercentFormatterFactory, NumberFormatting_INumberFormatterOptions>)
  public
    // -> NumberFormatting_IPercentFormatterFactory
    class function CreatePercentFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions; static; inline;
  end;

  // Windows.Globalization.NumberFormatting.PermilleFormatter
  // DualAPI
  TNumberFormatting_PermilleFormatter = class(TWinRTGenericImportFI<NumberFormatting_IPermilleFormatterFactory, NumberFormatting_INumberFormatterOptions>)
  public
    // -> NumberFormatting_IPermilleFormatterFactory
    class function CreatePermilleFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions; static; inline;
  end;

  // Windows.Globalization.NumberFormatting.CurrencyFormatter
  // DualAPI
  TNumberFormatting_CurrencyFormatter = class(TWinRTGenericImportF<NumberFormatting_ICurrencyFormatterFactory>)
  public
    // -> NumberFormatting_ICurrencyFormatterFactory
    class function CreateCurrencyFormatterCode(currencyCode: HSTRING): NumberFormatting_ICurrencyFormatter; static; inline;
    class function CreateCurrencyFormatterCodeContext(currencyCode: HSTRING; languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_ICurrencyFormatter; static; inline;
  end;

  // Windows.Globalization.NumberFormatting.NumeralSystemTranslator
  // DualAPI
  TNumberFormatting_NumeralSystemTranslator = class(TWinRTGenericImportFI<NumberFormatting_INumeralSystemTranslatorFactory, NumberFormatting_INumeralSystemTranslator>)
  public
    // -> NumberFormatting_INumeralSystemTranslatorFactory
    class function Create(languages: IIterable_1__HSTRING): NumberFormatting_INumeralSystemTranslator; overload; static; inline;
  end;

  // Windows.Globalization.Collation.CharacterGrouping
  // DualAPI

  // Windows.Globalization.Collation.CharacterGroupings
  // DualAPI
  TCollation_CharacterGroupings = class(TWinRTGenericImportI<Collation_ICharacterGroupings>) end;


implementation

  // Emit Classes Implementation
 { TFonts_LanguageFontGroup }
// Factories for : "Fonts_LanguageFontGroup"
// Factory: "Windows.Globalization.Fonts.ILanguageFontGroupFactory"
// -> Fonts_ILanguageFontGroupFactory

class function TFonts_LanguageFontGroup.CreateLanguageFontGroup(languageTag: HSTRING): Fonts_ILanguageFontGroup;
begin
  Result := Factory.CreateLanguageFontGroup(languageTag);
end;


 { TCalendarIdentifiers }

class function TCalendarIdentifiers.get_Gregorian: HSTRING;
begin
  Result := Statics.get_Gregorian;
end;

class function TCalendarIdentifiers.get_Hebrew: HSTRING;
begin
  Result := Statics.get_Hebrew;
end;

class function TCalendarIdentifiers.get_Hijri: HSTRING;
begin
  Result := Statics.get_Hijri;
end;

class function TCalendarIdentifiers.get_Japanese: HSTRING;
begin
  Result := Statics.get_Japanese;
end;

class function TCalendarIdentifiers.get_Julian: HSTRING;
begin
  Result := Statics.get_Julian;
end;

class function TCalendarIdentifiers.get_Korean: HSTRING;
begin
  Result := Statics.get_Korean;
end;

class function TCalendarIdentifiers.get_Taiwan: HSTRING;
begin
  Result := Statics.get_Taiwan;
end;

class function TCalendarIdentifiers.get_Thai: HSTRING;
begin
  Result := Statics.get_Thai;
end;

class function TCalendarIdentifiers.get_UmAlQura: HSTRING;
begin
  Result := Statics.get_UmAlQura;
end;


class function TCalendarIdentifiers.get_Persian: HSTRING;
begin
  Result := Statics2.get_Persian;
end;


 { TClockIdentifiers }

class function TClockIdentifiers.get_TwelveHour: HSTRING;
begin
  Result := Statics.get_TwelveHour;
end;

class function TClockIdentifiers.get_TwentyFourHour: HSTRING;
begin
  Result := Statics.get_TwentyFourHour;
end;


 { TNumeralSystemIdentifiers }

class function TNumeralSystemIdentifiers.get_Arab: HSTRING;
begin
  Result := Statics.get_Arab;
end;

class function TNumeralSystemIdentifiers.get_ArabExt: HSTRING;
begin
  Result := Statics.get_ArabExt;
end;

class function TNumeralSystemIdentifiers.get_Bali: HSTRING;
begin
  Result := Statics.get_Bali;
end;

class function TNumeralSystemIdentifiers.get_Beng: HSTRING;
begin
  Result := Statics.get_Beng;
end;

class function TNumeralSystemIdentifiers.get_Cham: HSTRING;
begin
  Result := Statics.get_Cham;
end;

class function TNumeralSystemIdentifiers.get_Deva: HSTRING;
begin
  Result := Statics.get_Deva;
end;

class function TNumeralSystemIdentifiers.get_FullWide: HSTRING;
begin
  Result := Statics.get_FullWide;
end;

class function TNumeralSystemIdentifiers.get_Gujr: HSTRING;
begin
  Result := Statics.get_Gujr;
end;

class function TNumeralSystemIdentifiers.get_Guru: HSTRING;
begin
  Result := Statics.get_Guru;
end;

class function TNumeralSystemIdentifiers.get_HaniDec: HSTRING;
begin
  Result := Statics.get_HaniDec;
end;

class function TNumeralSystemIdentifiers.get_Java: HSTRING;
begin
  Result := Statics.get_Java;
end;

class function TNumeralSystemIdentifiers.get_Kali: HSTRING;
begin
  Result := Statics.get_Kali;
end;

class function TNumeralSystemIdentifiers.get_Khmr: HSTRING;
begin
  Result := Statics.get_Khmr;
end;

class function TNumeralSystemIdentifiers.get_Knda: HSTRING;
begin
  Result := Statics.get_Knda;
end;

class function TNumeralSystemIdentifiers.get_Lana: HSTRING;
begin
  Result := Statics.get_Lana;
end;

class function TNumeralSystemIdentifiers.get_LanaTham: HSTRING;
begin
  Result := Statics.get_LanaTham;
end;

class function TNumeralSystemIdentifiers.get_Laoo: HSTRING;
begin
  Result := Statics.get_Laoo;
end;

class function TNumeralSystemIdentifiers.get_Latn: HSTRING;
begin
  Result := Statics.get_Latn;
end;

class function TNumeralSystemIdentifiers.get_Lepc: HSTRING;
begin
  Result := Statics.get_Lepc;
end;

class function TNumeralSystemIdentifiers.get_Limb: HSTRING;
begin
  Result := Statics.get_Limb;
end;

class function TNumeralSystemIdentifiers.get_Mlym: HSTRING;
begin
  Result := Statics.get_Mlym;
end;

class function TNumeralSystemIdentifiers.get_Mong: HSTRING;
begin
  Result := Statics.get_Mong;
end;

class function TNumeralSystemIdentifiers.get_Mtei: HSTRING;
begin
  Result := Statics.get_Mtei;
end;

class function TNumeralSystemIdentifiers.get_Mymr: HSTRING;
begin
  Result := Statics.get_Mymr;
end;

class function TNumeralSystemIdentifiers.get_MymrShan: HSTRING;
begin
  Result := Statics.get_MymrShan;
end;

class function TNumeralSystemIdentifiers.get_Nkoo: HSTRING;
begin
  Result := Statics.get_Nkoo;
end;

class function TNumeralSystemIdentifiers.get_Olck: HSTRING;
begin
  Result := Statics.get_Olck;
end;

class function TNumeralSystemIdentifiers.get_Orya: HSTRING;
begin
  Result := Statics.get_Orya;
end;

class function TNumeralSystemIdentifiers.get_Saur: HSTRING;
begin
  Result := Statics.get_Saur;
end;

class function TNumeralSystemIdentifiers.get_Sund: HSTRING;
begin
  Result := Statics.get_Sund;
end;

class function TNumeralSystemIdentifiers.get_Talu: HSTRING;
begin
  Result := Statics.get_Talu;
end;

class function TNumeralSystemIdentifiers.get_TamlDec: HSTRING;
begin
  Result := Statics.get_TamlDec;
end;

class function TNumeralSystemIdentifiers.get_Telu: HSTRING;
begin
  Result := Statics.get_Telu;
end;

class function TNumeralSystemIdentifiers.get_Thai: HSTRING;
begin
  Result := Statics.get_Thai;
end;

class function TNumeralSystemIdentifiers.get_Tibt: HSTRING;
begin
  Result := Statics.get_Tibt;
end;

class function TNumeralSystemIdentifiers.get_Vaii: HSTRING;
begin
  Result := Statics.get_Vaii;
end;


class function TNumeralSystemIdentifiers.get_Brah: HSTRING;
begin
  Result := Statics2.get_Brah;
end;

class function TNumeralSystemIdentifiers.get_Osma: HSTRING;
begin
  Result := Statics2.get_Osma;
end;

class function TNumeralSystemIdentifiers.get_MathBold: HSTRING;
begin
  Result := Statics2.get_MathBold;
end;

class function TNumeralSystemIdentifiers.get_MathDbl: HSTRING;
begin
  Result := Statics2.get_MathDbl;
end;

class function TNumeralSystemIdentifiers.get_MathSans: HSTRING;
begin
  Result := Statics2.get_MathSans;
end;

class function TNumeralSystemIdentifiers.get_MathSanb: HSTRING;
begin
  Result := Statics2.get_MathSanb;
end;

class function TNumeralSystemIdentifiers.get_MathMono: HSTRING;
begin
  Result := Statics2.get_MathMono;
end;

class function TNumeralSystemIdentifiers.get_ZmthBold: HSTRING;
begin
  Result := Statics2.get_ZmthBold;
end;

class function TNumeralSystemIdentifiers.get_ZmthDbl: HSTRING;
begin
  Result := Statics2.get_ZmthDbl;
end;

class function TNumeralSystemIdentifiers.get_ZmthSans: HSTRING;
begin
  Result := Statics2.get_ZmthSans;
end;

class function TNumeralSystemIdentifiers.get_ZmthSanb: HSTRING;
begin
  Result := Statics2.get_ZmthSanb;
end;

class function TNumeralSystemIdentifiers.get_ZmthMono: HSTRING;
begin
  Result := Statics2.get_ZmthMono;
end;


 { TCurrencyIdentifiers }

class function TCurrencyIdentifiers.get_AED: HSTRING;
begin
  Result := Statics.get_AED;
end;

class function TCurrencyIdentifiers.get_AFN: HSTRING;
begin
  Result := Statics.get_AFN;
end;

class function TCurrencyIdentifiers.get_ALL: HSTRING;
begin
  Result := Statics.get_ALL;
end;

class function TCurrencyIdentifiers.get_AMD: HSTRING;
begin
  Result := Statics.get_AMD;
end;

class function TCurrencyIdentifiers.get_ANG: HSTRING;
begin
  Result := Statics.get_ANG;
end;

class function TCurrencyIdentifiers.get_AOA: HSTRING;
begin
  Result := Statics.get_AOA;
end;

class function TCurrencyIdentifiers.get_ARS: HSTRING;
begin
  Result := Statics.get_ARS;
end;

class function TCurrencyIdentifiers.get_AUD: HSTRING;
begin
  Result := Statics.get_AUD;
end;

class function TCurrencyIdentifiers.get_AWG: HSTRING;
begin
  Result := Statics.get_AWG;
end;

class function TCurrencyIdentifiers.get_AZN: HSTRING;
begin
  Result := Statics.get_AZN;
end;

class function TCurrencyIdentifiers.get_BAM: HSTRING;
begin
  Result := Statics.get_BAM;
end;

class function TCurrencyIdentifiers.get_BBD: HSTRING;
begin
  Result := Statics.get_BBD;
end;

class function TCurrencyIdentifiers.get_BDT: HSTRING;
begin
  Result := Statics.get_BDT;
end;

class function TCurrencyIdentifiers.get_BGN: HSTRING;
begin
  Result := Statics.get_BGN;
end;

class function TCurrencyIdentifiers.get_BHD: HSTRING;
begin
  Result := Statics.get_BHD;
end;

class function TCurrencyIdentifiers.get_BIF: HSTRING;
begin
  Result := Statics.get_BIF;
end;

class function TCurrencyIdentifiers.get_BMD: HSTRING;
begin
  Result := Statics.get_BMD;
end;

class function TCurrencyIdentifiers.get_BND: HSTRING;
begin
  Result := Statics.get_BND;
end;

class function TCurrencyIdentifiers.get_BOB: HSTRING;
begin
  Result := Statics.get_BOB;
end;

class function TCurrencyIdentifiers.get_BRL: HSTRING;
begin
  Result := Statics.get_BRL;
end;

class function TCurrencyIdentifiers.get_BSD: HSTRING;
begin
  Result := Statics.get_BSD;
end;

class function TCurrencyIdentifiers.get_BTN: HSTRING;
begin
  Result := Statics.get_BTN;
end;

class function TCurrencyIdentifiers.get_BWP: HSTRING;
begin
  Result := Statics.get_BWP;
end;

class function TCurrencyIdentifiers.get_BYR: HSTRING;
begin
  Result := Statics.get_BYR;
end;

class function TCurrencyIdentifiers.get_BZD: HSTRING;
begin
  Result := Statics.get_BZD;
end;

class function TCurrencyIdentifiers.get_CAD: HSTRING;
begin
  Result := Statics.get_CAD;
end;

class function TCurrencyIdentifiers.get_CDF: HSTRING;
begin
  Result := Statics.get_CDF;
end;

class function TCurrencyIdentifiers.get_CHF: HSTRING;
begin
  Result := Statics.get_CHF;
end;

class function TCurrencyIdentifiers.get_CLP: HSTRING;
begin
  Result := Statics.get_CLP;
end;

class function TCurrencyIdentifiers.get_CNY: HSTRING;
begin
  Result := Statics.get_CNY;
end;

class function TCurrencyIdentifiers.get_COP: HSTRING;
begin
  Result := Statics.get_COP;
end;

class function TCurrencyIdentifiers.get_CRC: HSTRING;
begin
  Result := Statics.get_CRC;
end;

class function TCurrencyIdentifiers.get_CUP: HSTRING;
begin
  Result := Statics.get_CUP;
end;

class function TCurrencyIdentifiers.get_CVE: HSTRING;
begin
  Result := Statics.get_CVE;
end;

class function TCurrencyIdentifiers.get_CZK: HSTRING;
begin
  Result := Statics.get_CZK;
end;

class function TCurrencyIdentifiers.get_DJF: HSTRING;
begin
  Result := Statics.get_DJF;
end;

class function TCurrencyIdentifiers.get_DKK: HSTRING;
begin
  Result := Statics.get_DKK;
end;

class function TCurrencyIdentifiers.get_DOP: HSTRING;
begin
  Result := Statics.get_DOP;
end;

class function TCurrencyIdentifiers.get_DZD: HSTRING;
begin
  Result := Statics.get_DZD;
end;

class function TCurrencyIdentifiers.get_EGP: HSTRING;
begin
  Result := Statics.get_EGP;
end;

class function TCurrencyIdentifiers.get_ERN: HSTRING;
begin
  Result := Statics.get_ERN;
end;

class function TCurrencyIdentifiers.get_ETB: HSTRING;
begin
  Result := Statics.get_ETB;
end;

class function TCurrencyIdentifiers.get_EUR: HSTRING;
begin
  Result := Statics.get_EUR;
end;

class function TCurrencyIdentifiers.get_FJD: HSTRING;
begin
  Result := Statics.get_FJD;
end;

class function TCurrencyIdentifiers.get_FKP: HSTRING;
begin
  Result := Statics.get_FKP;
end;

class function TCurrencyIdentifiers.get_GBP: HSTRING;
begin
  Result := Statics.get_GBP;
end;

class function TCurrencyIdentifiers.get_GEL: HSTRING;
begin
  Result := Statics.get_GEL;
end;

class function TCurrencyIdentifiers.get_GHS: HSTRING;
begin
  Result := Statics.get_GHS;
end;

class function TCurrencyIdentifiers.get_GIP: HSTRING;
begin
  Result := Statics.get_GIP;
end;

class function TCurrencyIdentifiers.get_GMD: HSTRING;
begin
  Result := Statics.get_GMD;
end;

class function TCurrencyIdentifiers.get_GNF: HSTRING;
begin
  Result := Statics.get_GNF;
end;

class function TCurrencyIdentifiers.get_GTQ: HSTRING;
begin
  Result := Statics.get_GTQ;
end;

class function TCurrencyIdentifiers.get_GYD: HSTRING;
begin
  Result := Statics.get_GYD;
end;

class function TCurrencyIdentifiers.get_HKD: HSTRING;
begin
  Result := Statics.get_HKD;
end;

class function TCurrencyIdentifiers.get_HNL: HSTRING;
begin
  Result := Statics.get_HNL;
end;

class function TCurrencyIdentifiers.get_HRK: HSTRING;
begin
  Result := Statics.get_HRK;
end;

class function TCurrencyIdentifiers.get_HTG: HSTRING;
begin
  Result := Statics.get_HTG;
end;

class function TCurrencyIdentifiers.get_HUF: HSTRING;
begin
  Result := Statics.get_HUF;
end;

class function TCurrencyIdentifiers.get_IDR: HSTRING;
begin
  Result := Statics.get_IDR;
end;

class function TCurrencyIdentifiers.get_ILS: HSTRING;
begin
  Result := Statics.get_ILS;
end;

class function TCurrencyIdentifiers.get_INR: HSTRING;
begin
  Result := Statics.get_INR;
end;

class function TCurrencyIdentifiers.get_IQD: HSTRING;
begin
  Result := Statics.get_IQD;
end;

class function TCurrencyIdentifiers.get_IRR: HSTRING;
begin
  Result := Statics.get_IRR;
end;

class function TCurrencyIdentifiers.get_ISK: HSTRING;
begin
  Result := Statics.get_ISK;
end;

class function TCurrencyIdentifiers.get_JMD: HSTRING;
begin
  Result := Statics.get_JMD;
end;

class function TCurrencyIdentifiers.get_JOD: HSTRING;
begin
  Result := Statics.get_JOD;
end;

class function TCurrencyIdentifiers.get_JPY: HSTRING;
begin
  Result := Statics.get_JPY;
end;

class function TCurrencyIdentifiers.get_KES: HSTRING;
begin
  Result := Statics.get_KES;
end;

class function TCurrencyIdentifiers.get_KGS: HSTRING;
begin
  Result := Statics.get_KGS;
end;

class function TCurrencyIdentifiers.get_KHR: HSTRING;
begin
  Result := Statics.get_KHR;
end;

class function TCurrencyIdentifiers.get_KMF: HSTRING;
begin
  Result := Statics.get_KMF;
end;

class function TCurrencyIdentifiers.get_KPW: HSTRING;
begin
  Result := Statics.get_KPW;
end;

class function TCurrencyIdentifiers.get_KRW: HSTRING;
begin
  Result := Statics.get_KRW;
end;

class function TCurrencyIdentifiers.get_KWD: HSTRING;
begin
  Result := Statics.get_KWD;
end;

class function TCurrencyIdentifiers.get_KYD: HSTRING;
begin
  Result := Statics.get_KYD;
end;

class function TCurrencyIdentifiers.get_KZT: HSTRING;
begin
  Result := Statics.get_KZT;
end;

class function TCurrencyIdentifiers.get_LAK: HSTRING;
begin
  Result := Statics.get_LAK;
end;

class function TCurrencyIdentifiers.get_LBP: HSTRING;
begin
  Result := Statics.get_LBP;
end;

class function TCurrencyIdentifiers.get_LKR: HSTRING;
begin
  Result := Statics.get_LKR;
end;

class function TCurrencyIdentifiers.get_LRD: HSTRING;
begin
  Result := Statics.get_LRD;
end;

class function TCurrencyIdentifiers.get_LSL: HSTRING;
begin
  Result := Statics.get_LSL;
end;

class function TCurrencyIdentifiers.get_LTL: HSTRING;
begin
  Result := Statics.get_LTL;
end;

class function TCurrencyIdentifiers.get_LVL: HSTRING;
begin
  Result := Statics.get_LVL;
end;

class function TCurrencyIdentifiers.get_LYD: HSTRING;
begin
  Result := Statics.get_LYD;
end;

class function TCurrencyIdentifiers.get_MAD: HSTRING;
begin
  Result := Statics.get_MAD;
end;

class function TCurrencyIdentifiers.get_MDL: HSTRING;
begin
  Result := Statics.get_MDL;
end;

class function TCurrencyIdentifiers.get_MGA: HSTRING;
begin
  Result := Statics.get_MGA;
end;

class function TCurrencyIdentifiers.get_MKD: HSTRING;
begin
  Result := Statics.get_MKD;
end;

class function TCurrencyIdentifiers.get_MMK: HSTRING;
begin
  Result := Statics.get_MMK;
end;

class function TCurrencyIdentifiers.get_MNT: HSTRING;
begin
  Result := Statics.get_MNT;
end;

class function TCurrencyIdentifiers.get_MOP: HSTRING;
begin
  Result := Statics.get_MOP;
end;

class function TCurrencyIdentifiers.get_MRO: HSTRING;
begin
  Result := Statics.get_MRO;
end;

class function TCurrencyIdentifiers.get_MUR: HSTRING;
begin
  Result := Statics.get_MUR;
end;

class function TCurrencyIdentifiers.get_MVR: HSTRING;
begin
  Result := Statics.get_MVR;
end;

class function TCurrencyIdentifiers.get_MWK: HSTRING;
begin
  Result := Statics.get_MWK;
end;

class function TCurrencyIdentifiers.get_MXN: HSTRING;
begin
  Result := Statics.get_MXN;
end;

class function TCurrencyIdentifiers.get_MYR: HSTRING;
begin
  Result := Statics.get_MYR;
end;

class function TCurrencyIdentifiers.get_MZN: HSTRING;
begin
  Result := Statics.get_MZN;
end;

class function TCurrencyIdentifiers.get_NAD: HSTRING;
begin
  Result := Statics.get_NAD;
end;

class function TCurrencyIdentifiers.get_NGN: HSTRING;
begin
  Result := Statics.get_NGN;
end;

class function TCurrencyIdentifiers.get_NIO: HSTRING;
begin
  Result := Statics.get_NIO;
end;

class function TCurrencyIdentifiers.get_NOK: HSTRING;
begin
  Result := Statics.get_NOK;
end;

class function TCurrencyIdentifiers.get_NPR: HSTRING;
begin
  Result := Statics.get_NPR;
end;

class function TCurrencyIdentifiers.get_NZD: HSTRING;
begin
  Result := Statics.get_NZD;
end;

class function TCurrencyIdentifiers.get_OMR: HSTRING;
begin
  Result := Statics.get_OMR;
end;

class function TCurrencyIdentifiers.get_PAB: HSTRING;
begin
  Result := Statics.get_PAB;
end;

class function TCurrencyIdentifiers.get_PEN: HSTRING;
begin
  Result := Statics.get_PEN;
end;

class function TCurrencyIdentifiers.get_PGK: HSTRING;
begin
  Result := Statics.get_PGK;
end;

class function TCurrencyIdentifiers.get_PHP: HSTRING;
begin
  Result := Statics.get_PHP;
end;

class function TCurrencyIdentifiers.get_PKR: HSTRING;
begin
  Result := Statics.get_PKR;
end;

class function TCurrencyIdentifiers.get_PLN: HSTRING;
begin
  Result := Statics.get_PLN;
end;

class function TCurrencyIdentifiers.get_PYG: HSTRING;
begin
  Result := Statics.get_PYG;
end;

class function TCurrencyIdentifiers.get_QAR: HSTRING;
begin
  Result := Statics.get_QAR;
end;

class function TCurrencyIdentifiers.get_RON: HSTRING;
begin
  Result := Statics.get_RON;
end;

class function TCurrencyIdentifiers.get_RSD: HSTRING;
begin
  Result := Statics.get_RSD;
end;

class function TCurrencyIdentifiers.get_RUB: HSTRING;
begin
  Result := Statics.get_RUB;
end;

class function TCurrencyIdentifiers.get_RWF: HSTRING;
begin
  Result := Statics.get_RWF;
end;

class function TCurrencyIdentifiers.get_SAR: HSTRING;
begin
  Result := Statics.get_SAR;
end;

class function TCurrencyIdentifiers.get_SBD: HSTRING;
begin
  Result := Statics.get_SBD;
end;

class function TCurrencyIdentifiers.get_SCR: HSTRING;
begin
  Result := Statics.get_SCR;
end;

class function TCurrencyIdentifiers.get_SDG: HSTRING;
begin
  Result := Statics.get_SDG;
end;

class function TCurrencyIdentifiers.get_SEK: HSTRING;
begin
  Result := Statics.get_SEK;
end;

class function TCurrencyIdentifiers.get_SGD: HSTRING;
begin
  Result := Statics.get_SGD;
end;

class function TCurrencyIdentifiers.get_SHP: HSTRING;
begin
  Result := Statics.get_SHP;
end;

class function TCurrencyIdentifiers.get_SLL: HSTRING;
begin
  Result := Statics.get_SLL;
end;

class function TCurrencyIdentifiers.get_SOS: HSTRING;
begin
  Result := Statics.get_SOS;
end;

class function TCurrencyIdentifiers.get_SRD: HSTRING;
begin
  Result := Statics.get_SRD;
end;

class function TCurrencyIdentifiers.get_STD: HSTRING;
begin
  Result := Statics.get_STD;
end;

class function TCurrencyIdentifiers.get_SYP: HSTRING;
begin
  Result := Statics.get_SYP;
end;

class function TCurrencyIdentifiers.get_SZL: HSTRING;
begin
  Result := Statics.get_SZL;
end;

class function TCurrencyIdentifiers.get_THB: HSTRING;
begin
  Result := Statics.get_THB;
end;

class function TCurrencyIdentifiers.get_TJS: HSTRING;
begin
  Result := Statics.get_TJS;
end;

class function TCurrencyIdentifiers.get_TMT: HSTRING;
begin
  Result := Statics.get_TMT;
end;

class function TCurrencyIdentifiers.get_TND: HSTRING;
begin
  Result := Statics.get_TND;
end;

class function TCurrencyIdentifiers.get_TOP: HSTRING;
begin
  Result := Statics.get_TOP;
end;

class function TCurrencyIdentifiers.get_TRY: HSTRING;
begin
  Result := Statics.get_TRY;
end;

class function TCurrencyIdentifiers.get_TTD: HSTRING;
begin
  Result := Statics.get_TTD;
end;

class function TCurrencyIdentifiers.get_TWD: HSTRING;
begin
  Result := Statics.get_TWD;
end;

class function TCurrencyIdentifiers.get_TZS: HSTRING;
begin
  Result := Statics.get_TZS;
end;

class function TCurrencyIdentifiers.get_UAH: HSTRING;
begin
  Result := Statics.get_UAH;
end;

class function TCurrencyIdentifiers.get_UGX: HSTRING;
begin
  Result := Statics.get_UGX;
end;

class function TCurrencyIdentifiers.get_USD: HSTRING;
begin
  Result := Statics.get_USD;
end;

class function TCurrencyIdentifiers.get_UYU: HSTRING;
begin
  Result := Statics.get_UYU;
end;

class function TCurrencyIdentifiers.get_UZS: HSTRING;
begin
  Result := Statics.get_UZS;
end;

class function TCurrencyIdentifiers.get_VEF: HSTRING;
begin
  Result := Statics.get_VEF;
end;

class function TCurrencyIdentifiers.get_VND: HSTRING;
begin
  Result := Statics.get_VND;
end;

class function TCurrencyIdentifiers.get_VUV: HSTRING;
begin
  Result := Statics.get_VUV;
end;

class function TCurrencyIdentifiers.get_WST: HSTRING;
begin
  Result := Statics.get_WST;
end;

class function TCurrencyIdentifiers.get_XAF: HSTRING;
begin
  Result := Statics.get_XAF;
end;

class function TCurrencyIdentifiers.get_XCD: HSTRING;
begin
  Result := Statics.get_XCD;
end;

class function TCurrencyIdentifiers.get_XOF: HSTRING;
begin
  Result := Statics.get_XOF;
end;

class function TCurrencyIdentifiers.get_XPF: HSTRING;
begin
  Result := Statics.get_XPF;
end;

class function TCurrencyIdentifiers.get_XXX: HSTRING;
begin
  Result := Statics.get_XXX;
end;

class function TCurrencyIdentifiers.get_YER: HSTRING;
begin
  Result := Statics.get_YER;
end;

class function TCurrencyIdentifiers.get_ZAR: HSTRING;
begin
  Result := Statics.get_ZAR;
end;

class function TCurrencyIdentifiers.get_ZMW: HSTRING;
begin
  Result := Statics.get_ZMW;
end;

class function TCurrencyIdentifiers.get_ZWL: HSTRING;
begin
  Result := Statics.get_ZWL;
end;


 { TGeographicRegion }

class function TGeographicRegion.IsSupported(geographicRegionCode: HSTRING): Boolean;
begin
  Result := Statics.IsSupported(geographicRegionCode);
end;

// Factories for : "GeographicRegion"
// Factory: "Windows.Globalization.IGeographicRegionFactory"
// -> IGeographicRegionFactory

class function TGeographicRegion.CreateGeographicRegion(geographicRegionCode: HSTRING): IGeographicRegion;
begin
  Result := Factory.CreateGeographicRegion(geographicRegionCode);
end;


 { TLanguage }

class function TLanguage.IsWellFormed(languageTag: HSTRING): Boolean;
begin
  Result := Statics.IsWellFormed(languageTag);
end;

class function TLanguage.get_CurrentInputMethodLanguageTag: HSTRING;
begin
  Result := Statics.get_CurrentInputMethodLanguageTag;
end;


class function TLanguage.TrySetInputMethodLanguageTag(languageTag: HSTRING): Boolean;
begin
  Result := Statics2.TrySetInputMethodLanguageTag(languageTag);
end;

// Factories for : "Language"
// Factory: "Windows.Globalization.ILanguageFactory"
// -> ILanguageFactory

class function TLanguage.CreateLanguage(languageTag: HSTRING): ILanguage;
begin
  Result := Factory.CreateLanguage(languageTag);
end;


 { TDateTimeFormatting_DateTimeFormatter }

class function TDateTimeFormatting_DateTimeFormatter.get_LongDate: DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Statics.get_LongDate;
end;

class function TDateTimeFormatting_DateTimeFormatter.get_LongTime: DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Statics.get_LongTime;
end;

class function TDateTimeFormatting_DateTimeFormatter.get_ShortDate: DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Statics.get_ShortDate;
end;

class function TDateTimeFormatting_DateTimeFormatter.get_ShortTime: DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Statics.get_ShortTime;
end;

// Factories for : "DateTimeFormatting_DateTimeFormatter"
// Factory: "Windows.Globalization.DateTimeFormatting.IDateTimeFormatterFactory"
// -> DateTimeFormatting_IDateTimeFormatterFactory

class function TDateTimeFormatting_DateTimeFormatter.CreateDateTimeFormatter(formatTemplate: HSTRING): DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Factory.CreateDateTimeFormatter(formatTemplate);
end;

class function TDateTimeFormatting_DateTimeFormatter.CreateDateTimeFormatterLanguages(formatTemplate: HSTRING; languages: IIterable_1__HSTRING): DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Factory.CreateDateTimeFormatterLanguages(formatTemplate, languages);
end;

class function TDateTimeFormatting_DateTimeFormatter.CreateDateTimeFormatterContext(formatTemplate: HSTRING; languages: IIterable_1__HSTRING; geographicRegion: HSTRING; calendar: HSTRING; clock: HSTRING): DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Factory.CreateDateTimeFormatterContext(formatTemplate, languages, geographicRegion, calendar, clock);
end;

class function TDateTimeFormatting_DateTimeFormatter.CreateDateTimeFormatterDate(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat): DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Factory.CreateDateTimeFormatterDate(yearFormat, monthFormat, dayFormat, dayOfWeekFormat);
end;

class function TDateTimeFormatting_DateTimeFormatter.CreateDateTimeFormatterTime(hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat): DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Factory.CreateDateTimeFormatterTime(hourFormat, minuteFormat, secondFormat);
end;

class function TDateTimeFormatting_DateTimeFormatter.CreateDateTimeFormatterDateTimeLanguages(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat; hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat; languages: IIterable_1__HSTRING): DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Factory.CreateDateTimeFormatterDateTimeLanguages(yearFormat, monthFormat, dayFormat, dayOfWeekFormat, hourFormat, minuteFormat, secondFormat, languages);
end;

class function TDateTimeFormatting_DateTimeFormatter.CreateDateTimeFormatterDateTimeContext(yearFormat: DateTimeFormatting_YearFormat; monthFormat: DateTimeFormatting_MonthFormat; dayFormat: DateTimeFormatting_DayFormat; dayOfWeekFormat: DateTimeFormatting_DayOfWeekFormat; hourFormat: DateTimeFormatting_HourFormat; minuteFormat: DateTimeFormatting_MinuteFormat; secondFormat: DateTimeFormatting_SecondFormat; languages: IIterable_1__HSTRING; geographicRegion: HSTRING; calendar: HSTRING; clock: HSTRING): DateTimeFormatting_IDateTimeFormatter;
begin
  Result := Factory.CreateDateTimeFormatterDateTimeContext(yearFormat, monthFormat, dayFormat, dayOfWeekFormat, hourFormat, minuteFormat, secondFormat, languages, geographicRegion, calendar, clock);
end;


 { TCalendar }
// Factories for : "Calendar"
// Factory: "Windows.Globalization.ICalendarFactory"
// -> ICalendarFactory

class function TCalendar.CreateCalendarDefaultCalendarAndClock(languages: IIterable_1__HSTRING): ICalendar;
begin
  Result := Factory.CreateCalendarDefaultCalendarAndClock(languages);
end;

class function TCalendar.CreateCalendar(languages: IIterable_1__HSTRING; calendar: HSTRING; clock: HSTRING): ICalendar;
begin
  Result := Factory.CreateCalendar(languages, calendar, clock);
end;

// Factory: "Windows.Globalization.ICalendarFactory2"
// -> ICalendarFactory2

class function TCalendar.CreateCalendarWithTimeZone(languages: IIterable_1__HSTRING; calendar: HSTRING; clock: HSTRING; timeZoneId: HSTRING): ICalendar;
begin
  Result := Factory2.CreateCalendarWithTimeZone(languages, calendar, clock, timeZoneId);
end;


 { TNumberFormatting_SignificantDigitsNumberRounder }

 { TNumberFormatting_IncrementNumberRounder }

 { TNumberFormatting_DecimalFormatter }
// Factories for : "NumberFormatting_DecimalFormatter"
// Factory: "Windows.Globalization.NumberFormatting.IDecimalFormatterFactory"
// -> NumberFormatting_IDecimalFormatterFactory

class function TNumberFormatting_DecimalFormatter.CreateDecimalFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions;
begin
  Result := Factory.CreateDecimalFormatter(languages, geographicRegion);
end;


 { TNumberFormatting_PercentFormatter }
// Factories for : "NumberFormatting_PercentFormatter"
// Factory: "Windows.Globalization.NumberFormatting.IPercentFormatterFactory"
// -> NumberFormatting_IPercentFormatterFactory

class function TNumberFormatting_PercentFormatter.CreatePercentFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions;
begin
  Result := Factory.CreatePercentFormatter(languages, geographicRegion);
end;


 { TNumberFormatting_PermilleFormatter }
// Factories for : "NumberFormatting_PermilleFormatter"
// Factory: "Windows.Globalization.NumberFormatting.IPermilleFormatterFactory"
// -> NumberFormatting_IPermilleFormatterFactory

class function TNumberFormatting_PermilleFormatter.CreatePermilleFormatter(languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_INumberFormatterOptions;
begin
  Result := Factory.CreatePermilleFormatter(languages, geographicRegion);
end;


 { TNumberFormatting_CurrencyFormatter }
// Factories for : "NumberFormatting_CurrencyFormatter"
// Factory: "Windows.Globalization.NumberFormatting.ICurrencyFormatterFactory"
// -> NumberFormatting_ICurrencyFormatterFactory

class function TNumberFormatting_CurrencyFormatter.CreateCurrencyFormatterCode(currencyCode: HSTRING): NumberFormatting_ICurrencyFormatter;
begin
  Result := Factory.CreateCurrencyFormatterCode(currencyCode);
end;

class function TNumberFormatting_CurrencyFormatter.CreateCurrencyFormatterCodeContext(currencyCode: HSTRING; languages: IIterable_1__HSTRING; geographicRegion: HSTRING): NumberFormatting_ICurrencyFormatter;
begin
  Result := Factory.CreateCurrencyFormatterCodeContext(currencyCode, languages, geographicRegion);
end;


 { TNumberFormatting_NumeralSystemTranslator }
// Factories for : "NumberFormatting_NumeralSystemTranslator"
// Factory: "Windows.Globalization.NumberFormatting.INumeralSystemTranslatorFactory"
// -> NumberFormatting_INumeralSystemTranslatorFactory

class function TNumberFormatting_NumeralSystemTranslator.Create(languages: IIterable_1__HSTRING): NumberFormatting_INumeralSystemTranslator;
begin
  Result := Factory.Create(languages);
end;


 { TCollation_CharacterGroupings }


end.
