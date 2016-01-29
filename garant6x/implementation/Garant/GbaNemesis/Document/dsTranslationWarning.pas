unit dsTranslationWarning;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Document"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Document/dsTranslationWarning.pas"
// Начат: 05.12.2011 20:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Контроллер работы с документом и абстрактная фабрика документа::F1 Document Processing::Document::Document::TdsTranslationWarning
//
// Предупреждение к переводу документа
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
  DocInfoInterfaces,
  DocumentInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsTranslationWarning = {vac} class(TdsWarning)
  {* Предупреждение к переводу документа }
 private
 // private fields
   ucc_DocInfo : IsdsDocInfo;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // overridden protected methods
   function DoGetDocInfo: IdeDocInfo; override;
 end;//TdsTranslationWarning
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsTranslationWarning

function TdsTranslationWarning.DoGetDocInfo: IdeDocInfo;
//#UC START# *4EDCF99301CA_4EDCF6BC00D9_var*
//#UC END# *4EDCF99301CA_4EDCF6BC00D9_var*
begin
//#UC START# *4EDCF99301CA_4EDCF6BC00D9_impl*
 // Assigned(ucc_DocInfo.dsTranslation) для http://mdp.garant.ru/pages/viewpage.action?pageId=325259961
 if Assigned(ucc_DocInfo) and Assigned(ucc_DocInfo.dsTranslation) then
  Result := ucc_DocInfo.dsTranslation.DocInfo
 else
  Result := nil;
//#UC END# *4EDCF99301CA_4EDCF6BC00D9_impl*
end;//TdsTranslationWarning.DoGetDocInfo

procedure TdsTranslationWarning.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsDocInfo, ucc_DocInfo);
end;

procedure TdsTranslationWarning.ClearRefs;
begin
 inherited;
 ucc_DocInfo := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.