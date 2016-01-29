unit cfProperties;

{ $Id: cfProperties.pas,v 1.16 2010/10/19 08:52:59 fireton Exp $}

// $Log: cfProperties.pas,v $
// Revision 1.16  2010/10/19 08:52:59  fireton
// - не теряем стек ошибки
//
// Revision 1.15  2009/04/02 13:11:30  fireton
// - [$137470683]. Правка огрехов в отрисовке дерева пользователей.
//
// Revision 1.14  2007/03/26 13:16:31  fireton
// - мелкий багфикс там и сям
//
// Revision 1.13  2007/03/13 09:09:08  fireton
// - не-админ теперь не сможет пользоваться программой
// - мелкие правки
// - чистка кода
//
// Revision 1.12  2007/03/07 13:02:16  narry
// - не компилировалось
//
// Revision 1.11  2007/01/20 16:22:02  lulin
// - bug fix: админ не собирался в результате изменений в библиотеках.
//
// Revision 1.10  2006/11/27 16:24:39  fireton
// - bugfix
//
// Revision 1.9  2006/11/22 16:22:21  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.8  2005/11/28 14:12:49  fireton
// - промежуточный коммит
//
// Revision 1.7  2005/09/14 10:53:04  fireton
// - add: на Ia2Persistent добавился IsNew (коррекция ontest для Revert)
//
// Revision 1.6  2005/09/09 13:51:31  fireton
// - add: добавлена возможность редактирования списка пользователей внутри группы
//
// Revision 1.5  2005/08/26 13:16:55  fireton
// - промежуточный коммит (профили группы + bug fix)
//
// Revision 1.4  2005/08/23 13:58:29  fireton
// - промежуточный коммит (реализация сохранения + bug fix)
//
// Revision 1.3  2005/08/22 13:12:59  fireton
// - промежуточный коммит (реализация визуальной части - bug fix и группы пользователей)
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
  Dialogs, vcmExternalInterfaces, vcmInterfaces, vcmBase, vcmContainerForm, vcmEntities,
  vcmComponent, vcmBaseEntities, StdCtrls, ExtCtrls,

  a2Interfaces, ComCtrls, l3InterfacedComponent;

type
  TcfProps = class(TvcmContainerForm)
    Entities : TvcmEntities;
    zMain: TPageControl;
    procedure enPropertiesopSaveExecute(var aParams: IvcmExecuteParams);
    procedure enPropertiesopRevertExecute(var aParams: IvcmExecuteParams);
    procedure vcmContainerFormChangedDataSource(aSender: TObject;
      const aOld, aNew: IvcmFormDataSource; const aFromHistory : Boolean);
    procedure enPropertiesopSaveTest(const aParams: IvcmTestParams);
    procedure enPropertiesopRevertTest(const aParams: IvcmTestParams);
   private
     { Private declarations }
    f_DS: Ia2dsPropertyContainer;
    procedure RefreshTree;
   protected
    procedure Cleanup; override;
   public
     constructor Create(anOwner: TComponent); override;
      { Public declarations }
  end;

implementation
uses
 a2Base,
 l3Base;

{$R *.DFM}

constructor TcfProps.Create(anOwner: TComponent);
begin
 inherited;
 f_DS := nil;
end;

procedure TcfProps.Cleanup;
begin
 f_DS := nil;
 inherited;
end;

procedure TcfProps.enPropertiesopSaveExecute(var aParams: IvcmExecuteParams);
begin
 try
  f_DS.Persistent.Save;
 except
  on E: Ea2UserDataSaveError do
  begin
   l3System.Stack2Log(E.Message);
   MessageDlg(l3CStr(E.Message), mtError);
   Exit;
  end;
 else
  raise 
 end; {try..except}
 RefreshTree;
end;

procedure TcfProps.enPropertiesopRevertExecute(var aParams: IvcmExecuteParams);
begin
 f_DS.Persistent.Revert;
 RefreshTree;
end;

procedure TcfProps.vcmContainerFormChangedDataSource(aSender: TObject;
  const aOld, aNew: IvcmFormDataSource; const aFromHistory : Boolean);
begin
 Supports(aNew, Ia2dsPropertyContainer, f_DS)
end;

procedure TcfProps.enPropertiesopSaveTest(const aParams: IvcmTestParams);
begin
 aParams.Op.Flag[vcm_ofEnabled] := f_DS.Persistent.Modified;
end;

procedure TcfProps.RefreshTree;
var
 l_Profile: Ia2Profile;
begin
 if Supports(f_DS.Persistent, Ia2Profile, l_Profile) then
 try
  f_DS.Refresh(l_Profile);
 finally
  l_Profile := nil;
 end;
end;

procedure TcfProps.enPropertiesopRevertTest(const aParams: IvcmTestParams);
begin
 with f_DS.Persistent do
  aParams.Op.Flag[vcm_ofEnabled] := Modified and (not IsNew);
end;

end.
