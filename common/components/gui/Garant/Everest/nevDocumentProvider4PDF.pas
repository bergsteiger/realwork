unit nevDocumentProvider4PDF;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/nevDocumentProvider4PDF.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Printing::TnevDocumentProvider4PDF
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevDocumentProviderEx,
  afwInterfaces
  ;

type
 TnevDocumentProvider4PDF = class(TnevDocumentProviderEx)
 protected
 // overridden property methods
   function pm_GetCanProvideOriginalDocument: Boolean; override;
   function pm_GetPageSetup: IafwPageSetup; override;
 end;//TnevDocumentProvider4PDF

implementation

// start class TnevDocumentProvider4PDF

function TnevDocumentProvider4PDF.pm_GetCanProvideOriginalDocument: Boolean;
//#UC START# *4CB589C80045_541149B203E1get_var*
//#UC END# *4CB589C80045_541149B203E1get_var*
begin
//#UC START# *4CB589C80045_541149B203E1get_impl*
 Result := False;
//#UC END# *4CB589C80045_541149B203E1get_impl*
end;//TnevDocumentProvider4PDF.pm_GetCanProvideOriginalDocument

function TnevDocumentProvider4PDF.pm_GetPageSetup: IafwPageSetup;
//#UC START# *4D18832500B4_541149B203E1get_var*
//#UC END# *4D18832500B4_541149B203E1get_var*
begin
//#UC START# *4D18832500B4_541149B203E1get_impl*
 Result := Self;
//#UC END# *4D18832500B4_541149B203E1get_impl*
end;//TnevDocumentProvider4PDF.pm_GetPageSetup

end.