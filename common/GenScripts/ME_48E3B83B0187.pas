unit evMultiSelectionBlock;

interface

uses
 l3IntfUses
 , evMultiSelectionText
 , evdInterfaces
 , nevTools
 , nevBase
 , l3Interfaces
;

type
 TevMultiSelectionBlock = class(TevMultiSelectionText, IevdDataObject, InevDataObjectPrim2)
  procedure DoStore(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags);
   {* ��������� ��������� � G }
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* ��������� ��������� � G. }
  function Store(aFormat: TevdClipboardFormat;
   const aPool: IStream;
   const aFilters: TevdTagGenerator;
   aFlags: TevdStoreFlags): Boolean; overload;
   {* ��������� ��������� � ������� aFormat � Pool, ������� ������ ������������� IStream. }
  function GetData: IevdDataObject;
  function GetAsStorable: InevDataObjectPrim2;
 end;//TevMultiSelectionBlock
 
implementation

uses
 l3ImplUses
 , l3InterfacedString
 , k2BaseTypes
 , l3Base
 , nevFacade
 , ContentsElement_Const
 , Block_Const
 , Document_Const
 , k2Tags
;

end.
