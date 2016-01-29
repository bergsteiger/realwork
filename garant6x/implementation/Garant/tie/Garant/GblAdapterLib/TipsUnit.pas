unit TipsUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/TipsUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Tips
//
// ����� ���
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  DynamicTreeUnit
  ;

type
 ITipsManager = interface(IUnknown)
  {* �������� ������� ��� }
   ['{E7AFD5DA-77C8-4E4E-95C3-D54CBB8CD5D7}']
   function GetTipsTreeRoot: INodeBase; stdcall;
   procedure GetCurrentTip(out aRet {: INodeIndexPath}); stdcall;
     {* �������� ������� (�� ��������) ����� ��� }
   function IsExist: ByteBool; stdcall;
   property tips_tree_root: INodeBase
     read GetTipsTreeRoot;
     {* ��� ������ ����� ��� }
 end;//ITipsManager

implementation

end.