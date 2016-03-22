unit ddRTFReaderSpec;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/ddRTFReaderSpec.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::Readers::TddRTFReaderSpec
//
// ������� �� ������������ ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddRTFReader,
  destNorm
  ;

type
 TddRTFReaderSpec = class(TddRTFReader)
  {* ������� �� ������������ ���������. }
 protected
 // overridden protected methods
   function GetdestNormClass: RdestNorm; override;
 end;//TddRTFReaderSpec

implementation

uses
  destNormSpec
  ;

// start class TddRTFReaderSpec

function TddRTFReaderSpec.GetdestNormClass: RdestNorm;
//#UC START# *56BB204702E6_56BB14B90213_var*
//#UC END# *56BB204702E6_56BB14B90213_var*
begin
//#UC START# *56BB204702E6_56BB14B90213_impl*
 Result := TdestNormSpec;
//#UC END# *56BB204702E6_56BB14B90213_impl*
end;//TddRTFReaderSpec.GetdestNormClass

end.