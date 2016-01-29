unit vcmZonesCollection;
{* Коллекция зон докинга. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmZonesCollection - }
{ Начат: 21.04.2003 19:30 }
{ $Id: vcmZonesCollection.pas,v 1.37 2015/03/18 11:14:08 lulin Exp $ }

// $Log: vcmZonesCollection.pas,v $
// Revision 1.37  2015/03/18 11:14:08  lulin
// - упорядочиваем генерацию зависимостей.
//
// Revision 1.36  2013/11/29 12:50:47  kostitsin
// [$372643503]
//
// Revision 1.35  2012/12/05 14:49:12  lulin
// {RequestLink:371649474}
//
// Revision 1.34  2012/04/13 14:37:56  lulin
// {RequestLink:237994598}
//
// Revision 1.33  2012/04/09 08:38:58  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.32  2012/04/05 19:44:26  lulin
// {RequestLink:237994598}
//
// Revision 1.31  2011/09/21 18:13:33  lulin
// {RequestLink:278836572}.
//
// Revision 1.30  2011/09/21 17:27:56  lulin
// {RequestLink:278836572}.
//
// Revision 1.29  2009/09/25 12:09:14  lulin
// - выкидываем ненужное.
//
// Revision 1.28  2009/08/04 16:53:01  lulin
// - наконец-то дошли до вызова сравнения редакций, которое падает.
//
// Revision 1.27  2007/02/07 17:48:42  lulin
// - избавляемся от копирования строк при чтении из настроек.
//
// Revision 1.26  2005/01/13 12:17:52  mmorozov
// - add unit;
//
// Revision 1.25  2005/01/13 12:07:39  mmorozov
// change: выставляем в _InsertForm параметры FloatID, FloatWindowBounds только если они не нулевые;
//
// Revision 1.24  2004/11/12 13:28:10  mmorozov
// change: в _InsertForm не используется IvcmFloatingDockSiteClass (не устанавливается размер плавающей формы), т.к. плавающая форма создаётся асинхронно ("за пределами _InsertForm");
//
// Revision 1.23  2004/11/10 14:16:49  mmorozov
// new: установка TvcmForm.FloatWindowState при чтении настроек;
//
// Revision 1.22  2004/10/08 04:53:16  mmorozov
// bugfix: не комплировалось (используем define vcmUseSettings);
//
// Revision 1.21  2004/10/07 12:35:44  mmorozov
// new: property Items;
// new: method _RestoreControlSize;
//
// Revision 1.20  2004/09/10 16:50:22  mmorozov
// remove: _HasForm;
//
// Revision 1.19  2004/09/03 11:41:01  mmorozov
// new: method TvcmZonesCollection._FindZone;
//
// Revision 1.18  2004/09/02 06:57:07  law
// - bug fix: при восстановлении формы из истории не учитывался GUID (точнее подменялся старый) и из-за этого не сохранялось состояние формы по операции Back (и соответственно не восстанавливалось по Forward) (CQ OIT5-8743).
//
// Revision 1.17  2004/06/29 10:47:26  mmorozov
// new behaviour: при количестве мониторов больше 1-го устанавливаем BoundsRect для плавающих форм после вызова Show (см. комментрарий в TvcmZonesCollection._InsertForm);
//
// Revision 1.16  2004/03/30 10:21:50  mmorozov
// new: uses vcmExternalInterfaces;
// new: при создании плавающей формы используется интерфейс IvcmFloatingDockSiteClass;
//
// Revision 1.15  2004/03/29 17:06:56  mmorozov
// new: при вставке формы устанавливаем TvcmForm.FloatID;
//
// Revision 1.14  2004/03/19 15:03:19  mmorozov
// new: в метод _HasForm добавлен параметр (UserType : Integer = vcm_utAny);
//
// Revision 1.13  2004/03/13 12:53:01  law
// - bug fix: плавающая форма поднималась не по запомненным координатам.
//
// Revision 1.12  2004/03/11 17:02:42  law
// - bug fix: неправильно показывалась форма выбора атрибутов из ППР.
// - new behavior: запоминаем/восстанавливаем состояние формы Floating.
//
// Revision 1.11  2004/03/05 17:10:27  law
// - new behavior: формы встраиваются в тот док, который был запомнен в настройках.
//
// Revision 1.10  2003/11/28 13:01:30  law
// - new behavior: опираемся на идентификаторы форм, а не на имена.
//
// Revision 1.9  2003/11/19 11:38:25  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//
// Revision 1.8  2003/10/23 12:12:11  law
// - remove proc: EntityBroadcast, как ненужную и не совсем прозрачную.
//
// Revision 1.7  2003/10/20 10:51:29  migel
// - new: посылка операции сущности в режиме бродкаста.
//
// Revision 1.6  2003/07/25 10:45:43  law
// - new unit: vcmBaseCollection.
//
// Revision 1.5  2003/04/23 14:54:32  law
// - new method: _IvcmContainer._HasForm.
//
// Revision 1.4  2003/04/22 15:50:51  law
// - new behavior: при докинге пользователем проверяем тип зоны, куда пользователь пытается вставить форму.
//
// Revision 1.3  2003/04/22 14:03:00  law
// - new behavior: сделана обработка операций, описанных на основной форме.
//
// Revision 1.2  2003/04/21 16:16:04  law
// - new behavior: сделана вставка формы в контрол, связанный с зоной.
//
// Revision 1.1  2003/04/21 15:51:06  law
// - new: реализуем описание зон докинга в _TvcmContainerForm - свойство Zones.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,
  Controls,

  vcmInterfaces,
  vcmExternalInterfaces,

  vcmBaseCollection,
  vcmZonesCollectionItem
  ;

type
  TvcmZonesCollection = class(TvcmBaseCollection)
   {* Коллекция зон докинга. }
    private
    // internal methods
      function pm_GetItem(aIndex : Integer) : TvcmZonesCollectionItem;
        {-}
      procedure pm_SetItem(aIndex : Integer;
                           aItem  : TvcmZonesCollectionItem);
        {-}
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      function InsertForm(const aForm: IvcmEntityForm): Boolean;
        {* - вставляет форму в зону. }
      function AcceptForm(const aForm : IvcmEntityForm;
                          aControl    : TComponent = nil): Boolean;
        {-}
      function FindZone(aControl : TComponent) : TvcmZonesCollectionItem;
        {* - возвращает зону по идентификатору. }
      procedure RestoreControlSize;
        {* - восстанавливает размер компонентов зон. Используется при
             "Восстановить все". }
    public
    // public properties
      property Items[aIndex : Integer] : TvcmZonesCollectionItem
        read pm_GetItem
        write pm_SetItem;
        {* - элементы коллекции. }
  end;//TvcmZonesCollection

implementation

uses
  Types,
  
  {$IfDef vcmUseSettings}
  SysUtils,
  Forms,
  {$EndIf vcmUseSettings}

  vcmBase,
  vcmBaseCollectionItem
  
  {$IfDef vcmUseSettings}
  ,
  vcmForm,
  vcmSettings,
  vcmEntityForm
  {$EndIf vcmUseSettings}
  ;

class function TvcmZonesCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmZonesCollectionItem;
end;

function TvcmZonesCollection.pm_GetItem(aIndex : Integer) : TvcmZonesCollectionItem;
begin
 Result := TvcmZonesCollectionItem(inherited Items[aIndex]);
end;

procedure TvcmZonesCollection.pm_SetItem(aIndex : Integer;
                                         aItem  : TvcmZonesCollectionItem);
begin
 inherited Items[aIndex] := TvcmBaseCollectionItem(aItem);
end;

function TvcmZonesCollection.InsertForm(const aForm: IvcmEntityForm): Boolean;
  {-}
var
 l_Index         : Integer;
 {$IfDef vcmUseSettings}
 l_CheckParent   : Boolean;
 l_Params        : TvcmFormParams;
 l_Form          : TWinControl;
 {$EndIf vcmUseSettings}
begin
 Result := false;
 {$IfDef vcmUseSettings}
 FillChar(l_Params, SizeOf(l_Params), 0);
 l_Form := aForm.VCLWinControl;
 l_CheckParent := vcmLoadFormParams(Owner, l_Form As TForm, l_Params);
 if l_CheckParent AND not vcmIsNil(l_Params.rParent) then
 begin
 for l_Index := 0 to Pred(Count) do
  with TvcmZonesCollectionItem(Items[l_Index]) do
   if (Control <> nil) AND ANSISameText(Control.Name, vcmStr(l_Params.rParent)) then
    if InsertForm(aForm, not l_Params.rFloating) then
    begin
     Result := True;
     // размеры плавающего окна, в котором находилась формы всегда читаем, для
     // восстанавливать его в той же позиции 
     if (l_Form is TvcmForm) then
      with TvcmForm(l_Form) do
      begin
       // id плавающего окна. Если происходит перевставка форм, то устанавливать
       // не нужно
       if FloatID = 0 then
        FloatID := l_Params.rFloatID;
       // состояние плавающего окна
       FloatWindowState := l_Params.rFloatWindowState;
       // положение окна. Если происходит перевставка форм, то устанавливать
       // не нужно
       if IsRectEmpty(FloatWindowBounds) then
        FloatWindowBounds := l_Params.rFloatWindowBounds;
      end;
     // форма должна быть плавающей
     if l_Params.rFloating then
     begin
      (l_Form As TvcmEntityForm).FloatingVisible := l_Params.rFloatingVisible;
      l_Form.ManualFloat(l_Params.rFloatWindowBounds);
      aForm.VCLWinControl.Show;
      aForm.CheckFloatingVisibility;
     end;//l_Params.rFloating
     Exit;
    end;//InsertForm(aForm)
 end;//l_CheckParent
 {$EndIf vcmUseSettings}
 for l_Index := 0 to Pred(Count) do
  if TvcmZonesCollectionItem(Items[l_Index]).InsertForm(aForm, true) then
  begin
   Result := true;
   break;
  end;//TvcmZonesCollectionItem(Items[l_Index]).InsertForm(aForm)
end;

function TvcmZonesCollection.AcceptForm(const aForm : IvcmEntityForm;
                                        aControl    : TComponent = nil): Boolean;
  {-}
var
 l_Index : Integer;
begin
 Result := false;
 for l_Index := 0 to Pred(Count) do
  if TvcmZonesCollectionItem(Items[l_Index]).AcceptForm(aForm, aControl) then begin
   Result := true;
   break;
  end;//TvcmZonesCollectionItem(Items[l_Index]).AcceptForm(aForm)
end;

procedure TvcmZonesCollection.RestoreControlSize;
var
 lIndex : Integer;
begin
 for lIndex := 0 to Pred(Count) do
  Items[lIndex].RestoreControlSize;
end;

function TvcmZonesCollection.FindZone(aControl : TComponent) : TvcmZonesCollectionItem;
var
 lIndex : Integer;
begin
 Result := nil;
 for lIndex := 0 to Pred(Count) do
  if TvcmZonesCollectionItem(Items[lIndex]).Control = aControl then
  begin
   Result := TvcmZonesCollectionItem(Items[lIndex]);
   Break;
  end;//TvcmZonesCollectionItem(Items[lIndex]).Control = aControl
end;

end.

