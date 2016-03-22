unit CompareEditions_Controls;
 {* Операции специфичные для Сравнения редакций }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\CompareEditions_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "CompareEditions" MUID: (4A897A0F0097)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Base_Operations_Editions_Controls
 , DocumentUnit
 , NavigationInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // Edition

 TGotoParaResult = (
  {* Результат перехода на параграф }
  gtprFail
   {* Неуспешно }
  , gtprOk
   {* Успешно }
  , gtprAlready
   {* Уже стояли на этом параграфе }
 );//TGotoParaResult

 // Document

 // RightEdition

 // Finder

 IDocument_OpenEditionLocalLink_Params = interface
  {* Параметры для операции Document.OpenEditionLocalLink }
  ['{14D37F98-4FEA-468A-8938-DC976BB1F999}']
  function Get_Document: IDocument;
  function Get_Sub: Cardinal;
  function Get_Behaviour: TbsProcessHyperLinkBehaviour;
  property Document: IDocument
   read Get_Document;
  property Sub: Cardinal
   read Get_Sub;
  property Behaviour: TbsProcessHyperLinkBehaviour
   read Get_Behaviour;
 end;//IDocument_OpenEditionLocalLink_Params

 Op_Document_OpenEditionLocalLink = class
  {* Класс для вызова операции Document.OpenEditionLocalLink }
  public
   class function Call(const aTarget: IvcmEntity;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
    {* Вызов операции Document.OpenEditionLocalLink у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
    {* Вызов операции Document.OpenEditionLocalLink у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
    {* Вызов операции Document.OpenEditionLocalLink у формы }
   class function Call(const aTarget: IvcmContainer;
    const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
    {* Вызов операции Document.OpenEditionLocalLink у контейнера }
 end;//Op_Document_OpenEditionLocalLink

 Op_RightEdition_ReturnToDocument = class
  {* Класс для вызова операции RightEdition.ReturnToDocument }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции RightEdition.ReturnToDocument у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции RightEdition.ReturnToDocument у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции RightEdition.ReturnToDocument у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции RightEdition.ReturnToDocument у контейнера }
 end;//Op_RightEdition_ReturnToDocument

 Op_RightEdition_SetFocusToText = class
  {* Класс для вызова операции RightEdition.SetFocusToText }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции RightEdition.SetFocusToText у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции RightEdition.SetFocusToText у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции RightEdition.SetFocusToText у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции RightEdition.SetFocusToText у контейнера }
 end;//Op_RightEdition_SetFocusToText

 IRightEdition_IsCurrentPara_Params = interface
  {* Параметры для операции RightEdition.IsCurrentPara }
  ['{C973500C-ADAC-48EB-A19A-E362ADE07D19}']
  function Get_Para: Integer;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Para: Integer
   read Get_Para;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IRightEdition_IsCurrentPara_Params

 Op_RightEdition_IsCurrentPara = class
  {* Класс для вызова операции RightEdition.IsCurrentPara }
  public
   class function Call(const aTarget: IvcmEntity;
    aPara: Integer): Boolean; overload;
    {* Вызов операции RightEdition.IsCurrentPara у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aPara: Integer): Boolean; overload;
    {* Вызов операции RightEdition.IsCurrentPara у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aPara: Integer): Boolean; overload;
    {* Вызов операции RightEdition.IsCurrentPara у формы }
   class function Call(const aTarget: IvcmContainer;
    aPara: Integer): Boolean; overload;
    {* Вызов операции RightEdition.IsCurrentPara у контейнера }
 end;//Op_RightEdition_IsCurrentPara

 IFinder_GotoPara_Params = interface
  {* Параметры для операции Finder.GotoPara }
  ['{C07EBC14-D098-4B33-A28C-40AEBC95BCCC}']
  function Get_Para: Integer;
  function Get_ResultValue: TGotoParaResult;
  procedure Set_ResultValue(aValue: TGotoParaResult);
  property Para: Integer
   read Get_Para;
  property ResultValue: TGotoParaResult
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFinder_GotoPara_Params

 Op_Finder_GotoPara = class
  {* Класс для вызова операции Finder.GotoPara }
  public
   class function Call(const aTarget: IvcmEntity;
    aPara: Integer): TGotoParaResult; overload;
    {* Вызов операции Finder.GotoPara у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aPara: Integer): TGotoParaResult; overload;
    {* Вызов операции Finder.GotoPara у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aPara: Integer): TGotoParaResult; overload;
    {* Вызов операции Finder.GotoPara у формы }
   class function Call(const aTarget: IvcmContainer;
    aPara: Integer): TGotoParaResult; overload;
    {* Вызов операции Finder.GotoPara у контейнера }
 end;//Op_Finder_GotoPara

 Op_Finder_DisableForceDrawFocusRect = class
  {* Класс для вызова операции Finder.DisableForceDrawFocusRect }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Finder.DisableForceDrawFocusRect у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Finder.DisableForceDrawFocusRect у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Finder.DisableForceDrawFocusRect у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Finder.DisableForceDrawFocusRect у контейнера }
 end;//Op_Finder_DisableForceDrawFocusRect
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TDocument_OpenEditionLocalLink_Params = class(Tl3CProtoObject, IDocument_OpenEditionLocalLink_Params)
  {* Реализация IDocument_OpenEditionLocalLink_Params }
  private
   f_Document: IDocument;
   f_Sub: Cardinal;
   f_Behaviour: TbsProcessHyperLinkBehaviour;
  protected
   function Get_Sub: Cardinal;
   function Get_Document: IDocument;
   function Get_Behaviour: TbsProcessHyperLinkBehaviour;
   procedure ClearFields; override;
  public
   constructor Create(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); reintroduce;
    {* Конструктор TDocument_OpenEditionLocalLink_Params }
   class function Make(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): IDocument_OpenEditionLocalLink_Params; reintroduce;
    {* Фабрика TDocument_OpenEditionLocalLink_Params }
 end;//TDocument_OpenEditionLocalLink_Params

 TRightEdition_IsCurrentPara_Params = class(Tl3CProtoObject, IRightEdition_IsCurrentPara_Params)
  {* Реализация IRightEdition_IsCurrentPara_Params }
  private
   f_Para: Integer;
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_Para: Integer;
  public
   constructor Create(aPara: Integer); reintroduce;
    {* Конструктор TRightEdition_IsCurrentPara_Params }
   class function Make(aPara: Integer): IRightEdition_IsCurrentPara_Params; reintroduce;
    {* Фабрика TRightEdition_IsCurrentPara_Params }
 end;//TRightEdition_IsCurrentPara_Params

 TFinder_GotoPara_Params = class(Tl3CProtoObject, IFinder_GotoPara_Params)
  {* Реализация IFinder_GotoPara_Params }
  private
   f_Para: Integer;
   f_ResultValue: TGotoParaResult;
  protected
   function Get_ResultValue: TGotoParaResult;
   procedure Set_ResultValue(aValue: TGotoParaResult);
   function Get_Para: Integer;
  public
   constructor Create(aPara: Integer); reintroduce;
    {* Конструктор TFinder_GotoPara_Params }
   class function Make(aPara: Integer): IFinder_GotoPara_Params; reintroduce;
    {* Фабрика TFinder_GotoPara_Params }
 end;//TFinder_GotoPara_Params

constructor TDocument_OpenEditionLocalLink_Params.Create(const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour);
 {* Конструктор TDocument_OpenEditionLocalLink_Params }
//#UC START# *D981FDAF4C1B_6C45CFF10AA4_var*
//#UC END# *D981FDAF4C1B_6C45CFF10AA4_var*
begin
//#UC START# *D981FDAF4C1B_6C45CFF10AA4_impl*
 !!! Needs to be implemented !!!
//#UC END# *D981FDAF4C1B_6C45CFF10AA4_impl*
end;//TDocument_OpenEditionLocalLink_Params.Create

class function TDocument_OpenEditionLocalLink_Params.Make(const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): IDocument_OpenEditionLocalLink_Params;
 {* Фабрика TDocument_OpenEditionLocalLink_Params }
var
 l_Inst : TDocument_OpenEditionLocalLink_Params;
begin
 l_Inst := Create(aDocument, aSub, aBehaviour);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_OpenEditionLocalLink_Params.Make

function TDocument_OpenEditionLocalLink_Params.Get_Sub: Cardinal;
//#UC START# *1AE3FCD83689_6C45CFF10AA4get_var*
//#UC END# *1AE3FCD83689_6C45CFF10AA4get_var*
begin
//#UC START# *1AE3FCD83689_6C45CFF10AA4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1AE3FCD83689_6C45CFF10AA4get_impl*
end;//TDocument_OpenEditionLocalLink_Params.Get_Sub

function TDocument_OpenEditionLocalLink_Params.Get_Document: IDocument;
//#UC START# *501A51D14AB4_6C45CFF10AA4get_var*
//#UC END# *501A51D14AB4_6C45CFF10AA4get_var*
begin
//#UC START# *501A51D14AB4_6C45CFF10AA4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *501A51D14AB4_6C45CFF10AA4get_impl*
end;//TDocument_OpenEditionLocalLink_Params.Get_Document

function TDocument_OpenEditionLocalLink_Params.Get_Behaviour: TbsProcessHyperLinkBehaviour;
//#UC START# *FB30611E00A1_6C45CFF10AA4get_var*
//#UC END# *FB30611E00A1_6C45CFF10AA4get_var*
begin
//#UC START# *FB30611E00A1_6C45CFF10AA4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *FB30611E00A1_6C45CFF10AA4get_impl*
end;//TDocument_OpenEditionLocalLink_Params.Get_Behaviour

procedure TDocument_OpenEditionLocalLink_Params.ClearFields;
begin
 f_Document := nil;
 inherited;
end;//TDocument_OpenEditionLocalLink_Params.ClearFields

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmEntity;
 const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Вызов операции Document.OpenEditionLocalLink у сущности }
//#UC START# *1BA3C17612BE_69E1E03DA971_var*
//#UC END# *1BA3C17612BE_69E1E03DA971_var*
begin
//#UC START# *1BA3C17612BE_69E1E03DA971_impl*
 !!! Needs to be implemented !!!
//#UC END# *1BA3C17612BE_69E1E03DA971_impl*
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmAggregate;
 const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Вызов операции Document.OpenEditionLocalLink у агрегации }
//#UC START# *4BE381659D0E_69E1E03DA971_var*
//#UC END# *4BE381659D0E_69E1E03DA971_var*
begin
//#UC START# *4BE381659D0E_69E1E03DA971_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BE381659D0E_69E1E03DA971_impl*
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmEntityForm;
 const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Вызов операции Document.OpenEditionLocalLink у формы }
//#UC START# *20D47FA4BA5A_69E1E03DA971_var*
//#UC END# *20D47FA4BA5A_69E1E03DA971_var*
begin
//#UC START# *20D47FA4BA5A_69E1E03DA971_impl*
 !!! Needs to be implemented !!!
//#UC END# *20D47FA4BA5A_69E1E03DA971_impl*
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_Document_OpenEditionLocalLink.Call(const aTarget: IvcmContainer;
 const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Вызов операции Document.OpenEditionLocalLink у контейнера }
//#UC START# *67290A910F21_69E1E03DA971_var*
//#UC END# *67290A910F21_69E1E03DA971_var*
begin
//#UC START# *67290A910F21_69E1E03DA971_impl*
 !!! Needs to be implemented !!!
//#UC END# *67290A910F21_69E1E03DA971_impl*
end;//Op_Document_OpenEditionLocalLink.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции RightEdition.ReturnToDocument у сущности }
//#UC START# *391F29C848C8_F3B7A68ECD5A_var*
//#UC END# *391F29C848C8_F3B7A68ECD5A_var*
begin
//#UC START# *391F29C848C8_F3B7A68ECD5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *391F29C848C8_F3B7A68ECD5A_impl*
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции RightEdition.ReturnToDocument у агрегации }
//#UC START# *695EE9B6D318_F3B7A68ECD5A_var*
//#UC END# *695EE9B6D318_F3B7A68ECD5A_var*
begin
//#UC START# *695EE9B6D318_F3B7A68ECD5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *695EE9B6D318_F3B7A68ECD5A_impl*
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции RightEdition.ReturnToDocument у формы }
//#UC START# *6D1AE62F4CCD_F3B7A68ECD5A_var*
//#UC END# *6D1AE62F4CCD_F3B7A68ECD5A_var*
begin
//#UC START# *6D1AE62F4CCD_F3B7A68ECD5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D1AE62F4CCD_F3B7A68ECD5A_impl*
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_ReturnToDocument.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции RightEdition.ReturnToDocument у контейнера }
//#UC START# *CD8F6A331239_F3B7A68ECD5A_var*
//#UC END# *CD8F6A331239_F3B7A68ECD5A_var*
begin
//#UC START# *CD8F6A331239_F3B7A68ECD5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *CD8F6A331239_F3B7A68ECD5A_impl*
end;//Op_RightEdition_ReturnToDocument.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции RightEdition.SetFocusToText у сущности }
//#UC START# *76892B8D4400_0730A91F5FE2_var*
//#UC END# *76892B8D4400_0730A91F5FE2_var*
begin
//#UC START# *76892B8D4400_0730A91F5FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *76892B8D4400_0730A91F5FE2_impl*
end;//Op_RightEdition_SetFocusToText.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции RightEdition.SetFocusToText у агрегации }
//#UC START# *A6C8EB7BCE50_0730A91F5FE2_var*
//#UC END# *A6C8EB7BCE50_0730A91F5FE2_var*
begin
//#UC START# *A6C8EB7BCE50_0730A91F5FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *A6C8EB7BCE50_0730A91F5FE2_impl*
end;//Op_RightEdition_SetFocusToText.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции RightEdition.SetFocusToText у формы }
//#UC START# *A1CF986CD5FD_0730A91F5FE2_var*
//#UC END# *A1CF986CD5FD_0730A91F5FE2_var*
begin
//#UC START# *A1CF986CD5FD_0730A91F5FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *A1CF986CD5FD_0730A91F5FE2_impl*
end;//Op_RightEdition_SetFocusToText.Call

class function Op_RightEdition_SetFocusToText.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции RightEdition.SetFocusToText у контейнера }
//#UC START# *6CB1CD721459_0730A91F5FE2_var*
//#UC END# *6CB1CD721459_0730A91F5FE2_var*
begin
//#UC START# *6CB1CD721459_0730A91F5FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *6CB1CD721459_0730A91F5FE2_impl*
end;//Op_RightEdition_SetFocusToText.Call

constructor TRightEdition_IsCurrentPara_Params.Create(aPara: Integer);
 {* Конструктор TRightEdition_IsCurrentPara_Params }
//#UC START# *343F6EE33EEE_13B946D236A8_var*
//#UC END# *343F6EE33EEE_13B946D236A8_var*
begin
//#UC START# *343F6EE33EEE_13B946D236A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *343F6EE33EEE_13B946D236A8_impl*
end;//TRightEdition_IsCurrentPara_Params.Create

class function TRightEdition_IsCurrentPara_Params.Make(aPara: Integer): IRightEdition_IsCurrentPara_Params;
 {* Фабрика TRightEdition_IsCurrentPara_Params }
var
 l_Inst : TRightEdition_IsCurrentPara_Params;
begin
 l_Inst := Create(aPara);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TRightEdition_IsCurrentPara_Params.Make

function TRightEdition_IsCurrentPara_Params.Get_ResultValue: Boolean;
//#UC START# *55B292EA78F9_13B946D236A8get_var*
//#UC END# *55B292EA78F9_13B946D236A8get_var*
begin
//#UC START# *55B292EA78F9_13B946D236A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *55B292EA78F9_13B946D236A8get_impl*
end;//TRightEdition_IsCurrentPara_Params.Get_ResultValue

procedure TRightEdition_IsCurrentPara_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *55B292EA78F9_13B946D236A8set_var*
//#UC END# *55B292EA78F9_13B946D236A8set_var*
begin
//#UC START# *55B292EA78F9_13B946D236A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *55B292EA78F9_13B946D236A8set_impl*
end;//TRightEdition_IsCurrentPara_Params.Set_ResultValue

function TRightEdition_IsCurrentPara_Params.Get_Para: Integer;
//#UC START# *A70271FDE17E_13B946D236A8get_var*
//#UC END# *A70271FDE17E_13B946D236A8get_var*
begin
//#UC START# *A70271FDE17E_13B946D236A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A70271FDE17E_13B946D236A8get_impl*
end;//TRightEdition_IsCurrentPara_Params.Get_Para

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmEntity;
 aPara: Integer): Boolean;
 {* Вызов операции RightEdition.IsCurrentPara у сущности }
//#UC START# *F9309D43AF45_39C9DDDC4146_var*
//#UC END# *F9309D43AF45_39C9DDDC4146_var*
begin
//#UC START# *F9309D43AF45_39C9DDDC4146_impl*
 !!! Needs to be implemented !!!
//#UC END# *F9309D43AF45_39C9DDDC4146_impl*
end;//Op_RightEdition_IsCurrentPara.Call

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmAggregate;
 aPara: Integer): Boolean;
 {* Вызов операции RightEdition.IsCurrentPara у агрегации }
//#UC START# *29705D323996_39C9DDDC4146_var*
//#UC END# *29705D323996_39C9DDDC4146_var*
begin
//#UC START# *29705D323996_39C9DDDC4146_impl*
 !!! Needs to be implemented !!!
//#UC END# *29705D323996_39C9DDDC4146_impl*
end;//Op_RightEdition_IsCurrentPara.Call

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmEntityForm;
 aPara: Integer): Boolean;
 {* Вызов операции RightEdition.IsCurrentPara у формы }
//#UC START# *06B0E14D520F_39C9DDDC4146_var*
//#UC END# *06B0E14D520F_39C9DDDC4146_var*
begin
//#UC START# *06B0E14D520F_39C9DDDC4146_impl*
 !!! Needs to be implemented !!!
//#UC END# *06B0E14D520F_39C9DDDC4146_impl*
end;//Op_RightEdition_IsCurrentPara.Call

class function Op_RightEdition_IsCurrentPara.Call(const aTarget: IvcmContainer;
 aPara: Integer): Boolean;
 {* Вызов операции RightEdition.IsCurrentPara у контейнера }
//#UC START# *1DDFB2C97A56_39C9DDDC4146_var*
//#UC END# *1DDFB2C97A56_39C9DDDC4146_var*
begin
//#UC START# *1DDFB2C97A56_39C9DDDC4146_impl*
 !!! Needs to be implemented !!!
//#UC END# *1DDFB2C97A56_39C9DDDC4146_impl*
end;//Op_RightEdition_IsCurrentPara.Call

constructor TFinder_GotoPara_Params.Create(aPara: Integer);
 {* Конструктор TFinder_GotoPara_Params }
//#UC START# *1DA4EB55EE9D_67691C3B37B8_var*
//#UC END# *1DA4EB55EE9D_67691C3B37B8_var*
begin
//#UC START# *1DA4EB55EE9D_67691C3B37B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *1DA4EB55EE9D_67691C3B37B8_impl*
end;//TFinder_GotoPara_Params.Create

class function TFinder_GotoPara_Params.Make(aPara: Integer): IFinder_GotoPara_Params;
 {* Фабрика TFinder_GotoPara_Params }
var
 l_Inst : TFinder_GotoPara_Params;
begin
 l_Inst := Create(aPara);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFinder_GotoPara_Params.Make

function TFinder_GotoPara_Params.Get_ResultValue: TGotoParaResult;
//#UC START# *B44AFF3A9FA4_67691C3B37B8get_var*
//#UC END# *B44AFF3A9FA4_67691C3B37B8get_var*
begin
//#UC START# *B44AFF3A9FA4_67691C3B37B8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B44AFF3A9FA4_67691C3B37B8get_impl*
end;//TFinder_GotoPara_Params.Get_ResultValue

procedure TFinder_GotoPara_Params.Set_ResultValue(aValue: TGotoParaResult);
//#UC START# *B44AFF3A9FA4_67691C3B37B8set_var*
//#UC END# *B44AFF3A9FA4_67691C3B37B8set_var*
begin
//#UC START# *B44AFF3A9FA4_67691C3B37B8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *B44AFF3A9FA4_67691C3B37B8set_impl*
end;//TFinder_GotoPara_Params.Set_ResultValue

function TFinder_GotoPara_Params.Get_Para: Integer;
//#UC START# *E8D42E69146B_67691C3B37B8get_var*
//#UC END# *E8D42E69146B_67691C3B37B8get_var*
begin
//#UC START# *E8D42E69146B_67691C3B37B8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E8D42E69146B_67691C3B37B8get_impl*
end;//TFinder_GotoPara_Params.Get_Para

class function Op_Finder_GotoPara.Call(const aTarget: IvcmEntity;
 aPara: Integer): TGotoParaResult;
 {* Вызов операции Finder.GotoPara у сущности }
//#UC START# *2E79CB2E85F4_34B0980955D0_var*
//#UC END# *2E79CB2E85F4_34B0980955D0_var*
begin
//#UC START# *2E79CB2E85F4_34B0980955D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E79CB2E85F4_34B0980955D0_impl*
end;//Op_Finder_GotoPara.Call

class function Op_Finder_GotoPara.Call(const aTarget: IvcmAggregate;
 aPara: Integer): TGotoParaResult;
 {* Вызов операции Finder.GotoPara у агрегации }
//#UC START# *5EB98B1E1044_34B0980955D0_var*
//#UC END# *5EB98B1E1044_34B0980955D0_var*
begin
//#UC START# *5EB98B1E1044_34B0980955D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5EB98B1E1044_34B0980955D0_impl*
end;//Op_Finder_GotoPara.Call

class function Op_Finder_GotoPara.Call(const aTarget: IvcmEntityForm;
 aPara: Integer): TGotoParaResult;
 {* Вызов операции Finder.GotoPara у формы }
//#UC START# *3D18DB6ED737_34B0980955D0_var*
//#UC END# *3D18DB6ED737_34B0980955D0_var*
begin
//#UC START# *3D18DB6ED737_34B0980955D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *3D18DB6ED737_34B0980955D0_impl*
end;//Op_Finder_GotoPara.Call

class function Op_Finder_GotoPara.Call(const aTarget: IvcmContainer;
 aPara: Integer): TGotoParaResult;
 {* Вызов операции Finder.GotoPara у контейнера }
//#UC START# *10C5423A801A_34B0980955D0_var*
//#UC END# *10C5423A801A_34B0980955D0_var*
begin
//#UC START# *10C5423A801A_34B0980955D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *10C5423A801A_34B0980955D0_impl*
end;//Op_Finder_GotoPara.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Finder.DisableForceDrawFocusRect у сущности }
//#UC START# *4BE08C03312C_CB3E212A2D66_var*
//#UC END# *4BE08C03312C_CB3E212A2D66_var*
begin
//#UC START# *4BE08C03312C_CB3E212A2D66_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BE08C03312C_CB3E212A2D66_impl*
end;//Op_Finder_DisableForceDrawFocusRect.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Finder.DisableForceDrawFocusRect у агрегации }
//#UC START# *7C204BF2BB7C_CB3E212A2D66_var*
//#UC END# *7C204BF2BB7C_CB3E212A2D66_var*
begin
//#UC START# *7C204BF2BB7C_CB3E212A2D66_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C204BF2BB7C_CB3E212A2D66_impl*
end;//Op_Finder_DisableForceDrawFocusRect.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Finder.DisableForceDrawFocusRect у формы }
//#UC START# *A25B3317A8E1_CB3E212A2D66_var*
//#UC END# *A25B3317A8E1_CB3E212A2D66_var*
begin
//#UC START# *A25B3317A8E1_CB3E212A2D66_impl*
 !!! Needs to be implemented !!!
//#UC END# *A25B3317A8E1_CB3E212A2D66_impl*
end;//Op_Finder_DisableForceDrawFocusRect.Call

class function Op_Finder_DisableForceDrawFocusRect.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Finder.DisableForceDrawFocusRect у контейнера }
//#UC START# *96BEAC9CDE5B_CB3E212A2D66_var*
//#UC END# *96BEAC9CDE5B_CB3E212A2D66_var*
begin
//#UC START# *96BEAC9CDE5B_CB3E212A2D66_impl*
 !!! Needs to be implemented !!!
//#UC END# *96BEAC9CDE5B_CB3E212A2D66_impl*
end;//Op_Finder_DisableForceDrawFocusRect.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
