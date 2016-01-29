unit l3WideStringManager;

interface

uses
 l3IntfUses
 , l3SizedPoolManager
 , l3Interfaces
;

type
 Tl3WideStringManager = class(Tl3SizedPoolManager)
  {* �������� Unicode-����� }
  procedure Create(aBlockSize: Integer);
  function AllocString(const aString: WideString): PWideChar;
   {* ������������ ������ }
  procedure FreeString(var theString: PWideChar);
   {* ����������� ������ }
  function StringAsPCharLen(aString: PWideChar): Tl3WString;
   {* �������� ������ � Tl3PChatLen }
  function StringAsWideString(aString: PWideChar): WideString;
   {* �������� ������ � WideString }
 end;//Tl3WideStringManager
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
