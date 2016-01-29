unit dsMainList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "List"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/List/dsMainList.pas"
// Начат: 2007/04/06 13:04:11
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Работа с документом и списком документов::WorkWithList::List::List::TdsMainList
//
// Список документов прецедента "Список". Списков в системе много, а сообщать о смене текущего
// прецеденту должен только один - список документов прецедента "Cписок". Для этой цели создан
// dsMainList с перекрытым NotifyAboutChangeCurrent
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
  dsDocumentList,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsMainList = {vac} class(TdsDocumentList)
  {* Список документов прецедента "Список". Списков в системе много, а сообщать о смене текущего прецеденту должен только один - список документов прецедента "Cписок". Для этой цели создан dsMainList с перекрытым NotifyAboutChangeCurrent }
 protected
 // overridden protected methods
   function NotifyAboutChangeCurrent: Boolean; override;
     {* уведомлять бизнес объект прецедента о смене текущего. }
   function DoIsMain: Boolean; override;
     {* - определяет список в основной зоне приложения. }
   function DoGetIsShortList: Boolean; override;
   procedure DoSetupNewSimpleTree(const aTree: Il3SimpleTree); override;
   function DoGetIsSnippet: Boolean; override;
   function DoCanAnalize: Boolean; override;
 end;//TdsMainList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsMainList

function TdsMainList.NotifyAboutChangeCurrent: Boolean;
//#UC START# *47F0D913030D_4926C0970020_var*
//#UC END# *47F0D913030D_4926C0970020_var*
begin
//#UC START# *47F0D913030D_4926C0970020_impl*
 Result := true;
//#UC END# *47F0D913030D_4926C0970020_impl*
end;//TdsMainList.NotifyAboutChangeCurrent

function TdsMainList.DoIsMain: Boolean;
//#UC START# *47FB00640212_4926C0970020_var*
//#UC END# *47FB00640212_4926C0970020_var*
begin
//#UC START# *47FB00640212_4926C0970020_impl*
 Result := true;
//#UC END# *47FB00640212_4926C0970020_impl*
end;//TdsMainList.DoIsMain

function TdsMainList.DoGetIsShortList: Boolean;
//#UC START# *4A2D0838019C_4926C0970020_var*
//#UC END# *4A2D0838019C_4926C0970020_var*
begin
//#UC START# *4A2D0838019C_4926C0970020_impl*
 Result := Assigned(ImpList) and ImpList.GetIsShort;
//#UC END# *4A2D0838019C_4926C0970020_impl*
end;//TdsMainList.DoGetIsShortList

procedure TdsMainList.DoSetupNewSimpleTree(const aTree: Il3SimpleTree);
//#UC START# *4A4074FB0192_4926C0970020_var*
//#UC END# *4A4074FB0192_4926C0970020_var*
begin
//#UC START# *4A4074FB0192_4926C0970020_impl*
 if DoGetIsSnippet then
  aTree.ExpandSubDir(nil, True, 0);
//#UC END# *4A4074FB0192_4926C0970020_impl*
end;//TdsMainList.DoSetupNewSimpleTree

function TdsMainList.DoGetIsSnippet: Boolean;
//#UC START# *4A796F46039D_4926C0970020_var*
//#UC END# *4A796F46039D_4926C0970020_var*
begin
//#UC START# *4A796F46039D_4926C0970020_impl*
 Result := Assigned(ImpList) and ImpList.GetIsSnippet;
//#UC END# *4A796F46039D_4926C0970020_impl*
end;//TdsMainList.DoGetIsSnippet

function TdsMainList.DoCanAnalize: Boolean;
//#UC START# *4AA0F2E70398_4926C0970020_var*
//#UC END# *4AA0F2E70398_4926C0970020_var*
begin
//#UC START# *4AA0F2E70398_4926C0970020_impl*
 Result := true;
//#UC END# *4AA0F2E70398_4926C0970020_impl*
end;//TdsMainList.DoCanAnalize

{$IfEnd} //not Admin AND not Monitorings

end.