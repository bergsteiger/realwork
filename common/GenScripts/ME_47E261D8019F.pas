unit nevDocumentContainerListPrim;
 {* ������ ����������� ����������. }

// ������: "w:\common\components\gui\Garant\Everest\new\nevDocumentContainerListPrim.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InevDocumentContainer;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 TnevDocumentContainerListPrim = class(_l3InterfaceRefList_)
  {* ������ ����������� ����������. }
 end;//TnevDocumentContainerListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnevDocumentContainerListPrim;

{$Include l3InterfaceRefList.imp.pas}

end.
