unit vcmMenuItemActionLink;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmMenuItemActionLink - }
{ Начат: 15.09.2004 18:54 }
{ $Id: vcmMenuItemActionLink.pas,v 1.18 2015/01/15 14:08:33 lulin Exp $ }

// $Log: vcmMenuItemActionLink.pas,v $
// Revision 1.18  2015/01/15 14:08:33  lulin
// {RequestLink:585926571}. Используем Interlocked.
//
// Revision 1.17  2011/12/07 18:14:27  lulin
// {RequestLink:273590436}
//
// Revision 1.16  2011/12/07 17:48:20  lulin
// {RequestLink:273590436}
//
// Revision 1.15  2009/10/16 17:00:46  lulin
// {RequestLink:159360578}. №52.
//
// Revision 1.14  2008/02/14 19:32:33  lulin
// - изменены имена файлов с примесями.
//
// Revision 1.13  2008/02/14 14:12:17  lulin
// - <K>: 83920106.
//
// Revision 1.12  2008/02/07 08:37:46  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.11  2008/01/30 20:31:42  lulin
// - подготавливаемся к штатному использованию классов-примесей на модели.
//
// Revision 1.10  2008/01/25 12:06:52  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.9  2008/01/25 11:32:07  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.8  2007/09/26 06:18:09  mmorozov
// - change: вместо использования TvcmAction используем IvcmAction + правки ошибок при переходе на использование _SelectedString вместо Caption (в рамках работы над CQ: OIT5-26741 + K<50758978>);
//
// Revision 1.7  2007/04/26 11:43:09  oman
// - fix: Жирность в пункте меню теперь делается не типом операции
//  vcm_otLabel, а флагом vcm_ofDefault (cq24612)
//
// Revision 1.6  2007/04/26 09:27:49  oman
// - fix: Выделение жирным для vcm_otLabel перенес на ActionLink (cq24612, 25145)
//
// Revision 1.5  2007/01/18 10:49:35  lulin
// - заменяем объект менеджера памяти на интерфейс.
//
// Revision 1.4  2006/04/14 13:40:24  lulin
// - запрещаем перекрывать деструктор.
//
// Revision 1.3  2006/04/14 12:11:19  lulin
// - файлу с шаблоном дано более правильное название.
//
// Revision 1.2  2006/04/14 11:53:08  lulin
// - объединил интерфейс и реализацию _Unknown_ в один файл.
//
// Revision 1.1  2004/09/15 15:04:01  lulin
// - new unit: vcmMenuItemActionLink.
//

{$Include vcmDefine.inc }

interface

uses
  Windows,
  
  Menus,

  vcmExternalInterfaces
  ;

type
  _l3Unknown_Parent_ = TMenuActionLink;
  {$Define _UnknownNeedsQI}
  {$IfNDef vcmNeedL3}
   {$Define _UnknownNotNeedL3}
  {$EndIf  vcmNeedL3}
  {$Include l3Unknown.imp.pas}
  TvcmMenuItemActionLink = class(_l3Unknown_, IvcmActionLink)
    protected
    // interface methods
      // IvcmActionLink
      procedure ParamsChanged(const anAction: IvcmAction);
        virtual;
        {-}
      procedure ParamsChanging(const anAction: IvcmAction);
        virtual;
        {-}
  end;//TvcmMenuItemActionLink

implementation

uses
  SysUtils,

  {$IfDef vcmNeedL3}
  l3Base,
  l3Interfaces,
  l3MinMax,
  l3Interlocked,
  {$EndIf vcmNeedL3}

  vcmMenus
  ;

{$Include l3Unknown.imp.pas}

// start class TvcmMenuItemActionLink

procedure TvcmMenuItemActionLink.ParamsChanged(const anAction: IvcmAction);
  {-}
var
 l_IsDefault : Boolean;
 //I: Integer;
begin
 l_IsDefault := anAction.IsDefault AND
                not (FClient Is TvcmNodeMenuItem) AND
                FClient.Enabled;
                // http://mdp.garant.ru/pages/viewpage.action?pageId=273590436
(* if l_IsDefault then
  for I := 0 to Min(FClient.Parent.IndexOf(FClient) - 1, FClient.Parent.Count - 1) do
    if FClient.Parent[I].Default then
     Exit;*)
 FClient.Default := l_IsDefault;
end;

procedure TvcmMenuItemActionLink.ParamsChanging(const anAction: IvcmAction);
  {-}
begin
end;

end.

