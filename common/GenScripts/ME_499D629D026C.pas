unit vcmWritersInterfaces;

interface

uses
 l3IntfUses
;

type
 IvcmXMLWriter = interface(Il3XMLWriter)
  procedure SaveUF(const aString: AnsiString;
   const anUF: IvcmUserFriendlyControl;
   aNeedClose: Boolean); overload;
   {* ��������� ������ � ����� }
  procedure SaveUF(const aString: AnsiString;
   const anUF: IvcmUserFriendlyControl;
   const aSuffix: AnsiString;
   aNeedClose: Boolean); overload;
   {* ��������� ������ � ����� }
 end;//IvcmXMLWriter
 
 IvcmContentWriter = interface(IvcmXMLWriter)
 end;//IvcmContentWriter
 
implementation

uses
 l3ImplUses
 , l3Interfaces
 , vcmUserControls
;

end.
