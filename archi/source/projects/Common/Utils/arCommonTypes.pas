unit arCommonTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Utils"
// ������: "w:/archi/source/projects/Common/Utils/arCommonTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> archi$common::Utils::arCommonTypes
//
// ����� ���� ��� ���� � ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
  evdTypes
  ;

type
 TSubType = (
   stSub
 , stBlock
 );//TSubType

 IarCheckLeftOrRightBlock = interface(IUnknown)
   ['{994BAAA2-978D-4CB7-B149-87D84CF4423A}']
   function HasAACBlock(aLeft: Boolean): Boolean;
   procedure SetBlockKind(aOldSubID: Integer;
    aNewSubID: Integer;
    aBlockKind: TevBlockViewKind);
 end;//IarCheckLeftOrRightBlock

 IevClearPreviewLink = interface(IUnknown)
   ['{2D16504C-B2BF-4480-84CA-C068F041C296}']
   procedure ClearPreview;
 end;//IevClearPreviewLink

implementation

end.