unit vcmFormDataSourceRef;

interface

uses
 l3IntfUses
 , vcmControllers
 , l3ProtoObject
 , l3Interfaces
 , vcmBaseTypes
 , vcmInterfaces
;

type
 TvcmFormDataSourceRef = class(Tl3ProtoObject, Il3ItemNotifyRecipient, IvcmFormDataSourceRef)
  {* ���������� ������ �� ������ ������ ����� }
  procedure Create(aNeedMake: TvcmNeedMakeDS);
  function Make(aNeedMake: TvcmNeedMakeDS): IvcmFormDataSourceRef;
   {* ��������� ����� }
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* ������ ��������. }
  procedure Clear;
   {* ���������� ������ �� _DataSource � NeedMake ������������� ��� vcm_nmNo }
  procedure SetIfNeedMakeNo(aValue: TvcmNeedMakeDS);
   {* ������������� ���� ���� ��� �������� vcm_nmNo }
  procedure Assign(const aSource: IvcmFormDataSourceRef);
   {* ����������� ������ aSource }
  function Referred: IvcmFormDataSource;
   {* ������ �� ���������� ������� ������ }
  function NeedMake: TvcmNeedMakeDS;
   {* ���������� ������������� �������� ��� }
  function IsEmpty: Boolean;
   {* ���������� ������� ��������� ������. }
  function CanBeClosed: Boolean;
   {* ����� �� ������� }
 end;//TvcmFormDataSourceRef
 
 TvcmViewAreaControllerRef = TvcmFormDataSourceRef;
 
implementation

uses
 l3ImplUses
;

end.
