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
   {* сохраняет объект в поток }
  procedure SaveUF(const aString: AnsiString;
   const anUF: IvcmUserFriendlyControl;
   const aSuffix: AnsiString;
   aNeedClose: Boolean); overload;
   {* сохраняет объект в поток }
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
