unit F1Like_InternalOperations_Controls;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , l3CProtoObject
;

type
 // Switcher
 
 // Common
 
 ISwitcher_BecomeActive_Params = interface
  {* ��������� ��� �������� Switcher.BecomeActive }
 end;//ISwitcher_BecomeActive_Params
 
 Op_Switcher_BecomeActive = class
  {* ����� ��� ������ �������� Switcher.BecomeActive }
  function Call(const aTarget: IvcmEntity;
   const aForm: IvcmEntityForm): Boolean; overload;
   {* ����� �������� Switcher.BecomeActive � �������� }
  function Call(const aTarget: IvcmAggregate;
   const aForm: IvcmEntityForm): Boolean; overload;
   {* ����� �������� Switcher.BecomeActive � ��������� }
  function Call(const aTarget: IvcmEntityForm;
   const aForm: IvcmEntityForm): Boolean; overload;
   {* ����� �������� Switcher.BecomeActive � ����� }
  function Call(const aTarget: IvcmContainer;
   const aForm: IvcmEntityForm): Boolean; overload;
   {* ����� �������� Switcher.BecomeActive � ���������� }
 end;//Op_Switcher_BecomeActive
 
 Op_Switcher_SetFirstPageActive = class
  {* ����� ��� ������ �������� Switcher.SetFirstPageActive }
  function Call(const aTarget: IvcmEntity): Boolean; overload;
   {* ����� �������� Switcher.SetFirstPageActive � �������� }
  function Call(const aTarget: IvcmAggregate): Boolean; overload;
   {* ����� �������� Switcher.SetFirstPageActive � ��������� }
  function Call(const aTarget: IvcmEntityForm): Boolean; overload;
   {* ����� �������� Switcher.SetFirstPageActive � ����� }
  function Call(const aTarget: IvcmContainer): Boolean; overload;
   {* ����� �������� Switcher.SetFirstPageActive � ���������� }
 end;//Op_Switcher_SetFirstPageActive
 
 ICommon_ShowSplitter_Params = interface
  {* ��������� ��� �������� Common.ShowSplitter }
 end;//ICommon_ShowSplitter_Params
 
 Op_Common_ShowSplitter = class
  {* ����� ��� ������ �������� Common.ShowSplitter }
  function Call(const aTarget: IvcmEntity;
   aVisible: Boolean): Boolean; overload;
   {* ����� �������� Common.ShowSplitter � �������� }
  function Call(const aTarget: IvcmAggregate;
   aVisible: Boolean): Boolean; overload;
   {* ����� �������� Common.ShowSplitter � ��������� }
  function Call(const aTarget: IvcmEntityForm;
   aVisible: Boolean): Boolean; overload;
   {* ����� �������� Common.ShowSplitter � ����� }
  function Call(const aTarget: IvcmContainer;
   aVisible: Boolean): Boolean; overload;
   {* ����� �������� Common.ShowSplitter � ���������� }
 end;//Op_Common_ShowSplitter
 
 ICommon_CheckChildZone_Params = interface
  {* ��������� ��� �������� Common.CheckChildZone }
 end;//ICommon_CheckChildZone_Params
 
 Op_Common_CheckChildZone = class
  {* ����� ��� ������ �������� Common.CheckChildZone }
  function Call(const aTarget: IvcmEntity;
   aToggle: Boolean): Boolean; overload;
   {* ����� �������� Common.CheckChildZone � �������� }
  function Call(const aTarget: IvcmAggregate;
   aToggle: Boolean): Boolean; overload;
   {* ����� �������� Common.CheckChildZone � ��������� }
  function Call(const aTarget: IvcmEntityForm;
   aToggle: Boolean): Boolean; overload;
   {* ����� �������� Common.CheckChildZone � ����� }
  function Call(const aTarget: IvcmContainer;
   aToggle: Boolean): Boolean; overload;
   {* ����� �������� Common.CheckChildZone � ���������� }
 end;//Op_Common_CheckChildZone
 
implementation

uses
 l3ImplUses
;

type
 TSwitcher_BecomeActive_Params = class(Tl3CProtoObject, ISwitcher_BecomeActive_Params)
  {* ���������� ISwitcher_BecomeActive_Params }
  procedure Create(const aForm: IvcmEntityForm);
   {* ����������� TSwitcher_BecomeActive_Params }
  procedure Make(const aForm: IvcmEntityForm);
   {* ������� TSwitcher_BecomeActive_Params }
  function Form: IvcmEntityForm;
 end;//TSwitcher_BecomeActive_Params
 
 TCommon_ShowSplitter_Params = class(Tl3CProtoObject, ICommon_ShowSplitter_Params)
  {* ���������� ICommon_ShowSplitter_Params }
  procedure Create(aVisible: Boolean);
   {* ����������� TCommon_ShowSplitter_Params }
  procedure Make(aVisible: Boolean);
   {* ������� TCommon_ShowSplitter_Params }
  function Visible: Boolean;
 end;//TCommon_ShowSplitter_Params
 
 TCommon_CheckChildZone_Params = class(Tl3CProtoObject, ICommon_CheckChildZone_Params)
  {* ���������� ICommon_CheckChildZone_Params }
  procedure Create(aToggle: Boolean);
   {* ����������� TCommon_CheckChildZone_Params }
  procedure Make(aToggle: Boolean);
   {* ������� TCommon_CheckChildZone_Params }
  function Toggle: Boolean;
 end;//TCommon_CheckChildZone_Params
 
end.
