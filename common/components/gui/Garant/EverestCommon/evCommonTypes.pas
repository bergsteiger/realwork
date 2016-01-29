unit evCommonTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestCommon"
// ������: "w:/common/components/gui/Garant/EverestCommon/evCommonTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::EverestCommon::evCommonTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  l3Interfaces,
  k2Interfaces,
  nevBase,
  nevTools,
  nevInternalInterfaces,
  evdInterfaces,
  evOldEverestTypes,
  k2CustomReader,
  l3Variant
  ;

type
 TevGenerator = nevBase.InevTagGenerator;

 TevCustomFileReader = k2CustomReader.Tk2CustomReader;

 TnevCustomUndoBuffer = l3Variant.Ik2UndoBuffer;

 TnevLocation = nevTools.InevLocation;

 TnevCursor = nevTools.InevBasePoint;

 TnevBaseCursor = nevTools.InevBasePoint;

 InevCommonPoint = nevTools.InevBasePoint;

 TnevIRange = nevTools.InevRange;

 TnevBlock = nevTools.InevRange;

 InevTagSelection = nevTools.InevRange;

 IevCommonDataObject = evdInterfaces.IevdDataObject;

 TevFileReader = k2CustomReader.Tk2CustomReader;

 InevRange = nevTools.InevRange;

 InevPointTool = nevTools.InevPoint;

 InevSelection = nevTools.InevSelection;

implementation

end.