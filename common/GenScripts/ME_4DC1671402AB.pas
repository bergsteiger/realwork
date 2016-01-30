{$IfNDef nsListWarningGenerator_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas"
// Стереотип: "Impurity"

{$Define nsListWarningGenerator_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _nsListWarningGenerator_ = class(_nsListWarningGenerator_Parent_)
  public
   function Generate(const aWarning: IdsWarning;
    const aGen: InevTagGenerator;
    aUserType: TvcmUserType): TWarningTypeSet;
    {* Результат сообщает о том, какие предупреждения есть у документа. Если нет ни одного предупреждения, то вернется cEmptyWarning }
 end;//_nsListWarningGenerator_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_nsListWarningGenerator_ = _nsListWarningGenerator_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else nsListWarningGenerator_imp}

{$IfNDef nsListWarningGenerator_imp_impl}

{$Define nsListWarningGenerator_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _nsListWarningGenerator_.Generate(const aWarning: IdsWarning;
 const aGen: InevTagGenerator;
 aUserType: TvcmUserType): TWarningTypeSet;
 {* Результат сообщает о том, какие предупреждения есть у документа. Если нет ни одного предупреждения, то вернется cEmptyWarning }
//#UC START# *493E4F7E039B_4DC1671402AB_var*
var
 l_dsDocument : IdsBaseDocument;
 l_DocInfo    : IdeDocInfo;
 l_Document   : IDocument;
//#UC END# *493E4F7E039B_4DC1671402AB_var*
begin
//#UC START# *493E4F7E039B_4DC1671402AB_impl*
 l_dsDocument := Self.pm_GetDsDocument;
 if (l_dsDocument <> nil) then
 begin
  l_DocInfo := l_dsDocument.DocInfo;
  if (l_DocInfo <> nil) then
   l_Document := l_DocInfo.Doc
  else
   l_Document := nil;
 end//l_dsDocument <> nil
 else
 begin
  l_DocInfo := nil;
  l_Document := nil;
 end;//l_dsDocument <> nil
 Result := TnsListWarningGenerator.Generate(aWarning,
                                            l_Document,
                                            aGen, aUserType,
                                            l_dsDocument As IucpUnderControl);
//#UC END# *493E4F7E039B_4DC1671402AB_impl*
end;//_nsListWarningGenerator_.Generate
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf nsListWarningGenerator_imp_impl}

{$EndIf nsListWarningGenerator_imp}

