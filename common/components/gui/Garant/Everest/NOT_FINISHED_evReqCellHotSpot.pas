unit NOT_FINISHED_evReqCellHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evReqCellHotSpot.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::HotSpots::evReqCellHotSpot
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
  evTableCellHotSpot
  ;

{$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
type
 TevReqCellHotSpotTester = class(TevTableCellHotSpotTester)
 end;//TevReqCellHotSpotTester
{$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
{$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}


{$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
{$IfEnd} //evNeedHotSpot
end.