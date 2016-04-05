unit F1Like_InternalOperations_Controls;

// Модуль: "w:\common\components\gui\Garant\VCM\View\F1Like_InternalOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "InternalOperations" MUID: (4F71AD0E01FE)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 ISwitcher_BecomeActive_Params = interface
  {* Параметры для операции Switcher.BecomeActive }
  ['{EF87C1B2-C651-415F-BB29-5A3843B62AE9}']
  function Get_Form: IvcmEntityForm;
  property Form: IvcmEntityForm
   read Get_Form;
 end;//ISwitcher_BecomeActive_Params

 Op_Switcher_BecomeActive = class
  {* Класс для вызова операции Switcher.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity;
    const aForm: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aForm: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aForm: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у формы }
   class function Call(const aTarget: IvcmContainer;
    const aForm: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у контейнера }
 end;//Op_Switcher_BecomeActive

 Op_Switcher_SetFirstPageActive = class
  {* Класс для вызова операции Switcher.SetFirstPageActive }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Switcher.SetFirstPageActive у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Switcher.SetFirstPageActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.SetFirstPageActive у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Switcher.SetFirstPageActive у контейнера }
 end;//Op_Switcher_SetFirstPageActive

 ICommon_ShowSplitter_Params = interface
  {* Параметры для операции Common.ShowSplitter }
  ['{AF74D4F2-0734-4719-BBD8-5E33BA04A510}']
  function Get_Visible: Boolean;
  property Visible: Boolean
   read Get_Visible;
 end;//ICommon_ShowSplitter_Params

 Op_Common_ShowSplitter = class
  {* Класс для вызова операции Common.ShowSplitter }
  public
   class function Call(const aTarget: IvcmEntity;
    aVisible: Boolean): Boolean; overload;
    {* Вызов операции Common.ShowSplitter у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aVisible: Boolean): Boolean; overload;
    {* Вызов операции Common.ShowSplitter у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aVisible: Boolean): Boolean; overload;
    {* Вызов операции Common.ShowSplitter у формы }
   class function Call(const aTarget: IvcmContainer;
    aVisible: Boolean): Boolean; overload;
    {* Вызов операции Common.ShowSplitter у контейнера }
 end;//Op_Common_ShowSplitter

 ICommon_CheckChildZone_Params = interface
  {* Параметры для операции Common.CheckChildZone }
  ['{C0C35601-A404-4BE5-9C4D-376FA4AA3760}']
  function Get_Toggle: Boolean;
  property Toggle: Boolean
   read Get_Toggle;
 end;//ICommon_CheckChildZone_Params

 Op_Common_CheckChildZone = class
  {* Класс для вызова операции Common.CheckChildZone }
  public
   class function Call(const aTarget: IvcmEntity;
    aToggle: Boolean): Boolean; overload;
    {* Вызов операции Common.CheckChildZone у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aToggle: Boolean): Boolean; overload;
    {* Вызов операции Common.CheckChildZone у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aToggle: Boolean): Boolean; overload;
    {* Вызов операции Common.CheckChildZone у формы }
   class function Call(const aTarget: IvcmContainer;
    aToggle: Boolean): Boolean; overload;
    {* Вызов операции Common.CheckChildZone у контейнера }
 end;//Op_Common_CheckChildZone

implementation

uses
 l3ImplUses
 , l3CProtoObject
;

type
 TSwitcher_BecomeActive_Params = class(Tl3CProtoObject, ISwitcher_BecomeActive_Params)
  {* Реализация ISwitcher_BecomeActive_Params }
  private
   f_Form: IvcmEntityForm;
  protected
   function Get_Form: IvcmEntityForm;
   procedure ClearFields; override;
  public
   constructor Create(const aForm: IvcmEntityForm); reintroduce;
    {* Конструктор TSwitcher_BecomeActive_Params }
   class function Make(const aForm: IvcmEntityForm): ISwitcher_BecomeActive_Params; reintroduce;
    {* Фабрика TSwitcher_BecomeActive_Params }
 end;//TSwitcher_BecomeActive_Params

 TCommon_ShowSplitter_Params = class(Tl3CProtoObject, ICommon_ShowSplitter_Params)
  {* Реализация ICommon_ShowSplitter_Params }
  private
   f_Visible: Boolean;
  protected
   function Get_Visible: Boolean;
  public
   constructor Create(aVisible: Boolean); reintroduce;
    {* Конструктор TCommon_ShowSplitter_Params }
   class function Make(aVisible: Boolean): ICommon_ShowSplitter_Params; reintroduce;
    {* Фабрика TCommon_ShowSplitter_Params }
 end;//TCommon_ShowSplitter_Params

 TCommon_CheckChildZone_Params = class(Tl3CProtoObject, ICommon_CheckChildZone_Params)
  {* Реализация ICommon_CheckChildZone_Params }
  private
   f_Toggle: Boolean;
  protected
   function Get_Toggle: Boolean;
  public
   constructor Create(aToggle: Boolean); reintroduce;
    {* Конструктор TCommon_CheckChildZone_Params }
   class function Make(aToggle: Boolean): ICommon_CheckChildZone_Params; reintroduce;
    {* Фабрика TCommon_CheckChildZone_Params }
 end;//TCommon_CheckChildZone_Params

constructor TSwitcher_BecomeActive_Params.Create(const aForm: IvcmEntityForm);
 {* Конструктор TSwitcher_BecomeActive_Params }
//#UC START# *844C956CBD25_07AC461A0DA6_var*
//#UC END# *844C956CBD25_07AC461A0DA6_var*
begin
//#UC START# *844C956CBD25_07AC461A0DA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *844C956CBD25_07AC461A0DA6_impl*
end;//TSwitcher_BecomeActive_Params.Create

class function TSwitcher_BecomeActive_Params.Make(const aForm: IvcmEntityForm): ISwitcher_BecomeActive_Params;
 {* Фабрика TSwitcher_BecomeActive_Params }
var
 l_Inst : TSwitcher_BecomeActive_Params;
begin
 l_Inst := Create(aForm);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSwitcher_BecomeActive_Params.Make

function TSwitcher_BecomeActive_Params.Get_Form: IvcmEntityForm;
//#UC START# *0C1C073ED7EC_07AC461A0DA6get_var*
//#UC END# *0C1C073ED7EC_07AC461A0DA6get_var*
begin
//#UC START# *0C1C073ED7EC_07AC461A0DA6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0C1C073ED7EC_07AC461A0DA6get_impl*
end;//TSwitcher_BecomeActive_Params.Get_Form

procedure TSwitcher_BecomeActive_Params.ClearFields;
begin
 f_Form := nil;
 inherited;
end;//TSwitcher_BecomeActive_Params.ClearFields

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntity;
 const aForm: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у сущности }
//#UC START# *86721B7A6555_2C5A39BFDCFE_var*
//#UC END# *86721B7A6555_2C5A39BFDCFE_var*
begin
//#UC START# *86721B7A6555_2C5A39BFDCFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *86721B7A6555_2C5A39BFDCFE_impl*
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmAggregate;
 const aForm: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у агрегации }
//#UC START# *B6B1DB68EFA5_2C5A39BFDCFE_var*
//#UC END# *B6B1DB68EFA5_2C5A39BFDCFE_var*
begin
//#UC START# *B6B1DB68EFA5_2C5A39BFDCFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *B6B1DB68EFA5_2C5A39BFDCFE_impl*
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntityForm;
 const aForm: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у формы }
//#UC START# *46F588027291_2C5A39BFDCFE_var*
//#UC END# *46F588027291_2C5A39BFDCFE_var*
begin
//#UC START# *46F588027291_2C5A39BFDCFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *46F588027291_2C5A39BFDCFE_impl*
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmContainer;
 const aForm: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у контейнера }
//#UC START# *3A5067493346_2C5A39BFDCFE_var*
//#UC END# *3A5067493346_2C5A39BFDCFE_var*
begin
//#UC START# *3A5067493346_2C5A39BFDCFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A5067493346_2C5A39BFDCFE_impl*
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Switcher.SetFirstPageActive у сущности }
//#UC START# *85165AD9F7BC_2DD92880BD5D_var*
//#UC END# *85165AD9F7BC_2DD92880BD5D_var*
begin
//#UC START# *85165AD9F7BC_2DD92880BD5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *85165AD9F7BC_2DD92880BD5D_impl*
end;//Op_Switcher_SetFirstPageActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Switcher.SetFirstPageActive у агрегации }
//#UC START# *B5561AC8820C_2DD92880BD5D_var*
//#UC END# *B5561AC8820C_2DD92880BD5D_var*
begin
//#UC START# *B5561AC8820C_2DD92880BD5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *B5561AC8820C_2DD92880BD5D_impl*
end;//Op_Switcher_SetFirstPageActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.SetFirstPageActive у формы }
//#UC START# *907F41E69807_2DD92880BD5D_var*
//#UC END# *907F41E69807_2DD92880BD5D_var*
begin
//#UC START# *907F41E69807_2DD92880BD5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *907F41E69807_2DD92880BD5D_impl*
end;//Op_Switcher_SetFirstPageActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Switcher.SetFirstPageActive у контейнера }
//#UC START# *1D02D495FC55_2DD92880BD5D_var*
//#UC END# *1D02D495FC55_2DD92880BD5D_var*
begin
//#UC START# *1D02D495FC55_2DD92880BD5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *1D02D495FC55_2DD92880BD5D_impl*
end;//Op_Switcher_SetFirstPageActive.Call

constructor TCommon_ShowSplitter_Params.Create(aVisible: Boolean);
 {* Конструктор TCommon_ShowSplitter_Params }
//#UC START# *9D6F07D6866E_514C9A0BDDA2_var*
//#UC END# *9D6F07D6866E_514C9A0BDDA2_var*
begin
//#UC START# *9D6F07D6866E_514C9A0BDDA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *9D6F07D6866E_514C9A0BDDA2_impl*
end;//TCommon_ShowSplitter_Params.Create

class function TCommon_ShowSplitter_Params.Make(aVisible: Boolean): ICommon_ShowSplitter_Params;
 {* Фабрика TCommon_ShowSplitter_Params }
var
 l_Inst : TCommon_ShowSplitter_Params;
begin
 l_Inst := Create(aVisible);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TCommon_ShowSplitter_Params.Make

function TCommon_ShowSplitter_Params.Get_Visible: Boolean;
//#UC START# *80C16E15F37E_514C9A0BDDA2get_var*
//#UC END# *80C16E15F37E_514C9A0BDDA2get_var*
begin
//#UC START# *80C16E15F37E_514C9A0BDDA2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *80C16E15F37E_514C9A0BDDA2get_impl*
end;//TCommon_ShowSplitter_Params.Get_Visible

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmEntity;
 aVisible: Boolean): Boolean;
 {* Вызов операции Common.ShowSplitter у сущности }
//#UC START# *12F715F57197_9F5B7581601E_var*
//#UC END# *12F715F57197_9F5B7581601E_var*
begin
//#UC START# *12F715F57197_9F5B7581601E_impl*
 !!! Needs to be implemented !!!
//#UC END# *12F715F57197_9F5B7581601E_impl*
end;//Op_Common_ShowSplitter.Call

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmAggregate;
 aVisible: Boolean): Boolean;
 {* Вызов операции Common.ShowSplitter у агрегации }
//#UC START# *4336D5E4FBE7_9F5B7581601E_var*
//#UC END# *4336D5E4FBE7_9F5B7581601E_var*
begin
//#UC START# *4336D5E4FBE7_9F5B7581601E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4336D5E4FBE7_9F5B7581601E_impl*
end;//Op_Common_ShowSplitter.Call

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmEntityForm;
 aVisible: Boolean): Boolean;
 {* Вызов операции Common.ShowSplitter у формы }
//#UC START# *D3824D770987_9F5B7581601E_var*
//#UC END# *D3824D770987_9F5B7581601E_var*
begin
//#UC START# *D3824D770987_9F5B7581601E_impl*
 !!! Needs to be implemented !!!
//#UC END# *D3824D770987_9F5B7581601E_impl*
end;//Op_Common_ShowSplitter.Call

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmContainer;
 aVisible: Boolean): Boolean;
 {* Вызов операции Common.ShowSplitter у контейнера }
//#UC START# *21575C14EDF4_9F5B7581601E_var*
//#UC END# *21575C14EDF4_9F5B7581601E_var*
begin
//#UC START# *21575C14EDF4_9F5B7581601E_impl*
 !!! Needs to be implemented !!!
//#UC END# *21575C14EDF4_9F5B7581601E_impl*
end;//Op_Common_ShowSplitter.Call

constructor TCommon_CheckChildZone_Params.Create(aToggle: Boolean);
 {* Конструктор TCommon_CheckChildZone_Params }
//#UC START# *A7D4859AA7BB_7344A49B8F35_var*
//#UC END# *A7D4859AA7BB_7344A49B8F35_var*
begin
//#UC START# *A7D4859AA7BB_7344A49B8F35_impl*
 !!! Needs to be implemented !!!
//#UC END# *A7D4859AA7BB_7344A49B8F35_impl*
end;//TCommon_CheckChildZone_Params.Create

class function TCommon_CheckChildZone_Params.Make(aToggle: Boolean): ICommon_CheckChildZone_Params;
 {* Фабрика TCommon_CheckChildZone_Params }
var
 l_Inst : TCommon_CheckChildZone_Params;
begin
 l_Inst := Create(aToggle);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TCommon_CheckChildZone_Params.Make

function TCommon_CheckChildZone_Params.Get_Toggle: Boolean;
//#UC START# *917EE15183A6_7344A49B8F35get_var*
//#UC END# *917EE15183A6_7344A49B8F35get_var*
begin
//#UC START# *917EE15183A6_7344A49B8F35get_impl*
 !!! Needs to be implemented !!!
//#UC END# *917EE15183A6_7344A49B8F35get_impl*
end;//TCommon_CheckChildZone_Params.Get_Toggle

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmEntity;
 aToggle: Boolean): Boolean;
 {* Вызов операции Common.CheckChildZone у сущности }
//#UC START# *39E53D3A2FA8_91AD1A3BA04B_var*
//#UC END# *39E53D3A2FA8_91AD1A3BA04B_var*
begin
//#UC START# *39E53D3A2FA8_91AD1A3BA04B_impl*
 !!! Needs to be implemented !!!
//#UC END# *39E53D3A2FA8_91AD1A3BA04B_impl*
end;//Op_Common_CheckChildZone.Call

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmAggregate;
 aToggle: Boolean): Boolean;
 {* Вызов операции Common.CheckChildZone у агрегации }
//#UC START# *6A24FD28B9F8_91AD1A3BA04B_var*
//#UC END# *6A24FD28B9F8_91AD1A3BA04B_var*
begin
//#UC START# *6A24FD28B9F8_91AD1A3BA04B_impl*
 !!! Needs to be implemented !!!
//#UC END# *6A24FD28B9F8_91AD1A3BA04B_impl*
end;//Op_Common_CheckChildZone.Call

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmEntityForm;
 aToggle: Boolean): Boolean;
 {* Вызов операции Common.CheckChildZone у формы }
//#UC START# *C78D42F5BFCE_91AD1A3BA04B_var*
//#UC END# *C78D42F5BFCE_91AD1A3BA04B_var*
begin
//#UC START# *C78D42F5BFCE_91AD1A3BA04B_impl*
 !!! Needs to be implemented !!!
//#UC END# *C78D42F5BFCE_91AD1A3BA04B_impl*
end;//Op_Common_CheckChildZone.Call

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmContainer;
 aToggle: Boolean): Boolean;
 {* Вызов операции Common.CheckChildZone у контейнера }
//#UC START# *400A1135F0E7_91AD1A3BA04B_var*
//#UC END# *400A1135F0E7_91AD1A3BA04B_var*
begin
//#UC START# *400A1135F0E7_91AD1A3BA04B_impl*
 !!! Needs to be implemented !!!
//#UC END# *400A1135F0E7_91AD1A3BA04B_impl*
end;//Op_Common_CheckChildZone.Call

end.
