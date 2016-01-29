unit l3FormsService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Forms
 , Classes
;

type
 TCustomForm = Forms.TCustomForm;
 
 (*
 Ml3FormsService = interface
  {* �������� ������� Tl3FormsService }
  function GetParentForm(Component: TPersistent): TCustomForm;
  function GetAnotherParentForm(Component: TPersistent): TCustomForm;
  function GetTopParentForm(Component: TPersistent): TCustomForm;
  function GetMainForm(Component: TPersistent): TCustomForm;
 end;//Ml3FormsService
 *)
 
 Il3FormsService = interface
  {* ��������� ������� Tl3FormsService }
  function GetParentForm(Component: TPersistent): TCustomForm;
  function GetAnotherParentForm(Component: TPersistent): TCustomForm;
  function GetTopParentForm(Component: TPersistent): TCustomForm;
  function GetMainForm(Component: TPersistent): TCustomForm;
 end;//Il3FormsService
 
 Tl3FormsService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function GetAnotherParentForm(Component: TPersistent): TCustomForm;
  function GetMainForm(Component: TPersistent): TCustomForm;
  function GetParentForm(Component: TPersistent): TCustomForm;
  function GetTopParentForm(Component: TPersistent): TCustomForm;
 end;//Tl3FormsService
 
implementation

uses
 l3ImplUses
;

end.
