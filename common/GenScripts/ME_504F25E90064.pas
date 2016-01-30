{$IfNDef atStringConverter_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringConverter.imp.pas"
// Стереотип: "Impurity"

{$Define atStringConverter_imp}

 _FirstType_ = AnsiString;
 {$Include atConverter.imp.pas}
 _atStringConverterImp_Parent_ = _atConverter_;
 {$Include atStringConverterImp.imp.pas}
 _atStringConverter_ = class(_atStringConverterImp_)
 end;//_atStringConverter_

{$Else atStringConverter_imp}

{$IfNDef atStringConverter_imp_impl}

{$Define atStringConverter_imp_impl}

{$Include atConverter.imp.pas}

{$Include atStringConverterImp.imp.pas}

{$EndIf atStringConverter_imp_impl}

{$EndIf atStringConverter_imp}

