unit cfHoriz;

{ $Id: cfHoriz.pas,v 1.5 2009/01/29 14:22:48 fireton Exp $}

// $Log: cfHoriz.pas,v $
// Revision 1.5  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.4  2005/09/23 14:53:27  fireton
// - добавляем приоритеты в свойства групп
//
// Revision 1.3  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//
// Revision 1.2  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmContainerForm, vcmEntities,
  vcmComponent, vcmBaseEntities, ExtCtrls,

  StdRes, RXSplit, l3InterfacedComponent;

type
  TcfHorizontal = class(TvcmContainerForm)
      Entities : TvcmEntities;
    zTop: TPanel;
    zBottom: TPanel;
    Splitter1: TRxSplitter;
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure vcmContainerFormShow(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
  end;

implementation

uses vcmEntityForm;

{$R *.DFM}

procedure TcfHorizontal.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
 if TcfHorizontalUT(CurUserTypeDef.ID) = utHUserProperties then
 begin
  if NewSize < 200 then
   NewSize := 200;
 end;
 if TcfHorizontalUT(CurUserTypeDef.ID) = utHUserGroupProperties then
 begin
  if NewSize < 170 then
   NewSize := 170;
 end;
end;

procedure TcfHorizontal.vcmContainerFormShow(Sender: TObject);
begin
 if TcfHorizontalUT(CurUserTypeDef.ID) = utHUserProperties then
  zTop.Height := 200;
 if TcfHorizontalUT(CurUserTypeDef.ID) = utHUserGroupProperties then
 begin
  zTop.Height := 170;
 end;
end;

end.
