unit Base_Operations_Editions_Controls;
 {* Работа с редакциями }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Editions_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Editions" MUID: (4A77058200BA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , eeInterfaces
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // Document

 // Document

 // Document

 // Document

 // Edition

 // Document

 IDocument_SetPosition_Params = interface
  {* Параметры для операции Document.SetPosition }
  ['{1787C467-17B6-4E3F-B610-EF24112F0BBE}']
  function Get_PointID: Cardinal;
  function Get_PointType: TDocumentPositionType;
  function Get_UserType: Integer;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property PointID: Cardinal
   read Get_PointID;
  property PointType: TDocumentPositionType
   read Get_PointType;
  property UserType: Integer
   read Get_UserType;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_SetPosition_Params

 Op_Document_SetPosition = class
  {* Класс для вызова операции Document.SetPosition }
  public
   class function Call(const aTarget: IvcmEntity;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean; overload;
    {* Вызов операции Document.SetPosition у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean; overload;
    {* Вызов операции Document.SetPosition у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean; overload;
    {* Вызов операции Document.SetPosition у формы }
   class function Call(const aTarget: IvcmContainer;
    aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub;
    aUserType: Integer = 0): Boolean; overload;
    {* Вызов операции Document.SetPosition у контейнера }
 end;//Op_Document_SetPosition

 IDocument_GetParaForPositionning_Params = interface
  {* Параметры для операции Document.GetParaForPositionning }
  ['{E79D0E07-76C9-4606-9FE2-95A75EDF5769}']
  function Get_ResultValue: IeeLeafPara;
  procedure Set_ResultValue(const aValue: IeeLeafPara);
  property ResultValue: IeeLeafPara
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_GetParaForPositionning_Params

 Op_Document_GetParaForPositionning = class
  {* Класс для вызова операции Document.GetParaForPositionning }
  public
   class function Call(const aTarget: IvcmEntity): IeeLeafPara; overload;
    {* Вызов операции Document.GetParaForPositionning у сущности }
   class function Call(const aTarget: IvcmAggregate): IeeLeafPara; overload;
    {* Вызов операции Document.GetParaForPositionning у агрегации }
   class function Call(const aTarget: IvcmEntityForm): IeeLeafPara; overload;
    {* Вызов операции Document.GetParaForPositionning у формы }
   class function Call(const aTarget: IvcmContainer): IeeLeafPara; overload;
    {* Вызов операции Document.GetParaForPositionning у контейнера }
 end;//Op_Document_GetParaForPositionning
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TDocument_SetPosition_Params = class(Tl3CProtoObject, IDocument_SetPosition_Params)
  {* Реализация IDocument_SetPosition_Params }
  private
   f_PointID: Cardinal;
   f_PointType: TDocumentPositionType;
   f_UserType: Integer;
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_UserType: Integer;
   function Get_PointType: TDocumentPositionType;
   function Get_PointID: Cardinal;
  public
   constructor Create(aPointID: Cardinal;
    aPointType: TDocumentPositionType;
    aUserType: Integer); reintroduce;
    {* Конструктор TDocument_SetPosition_Params }
   class function Make(aPointID: Cardinal;
    aPointType: TDocumentPositionType;
    aUserType: Integer): IDocument_SetPosition_Params; reintroduce;
    {* Фабрика TDocument_SetPosition_Params }
 end;//TDocument_SetPosition_Params

 TDocument_GetParaForPositionning_Params = class(Tl3CProtoObject, IDocument_GetParaForPositionning_Params)
  {* Реализация IDocument_GetParaForPositionning_Params }
  private
   f_ResultValue: IeeLeafPara;
  protected
   function Get_ResultValue: IeeLeafPara;
   procedure Set_ResultValue(const aValue: IeeLeafPara);
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
    {* Конструктор TDocument_GetParaForPositionning_Params }
   class function Make: IDocument_GetParaForPositionning_Params; reintroduce;
    {* Фабрика TDocument_GetParaForPositionning_Params }
 end;//TDocument_GetParaForPositionning_Params

constructor TDocument_SetPosition_Params.Create(aPointID: Cardinal;
 aPointType: TDocumentPositionType;
 aUserType: Integer);
 {* Конструктор TDocument_SetPosition_Params }
//#UC START# *90E2ACA44431_D2D41F3E8BA1_var*
//#UC END# *90E2ACA44431_D2D41F3E8BA1_var*
begin
//#UC START# *90E2ACA44431_D2D41F3E8BA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *90E2ACA44431_D2D41F3E8BA1_impl*
end;//TDocument_SetPosition_Params.Create

class function TDocument_SetPosition_Params.Make(aPointID: Cardinal;
 aPointType: TDocumentPositionType;
 aUserType: Integer): IDocument_SetPosition_Params;
 {* Фабрика TDocument_SetPosition_Params }
var
 l_Inst : TDocument_SetPosition_Params;
begin
 l_Inst := Create(aPointID, aPointType, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_SetPosition_Params.Make

function TDocument_SetPosition_Params.Get_ResultValue: Boolean;
//#UC START# *4E4FEC1E508B_D2D41F3E8BA1get_var*
//#UC END# *4E4FEC1E508B_D2D41F3E8BA1get_var*
begin
//#UC START# *4E4FEC1E508B_D2D41F3E8BA1get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4FEC1E508B_D2D41F3E8BA1get_impl*
end;//TDocument_SetPosition_Params.Get_ResultValue

procedure TDocument_SetPosition_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *4E4FEC1E508B_D2D41F3E8BA1set_var*
//#UC END# *4E4FEC1E508B_D2D41F3E8BA1set_var*
begin
//#UC START# *4E4FEC1E508B_D2D41F3E8BA1set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4FEC1E508B_D2D41F3E8BA1set_impl*
end;//TDocument_SetPosition_Params.Set_ResultValue

function TDocument_SetPosition_Params.Get_UserType: Integer;
//#UC START# *A79B573AF449_D2D41F3E8BA1get_var*
//#UC END# *A79B573AF449_D2D41F3E8BA1get_var*
begin
//#UC START# *A79B573AF449_D2D41F3E8BA1get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A79B573AF449_D2D41F3E8BA1get_impl*
end;//TDocument_SetPosition_Params.Get_UserType

function TDocument_SetPosition_Params.Get_PointType: TDocumentPositionType;
//#UC START# *BC389FCA1CEC_D2D41F3E8BA1get_var*
//#UC END# *BC389FCA1CEC_D2D41F3E8BA1get_var*
begin
//#UC START# *BC389FCA1CEC_D2D41F3E8BA1get_impl*
 !!! Needs to be implemented !!!
//#UC END# *BC389FCA1CEC_D2D41F3E8BA1get_impl*
end;//TDocument_SetPosition_Params.Get_PointType

function TDocument_SetPosition_Params.Get_PointID: Cardinal;
//#UC START# *C43096EE1AF9_D2D41F3E8BA1get_var*
//#UC END# *C43096EE1AF9_D2D41F3E8BA1get_var*
begin
//#UC START# *C43096EE1AF9_D2D41F3E8BA1get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C43096EE1AF9_D2D41F3E8BA1get_impl*
end;//TDocument_SetPosition_Params.Get_PointID

class function Op_Document_SetPosition.Call(const aTarget: IvcmEntity;
 aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
 {* Вызов операции Document.SetPosition у сущности }
//#UC START# *2DF9B19B191F_293DA96B22E7_var*
//#UC END# *2DF9B19B191F_293DA96B22E7_var*
begin
//#UC START# *2DF9B19B191F_293DA96B22E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *2DF9B19B191F_293DA96B22E7_impl*
end;//Op_Document_SetPosition.Call

class function Op_Document_SetPosition.Call(const aTarget: IvcmAggregate;
 aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
 {* Вызов операции Document.SetPosition у агрегации }
//#UC START# *5E397189A36F_293DA96B22E7_var*
//#UC END# *5E397189A36F_293DA96B22E7_var*
begin
//#UC START# *5E397189A36F_293DA96B22E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5E397189A36F_293DA96B22E7_impl*
end;//Op_Document_SetPosition.Call

class function Op_Document_SetPosition.Call(const aTarget: IvcmEntityForm;
 aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
 {* Вызов операции Document.SetPosition у формы }
//#UC START# *8DE7FC7DDB65_293DA96B22E7_var*
//#UC END# *8DE7FC7DDB65_293DA96B22E7_var*
begin
//#UC START# *8DE7FC7DDB65_293DA96B22E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *8DE7FC7DDB65_293DA96B22E7_impl*
end;//Op_Document_SetPosition.Call

class function Op_Document_SetPosition.Call(const aTarget: IvcmContainer;
 aPointID: Cardinal;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub;
 aUserType: Integer = 0): Boolean;
 {* Вызов операции Document.SetPosition у контейнера }
//#UC START# *A6607DA320A0_293DA96B22E7_var*
//#UC END# *A6607DA320A0_293DA96B22E7_var*
begin
//#UC START# *A6607DA320A0_293DA96B22E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *A6607DA320A0_293DA96B22E7_impl*
end;//Op_Document_SetPosition.Call

constructor TDocument_GetParaForPositionning_Params.Create;
 {* Конструктор TDocument_GetParaForPositionning_Params }
//#UC START# *CACE1BA7DBBA_5DB76F402B0D_var*
//#UC END# *CACE1BA7DBBA_5DB76F402B0D_var*
begin
//#UC START# *CACE1BA7DBBA_5DB76F402B0D_impl*
 !!! Needs to be implemented !!!
//#UC END# *CACE1BA7DBBA_5DB76F402B0D_impl*
end;//TDocument_GetParaForPositionning_Params.Create

class function TDocument_GetParaForPositionning_Params.Make: IDocument_GetParaForPositionning_Params;
 {* Фабрика TDocument_GetParaForPositionning_Params }
var
 l_Inst : TDocument_GetParaForPositionning_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_GetParaForPositionning_Params.Make

function TDocument_GetParaForPositionning_Params.Get_ResultValue: IeeLeafPara;
//#UC START# *F9C055C57DF5_5DB76F402B0Dget_var*
//#UC END# *F9C055C57DF5_5DB76F402B0Dget_var*
begin
//#UC START# *F9C055C57DF5_5DB76F402B0Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *F9C055C57DF5_5DB76F402B0Dget_impl*
end;//TDocument_GetParaForPositionning_Params.Get_ResultValue

procedure TDocument_GetParaForPositionning_Params.Set_ResultValue(const aValue: IeeLeafPara);
//#UC START# *F9C055C57DF5_5DB76F402B0Dset_var*
//#UC END# *F9C055C57DF5_5DB76F402B0Dset_var*
begin
//#UC START# *F9C055C57DF5_5DB76F402B0Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *F9C055C57DF5_5DB76F402B0Dset_impl*
end;//TDocument_GetParaForPositionning_Params.Set_ResultValue

procedure TDocument_GetParaForPositionning_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TDocument_GetParaForPositionning_Params.ClearFields

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmEntity): IeeLeafPara;
 {* Вызов операции Document.GetParaForPositionning у сущности }
//#UC START# *75783DA0214F_0E3B5BC0A746_var*
//#UC END# *75783DA0214F_0E3B5BC0A746_var*
begin
//#UC START# *75783DA0214F_0E3B5BC0A746_impl*
 !!! Needs to be implemented !!!
//#UC END# *75783DA0214F_0E3B5BC0A746_impl*
end;//Op_Document_GetParaForPositionning.Call

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmAggregate): IeeLeafPara;
 {* Вызов операции Document.GetParaForPositionning у агрегации }
//#UC START# *587BFA83ABA0_0E3B5BC0A746_var*
//#UC END# *587BFA83ABA0_0E3B5BC0A746_var*
begin
//#UC START# *587BFA83ABA0_0E3B5BC0A746_impl*
 !!! Needs to be implemented !!!
//#UC END# *587BFA83ABA0_0E3B5BC0A746_impl*
end;//Op_Document_GetParaForPositionning.Call

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmEntityForm): IeeLeafPara;
 {* Вызов операции Document.GetParaForPositionning у формы }
//#UC START# *DFF5F48F7C0F_0E3B5BC0A746_var*
//#UC END# *DFF5F48F7C0F_0E3B5BC0A746_var*
begin
//#UC START# *DFF5F48F7C0F_0E3B5BC0A746_impl*
 !!! Needs to be implemented !!!
//#UC END# *DFF5F48F7C0F_0E3B5BC0A746_impl*
end;//Op_Document_GetParaForPositionning.Call

class function Op_Document_GetParaForPositionning.Call(const aTarget: IvcmContainer): IeeLeafPara;
 {* Вызов операции Document.GetParaForPositionning у контейнера }
//#UC START# *8D673BCDD23C_0E3B5BC0A746_var*
//#UC END# *8D673BCDD23C_0E3B5BC0A746_var*
begin
//#UC START# *8D673BCDD23C_0E3B5BC0A746_impl*
 !!! Needs to be implemented !!!
//#UC END# *8D673BCDD23C_0E3B5BC0A746_impl*
end;//Op_Document_GetParaForPositionning.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
