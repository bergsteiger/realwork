unit tfwDictionary;

interface

uses
 l3IntfUses
 , tfwDictionaryPrim
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TtfwDictionary = class(TtfwDictionaryPrim)
  {* Словарь }
  function AddWord(const aWordName: AnsiString;
   aWordClass: RtfwWord): Boolean; overload;
  function AddWord(const aWordName: AnsiString;
   aWord: TtfwWord): Boolean; overload;
  function DoCheckWord(const aName: Il3CString): TtfwKeyWord;
  procedure Create;
  function OwnDRbyCName(const aName: Il3CString): TtfwKeyWord;
  function DoGetDRbyCName(const aName: Il3CString): TtfwKeyWord;
  function IsMain: Boolean;
  function IsAxiom: Boolean;
  function Add(aWord: TtfwKeyWord): Integer;
  function CheckWord(const aName: Il3CString): TtfwKeyWord;
 end;//TtfwDictionary
 
implementation

uses
 l3ImplUses
 , l3Types
 , l3String
 , Math
 , tfwDictionaryWordsPack
 , SysUtils
;

end.
