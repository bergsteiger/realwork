{$IfNDef atStringConverter_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atStringConverter.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::CoreObjects::atStringConverter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atStringConverter_imp}
 _FirstType_ = AnsiString;
 {$Include ..\CoreObjects\atConverter.imp.pas}
 _atStringConverterImp_Parent_ = _atConverter_;
 {$Include ..\CoreObjects\atStringConverterImp.imp.pas}
 _atStringConverter_ = {mixin} class(_atStringConverterImp_)
 end;//_atStringConverter_

{$Else atStringConverter_imp}

{$Include ..\CoreObjects\atConverter.imp.pas}

{$Include ..\CoreObjects\atStringConverterImp.imp.pas}


{$EndIf atStringConverter_imp}
