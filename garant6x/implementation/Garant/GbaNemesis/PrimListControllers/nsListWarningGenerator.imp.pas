{$IfNDef nsListWarningGenerator_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PrimListControllers"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/PrimListControllers/nsListWarningGenerator.imp.pas"
// Начат: 04.05.2011 18:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Base Operations::PrimListControllers::PrimListControllersRealization::nsListWarningGenerator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsListWarningGenerator_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _nsListWarningGenerator_ = {mixin} class(_nsListWarningGenerator_Parent_)
 public
 // realized methods
   function Generate(const aWarning: IdsWarning;
    const aGen: InevTagGenerator;
    aUserType: TvcmUserType): TWarningTypeSet;
     {* Результат сообщает о том, какие предупреждения есть у документа. Если нет ни одного предупреждения, то вернется cEmptyWarning }
 end;//_nsListWarningGenerator_
{$Else}

 _nsListWarningGenerator_ = _nsListWarningGenerator_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else nsListWarningGenerator_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _nsListWarningGenerator_

function _nsListWarningGenerator_.Generate(const aWarning: IdsWarning;
  const aGen: InevTagGenerator;
  aUserType: TvcmUserType): TWarningTypeSet;
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

{$IfEnd} //not Admin AND not Monitorings

{$EndIf nsListWarningGenerator_imp}
