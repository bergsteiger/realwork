unit vcmLayout.imp;

interface

uses
 l3IntfUses
 , vcmControllers
 , vcmInterfaces
;

type
 _vcmLayout_ = class
  procedure MakeControls;
  procedure InitEntities;
   {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
  procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
   const aNew: IvcmFormDataSource);
  function GetIsMainObjectForm: Boolean;
  procedure SetControlsResources;
   {* ���������� ��������� ������� ��� ������������������� }
  procedure EntitiesInited;
   {* ���������� ����� ���� ��� ��� �������� ���������������� }
  procedure InitControls;
   {* ��������� ������������� ���������. ��� ���������� � �������� }
  procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
   const aNew: IvcmViewAreaController);
   {* ��������� �������� ������. ��� ���������� � �������� }
 end;//_vcmLayout_
 
implementation

uses
 l3ImplUses
;

end.
