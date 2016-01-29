unit evTreeStorable;

interface

uses
 l3IntfUses
 , evStorable
 , nevBase
 , evdInterfaces
 , nevTools
;

type
 TevTreeStorableData = record
 end;//TevTreeStorableData
 
 TevTreeStorable = class(TevStorable)
  procedure DoStoreNode(const aNode: InevSimpleNode;
   const G: InevTagGenerator;
   aLevel: Integer);
  procedure DoIterateTree(const G: InevTagGenerator;
   aFlags: TevStoreFlags);
  procedure Create(const aData: TevTreeStorableData;
   const aReader: InevTagReader;
   aLevelIndent: Integer;
   const aSubRoot: InevSimpleNode);
  function Make(const aData: TevTreeStorableData;
   const aReader: InevTagReader;
   aLevelIndent: Integer;
   const aSubRoot: InevSimpleNode): IevdDataObject;
  function MakeStorable(const aData: TevTreeStorableData;
   const aReader: InevTagReader;
   aLevelIndent: Integer;
   const aSubRoot: InevSimpleNode): InevStorable;
  procedure DoStore(const G: InevTagGenerator;
   aFlags: TevdStoreFlags);
 end;//TevTreeStorable
 
implementation

uses
 l3ImplUses
 , l3Defaults
 , l3Base
 , nevPersistentDocumentContainer
 , k2Tags
 , SysUtils
 , l3TreeInterfaces
 , l3Nodes
 , TextPara_Const
 , Document_Const
;

end.
