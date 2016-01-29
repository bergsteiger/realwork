unit tfwStandardDictionaries;

interface

uses
 l3IntfUses
 , tfwStandardDictionaryList
 , tfwStandardDictionary
 , l3Interfaces
;

type
 TtfwStandardDictionaries = class(TtfwStandardDictionaryList)
  function CheckDictionary(const aName: Il3CString): TtfwStandardDictionary;
  function FindDictionary(const aName: Il3CString): TtfwStandardDictionary;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwStandardDictionaries
 
implementation

uses
 l3ImplUses
 , l3String
 , SysUtils
;

end.
