unit modAdministration;

{ $Id: modAdministration.pas,v 1.10 2009/01/29 14:22:48 fireton Exp $}

// $Log: modAdministration.pas,v $
// Revision 1.10  2009/01/29 14:22:48  fireton
// - пересборка под обновленный VCM
//
// Revision 1.9  2008/04/04 15:18:19  fireton
// - внешние номера документов из диапазона
//
// Revision 1.8  2007/01/20 16:22:02  lulin
// - bug fix: админ не собирался в результате изменений в библиотеках.
//
// Revision 1.7  2006/02/14 11:20:44  fireton
// - реализация Большого Брата
//
// Revision 1.6  2005/08/30 10:17:22  fireton
// - полностью доделал редактирование прав групп и данных профилей
//
// Revision 1.5  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//
// Revision 1.4  2005/08/26 13:16:55  fireton
// - промежуточный коммит (профили группы + bug fix)
//
// Revision 1.3  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.2  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmModule, vcmModuleDef, vcmBase, vcmComponent,
  vcmOperations, l3InterfacedComponent;

type
  TmoAdmin = class(TvcmModule)
      ModuleDef : TvcmModuleDef;
    procedure ModuleDefopOpenUsersListExecute(var aParams: IvcmExecuteParams);
    private
      { Private declarations }
    public
      { Public declarations }
    protected
    // internal methods
      class procedure GetEntityForms(aList : TvcmClassList);
        override;
        {* - возвращает список форм сущностей. }
  end;

implementation
uses
 vcmFormSetFactory,
 vcmFormSetDataSource,

 stdRes,

 a2sdsAdmin,
 a2UserGroupTree,
 cfHoriz,
 cfVert,
 cfProperties,
 enNoEdit,
 enUserProperties,
 enMarkedListView,
 enGroupProperties,
 enRightsGroups,
 enRightsValues,
 enBigBrother
 ;

{$R *.DFM}

class procedure TmoAdmin.GetEntityForms(aList : TvcmClassList);
  //override;
  {-}
begin
 inherited;
 aList.Add(TenUserTree);
 aList.Add(TcfProps);
 aList.Add(TcfVertical);
 aList.Add(TcfHorizontal);
 aList.Add(TenNoEditForm);
 aList.Add(TenUserPropertiesForm);
 aList.Add(TenMarkedListForm);
 aList.Add(TenUserGroupPropetriesForm);
 aList.Add(TenGroupRightsForm);
 aList.Add(TenRigthsValuesForm);
 aList.Add(TenBigBrotherForm);
end;

procedure TmoAdmin.ModuleDefopOpenUsersListExecute(
  var aParams: IvcmExecuteParams);
begin
 TvcmFormSetFactory.Make(fs_Admin, Ta2fdsAdmin.Make, aParams.Container);
end;

end.
