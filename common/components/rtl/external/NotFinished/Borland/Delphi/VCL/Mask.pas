unit Mask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Vcl"
// ������: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Vcl/Mask.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Vcl::Implementation::Mask
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If not defined(NoVCL)}
uses
  StdCtrls
  ;

type
 TCustomMaskEdit = class(TCustomEdit)
 protected
 // protected methods
    {$If defined(l3HackedVCL) AND not defined(DesignTimeLibrary) AND not defined(NoVCL)}
   function TextFromClipboard: AnsiString; virtual;
    {$IfEnd} //l3HackedVCL AND not DesignTimeLibrary AND not NoVCL
 end;//TCustomMaskEdit
{$IfEnd} //not NoVCL

implementation

{$If not defined(NoVCL)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TCustomMaskEdit

{$If defined(l3HackedVCL) AND not defined(DesignTimeLibrary) AND not defined(NoVCL)}
function TCustomMaskEdit.TextFromClipboard: AnsiString;
//#UC START# *554CBB4B0240_52A9ADCB0092_var*
//#UC END# *554CBB4B0240_52A9ADCB0092_var*
begin
//#UC START# *554CBB4B0240_52A9ADCB0092_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBB4B0240_52A9ADCB0092_impl*
end;//TCustomMaskEdit.TextFromClipboard
{$IfEnd} //l3HackedVCL AND not DesignTimeLibrary AND not NoVCL
{$IfEnd} //not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� TCustomMaskEdit
 TtfwClassRef.Register(TCustomMaskEdit);
{$IfEnd} //not NoScripts AND not NoVCL

end.