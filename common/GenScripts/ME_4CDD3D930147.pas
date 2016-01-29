unit evdHyperlinkInfo;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evdInterfaces
 , l3Interfaces
;

type
 TevdHyperlinkInfo = class(Tl3ProtoObject, IevdHyperlinkInfo)
  procedure Create(const aText: Il3CString;
   const anAddress: TevdAddress;
   const anAppInfo: Il3CString);
  function Make(const aText: Il3CString;
   const anAddress: TevdAddress;
   const anAppInfo: Il3CString): IevdHyperlinkInfo;
  function Text: Il3CString;
   {* ����� ������ }
  function Address: TevdAddress;
   {* ����� }
  function AppInfo: Il3CString;
   {* ���������� � ���������� }
 end;//TevdHyperlinkInfo
 
implementation

uses
 l3ImplUses
;

end.
