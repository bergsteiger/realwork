unit ddPipeOutInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/ddPipeOutInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::dd::ddPipeOutInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Interfaces,
  l3Filer
  ;

type
 TddExportDocPart = (
   edpDocument
 , edpReference
 , edpAnnotation
 );//TddExportDocPart

 IddExportFilerDispatcherElem = interface(IUnknown)
   ['{3CED5DB0-6E54-4C2F-A404-FCE80475BDAF}']
   procedure RollBack;
     {* ��������� ������ RollBack }
   function Get_Filer: Tl3CustomFiler;
   property Filer: Tl3CustomFiler
     read Get_Filer;
 end;//IddExportFilerDispatcherElem

 TddFilerDispatcherMapKeyRecord = record
   rPart : TddExportDocPart;
   rAccGroup : Il3CString;
 end;//TddFilerDispatcherMapKeyRecord

 TddExportDivideBy = (
   edbTopic
 , edbSize
 , edbAccGroup
 );//TddExportDivideBy

 TddExportDivideBySet = set of TddExportDivideBy;

 TddExportFileMaskPatternType = (
   eptPartNum
 , eptAccGroup
 , eptExportDate
 );//TddExportFileMaskPatternType

const
  { cExportFileMaskPatterns }
 cExportFileMaskPatterns : array [TddExportFileMaskPatternType] of Tl3WString = (
  (S: '%NUMBER%'; SLen: 8; SCodePage: 0)
  , (S: '%MAIN%'; SLen: 6; SCodePage: 0)
  , (S: '%DATE%'; SLen: 6; SCodePage: 0)
 );//cExportFileMaskPatterns
  { cDefaultFileMask }
 cDefaultFileMask : array [TddExportDocPart] of AnsiString = (
  'document'
  , 'related'
  , 'annotation'
 );//cDefaultFileMask
  { ��������� }
 cFilerOpenErrorMsg = 'CRITICAL ERROR: ������ (%s) �������� ����� %s';

implementation

end.