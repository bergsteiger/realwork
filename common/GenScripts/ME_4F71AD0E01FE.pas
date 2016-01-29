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
  {* Параметры для операции Switcher.BecomeActive }
 end;//ISwitcher_BecomeActive_Params
 
 Op_Switcher_BecomeActive = class
  {* Класс для вызова операции Switcher.BecomeActive }
  function Call(const aTarget: IvcmEntity;
   const aForm: IvcmEntityForm): Boolean; overload;
   {* Вызов операции Switcher.BecomeActive у сущности }
  function Call(const aTarget: IvcmAggregate;
   const aForm: IvcmEntityForm): Boolean; overload;
   {* Вызов операции Switcher.BecomeActive у агрегации }
  function Call(const aTarget: IvcmEntityForm;
   const aForm: IvcmEntityForm): Boolean; overload;
   {* Вызов операции Switcher.BecomeActive у формы }
  function Call(const aTarget: IvcmContainer;
   const aForm: IvcmEntityForm): Boolean; overload;
   {* Вызов операции Switcher.BecomeActive у контейнера }
 end;//Op_Switcher_BecomeActive
 
 Op_Switcher_SetFirstPageActive = class
  {* Класс для вызова операции Switcher.SetFirstPageActive }
  function Call(const aTarget: IvcmEntity): Boolean; overload;
   {* Вызов операции Switcher.SetFirstPageActive у сущности }
  function Call(const aTarget: IvcmAggregate): Boolean; overload;
   {* Вызов операции Switcher.SetFirstPageActive у агрегации }
  function Call(const aTarget: IvcmEntityForm): Boolean; overload;
   {* Вызов операции Switcher.SetFirstPageActive у формы }
  function Call(const aTarget: IvcmContainer): Boolean; overload;
   {* Вызов операции Switcher.SetFirstPageActive у контейнера }
 end;//Op_Switcher_SetFirstPageActive
 
 ICommon_ShowSplitter_Params = interface
  {* Параметры для операции Common.ShowSplitter }
 end;//ICommon_ShowSplitter_Params
 
 Op_Common_ShowSplitter = class
  {* Класс для вызова операции Common.ShowSplitter }
  function Call(const aTarget: IvcmEntity;
   aVisible: Boolean): Boolean; overload;
   {* Вызов операции Common.ShowSplitter у сущности }
  function Call(const aTarget: IvcmAggregate;
   aVisible: Boolean): Boolean; overload;
   {* Вызов операции Common.ShowSplitter у агрегации }
  function Call(const aTarget: IvcmEntityForm;
   aVisible: Boolean): Boolean; overload;
   {* Вызов операции Common.ShowSplitter у формы }
  function Call(const aTarget: IvcmContainer;
   aVisible: Boolean): Boolean; overload;
   {* Вызов операции Common.ShowSplitter у контейнера }
 end;//Op_Common_ShowSplitter
 
 ICommon_CheckChildZone_Params = interface
  {* Параметры для операции Common.CheckChildZone }
 end;//ICommon_CheckChildZone_Params
 
 Op_Common_CheckChildZone = class
  {* Класс для вызова операции Common.CheckChildZone }
  function Call(const aTarget: IvcmEntity;
   aToggle: Boolean): Boolean; overload;
   {* Вызов операции Common.CheckChildZone у сущности }
  function Call(const aTarget: IvcmAggregate;
   aToggle: Boolean): Boolean; overload;
   {* Вызов операции Common.CheckChildZone у агрегации }
  function Call(const aTarget: IvcmEntityForm;
   aToggle: Boolean): Boolean; overload;
   {* Вызов операции Common.CheckChildZone у формы }
  function Call(const aTarget: IvcmContainer;
   aToggle: Boolean): Boolean; overload;
   {* Вызов операции Common.CheckChildZone у контейнера }
 end;//Op_Common_CheckChildZone
 
implementation

uses
 l3ImplUses
;

type
 TSwitcher_BecomeActive_Params = class(Tl3CProtoObject, ISwitcher_BecomeActive_Params)
  {* Реализация ISwitcher_BecomeActive_Params }
  procedure Create(const aForm: IvcmEntityForm);
   {* Конструктор TSwitcher_BecomeActive_Params }
  procedure Make(const aForm: IvcmEntityForm);
   {* Фабрика TSwitcher_BecomeActive_Params }
  function Form: IvcmEntityForm;
 end;//TSwitcher_BecomeActive_Params
 
 TCommon_ShowSplitter_Params = class(Tl3CProtoObject, ICommon_ShowSplitter_Params)
  {* Реализация ICommon_ShowSplitter_Params }
  procedure Create(aVisible: Boolean);
   {* Конструктор TCommon_ShowSplitter_Params }
  procedure Make(aVisible: Boolean);
   {* Фабрика TCommon_ShowSplitter_Params }
  function Visible: Boolean;
 end;//TCommon_ShowSplitter_Params
 
 TCommon_CheckChildZone_Params = class(Tl3CProtoObject, ICommon_CheckChildZone_Params)
  {* Реализация ICommon_CheckChildZone_Params }
  procedure Create(aToggle: Boolean);
   {* Конструктор TCommon_CheckChildZone_Params }
  procedure Make(aToggle: Boolean);
   {* Фабрика TCommon_CheckChildZone_Params }
  function Toggle: Boolean;
 end;//TCommon_CheckChildZone_Params
 
end.
