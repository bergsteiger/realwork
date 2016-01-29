unit ddHTMLTag;

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3Base
 , l3RegEx
 , ddHTMLTags
 , l3Types
 , l3ProtoDataContainer
;

type
 TddParamsList = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TddParamsList
 
 TddParseParamAction = (
  dd_ppaAddNewValue
  , dd_ppaExtendString
 );//TddParseParamAction
 
 TddHTMLTag = class(Tl3SimpleObject)
  procedure AddChar(aChar: AnsiChar;
   aHRefSeacher: Tl3RegularSearch);
  procedure Create(aTagID: Integer);
  procedure AddString(const aString: Tl3String;
   aHRefSeacher: Tl3RegularSearch);
  function IsNil: Boolean;
   {* Проверяет есть ли данные в теге. }
  function HasKey(anKeyID: TddHTMLParamID;
   var aParam: TddHTMLParam): Boolean;
  function GetKeyID: TddHTMLParamID;
  procedure AddKeyValue(aValue: TddHTMLParamID);
  procedure AddIntValue(aHRefSeacher: Tl3RegularSearch);
  procedure AddStringValue(aHRefSeacher: Tl3RegularSearch);
  function GetPrevParamType: TddHTMLParamID;
  procedure TryAddValue(aKeyValue: Boolean;
   aHRefSeacher: Tl3RegularSearch);
  function CanAddNewValue: Boolean;
  procedure AlnalyseValue(aHRefSeacher: Tl3RegularSearch);
  procedure AnalyseCharSet;
  procedure AddVAlignValue;
  procedure TryAddPercent;
  procedure AnalyseHREF(aHRefSeacher: Tl3RegularSearch);
  procedure AnalyseStyle;
  function Param2PCharLen(const aParam: TddHTMLParam): Tl3PCharLen;
  procedure AddAlignValue(const aStr: Tl3String);
  function CheckServiceDocID(aDocID: Integer): Boolean;
   {* Исключаем ссылки на служебные топики с www-ссылками }
  procedure AddWidthValue;
 end;//TddHTMLTag
 
implementation

uses
 l3ImplUses
 , l3Chars
 , l3String
 , ddTypes
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3UnitsTools
;

end.
