unit vcmStatusElement;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmStatusElement - }
{ Начат: 23.12.2004 09:41 }
{ $Id: vcmStatusElement.pas,v 1.17 2012/08/10 14:13:36 lulin Exp $ }

// $Log: vcmStatusElement.pas,v $
// Revision 1.17  2012/08/10 14:13:36  lulin
// {RequestLink:382420790}
//
// Revision 1.16  2012/08/06 17:03:11  lulin
// {RequestLink:380046115}
//
// Revision 1.15  2012/01/24 16:30:02  lulin
// {RequestLink:330139744}
// - вставляем диагностику на предмет того, что формы не могут иметь одинаковые идентификаторы.
// - избавляемся от нетипизированных списков.
//
// Revision 1.14  2010/01/14 13:04:43  lulin
// {RequestLink:177963744}.
//
// Revision 1.13  2009/02/12 18:06:10  lulin
// - <K>: 135604584. Переносим константы.
//
// Revision 1.12  2009/01/30 07:59:24  lulin
// - <K>: 122674504.
//
// Revision 1.11  2008/04/23 13:01:52  lulin
// - cleanup.
//
// Revision 1.10  2008/04/23 12:53:35  lulin
// - cleanup.
//
// Revision 1.9  2008/04/23 12:44:29  oman
// - fix: Вставили assert (cq28922)
//
// Revision 1.8  2008/04/23 12:42:06  oman
// - fix: Для формы из сборки уточняем статус у самой сборки - и не падаем при этом (cq28922)
//
// Revision 1.7  2008/04/23 07:24:43  oman
// - new: Для формы из сборки уточняем статус у самой сборки (cq28922)
//
// Revision 1.6  2008/01/26 08:36:33  mmorozov
// - new behaviour: если активная форма в строку состояния ничего не выводит, то показываем строку состояния от формы в _vcm_ztParent зоне  (CQ: OIT5-10956);
//
// Revision 1.5  2007/03/16 13:56:52  lulin
// - переходим на собственную функцию форматирования строк.
//
// Revision 1.4  2007/02/12 16:40:27  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.3  2006/12/22 12:19:30  oman
// - new: Для статусбара кроме списка строк передаем еще признак о
//  необходимости вывода переливающегося  прогресс-индикатора
//  (cq23938)
//
// Revision 1.2  2005/01/11 08:19:52  lulin
// - bug fix: не компилировалось.
//
// Revision 1.1  2004/12/23 07:27:54  lulin
// - перевел обработку статусной строки на библиотеку AFW.
//

{$Include vcmDefine.inc }

interface

uses
  l3Interfaces,
  l3CProtoObject,

  afwInterfaces,

  vcmInterfaces,
  vcmBase
  ;

type
  TvcmStatusElement = class(Tl3CProtoObject{TvcmCacheableBase}, IafwStatusElement)
    protected
    // interface methods
      // IafwStatusElement
      procedure GetStatusInfo(out theString: Il3CString; out theNeedProgress: Boolean);
        {-}
    public
    // public methods
      class function Make: IafwStatusElement;
        reintroduce;
        {-}
  end;//TvcmStatusElement

implementation

uses
  SysUtils,

  vcmInternalConst
  ;

// start class TvcmStatusElement

class function TvcmStatusElement.Make: IafwStatusElement;
  //reintroduce;
  {-}
var
 l_Element : TvcmStatusElement;
begin
 l_Element := Create;
 try
  Result := l_Element;
 finally
  vcmFree(l_Element);
 end;//try..finally
end;

procedure TvcmStatusElement.GetStatusInfo(out theString: Il3CString; out theNeedProgress: Boolean);
  {-}

 procedure lp_ExtractStatus(const aForm: IvcmEntityForm);
 var
  l_Status : TvcmStatusStrings;
 begin
  Assert(aForm <> nil);
  // http://mdp.garant.ru/pages/viewpage.action?pageId=89106247&focusedCommentId=89106273#comment-89106273
  //if (aForm <> nil) then
   if aForm.GetStatus(l_Status) then
   begin
    if (Length(l_Status.rStrings) > 0) then
     theString := l_Status.rStrings[0];
    theNeedProgress := l_Status.rNeedProgress;
   end//aForm.GetStatus(l_Status)..
   else
    theNeedProgress := false;
 end;//lp_ExtractStatus

var
 l_ActiveForm : IvcmEntityForm;
 l_ParentForm : IvcmEntityForm;
 l_Container  : IvcmContainer;
begin
 theString := nil;
 theNeedProgress := False;
 if (vcmDispatcher <> nil) then
 begin
  if Supports(vcmDispatcher.ActiveEntity, IvcmEntityForm, l_ActiveForm) then
  begin
   // Получим информацию для строки состояния у активной формы:
   lp_ExtractStatus(l_ActiveForm);
   // Если активная форма ничего в строку состояния не пишет, то пытаемся обращаться к сборке
   if vcmIsNil(theString) then
    if Assigned(l_ActiveForm.DataSource) and
       Assigned(l_ActiveForm.DataSource.UseCaseController) and
       Assigned(l_ActiveForm.DataSource.UseCaseController.FormSet) then
    begin
     l_ParentForm := l_ActiveForm.DataSource.UseCaseController.FormSet.FindStatusInfoForm;
     if Assigned(l_ParentForm) and (l_ParentForm <> l_ActiveForm) then
      lp_ExtractStatus(l_ParentForm);
    end;//Assigned(l_ActiveForm.DataSource)..
   // Если активная форма ничего в строку состояния не пишет, то выводим
   // информацию формы в _vcm_ztParent зоне:
   if vcmIsNil(theString) then
    if Supports(vcmDispatcher.FormDispatcher.
         CurrentMainForm, IvcmContainer, l_Container) and
         l_Container.HasForm(fm_Any, {_vcm_ztParent}vcm_ztMainObjectForm, True, @l_ParentForm) and
         (l_ParentForm <> l_ActiveForm) then
     lp_ExtractStatus(l_ParentForm);
  end;//Supports(vcmDispatcher.ActiveEntity, IvcmEntityForm, l_ActiveForm)
 end;//vcmDispatcher <> nil
end;//GetStatusInfo

end.

