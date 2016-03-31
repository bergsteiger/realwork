{$IfNDef deDocInfoProvider_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Presentation\deDocInfoProvider.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "deDocInfoProvider" MUID: (4F54899502EA)
// Имя типа: "_deDocInfoProvider_"

{$Define deDocInfoProvider_imp}

 _deDocInfoProvider_ = class(_deDocInfoProvider_Parent_)
  protected
   function DocumentForDocInfoProvider: IDocument; virtual; abstract;
   {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
   function pm_GetDocInfo: IdeDocInfo;
   {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 end;//_deDocInfoProvider_

{$Else deDocInfoProvider_imp}

{$IfNDef deDocInfoProvider_imp_impl}

{$Define deDocInfoProvider_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _deDocInfoProvider_.pm_GetDocInfo: IdeDocInfo;
//#UC START# *4DF9D63B0360_4F54899502EAget_var*
//#UC END# *4DF9D63B0360_4F54899502EAget_var*
begin
//#UC START# *4DF9D63B0360_4F54899502EAget_impl*
 Result := TdeDocInfo.Make(DocumentForDocInfoProvider);
//#UC END# *4DF9D63B0360_4F54899502EAget_impl*
end;//_deDocInfoProvider_.pm_GetDocInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf deDocInfoProvider_imp_impl}

{$EndIf deDocInfoProvider_imp}

