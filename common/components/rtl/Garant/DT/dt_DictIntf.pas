unit dt_DictIntf;

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3TreeInterfaces,
  l3Types,
  l3Base,
  l3Tree_TLB,
  Dt_Types{, Dt_DictConst}
  ;

type
 IDictItem = interface(IUnknown)
     ['{34367420-E302-11D3-A0B3-0060083017DC}']
  function  di_Get_Handle : TDictID;
  function  di_Get_Name : Tl3PCharLenPrim;

  property Handle   : TDictID read di_Get_Handle;
  property Name     : Tl3PCharLenPrim read di_Get_Name;
 end;

 IDictItemPro = interface(IUnknown)
     ['{89957F41-FE93-11D3-A0B3-0060083017DC}']
  function  dip_RefCount : Longint;
  procedure dip_LinkDisconnect;

  function  dip_Get_LinkNode : Il3Node;
  procedure dip_Set_LinkNode(const Value : Il3Node);

  property LinkNode : Il3Node read dip_Get_LinkNode write dip_Set_LinkNode;
 end;

 IDictNode = interface(Il3HandleNode)
     ['{89957F40-FE93-11D3-A0B3-0060083017DC}']
  function  dn_IsLastEntry : Boolean;
  procedure dn_SetDictItem(aDictItem : IDictItem);
  function  GetDictNodeType : TDictNodeType;

  property  NodeType : TDictNodeType read GetDictNodeType;
 end;

const
 cUndefDictID = High(TDictID);

type 
 IPersistentNode = interface(IUnknown)
     ['{1435AC83-11CF-4C0D-A209-43A6C165019D}']
  function pn_CheckSaveStatus : boolean;

  procedure DeleteEx(aHeirID : TDictID = cUndefDictID; aDateDeleted: TDateTime = 0);
  property MaySaved : Boolean read pn_CheckSaveStatus;
 end;

implementation

end.