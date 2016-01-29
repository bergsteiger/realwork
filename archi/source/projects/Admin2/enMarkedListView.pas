unit enMarkedListView;

{ $Id: enMarkedListView.pas,v 1.9 2007/02/27 14:19:01 narry Exp $}

// $Log: enMarkedListView.pas,v $
// Revision 1.9  2007/02/27 14:19:01  narry
// - �� ���������������
//
// Revision 1.8  2006/12/06 13:45:15  fireton
// - �������� l3Control �� uses
// - ��������� "��������" � �������
// - ������ � ������� ������������� ������ ����������
//
// Revision 1.7  2006/12/01 15:30:02  fireton
// - ����������� ���� � ������� ���� � ������ �������
// - ���������� ������������ ��� ����������, ���� ������������ �� ����� ��������� ������
//
// Revision 1.6  2006/11/27 16:24:39  fireton
// - bugfix
//
// Revision 1.5  2006/02/01 16:08:23  fireton
// - ������ � ���� � ������
//
// Revision 1.4  2005/11/28 14:12:49  fireton
// - ������������� ������
//
// Revision 1.3  2005/08/22 13:12:59  fireton
// - ������������� ������ (���������� ���������� ����� - bug fix � ������ �������������)
//
// Revision 1.2  2005/08/20 11:06:16  fireton
// - ������������� ������ (���������� ���������� ����� � �������� ��� ������)
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmEntityForm, vcmEntities,
  vcmComponent, vcmBaseEntities, OvcBase, vtLister,
  l3Interfaces,
  a2Interfaces, ExtCtrls, afwControl, afwInputControl;

type
  TenMarkedListForm = class(TvcmEntityForm)
    Entities : TvcmEntities;
    MarkedList: TvtLister;
    procedure vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
      aNew: IvcmFormDataSource; const aFromHistory : Boolean);
    procedure MarkedListGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: Il3CString);
    procedure MarkedListIsSelected(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
    procedure MarkedListSelect(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
    private
     { Private declarations }
     f_DS: Ia2dsMarkedList;
    public
      { Public declarations }
  end;

implementation

uses
 vcmBaseUserTypesCollectionItem,
 l3Base;

{$R *.DFM}

procedure TenMarkedListForm.vcmEntityFormChangedDataSource(
  aSender: TObject; const aOld, aNew: IvcmFormDataSource; const aFromHistory : Boolean);
begin
 if Supports(aNew, Ia2dsMarkedList, f_DS) then
 begin
  MarkedList.Total := f_DS.MarkedList.Total;
  MarkedList.Refresh;
 end;
end;

procedure TenMarkedListForm.MarkedListGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: Il3CString);
begin
 ItemString := l3CStr(f_DS.MarkedList.Name[Index]);
end;

procedure TenMarkedListForm.MarkedListIsSelected(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 SelectedState := f_DS.MarkedList.State[Index];
end;

procedure TenMarkedListForm.MarkedListSelect(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 f_DS.MarkedList.State[Index] := SelectedState;
end;

end.
