unit l3VCLStrings;

interface

uses
 l3IntfUses
 , l3VCLStringsItems
 , l3StringList
 , l3Interfaces
;

type
 Tl3StringsItems = class(Tl3VCLStringsItems)
 end;//Tl3StringsItems
 
 Tl3CustomStrings = class(Tl3StringList, Il3Strings, Il3StringsEx)
  function Items: TStrings; overload;
   {* строки. }
  procedure Assign(const aStrings: Il3StringsEx); overload;
  procedure Assign(aStrings: TStrings); overload;
  function Items: TStrings; overload;
   {* элементы списка. }
  function EQ(const aStrings: Il3StringsEx): Boolean;
  function Add(const aStr: AnsiString): Integer; overload;
  function Add(const Item: Il3CString): Integer; overload;
  function Add(const aStr: Tl3WString): Integer; overload;
  function AddObject(const aStr: AnsiString;
   anObject: TObject): Integer; overload;
  function AddObject(const aStr: Il3CString;
   anObject: TObject): Integer; overload;
  procedure Insert(aIndex: Integer;
   const aStr: Il3CString); overload;
  procedure Insert(aIndex: Integer;
   const aStr: AnsiString); overload;
  procedure BeginUpdate;
  procedure EndUpdate;
  procedure Clear;
  procedure Delete(anIndex: Integer);
  function IndexOf(const aSt: AnsiString): Integer; overload;
  function IndexOf(const aSt: Il3CString): Integer; overload;
  function IndexOf(const aSt: Tl3WString): Integer; overload;
  function Count: Integer;
   {* количество элементов. }
  function Item: AnsiString;
   {* элементы списка. }
  function ItemC: Il3CString;
   {* элементы списка. }
  function Objects: TObject;
   {* объекты, ассоциированные со строками. }
  function Sorted: Boolean;
 end;//Tl3CustomStrings
 
 Tl3Strings = class(Tl3CustomStrings)
 end;//Tl3Strings
 
implementation

uses
 l3ImplUses
;

end.
