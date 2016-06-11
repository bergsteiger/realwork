{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.Text;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.UI.ViewManagement,
  // Internal Uses...
  Winapi.Storage.Streams,
  Winapi.Foundation,
  Winapi.Globalization,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // Windows.UI.Text.ITextCharacterFormat
  ITextCharacterFormat = interface;
  PITextCharacterFormat = ^ITextCharacterFormat;

  // Windows.UI.Text.ITextParagraphFormat
  ITextParagraphFormat = interface;
  PITextParagraphFormat = ^ITextParagraphFormat;

  // Windows.UI.Text.ITextRange
  ITextRange = interface;
  PITextRange = ^ITextRange;

  // Windows.UI.Text.ITextSelection
  ITextSelection = interface;
  PITextSelection = ^ITextSelection;

  // Windows.UI.Text.ITextDocument
  ITextDocument = interface;
  PITextDocument = ^ITextDocument;

  // Windows.Foundation.IReference`1<Windows.UI.Text.UnderlineType>
  IReference_1__UnderlineType = interface;
  PIReference_1__UnderlineType = ^IReference_1__UnderlineType;


  // Emit Forwarded interfaces
  // Windows.UI.Text Interfaces
  // Windows.UI.Text.ITextCharacterFormat
  ITextCharacterFormat = interface(IInspectable)
  ['{5ADEF3DB-05FB-442D-8065-642AFEA02CED}']
    function get_AllCaps: FormatEffect; safecall;
    procedure put_AllCaps(value: FormatEffect); safecall;
    function get_BackgroundColor: Color; safecall;
    procedure put_BackgroundColor(value: Color); safecall;
    function get_Bold: FormatEffect; safecall;
    procedure put_Bold(value: FormatEffect); safecall;
    function get_FontStretch: FontStretch; safecall;
    procedure put_FontStretch(value: FontStretch); safecall;
    function get_FontStyle: FontStyle; safecall;
    procedure put_FontStyle(value: FontStyle); safecall;
    function get_ForegroundColor: Color; safecall;
    procedure put_ForegroundColor(value: Color); safecall;
    function get_Hidden: FormatEffect; safecall;
    procedure put_Hidden(value: FormatEffect); safecall;
    function get_Italic: FormatEffect; safecall;
    procedure put_Italic(value: FormatEffect); safecall;
    function get_Kerning: Single; safecall;
    procedure put_Kerning(value: Single); safecall;
    function get_LanguageTag: HSTRING; safecall;
    procedure put_LanguageTag(value: HSTRING); safecall;
    function get_LinkType: LinkType; safecall;
    function get_Name: HSTRING; safecall;
    procedure put_Name(value: HSTRING); safecall;
    function get_Outline: FormatEffect; safecall;
    procedure put_Outline(value: FormatEffect); safecall;
    function get_Position: Single; safecall;
    procedure put_Position(value: Single); safecall;
    function get_ProtectedText: FormatEffect; safecall;
    procedure put_ProtectedText(value: FormatEffect); safecall;
    function get_Size: Single; safecall;
    procedure put_Size(value: Single); safecall;
    function get_SmallCaps: FormatEffect; safecall;
    procedure put_SmallCaps(value: FormatEffect); safecall;
    function get_Spacing: Single; safecall;
    procedure put_Spacing(value: Single); safecall;
    function get_Strikethrough: FormatEffect; safecall;
    procedure put_Strikethrough(value: FormatEffect); safecall;
    function get_Subscript: FormatEffect; safecall;
    procedure put_Subscript(value: FormatEffect); safecall;
    function get_Superscript: FormatEffect; safecall;
    procedure put_Superscript(value: FormatEffect); safecall;
    function get_TextScript: TextScript; safecall;
    procedure put_TextScript(value: TextScript); safecall;
    function get_Underline: UnderlineType; safecall;
    procedure put_Underline(value: UnderlineType); safecall;
    function get_Weight: Integer; safecall;
    procedure put_Weight(value: Integer); safecall;
    procedure SetClone(value: ITextCharacterFormat); safecall;
    function GetClone: ITextCharacterFormat; safecall;
    function IsEqual(format: ITextCharacterFormat): Boolean; safecall;
    property AllCaps: FormatEffect read get_AllCaps write put_AllCaps;
    property BackgroundColor: Color read get_BackgroundColor write put_BackgroundColor;
    property Bold: FormatEffect read get_Bold write put_Bold;
    property FontStretch: FontStretch read get_FontStretch write put_FontStretch;
    property FontStyle: FontStyle read get_FontStyle write put_FontStyle;
    property ForegroundColor: Color read get_ForegroundColor write put_ForegroundColor;
    property Hidden: FormatEffect read get_Hidden write put_Hidden;
    property Italic: FormatEffect read get_Italic write put_Italic;
    property Kerning: Single read get_Kerning write put_Kerning;
    property LanguageTag: HSTRING read get_LanguageTag write put_LanguageTag;
    property LinkType: LinkType read get_LinkType;
    property Name: HSTRING read get_Name write put_Name;
    property Outline: FormatEffect read get_Outline write put_Outline;
    property Position: Single read get_Position write put_Position;
    property ProtectedText: FormatEffect read get_ProtectedText write put_ProtectedText;
    property Size: Single read get_Size write put_Size;
    property SmallCaps: FormatEffect read get_SmallCaps write put_SmallCaps;
    property Spacing: Single read get_Spacing write put_Spacing;
    property Strikethrough: FormatEffect read get_Strikethrough write put_Strikethrough;
    property Subscript: FormatEffect read get_Subscript write put_Subscript;
    property Superscript: FormatEffect read get_Superscript write put_Superscript;
    property TextScript: TextScript read get_TextScript write put_TextScript;
    property Underline: UnderlineType read get_Underline write put_Underline;
    property Weight: Integer read get_Weight write put_Weight;
  end;

  // Windows.UI.Text.ITextParagraphFormat
  ITextParagraphFormat = interface(IInspectable)
  ['{2CF8CFA6-4676-498A-93F5-BBDBFC0BD883}']
    function get_Alignment: ParagraphAlignment; safecall;
    procedure put_Alignment(value: ParagraphAlignment); safecall;
    function get_FirstLineIndent: Single; safecall;
    function get_KeepTogether: FormatEffect; safecall;
    procedure put_KeepTogether(value: FormatEffect); safecall;
    function get_KeepWithNext: FormatEffect; safecall;
    procedure put_KeepWithNext(value: FormatEffect); safecall;
    function get_LeftIndent: Single; safecall;
    function get_LineSpacing: Single; safecall;
    function get_LineSpacingRule: LineSpacingRule; safecall;
    function get_ListAlignment: MarkerAlignment; safecall;
    procedure put_ListAlignment(value: MarkerAlignment); safecall;
    function get_ListLevelIndex: Integer; safecall;
    procedure put_ListLevelIndex(value: Integer); safecall;
    function get_ListStart: Integer; safecall;
    procedure put_ListStart(value: Integer); safecall;
    function get_ListStyle: MarkerStyle; safecall;
    procedure put_ListStyle(value: MarkerStyle); safecall;
    function get_ListTab: Single; safecall;
    procedure put_ListTab(value: Single); safecall;
    function get_ListType: MarkerType; safecall;
    procedure put_ListType(value: MarkerType); safecall;
    function get_NoLineNumber: FormatEffect; safecall;
    procedure put_NoLineNumber(value: FormatEffect); safecall;
    function get_PageBreakBefore: FormatEffect; safecall;
    procedure put_PageBreakBefore(value: FormatEffect); safecall;
    function get_RightIndent: Single; safecall;
    procedure put_RightIndent(value: Single); safecall;
    function get_RightToLeft: FormatEffect; safecall;
    procedure put_RightToLeft(value: FormatEffect); safecall;
    function get_Style: ParagraphStyle; safecall;
    procedure put_Style(value: ParagraphStyle); safecall;
    function get_SpaceAfter: Single; safecall;
    procedure put_SpaceAfter(value: Single); safecall;
    function get_SpaceBefore: Single; safecall;
    procedure put_SpaceBefore(value: Single); safecall;
    function get_WidowControl: FormatEffect; safecall;
    procedure put_WidowControl(value: FormatEffect); safecall;
    function get_TabCount: Integer; safecall;
    procedure AddTab(position: Single; align: TabAlignment; leader: TabLeader); safecall;
    procedure ClearAllTabs; safecall;
    procedure DeleteTab(position: Single); safecall;
    function GetClone: ITextParagraphFormat; safecall;
    procedure GetTab(index: Integer; out position: Single; out align: TabAlignment; out leader: TabLeader); safecall;
    function IsEqual(format: ITextParagraphFormat): Boolean; safecall;
    procedure SetClone(format: ITextParagraphFormat); safecall;
    procedure SetIndents(start: Single; left: Single; right: Single); safecall;
    procedure SetLineSpacing(rule: LineSpacingRule; spacing: Single); safecall;
    property Alignment: ParagraphAlignment read get_Alignment write put_Alignment;
    property FirstLineIndent: Single read get_FirstLineIndent;
    property KeepTogether: FormatEffect read get_KeepTogether write put_KeepTogether;
    property KeepWithNext: FormatEffect read get_KeepWithNext write put_KeepWithNext;
    property LeftIndent: Single read get_LeftIndent;
    property LineSpacing: Single read get_LineSpacing;
    property LineSpacingRule: LineSpacingRule read get_LineSpacingRule;
    property ListAlignment: MarkerAlignment read get_ListAlignment write put_ListAlignment;
    property ListLevelIndex: Integer read get_ListLevelIndex write put_ListLevelIndex;
    property ListStart: Integer read get_ListStart write put_ListStart;
    property ListStyle: MarkerStyle read get_ListStyle write put_ListStyle;
    property ListTab: Single read get_ListTab write put_ListTab;
    property ListType: MarkerType read get_ListType write put_ListType;
    property NoLineNumber: FormatEffect read get_NoLineNumber write put_NoLineNumber;
    property PageBreakBefore: FormatEffect read get_PageBreakBefore write put_PageBreakBefore;
    property RightIndent: Single read get_RightIndent write put_RightIndent;
    property RightToLeft: FormatEffect read get_RightToLeft write put_RightToLeft;
    property SpaceAfter: Single read get_SpaceAfter write put_SpaceAfter;
    property SpaceBefore: Single read get_SpaceBefore write put_SpaceBefore;
    property Style: ParagraphStyle read get_Style write put_Style;
    property TabCount: Integer read get_TabCount;
    property WidowControl: FormatEffect read get_WidowControl write put_WidowControl;
  end;

  // Windows.UI.Text.ITextRange
  ITextRange = interface(IInspectable)
  ['{5B9E4E57-C072-42A0-8945-AF503EE54768}']
    function get_Character: Char; safecall;
    procedure put_Character(value: Char); safecall;
    function get_CharacterFormat: ITextCharacterFormat; safecall;
    procedure put_CharacterFormat(value: ITextCharacterFormat); safecall;
    function get_FormattedText: ITextRange; safecall;
    procedure put_FormattedText(value: ITextRange); safecall;
    function get_EndPosition: Integer; safecall;
    procedure put_EndPosition(value: Integer); safecall;
    function get_Gravity: RangeGravity; safecall;
    procedure put_Gravity(value: RangeGravity); safecall;
    function get_Length: Integer; safecall;
    function get_Link: HSTRING; safecall;
    procedure put_Link(value: HSTRING); safecall;
    function get_ParagraphFormat: ITextParagraphFormat; safecall;
    procedure put_ParagraphFormat(value: ITextParagraphFormat); safecall;
    function get_StartPosition: Integer; safecall;
    procedure put_StartPosition(value: Integer); safecall;
    function get_StoryLength: Integer; safecall;
    function get_Text: HSTRING; safecall;
    procedure put_Text(value: HSTRING); safecall;
    function CanPaste(format: Integer): Boolean; safecall;
    procedure ChangeCase(value: LetterCase); safecall;
    procedure Collapse(value: Boolean); safecall;
    procedure Copy; safecall;
    procedure Cut; safecall;
    function Delete(&unit: TextRangeUnit; count: Integer): Integer; safecall;
    function EndOf(&unit: TextRangeUnit; extend: Boolean): Integer; safecall;
    function Expand(&unit: TextRangeUnit): Integer; safecall;
    function FindText(value: HSTRING; scanLength: Integer; options: FindOptions): Integer; safecall;
    procedure GetCharacterUtf32(out value: Cardinal; offset: Integer); safecall;
    function GetClone: ITextRange; safecall;
    function GetIndex(&unit: TextRangeUnit): Integer; safecall;
    procedure GetPoint(horizontalAlign: HorizontalCharacterAlignment; verticalAlign: VerticalCharacterAlignment; options: PointOptions; out point: TPointF); safecall;
    procedure GetRect(options: PointOptions; out rect: TRectF; out hit: Integer); safecall;
    procedure GetText(options: TextGetOptions; out value: HSTRING); safecall;
    procedure GetTextViaStream(options: TextGetOptions; value: IRandomAccessStream); safecall;
    function InRange(range: ITextRange): Boolean; safecall;
    procedure InsertImage(width: Integer; height: Integer; ascent: Integer; verticalAlign: VerticalCharacterAlignment; alternateText: HSTRING; value: IRandomAccessStream); safecall;
    function InStory(range: ITextRange): Boolean; safecall;
    function IsEqual(range: ITextRange): Boolean; safecall;
    function Move(&unit: TextRangeUnit; count: Integer): Integer; safecall;
    function MoveEnd(&unit: TextRangeUnit; count: Integer): Integer; safecall;
    function MoveStart(&unit: TextRangeUnit; count: Integer): Integer; safecall;
    procedure Paste(format: Integer); safecall;
    procedure ScrollIntoView(value: PointOptions); safecall;
    procedure MatchSelection; safecall;
    procedure SetIndex(&unit: TextRangeUnit; index: Integer; extend: Boolean); safecall;
    procedure SetPoint(point: TPointF; options: PointOptions; extend: Boolean); safecall;
    procedure SetRange(startPosition: Integer; endPosition: Integer); safecall;
    procedure SetText(options: TextSetOptions; value: HSTRING); safecall;
    procedure SetTextViaStream(options: TextSetOptions; value: IRandomAccessStream); safecall;
    function StartOf(&unit: TextRangeUnit; extend: Boolean): Integer; safecall;
    property Character: Char read get_Character write put_Character;
    property CharacterFormat: ITextCharacterFormat read get_CharacterFormat write put_CharacterFormat;
    property EndPosition: Integer read get_EndPosition write put_EndPosition;
    property FormattedText: ITextRange read get_FormattedText write put_FormattedText;
    property Gravity: RangeGravity read get_Gravity write put_Gravity;
    property Length: Integer read get_Length;
    property Link: HSTRING read get_Link write put_Link;
    property ParagraphFormat: ITextParagraphFormat read get_ParagraphFormat write put_ParagraphFormat;
    property StartPosition: Integer read get_StartPosition write put_StartPosition;
    property StoryLength: Integer read get_StoryLength;
    property Text: HSTRING read get_Text write put_Text;
  end;

  // Windows.UI.Text.ITextSelection
  ITextSelection = interface(IInspectable)
  ['{A6D36724-F28F-430A-B2CF-C343671EC0E9}']
    function get_Options: SelectionOptions; safecall;
    procedure put_Options(value: SelectionOptions); safecall;
    function get_Type: SelectionType; safecall;
    function EndKey(&unit: TextRangeUnit; extend: Boolean): Integer; safecall;
    function HomeKey(&unit: TextRangeUnit; extend: Boolean): Integer; safecall;
    function MoveDown(&unit: TextRangeUnit; count: Integer; extend: Boolean): Integer; safecall;
    function MoveLeft(&unit: TextRangeUnit; count: Integer; extend: Boolean): Integer; safecall;
    function MoveRight(&unit: TextRangeUnit; count: Integer; extend: Boolean): Integer; safecall;
    function MoveUp(&unit: TextRangeUnit; count: Integer; extend: Boolean): Integer; safecall;
    procedure TypeText(value: HSTRING); safecall;
    property Options: SelectionOptions read get_Options write put_Options;
    property &Type: SelectionType read get_Type;
  end;

  // Windows.UI.Text.ITextDocument
  ITextDocument = interface(IInspectable)
  ['{BEEE4DDB-90B2-408C-A2F6-0A0AC31E33E4}']
    function get_CaretType: CaretType; safecall;
    procedure put_CaretType(value: CaretType); safecall;
    function get_DefaultTabStop: Single; safecall;
    procedure put_DefaultTabStop(value: Single); safecall;
    function get_Selection: ITextSelection; safecall;
    function get_UndoLimit: Cardinal; safecall;
    procedure put_UndoLimit(value: Cardinal); safecall;
    function CanCopy: Boolean; safecall;
    function CanPaste: Boolean; safecall;
    function CanRedo: Boolean; safecall;
    function CanUndo: Boolean; safecall;
    function ApplyDisplayUpdates: Integer; safecall;
    function BatchDisplayUpdates: Integer; safecall;
    procedure BeginUndoGroup; safecall;
    procedure EndUndoGroup; safecall;
    function GetDefaultCharacterFormat: ITextCharacterFormat; safecall;
    function GetDefaultParagraphFormat: ITextParagraphFormat; safecall;
    function GetRange(startPosition: Integer; endPosition: Integer): ITextRange; safecall;
    function GetRangeFromPoint(point: TPointF; options: PointOptions): ITextRange; safecall;
    procedure GetText(options: TextGetOptions; out value: HSTRING); safecall;
    procedure LoadFromStream(options: TextSetOptions; value: IRandomAccessStream); safecall;
    procedure Redo; safecall;
    procedure SaveToStream(options: TextGetOptions; value: IRandomAccessStream); safecall;
    procedure SetDefaultCharacterFormat(value: ITextCharacterFormat); safecall;
    procedure SetDefaultParagraphFormat(value: ITextParagraphFormat); safecall;
    procedure SetText(options: TextSetOptions; value: HSTRING); safecall;
    procedure Undo; safecall;
    property CaretType: CaretType read get_CaretType write put_CaretType;
    property DefaultTabStop: Single read get_DefaultTabStop write put_DefaultTabStop;
    property Selection: ITextSelection read get_Selection;
    property UndoLimit: Cardinal read get_UndoLimit write put_UndoLimit;
  end;

  // Windows.Foundation.IReference`1<Windows.UI.Text.UnderlineType>
  IReference_1__UnderlineType = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: UnderlineType; safecall;
    property Value: UnderlineType read get_Value;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
