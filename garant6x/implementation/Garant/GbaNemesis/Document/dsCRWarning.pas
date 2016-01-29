unit dsCRWarning;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Document"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Document/dsCRWarning.pas"
// Начат: 23.12.2011 17:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Контроллер работы с документом и абстрактная фабрика документа::F1 Document Processing::Document::Document::TdsCRWarning
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsWarning,
  nevBase,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsCRWarning = {vac} class(TdsWarning)
 protected
 // overridden protected methods
   function DoGenerateWarning(const aGenerator: InevTagGenerator;
     aUserType: Integer): TWarningTypeSet; override;
 end;//TdsCRWarning
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaloonWarningUserTypes_remListModified_UserType,
  nsListWarningGenerator
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsCRWarning

function TdsCRWarning.DoGenerateWarning(const aGenerator: InevTagGenerator;
  aUserType: Integer): TWarningTypeSet;
//#UC START# *4EF4849D01C9_4EF485030376_var*
//#UC END# *4EF4849D01C9_4EF485030376_var*
begin
//#UC START# *4EF4849D01C9_4EF485030376_impl*
 if (aUserType = remListModified) then
  Result := TnsListWarningGenerator.Generate(Self,
                                             Self.pm_GetDocInfo.Doc,
                                             aGenerator,
                                             aUserType,
                                             nil)
 else
  Result := inherited DoGenerateWarning(aGenerator, aUserType);
//#UC END# *4EF4849D01C9_4EF485030376_impl*
end;//TdsCRWarning.DoGenerateWarning

{$IfEnd} //not Admin AND not Monitorings

end.