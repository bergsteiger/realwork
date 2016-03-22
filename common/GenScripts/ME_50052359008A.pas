unit Base_Operations_AAC_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_AAC_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "AAC" MUID: (50052359008A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , vtScrollBar
 , evCustomEditorWindow
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // AACTextContainer

 IAACTextContainer_GetVScrollBar_Params = interface
  {* Параметры для операции AACTextContainer.GetVScrollBar }
  ['{D92D17BA-66ED-45D0-A44D-46B0A151F82F}']
  function Get_Left: Boolean;
  function Get_ResultValue: TvtScrollBar;
  procedure Set_ResultValue(aValue: TvtScrollBar);
  property Left: Boolean
   read Get_Left;
  property ResultValue: TvtScrollBar
   read Get_ResultValue
   write Set_ResultValue;
 end;//IAACTextContainer_GetVScrollBar_Params

 Op_AACTextContainer_GetVScrollBar = class
  {* Класс для вызова операции AACTextContainer.GetVScrollBar }
  public
   class function Call(const aTarget: IvcmEntity;
    aLeft: Boolean): TvtScrollBar; overload;
    {* Вызов операции AACTextContainer.GetVScrollBar у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aLeft: Boolean): TvtScrollBar; overload;
    {* Вызов операции AACTextContainer.GetVScrollBar у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aLeft: Boolean): TvtScrollBar; overload;
    {* Вызов операции AACTextContainer.GetVScrollBar у формы }
   class function Call(const aTarget: IvcmContainer;
    aLeft: Boolean): TvtScrollBar; overload;
    {* Вызов операции AACTextContainer.GetVScrollBar у контейнера }
 end;//Op_AACTextContainer_GetVScrollBar

 IAACTextContainer_SetJumpTo_Params = interface
  {* Параметры для операции AACTextContainer.SetJumpTo }
  ['{AA22C948-B816-4987-8949-17CE74250FCC}']
  function Get_JumpTo: TevJumpToEvent;
  property JumpTo: TevJumpToEvent
   read Get_JumpTo;
 end;//IAACTextContainer_SetJumpTo_Params

 Op_AACTextContainer_SetJumpTo = class
  {* Класс для вызова операции AACTextContainer.SetJumpTo }
  public
   class function Call(const aTarget: IvcmEntity;
    aJumpTo: TevJumpToEvent): Boolean; overload;
    {* Вызов операции AACTextContainer.SetJumpTo у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aJumpTo: TevJumpToEvent): Boolean; overload;
    {* Вызов операции AACTextContainer.SetJumpTo у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aJumpTo: TevJumpToEvent): Boolean; overload;
    {* Вызов операции AACTextContainer.SetJumpTo у формы }
   class function Call(const aTarget: IvcmContainer;
    aJumpTo: TevJumpToEvent): Boolean; overload;
    {* Вызов операции AACTextContainer.SetJumpTo у контейнера }
 end;//Op_AACTextContainer_SetJumpTo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TAACTextContainer_GetVScrollBar_Params = class(Tl3CProtoObject, IAACTextContainer_GetVScrollBar_Params)
  {* Реализация IAACTextContainer_GetVScrollBar_Params }
  private
   f_Left: Boolean;
   f_ResultValue: TvtScrollBar;
  protected
   function Get_ResultValue: TvtScrollBar;
   procedure Set_ResultValue(aValue: TvtScrollBar);
   function Get_Left: Boolean;
  public
   constructor Create(aLeft: Boolean); reintroduce;
    {* Конструктор TAACTextContainer_GetVScrollBar_Params }
   class function Make(aLeft: Boolean): IAACTextContainer_GetVScrollBar_Params; reintroduce;
    {* Фабрика TAACTextContainer_GetVScrollBar_Params }
 end;//TAACTextContainer_GetVScrollBar_Params

 TAACTextContainer_SetJumpTo_Params = class(Tl3CProtoObject, IAACTextContainer_SetJumpTo_Params)
  {* Реализация IAACTextContainer_SetJumpTo_Params }
  private
   f_JumpTo: TevJumpToEvent;
  protected
   function Get_JumpTo: TevJumpToEvent;
  public
   constructor Create(aJumpTo: TevJumpToEvent); reintroduce;
    {* Конструктор TAACTextContainer_SetJumpTo_Params }
   class function Make(aJumpTo: TevJumpToEvent): IAACTextContainer_SetJumpTo_Params; reintroduce;
    {* Фабрика TAACTextContainer_SetJumpTo_Params }
 end;//TAACTextContainer_SetJumpTo_Params

constructor TAACTextContainer_GetVScrollBar_Params.Create(aLeft: Boolean);
 {* Конструктор TAACTextContainer_GetVScrollBar_Params }
//#UC START# *E22B52B08CDD_FB23594918E0_var*
//#UC END# *E22B52B08CDD_FB23594918E0_var*
begin
//#UC START# *E22B52B08CDD_FB23594918E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *E22B52B08CDD_FB23594918E0_impl*
end;//TAACTextContainer_GetVScrollBar_Params.Create

class function TAACTextContainer_GetVScrollBar_Params.Make(aLeft: Boolean): IAACTextContainer_GetVScrollBar_Params;
 {* Фабрика TAACTextContainer_GetVScrollBar_Params }
var
 l_Inst : TAACTextContainer_GetVScrollBar_Params;
begin
 l_Inst := Create(aLeft);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAACTextContainer_GetVScrollBar_Params.Make

function TAACTextContainer_GetVScrollBar_Params.Get_ResultValue: TvtScrollBar;
//#UC START# *00CFA452EE55_FB23594918E0get_var*
//#UC END# *00CFA452EE55_FB23594918E0get_var*
begin
//#UC START# *00CFA452EE55_FB23594918E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *00CFA452EE55_FB23594918E0get_impl*
end;//TAACTextContainer_GetVScrollBar_Params.Get_ResultValue

procedure TAACTextContainer_GetVScrollBar_Params.Set_ResultValue(aValue: TvtScrollBar);
//#UC START# *00CFA452EE55_FB23594918E0set_var*
//#UC END# *00CFA452EE55_FB23594918E0set_var*
begin
//#UC START# *00CFA452EE55_FB23594918E0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *00CFA452EE55_FB23594918E0set_impl*
end;//TAACTextContainer_GetVScrollBar_Params.Set_ResultValue

function TAACTextContainer_GetVScrollBar_Params.Get_Left: Boolean;
//#UC START# *D5BF0D594CD3_FB23594918E0get_var*
//#UC END# *D5BF0D594CD3_FB23594918E0get_var*
begin
//#UC START# *D5BF0D594CD3_FB23594918E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5BF0D594CD3_FB23594918E0get_impl*
end;//TAACTextContainer_GetVScrollBar_Params.Get_Left

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmEntity;
 aLeft: Boolean): TvtScrollBar;
 {* Вызов операции AACTextContainer.GetVScrollBar у сущности }
//#UC START# *377692C56D31_C2F9C1BEADB6_var*
//#UC END# *377692C56D31_C2F9C1BEADB6_var*
begin
//#UC START# *377692C56D31_C2F9C1BEADB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *377692C56D31_C2F9C1BEADB6_impl*
end;//Op_AACTextContainer_GetVScrollBar.Call

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmAggregate;
 aLeft: Boolean): TvtScrollBar;
 {* Вызов операции AACTextContainer.GetVScrollBar у агрегации }
//#UC START# *67B652B3F781_C2F9C1BEADB6_var*
//#UC END# *67B652B3F781_C2F9C1BEADB6_var*
begin
//#UC START# *67B652B3F781_C2F9C1BEADB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *67B652B3F781_C2F9C1BEADB6_impl*
end;//Op_AACTextContainer_GetVScrollBar.Call

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmEntityForm;
 aLeft: Boolean): TvtScrollBar;
 {* Вызов операции AACTextContainer.GetVScrollBar у формы }
//#UC START# *611559BFF8CB_C2F9C1BEADB6_var*
//#UC END# *611559BFF8CB_C2F9C1BEADB6_var*
begin
//#UC START# *611559BFF8CB_C2F9C1BEADB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *611559BFF8CB_C2F9C1BEADB6_impl*
end;//Op_AACTextContainer_GetVScrollBar.Call

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmContainer;
 aLeft: Boolean): TvtScrollBar;
 {* Вызов операции AACTextContainer.GetVScrollBar у контейнера }
//#UC START# *4F179556020E_C2F9C1BEADB6_var*
//#UC END# *4F179556020E_C2F9C1BEADB6_var*
begin
//#UC START# *4F179556020E_C2F9C1BEADB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F179556020E_C2F9C1BEADB6_impl*
end;//Op_AACTextContainer_GetVScrollBar.Call

constructor TAACTextContainer_SetJumpTo_Params.Create(aJumpTo: TevJumpToEvent);
 {* Конструктор TAACTextContainer_SetJumpTo_Params }
//#UC START# *3A9F73F15138_A35477C84801_var*
//#UC END# *3A9F73F15138_A35477C84801_var*
begin
//#UC START# *3A9F73F15138_A35477C84801_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A9F73F15138_A35477C84801_impl*
end;//TAACTextContainer_SetJumpTo_Params.Create

class function TAACTextContainer_SetJumpTo_Params.Make(aJumpTo: TevJumpToEvent): IAACTextContainer_SetJumpTo_Params;
 {* Фабрика TAACTextContainer_SetJumpTo_Params }
var
 l_Inst : TAACTextContainer_SetJumpTo_Params;
begin
 l_Inst := Create(aJumpTo);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAACTextContainer_SetJumpTo_Params.Make

function TAACTextContainer_SetJumpTo_Params.Get_JumpTo: TevJumpToEvent;
//#UC START# *E463C1EB5D75_A35477C84801get_var*
//#UC END# *E463C1EB5D75_A35477C84801get_var*
begin
//#UC START# *E463C1EB5D75_A35477C84801get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E463C1EB5D75_A35477C84801get_impl*
end;//TAACTextContainer_SetJumpTo_Params.Get_JumpTo

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmEntity;
 aJumpTo: TevJumpToEvent): Boolean;
 {* Вызов операции AACTextContainer.SetJumpTo у сущности }
//#UC START# *146DCB829C5E_0B5F1DF26F38_var*
//#UC END# *146DCB829C5E_0B5F1DF26F38_var*
begin
//#UC START# *146DCB829C5E_0B5F1DF26F38_impl*
 !!! Needs to be implemented !!!
//#UC END# *146DCB829C5E_0B5F1DF26F38_impl*
end;//Op_AACTextContainer_SetJumpTo.Call

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmAggregate;
 aJumpTo: TevJumpToEvent): Boolean;
 {* Вызов операции AACTextContainer.SetJumpTo у агрегации }
//#UC START# *44AD8B7226AE_0B5F1DF26F38_var*
//#UC END# *44AD8B7226AE_0B5F1DF26F38_var*
begin
//#UC START# *44AD8B7226AE_0B5F1DF26F38_impl*
 !!! Needs to be implemented !!!
//#UC END# *44AD8B7226AE_0B5F1DF26F38_impl*
end;//Op_AACTextContainer_SetJumpTo.Call

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmEntityForm;
 aJumpTo: TevJumpToEvent): Boolean;
 {* Вызов операции AACTextContainer.SetJumpTo у формы }
//#UC START# *5611D0548CEA_0B5F1DF26F38_var*
//#UC END# *5611D0548CEA_0B5F1DF26F38_var*
begin
//#UC START# *5611D0548CEA_0B5F1DF26F38_impl*
 !!! Needs to be implemented !!!
//#UC END# *5611D0548CEA_0B5F1DF26F38_impl*
end;//Op_AACTextContainer_SetJumpTo.Call

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmContainer;
 aJumpTo: TevJumpToEvent): Boolean;
 {* Вызов операции AACTextContainer.SetJumpTo у контейнера }
//#UC START# *9B16978C8FFC_0B5F1DF26F38_var*
//#UC END# *9B16978C8FFC_0B5F1DF26F38_var*
begin
//#UC START# *9B16978C8FFC_0B5F1DF26F38_impl*
 !!! Needs to be implemented !!!
//#UC END# *9B16978C8FFC_0B5F1DF26F38_impl*
end;//Op_AACTextContainer_SetJumpTo.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
