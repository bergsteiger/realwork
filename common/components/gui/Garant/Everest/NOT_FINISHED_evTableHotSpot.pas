unit NOT_FINISHED_evTableHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evTableHotSpot.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevTableHotSpot
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot)}
uses
  evParaListHotSpotTester,
  evSelectingHotSpot
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevTableHotSpotTester = class(TevParaListHotSpotTester)
 end;//TevTableHotSpotTester

 TevTableHotSpot = class(TevSelectingHotSpot)
 end;//TevTableHotSpot
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}


{$IfEnd} //evNeedHotSpot
end.