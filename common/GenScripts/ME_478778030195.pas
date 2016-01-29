unit l3LocaleInfo;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
;

type
 Tl3BaseLocaleInfo = class(Tl3ProtoObject, Il3LocaleInfo)
  function Id: LCID;
   {* ������������� �����. }
  function Language: AnsiString;
   {* ����. }
  function SubLanguage: AnsiString;
   {* �������. }
  function Name: AnsiString;
   {* ������. }
 end;//Tl3BaseLocaleInfo
 
 Tl3UnixLocaleInfo = class(Tl3BaseLocaleInfo)
 end;//Tl3UnixLocaleInfo
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
