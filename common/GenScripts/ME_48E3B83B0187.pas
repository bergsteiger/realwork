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
   {* сохраняет выделение в G }
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* сохраняет выделение в G. }
  function Store(aFormat: TevdClipboardFormat;
   const aPool: IStream;
   const aFilters: TevdTagGenerator;
   aFlags: TevdStoreFlags): Boolean; overload;
   {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
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
