unit enRightsValues;

{ $Id: enRightsValues.pas,v 1.9 2007/03/13 09:09:08 fireton Exp $}

// $Log: enRightsValues.pas,v $
// Revision 1.9  2007/03/13 09:09:08  fireton
// - не-админ теперь не сможет пользоваться программой
// - мелкие правки
// - чистка кода
//
// Revision 1.8  2007/03/07 13:02:16  narry
// - не компилировалось
//
// Revision 1.7  2007/02/28 10:05:43  lulin
// - bug fix: падал Арчи из-за несоответствия типов параметров.
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
  a2Interfaces, ExtCtrls, afwControl, afwInputControl;

type
  TenRigthsValuesForm = class(TvcmEntityForm)
    Entities : TvcmEntities;
    lstRightsValues: TvtLister;
    Panel1: TPanel;
    procedure vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
      aNew: IvcmFormDataSource; const aFromHistory : Boolean);
    procedure lstRightsValuesIsSelected(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
    procedure lstRightsValuesGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: Il3CString);
    procedure lstRightsValuesSelect(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
   private
    { Private declarations }
    f_DS: Ia2dsMarkedList;
   protected
    procedure Cleanup; override;
   public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TenRigthsValuesForm.Cleanup;
begin
 f_DS := nil;
 inherited;
end;

procedure TenRigthsValuesForm.vcmEntityFormChangedDataSource(
  aSender: TObject; const aOld, aNew: IvcmFormDataSource; const aFromHistory : Boolean);
begin
 if Supports(aNew, Ia2dsMarkedList, f_DS) then
 begin
  lstRightsValues.Total := f_DS.MarkedList.Total;
  lstRightsValues.Refresh;
 end;
end;

procedure TenRigthsValuesForm.lstRightsValuesIsSelected(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 if Assigned(f_DS) then
  SelectedState := f_DS.MarkedList.State[Index];
end;

procedure TenRigthsValuesForm.lstRightsValuesGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: Il3CString);
begin
 if Assigned(f_DS) then
  ItemString := l3CStr(f_DS.MarkedList.Name[Index]);
end;

procedure TenRigthsValuesForm.lstRightsValuesSelect(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 if Assigned(f_DS) then
  f_DS.MarkedList.State[Index] := SelectedState;
end;

end.
