unit vtNavigatorForm;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmExternalInterfaces
;

type
 TvtNavigatorForm = class(Tl3ProtoObject)
  {* ������� ������  ���� ����������. }
  procedure Create(const aCloseHandler: IvcmFormHandler);
   {* ����������� ������. }
 end;//TvtNavigatorForm
 
implementation

uses
 l3ImplUses
;

end.
