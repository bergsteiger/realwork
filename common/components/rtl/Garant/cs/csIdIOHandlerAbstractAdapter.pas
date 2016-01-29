unit csIdIOHandlerAbstractAdapter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/csIdIOHandlerAbstractAdapter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Core::TcsIdIOHandlerAbstractAdapter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csIdIOHandlerAbstractAdapterPrim
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsIdIOHandlerAbstractAdapter = {abstract} class(TcsIdIOHandlerAbstractAdapterPrim)
 public
 // public methods
   procedure WriteBufferOpen(AThreshhold: Integer); virtual; abstract;
   procedure WriteBufferClose; virtual; abstract;
   procedure WriteBufferClear; virtual; abstract;
   function Connected: Boolean; virtual; abstract;
   procedure WriteFile(const aFile: AnsiString); virtual; abstract;
   procedure InputBufferClear; virtual; abstract;
 end;//TcsIdIOHandlerAbstractAdapter
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.