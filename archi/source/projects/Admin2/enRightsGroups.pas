unit enRightsGroups;

{ $Id: enRightsGroups.pas,v 1.12 2009/01/29 14:22:48 fireton Exp $}

// $Log: enRightsGroups.pas,v $
// Revision 1.12  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.11  2008/03/04 08:27:26  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.10  2007/03/13 09:09:08  fireton
// - не-админ теперь не сможет пользоваться программой
// - мелкие правки
// - чистка кода
//
// Revision 1.9  2007/03/07 13:02:16  narry
// - не компилировалось
//
// Revision 1.8  2007/02/28 10:05:43  lulin
// - bug fix: падал Арчи из-за несоответствия типов параметров.
//
// Revision 1.7  2007/01/20 16:22:02  lulin
// - bug fix: админ не собирался в результате изменений в библиотеках.
//
// Revision 1.6  2006/12/06 13:45:15  fireton
// - удаление l3Control из uses
// - поддержка "отстрела" с сервера
// - импорт и экспорт пользователей теперь совместимы
//
// Revision 1.5  2006/11/27 16:24:39  fireton
// - bugfix
//
// Revision 1.4  2006/11/22 16:22:21  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.3  2005/11/28 14:12:49  fireton
// - промежуточный коммит
//
// Revision 1.2  2005/08/30 10:17:22  fireton
// - полностью доделал редактирование прав групп и данных профилей
//
// Revision 1.1  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmEntityForm, vcmEntities,
  vcmComponent, vcmBaseEntities, OvcBase, vtLister,

  l3Base,
  l3Interfaces,
  l3InternalInterfaces,

  a2Interfaces, ExtCtrls, afwControl, afwInputControl,
  l3InterfacedComponent, afwControlPrim, afwBaseControl;

type
  TenGroupRightsForm = class(TvcmEntityForm)
    Entities : TvcmEntities;
    lstDocGroups: TvtLister;
    Panel1: TPanel;
    procedure vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
      aNew: IvcmFormDataSource; const aFromHistory : Boolean);
    procedure lstDocGroupsGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: Il3CString);
    procedure lstDocGroupsGetItemFont(Sender: TObject; Index: Integer;
      const aFont: Il3Font);
    procedure lstDocGroupsCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
    private
      { Private declarations }
      f_DS: Ia2dsGroupRightsList;
    public
      { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TenGroupRightsForm.vcmEntityFormChangedDataSource(
  aSender: TObject; const aOld, aNew: IvcmFormDataSource; const aFromHistory : Boolean);
begin
 Supports(aNew, Ia2dsGroupRightsList, f_DS);
 if Assigned(f_DS) then
 with lstDocGroups do
 begin
  Total := f_DS.GroupRightsList.Total;
  Refresh;
  lstDocGroupsCurrentChanged(Self, Current, Current);
 end;
end;

procedure TenGroupRightsForm.lstDocGroupsGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: Il3CString);
begin
 if Assigned(f_DS) then
  ItemString := l3CStr(f_DS.GroupRightsList.Name[Index]);
end;

procedure TenGroupRightsForm.lstDocGroupsGetItemFont(Sender: TObject;
  Index: Integer; const aFont: Il3Font);
begin
 if Assigned(f_DS) then
  aFont.Bold := f_DS.GroupRightsList.IsSpecial[Index];
end;

procedure TenGroupRightsForm.lstDocGroupsCurrentChanged(Sender: TObject;
  aNewCurrent, aOldCurrent: Integer);
begin
 if Assigned(f_DS) then
  f_DS.ReloadRightValies(aNewCurrent);
end;

end.
