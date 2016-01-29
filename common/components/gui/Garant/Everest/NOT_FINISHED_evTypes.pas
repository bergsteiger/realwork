unit NOT_FINISHED_evTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evTypes.pas"
// �����: 11.12.96
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::evTypes
//
// ������� ���� ���������� "�������".
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces
  ;

type
 TevSelectTarget = (
   ev_stChar
 , ev_stWord
 , ev_stLine
 , ev_stPara
 , ev_stDocument
 );//TevSelectTarget

 TevSearchOptionEx = (
  {* ����� ������/������. }
   ev_soFind
 , ev_soBackward
 , ev_soMatchCase
 , ev_soGlobal
 , ev_soReplace
 , ev_soReplaceAll
 , ev_soWholeWord
 , ev_soSelText
 , ev_soConfirm
 , ev_soDocumentPart
 );//TevSearchOptionEx

 TevSearchOptionSetEx = set of TevSearchOptionEx;
  {* ����� ����� ������/������. }

 TevSearchOption = ev_soFind..ev_soConfirm;
  {* ��������� ����� ������/������. }

 TevSearchOptionSet = set of TevSearchOption;
  {* ����� ��������� ����� ������/������. }

const
  { Clipboard Formats }
 

type
 TevPageColontituls = (
   pcUpLeftFirst
 , pcUpRightFirst
 , pcDownLeftFirst
 , pcDownRightFirst
 , pcUpLeft
 , pcUpRight
 , pcDownLeft
 , pcDownRight
 );//TevPageColontituls

 TevFormat = l3Interfaces.Tl3ClipboardFormat;
  {* ������������� ������� ������. ����� ����:
         cf_EverestBin. cf_EverestTxt, cf_RTF, cf_RTFLite, cf_Text, cf_OEMText etc. }

 TevStyleId = ;

 TevPixel = ;

implementation

end.