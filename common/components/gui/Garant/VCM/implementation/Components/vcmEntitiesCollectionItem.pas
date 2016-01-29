unit vcmEntitiesCollectionItem;
{* Элемент коллекции сущностей. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmEntitiesCollectionItem - }
{ Начат: 11.03.2003 11:43 }
{ $Id: vcmEntitiesCollectionItem.pas,v 1.24 2015/10/04 17:37:06 kostitsin Exp $ }

// $Log: vcmEntitiesCollectionItem.pas,v $
// Revision 1.24  2015/10/04 17:37:06  kostitsin
// Рисуем TvcmBaseEntitiesCollectionItem
//
// Revision 1.23  2015/08/16 16:03:24  kostitsin
// {requestlink: 605157327 }
//
// Revision 1.22  2015/06/03 12:26:27  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.21  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.20  2012/04/06 13:20:00  lulin
// {RequestLink:237994598}
//
// Revision 1.19  2011/12/08 16:30:03  lulin
// {RequestLink:273590436}
// - чистка кода.
//
// Revision 1.18  2009/08/19 18:07:21  lulin
// {RequestLink:158795592}. Вставленный фрагмент из документа гаранта (вложенный k2_idDocument) сделать read-only, чтобы его можно было удалить только целиком.
//
// Revision 1.17  2009/02/20 17:29:20  lulin
// - чистка комментариев.
//
// Revision 1.16  2006/07/20 17:36:01  lulin
// - убраны параметры по умолчанию.
// - имя метода убрано из комментариев.
// - bug fix: в КЗ - рисовался "палец", теперь он правда рисуется в другом месте.
//
// Revision 1.15  2006/03/15 14:37:32  lulin
// - bug fix: писались не все сущности.
//
// Revision 1.14  2006/03/14 10:10:29  lulin
// - bug fix: не очищались провисшие ссылки - в результате была вероятность AV.
//
// Revision 1.13  2006/03/13 11:59:19  lulin
// - очищаем закешированные значения - чтобы взять актуальные названия элементов.
//
// Revision 1.12  2006/03/10 12:45:49  lulin
// - new behavior: берем Caption сущности из репозитория.
//
// Revision 1.11  2006/01/20 11:33:06  mmorozov
// 1. Нельзя было на панель инструментов положить неколько операций из разных сущностей с одинаковыми именами;
// 2. Если в панели инструментов встречаются операции с одинаковыми названиями, то им автоматически добавляется суффикс в виде названия сущности;
// 3. Появилась возможность указать, что контекстные операции сущности должны показываться в отдельном пункте меню;
// 3.
//
// Revision 1.10  2005/06/22 06:30:51  mmorozov
// remove: модуль в uses;
//
// Revision 1.9  2005/01/21 11:24:10  lulin
// - переименовал метод, чтобы название более соответствовало смыслу.
//
// Revision 1.8  2005/01/21 11:10:05  lulin
// - new behavior: не сохраняем операции, привязанные только к контролам.
//
// Revision 1.7  2003/11/30 12:12:29  law
// - cleanup: из централизованного хранилища убрано свойство Controls.
//
// Revision 1.6  2003/11/19 11:38:25  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//
// Revision 1.5  2003/11/18 19:35:54  law
// - new: начал делать общий репозиторий модулей, сущностей и операций в MenuManager'е. Чтобы все можно было править из одного места.
//
// Revision 1.4  2003/07/25 15:38:17  law
// - bug fix: бывал AV, когда вызывали операцию у сущности у которой не определено операций.
//
// Revision 1.3  2003/07/01 13:05:14  law
// - new method: _IeeEditor._GetHotspotOnPoint.
//
// Revision 1.2  2003/04/04 10:58:58  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - переименовываем MVC в VCM.
//
// Revision 1.22  2003/03/28 11:27:25  law
// - по идее Вована сделал редактор компонента, позволяющий быстро привязывать компонент к сущностям.
//
// Revision 1.21  2003/03/27 17:35:16  law
// - new method: TvcmEntitiesCollectionItem._SupportedBy.
//
// Revision 1.20  2003/03/26 12:13:41  law
// - cleanup.
//
// Revision 1.19  2003/03/24 14:04:06  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.18  2003/03/24 13:25:47  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.17  2003/03/21 12:34:43  law
// - new behavior: операциям добавлен список параметров.
//
// Revision 1.16  2003/03/21 11:32:11  law
// - change: добавлены редакторы свойства Caption.
//
// Revision 1.15  2003/03/21 10:13:35  law
// - cleanup: удалены модули vcm*Repository.
//
// Revision 1.14  2003/03/20 12:30:01  law
// - new behavior: сделана обработка контекстных операций.
//
// Revision 1.13  2003/03/19 16:31:51  law
// - new behavior: сделана более интеллектуальная сборка контекстного меню.
//
// Revision 1.12  2003/03/19 11:51:03  law
// - cleanup: добавлен метод TvcmCustomEntities.GetFirstFormItem.
//
// Revision 1.11  2003/03/18 15:39:05  law
// - new prop: TvcmEntitiesCollectionItem._Category.
//
// Revision 1.10  2003/03/13 09:52:02  law
// - new component: TvcmModuleDef.
//
// Revision 1.9  2003/03/11 15:34:30  law
// - new behavior: сделаны обработчики операций.
//
// Revision 1.8  2003/03/11 13:54:46  law
// - new unit: vcmEntitiesCollectionItemEntity.
//
// Revision 1.7  2003/03/11 13:37:24  law
// - new behavior: сделано привязывание управляющих элементов к сущностям.
//
// Revision 1.6  2003/03/11 12:44:42  law
// - new behavior: сделано вытаскивание сущностей и их операций из TvcmCustomEntities, которые лежат на форме для сущностей.
//
// Revision 1.5  2003/03/11 12:04:01  law
// - new units: vcmEntitiesRepository, vcmOperationsRepository.
//
// Revision 1.4  2003/03/11 09:38:16  law
// - new class: TvcmBaseCollectionItem.
//
// Revision 1.3  2003/03/11 09:31:23  law
// - new prop: TvcmEntitiesCollectionItem.Operations.
//
// Revision 1.2  2003/03/11 09:17:55  law
// - new prop: TvcmEntitiesCollectionItem.Name.
//
// Revision 1.1  2003/03/11 09:02:13  law
// - new class: TvcmEntitiesCollection.
//

{$Include vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  
  vcmBaseCollection,
  vcmBaseEntitiesCollectionItem
  ;

type
  TvcmEntitiesCollectionItem = class(TvcmBaseEntitiesCollectionItem)
   {* Элемент коллекции сущностей. }
    private
    // internal fields
      f_Rep : TvcmBaseEntitiesCollectionItem;
    protected
    // property methods
      {$IfNDef DesignTimeLibrary}
      function  pm_GetEntityDef: IvcmEntityDef;
        override;
        {-}
      {$EndIf  DesignTimeLibrary}
      function  pm_GetCaption: AnsiString;
        override;
        {-}
      function GetCaptionStored: Boolean;
        override;
        {-}
      procedure CaptionChanged;
        override;
        {-}
      function  GetOperationsStored: Boolean;
        override;
        {-}
      procedure BeforeAddToCache;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      procedure SetRep(aRep : TvcmBaseEntitiesCollectionItem);
        {-}
      class function GetOperationsCollectionClass: RvcmBaseCollection;
        override;
        {-}
    published
    // published properties
      property Controls;
        {-}
      property Options;
        {-}
  end;//TvcmEntitiesCollectionItem
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
uses
  vcmOperationsCollection,
  vcmRepEntitiesCollectionItem

  {$IfNDef DesignTimeLibrary}
  ,
  vcmBaseMenuManager
  {$EndIf  DesignTimeLibrary}
  ;

// start class TvcmEntitiesCollectionItem

procedure TvcmEntitiesCollectionItem.Cleanup;
  //override;
  {-}
begin
 if (f_Rep <> nil) then
  TvcmRepEntitiesCollectionItem(f_Rep).RemoveHolder(Self);
 inherited;
end;

procedure TvcmEntitiesCollectionItem.SetRep(aRep : TvcmBaseEntitiesCollectionItem);
  {-}
begin
 f_Rep := aRep;
end;
  
class function TvcmEntitiesCollectionItem.GetOperationsCollectionClass: RvcmBaseCollection;
  //override;
  {-}
begin
 Result := TvcmOperationsCollection;
end;

{$IfNDef DesignTimeLibrary}
function TvcmEntitiesCollectionItem.pm_GetEntityDef: IvcmEntityDef;
  //override;
  {-}
begin
 if (f_Rep = nil) AND (g_MenuManager <> nil) then
  f_Rep := g_MenuManager.ObjectByType(vcm_objEntity, Name) As TvcmBaseEntitiesCollectionItem;
 Result := inherited pm_GetEntityDef;
end;
{$EndIf  DesignTimeLibrary}

function TvcmEntitiesCollectionItem.pm_GetCaption: AnsiString;
  //override;
  {-}
begin
 if (f_Rep = nil) then
  Result := inherited pm_GetCaption
 else
  Result := f_Rep.Caption;
end;

function TvcmEntitiesCollectionItem.GetCaptionStored: Boolean;
  //override;
  {-}
begin
 if (f_Rep = nil) then
  Result := inherited GetCaptionStored
 else
  Result := false;
end;

procedure TvcmEntitiesCollectionItem.CaptionChanged;
  //override;
  {-}
begin
 if (f_Rep <> nil) then
  f_Rep.Caption := inherited pm_GetCaption;
 inherited;
end;

function TvcmEntitiesCollectionItem.GetOperationsStored: Boolean;
  //override;
  {-}
begin
 Result := inherited GetOperationsStored;
 if Result then
  Result := Operations.NeedToBeStored;
end;

procedure TvcmEntitiesCollectionItem.BeforeAddToCache;
  //override;
  {-}
begin
 inherited;
 f_Rep := nil;
end;
{$IfEnd}

end.

