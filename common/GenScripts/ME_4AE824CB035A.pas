unit Settings_Strange_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings_Strange_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Strange" MUID: (4AE824CB035A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // StyleEditor

 // StyleEditor

 // StyleEditor

 // Result

 // PopupMenu

 IStyleEditor_ReloadStylesTree_Params = interface
  {* ��������� ��� �������� StyleEditor.ReloadStylesTree }
  ['{44E58188-3AF4-4C21-83BC-CD468E83F8D6}']
  function Get_StyleName: Il3CString;
  property StyleName: Il3CString
   read Get_StyleName;
 end;//IStyleEditor_ReloadStylesTree_Params

 Op_StyleEditor_ReloadStylesTree = class
  {* ����� ��� ������ �������� StyleEditor.ReloadStylesTree }
  public
   class function Call(const aTarget: IvcmEntity;
    const aStyleName: Il3CString): Boolean; overload;
    {* ����� �������� StyleEditor.ReloadStylesTree � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aStyleName: Il3CString): Boolean; overload;
    {* ����� �������� StyleEditor.ReloadStylesTree � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aStyleName: Il3CString): Boolean; overload;
    {* ����� �������� StyleEditor.ReloadStylesTree � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aStyleName: Il3CString): Boolean; overload;
    {* ����� �������� StyleEditor.ReloadStylesTree � ���������� }
 end;//Op_StyleEditor_ReloadStylesTree

 IStyleEditor_RestoreStyleTable_Params = interface
  {* ��������� ��� �������� StyleEditor.RestoreStyleTable }
  ['{325BF732-0BD7-4E61-BEC5-48A77132247C}']
  function Get_RestoreDefault: Boolean;
  property RestoreDefault: Boolean
   read Get_RestoreDefault;
 end;//IStyleEditor_RestoreStyleTable_Params

 Op_StyleEditor_RestoreStyleTable = class
  {* ����� ��� ������ �������� StyleEditor.RestoreStyleTable }
  public
   class function Call(const aTarget: IvcmEntity;
    aRestoreDefault: Boolean): Boolean; overload;
    {* ����� �������� StyleEditor.RestoreStyleTable � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aRestoreDefault: Boolean): Boolean; overload;
    {* ����� �������� StyleEditor.RestoreStyleTable � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aRestoreDefault: Boolean): Boolean; overload;
    {* ����� �������� StyleEditor.RestoreStyleTable � ����� }
   class function Call(const aTarget: IvcmContainer;
    aRestoreDefault: Boolean): Boolean; overload;
    {* ����� �������� StyleEditor.RestoreStyleTable � ���������� }
 end;//Op_StyleEditor_RestoreStyleTable

 IStyleEditor_SaveStyleTable_Params = interface
  {* ��������� ��� �������� StyleEditor.SaveStyleTable }
  ['{71D351FB-D271-45F9-A89E-75908DCA75A2}']
  function Get_SaveAsDefault: Boolean;
  property SaveAsDefault: Boolean
   read Get_SaveAsDefault;
 end;//IStyleEditor_SaveStyleTable_Params

 Op_StyleEditor_SaveStyleTable = class
  {* ����� ��� ������ �������� StyleEditor.SaveStyleTable }
  public
   class function Call(const aTarget: IvcmEntity;
    aSaveAsDefault: Boolean): Boolean; overload;
    {* ����� �������� StyleEditor.SaveStyleTable � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aSaveAsDefault: Boolean): Boolean; overload;
    {* ����� �������� StyleEditor.SaveStyleTable � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aSaveAsDefault: Boolean): Boolean; overload;
    {* ����� �������� StyleEditor.SaveStyleTable � ����� }
   class function Call(const aTarget: IvcmContainer;
    aSaveAsDefault: Boolean): Boolean; overload;
    {* ����� �������� StyleEditor.SaveStyleTable � ���������� }
 end;//Op_StyleEditor_SaveStyleTable

 IStyleEditor_SetNewContent_Params = interface
  {* ��������� ��� �������� StyleEditor.SetNewContent }
  ['{23154956-86C0-45EA-A8AE-5A3CDA3D0F9A}']
  function Get_StyleID: Integer;
  property StyleID: Integer
   read Get_StyleID;
 end;//IStyleEditor_SetNewContent_Params

 Op_StyleEditor_SetNewContent = class
  {* ����� ��� ������ �������� StyleEditor.SetNewContent }
  public
   class function Call(const aTarget: IvcmEntity;
    aStyleID: Integer): Boolean; overload;
    {* ����� �������� StyleEditor.SetNewContent � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aStyleID: Integer): Boolean; overload;
    {* ����� �������� StyleEditor.SetNewContent � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aStyleID: Integer): Boolean; overload;
    {* ����� �������� StyleEditor.SetNewContent � ����� }
   class function Call(const aTarget: IvcmContainer;
    aStyleID: Integer): Boolean; overload;
    {* ����� �������� StyleEditor.SetNewContent � ���������� }
 end;//Op_StyleEditor_SetNewContent

 Op_StyleEditor_ReloadStyleTable = class
  {* ����� ��� ������ �������� StyleEditor.ReloadStyleTable }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� StyleEditor.ReloadStyleTable � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� StyleEditor.ReloadStyleTable � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� StyleEditor.ReloadStyleTable � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� StyleEditor.ReloadStyleTable � ���������� }
 end;//Op_StyleEditor_ReloadStyleTable
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TStyleEditor_ReloadStylesTree_Params = class(Tl3CProtoObject, IStyleEditor_ReloadStylesTree_Params)
  {* ���������� IStyleEditor_ReloadStylesTree_Params }
  private
   f_StyleName: Il3CString;
  protected
   function Get_StyleName: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aStyleName: Il3CString); reintroduce;
    {* ����������� TStyleEditor_ReloadStylesTree_Params }
   class function Make(const aStyleName: Il3CString): IStyleEditor_ReloadStylesTree_Params; reintroduce;
    {* ������� TStyleEditor_ReloadStylesTree_Params }
 end;//TStyleEditor_ReloadStylesTree_Params

 TStyleEditor_RestoreStyleTable_Params = class(Tl3CProtoObject, IStyleEditor_RestoreStyleTable_Params)
  {* ���������� IStyleEditor_RestoreStyleTable_Params }
  private
   f_RestoreDefault: Boolean;
  protected
   function Get_RestoreDefault: Boolean;
  public
   constructor Create(aRestoreDefault: Boolean); reintroduce;
    {* ����������� TStyleEditor_RestoreStyleTable_Params }
   class function Make(aRestoreDefault: Boolean): IStyleEditor_RestoreStyleTable_Params; reintroduce;
    {* ������� TStyleEditor_RestoreStyleTable_Params }
 end;//TStyleEditor_RestoreStyleTable_Params

 TStyleEditor_SaveStyleTable_Params = class(Tl3CProtoObject, IStyleEditor_SaveStyleTable_Params)
  {* ���������� IStyleEditor_SaveStyleTable_Params }
  private
   f_SaveAsDefault: Boolean;
  protected
   function Get_SaveAsDefault: Boolean;
  public
   constructor Create(aSaveAsDefault: Boolean); reintroduce;
    {* ����������� TStyleEditor_SaveStyleTable_Params }
   class function Make(aSaveAsDefault: Boolean): IStyleEditor_SaveStyleTable_Params; reintroduce;
    {* ������� TStyleEditor_SaveStyleTable_Params }
 end;//TStyleEditor_SaveStyleTable_Params

 TStyleEditor_SetNewContent_Params = class(Tl3CProtoObject, IStyleEditor_SetNewContent_Params)
  {* ���������� IStyleEditor_SetNewContent_Params }
  private
   f_StyleID: Integer;
  protected
   function Get_StyleID: Integer;
  public
   constructor Create(aStyleID: Integer); reintroduce;
    {* ����������� TStyleEditor_SetNewContent_Params }
   class function Make(aStyleID: Integer): IStyleEditor_SetNewContent_Params; reintroduce;
    {* ������� TStyleEditor_SetNewContent_Params }
 end;//TStyleEditor_SetNewContent_Params

constructor TStyleEditor_ReloadStylesTree_Params.Create(const aStyleName: Il3CString);
 {* ����������� TStyleEditor_ReloadStylesTree_Params }
//#UC START# *FFC82E388433_7F529317A0FC_var*
//#UC END# *FFC82E388433_7F529317A0FC_var*
begin
//#UC START# *FFC82E388433_7F529317A0FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *FFC82E388433_7F529317A0FC_impl*
end;//TStyleEditor_ReloadStylesTree_Params.Create

class function TStyleEditor_ReloadStylesTree_Params.Make(const aStyleName: Il3CString): IStyleEditor_ReloadStylesTree_Params;
 {* ������� TStyleEditor_ReloadStylesTree_Params }
var
 l_Inst : TStyleEditor_ReloadStylesTree_Params;
begin
 l_Inst := Create(aStyleName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TStyleEditor_ReloadStylesTree_Params.Make

function TStyleEditor_ReloadStylesTree_Params.Get_StyleName: Il3CString;
//#UC START# *F22873E69420_7F529317A0FCget_var*
//#UC END# *F22873E69420_7F529317A0FCget_var*
begin
//#UC START# *F22873E69420_7F529317A0FCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *F22873E69420_7F529317A0FCget_impl*
end;//TStyleEditor_ReloadStylesTree_Params.Get_StyleName

procedure TStyleEditor_ReloadStylesTree_Params.ClearFields;
begin
 f_StyleName := nil;
 inherited;
end;//TStyleEditor_ReloadStylesTree_Params.ClearFields

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmEntity;
 const aStyleName: Il3CString): Boolean;
 {* ����� �������� StyleEditor.ReloadStylesTree � �������� }
//#UC START# *D241355F29F6_866958AD096E_var*
//#UC END# *D241355F29F6_866958AD096E_var*
begin
//#UC START# *D241355F29F6_866958AD096E_impl*
 !!! Needs to be implemented !!!
//#UC END# *D241355F29F6_866958AD096E_impl*
end;//Op_StyleEditor_ReloadStylesTree.Call

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmAggregate;
 const aStyleName: Il3CString): Boolean;
 {* ����� �������� StyleEditor.ReloadStylesTree � ��������� }
//#UC START# *0280F54DB447_866958AD096E_var*
//#UC END# *0280F54DB447_866958AD096E_var*
begin
//#UC START# *0280F54DB447_866958AD096E_impl*
 !!! Needs to be implemented !!!
//#UC END# *0280F54DB447_866958AD096E_impl*
end;//Op_StyleEditor_ReloadStylesTree.Call

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmEntityForm;
 const aStyleName: Il3CString): Boolean;
 {* ����� �������� StyleEditor.ReloadStylesTree � ����� }
//#UC START# *9EBB367AA146_866958AD096E_var*
//#UC END# *9EBB367AA146_866958AD096E_var*
begin
//#UC START# *9EBB367AA146_866958AD096E_impl*
 !!! Needs to be implemented !!!
//#UC END# *9EBB367AA146_866958AD096E_impl*
end;//Op_StyleEditor_ReloadStylesTree.Call

class function Op_StyleEditor_ReloadStylesTree.Call(const aTarget: IvcmContainer;
 const aStyleName: Il3CString): Boolean;
 {* ����� �������� StyleEditor.ReloadStylesTree � ���������� }
//#UC START# *206BAC59D045_866958AD096E_var*
//#UC END# *206BAC59D045_866958AD096E_var*
begin
//#UC START# *206BAC59D045_866958AD096E_impl*
 !!! Needs to be implemented !!!
//#UC END# *206BAC59D045_866958AD096E_impl*
end;//Op_StyleEditor_ReloadStylesTree.Call

constructor TStyleEditor_RestoreStyleTable_Params.Create(aRestoreDefault: Boolean);
 {* ����������� TStyleEditor_RestoreStyleTable_Params }
//#UC START# *352EFF68E788_D1EE9507728C_var*
//#UC END# *352EFF68E788_D1EE9507728C_var*
begin
//#UC START# *352EFF68E788_D1EE9507728C_impl*
 !!! Needs to be implemented !!!
//#UC END# *352EFF68E788_D1EE9507728C_impl*
end;//TStyleEditor_RestoreStyleTable_Params.Create

class function TStyleEditor_RestoreStyleTable_Params.Make(aRestoreDefault: Boolean): IStyleEditor_RestoreStyleTable_Params;
 {* ������� TStyleEditor_RestoreStyleTable_Params }
var
 l_Inst : TStyleEditor_RestoreStyleTable_Params;
begin
 l_Inst := Create(aRestoreDefault);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TStyleEditor_RestoreStyleTable_Params.Make

function TStyleEditor_RestoreStyleTable_Params.Get_RestoreDefault: Boolean;
//#UC START# *03FF139F9A0C_D1EE9507728Cget_var*
//#UC END# *03FF139F9A0C_D1EE9507728Cget_var*
begin
//#UC START# *03FF139F9A0C_D1EE9507728Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *03FF139F9A0C_D1EE9507728Cget_impl*
end;//TStyleEditor_RestoreStyleTable_Params.Get_RestoreDefault

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmEntity;
 aRestoreDefault: Boolean): Boolean;
 {* ����� �������� StyleEditor.RestoreStyleTable � �������� }
//#UC START# *C048F463E899_B2C906B2DB11_var*
//#UC END# *C048F463E899_B2C906B2DB11_var*
begin
//#UC START# *C048F463E899_B2C906B2DB11_impl*
 !!! Needs to be implemented !!!
//#UC END# *C048F463E899_B2C906B2DB11_impl*
end;//Op_StyleEditor_RestoreStyleTable.Call

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmAggregate;
 aRestoreDefault: Boolean): Boolean;
 {* ����� �������� StyleEditor.RestoreStyleTable � ��������� }
//#UC START# *F088B45372E9_B2C906B2DB11_var*
//#UC END# *F088B45372E9_B2C906B2DB11_var*
begin
//#UC START# *F088B45372E9_B2C906B2DB11_impl*
 !!! Needs to be implemented !!!
//#UC END# *F088B45372E9_B2C906B2DB11_impl*
end;//Op_StyleEditor_RestoreStyleTable.Call

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmEntityForm;
 aRestoreDefault: Boolean): Boolean;
 {* ����� �������� StyleEditor.RestoreStyleTable � ����� }
//#UC START# *D2E907E6A1FD_B2C906B2DB11_var*
//#UC END# *D2E907E6A1FD_B2C906B2DB11_var*
begin
//#UC START# *D2E907E6A1FD_B2C906B2DB11_impl*
 !!! Needs to be implemented !!!
//#UC END# *D2E907E6A1FD_B2C906B2DB11_impl*
end;//Op_StyleEditor_RestoreStyleTable.Call

class function Op_StyleEditor_RestoreStyleTable.Call(const aTarget: IvcmContainer;
 aRestoreDefault: Boolean): Boolean;
 {* ����� �������� StyleEditor.RestoreStyleTable � ���������� }
//#UC START# *01FA5947B97F_B2C906B2DB11_var*
//#UC END# *01FA5947B97F_B2C906B2DB11_var*
begin
//#UC START# *01FA5947B97F_B2C906B2DB11_impl*
 !!! Needs to be implemented !!!
//#UC END# *01FA5947B97F_B2C906B2DB11_impl*
end;//Op_StyleEditor_RestoreStyleTable.Call

constructor TStyleEditor_SaveStyleTable_Params.Create(aSaveAsDefault: Boolean);
 {* ����������� TStyleEditor_SaveStyleTable_Params }
//#UC START# *196E49773208_9AEDDB922E48_var*
//#UC END# *196E49773208_9AEDDB922E48_var*
begin
//#UC START# *196E49773208_9AEDDB922E48_impl*
 !!! Needs to be implemented !!!
//#UC END# *196E49773208_9AEDDB922E48_impl*
end;//TStyleEditor_SaveStyleTable_Params.Create

class function TStyleEditor_SaveStyleTable_Params.Make(aSaveAsDefault: Boolean): IStyleEditor_SaveStyleTable_Params;
 {* ������� TStyleEditor_SaveStyleTable_Params }
var
 l_Inst : TStyleEditor_SaveStyleTable_Params;
begin
 l_Inst := Create(aSaveAsDefault);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TStyleEditor_SaveStyleTable_Params.Make

function TStyleEditor_SaveStyleTable_Params.Get_SaveAsDefault: Boolean;
//#UC START# *1CC2590F85EE_9AEDDB922E48get_var*
//#UC END# *1CC2590F85EE_9AEDDB922E48get_var*
begin
//#UC START# *1CC2590F85EE_9AEDDB922E48get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1CC2590F85EE_9AEDDB922E48get_impl*
end;//TStyleEditor_SaveStyleTable_Params.Get_SaveAsDefault

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmEntity;
 aSaveAsDefault: Boolean): Boolean;
 {* ����� �������� StyleEditor.SaveStyleTable � �������� }
//#UC START# *4A4EF20920BF_FF91D02A84CC_var*
//#UC END# *4A4EF20920BF_FF91D02A84CC_var*
begin
//#UC START# *4A4EF20920BF_FF91D02A84CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4EF20920BF_FF91D02A84CC_impl*
end;//Op_StyleEditor_SaveStyleTable.Call

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmAggregate;
 aSaveAsDefault: Boolean): Boolean;
 {* ����� �������� StyleEditor.SaveStyleTable � ��������� }
//#UC START# *7A8EB1F8AB0F_FF91D02A84CC_var*
//#UC END# *7A8EB1F8AB0F_FF91D02A84CC_var*
begin
//#UC START# *7A8EB1F8AB0F_FF91D02A84CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A8EB1F8AB0F_FF91D02A84CC_impl*
end;//Op_StyleEditor_SaveStyleTable.Call

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmEntityForm;
 aSaveAsDefault: Boolean): Boolean;
 {* ����� �������� StyleEditor.SaveStyleTable � ����� }
//#UC START# *B4FBF1544598_FF91D02A84CC_var*
//#UC END# *B4FBF1544598_FF91D02A84CC_var*
begin
//#UC START# *B4FBF1544598_FF91D02A84CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *B4FBF1544598_FF91D02A84CC_impl*
end;//Op_StyleEditor_SaveStyleTable.Call

class function Op_StyleEditor_SaveStyleTable.Call(const aTarget: IvcmContainer;
 aSaveAsDefault: Boolean): Boolean;
 {* ����� �������� StyleEditor.SaveStyleTable � ���������� }
//#UC START# *FFA270228CDE_FF91D02A84CC_var*
//#UC END# *FFA270228CDE_FF91D02A84CC_var*
begin
//#UC START# *FFA270228CDE_FF91D02A84CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *FFA270228CDE_FF91D02A84CC_impl*
end;//Op_StyleEditor_SaveStyleTable.Call

constructor TStyleEditor_SetNewContent_Params.Create(aStyleID: Integer);
 {* ����������� TStyleEditor_SetNewContent_Params }
//#UC START# *D103C8E00E3D_F73281FC1ED3_var*
//#UC END# *D103C8E00E3D_F73281FC1ED3_var*
begin
//#UC START# *D103C8E00E3D_F73281FC1ED3_impl*
 !!! Needs to be implemented !!!
//#UC END# *D103C8E00E3D_F73281FC1ED3_impl*
end;//TStyleEditor_SetNewContent_Params.Create

class function TStyleEditor_SetNewContent_Params.Make(aStyleID: Integer): IStyleEditor_SetNewContent_Params;
 {* ������� TStyleEditor_SetNewContent_Params }
var
 l_Inst : TStyleEditor_SetNewContent_Params;
begin
 l_Inst := Create(aStyleID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TStyleEditor_SetNewContent_Params.Make

function TStyleEditor_SetNewContent_Params.Get_StyleID: Integer;
//#UC START# *144087DB0A73_F73281FC1ED3get_var*
//#UC END# *144087DB0A73_F73281FC1ED3get_var*
begin
//#UC START# *144087DB0A73_F73281FC1ED3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *144087DB0A73_F73281FC1ED3get_impl*
end;//TStyleEditor_SetNewContent_Params.Get_StyleID

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmEntity;
 aStyleID: Integer): Boolean;
 {* ����� �������� StyleEditor.SetNewContent � �������� }
//#UC START# *C13F9D0CC76D_CE5EDFC2232C_var*
//#UC END# *C13F9D0CC76D_CE5EDFC2232C_var*
begin
//#UC START# *C13F9D0CC76D_CE5EDFC2232C_impl*
 !!! Needs to be implemented !!!
//#UC END# *C13F9D0CC76D_CE5EDFC2232C_impl*
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmAggregate;
 aStyleID: Integer): Boolean;
 {* ����� �������� StyleEditor.SetNewContent � ��������� }
//#UC START# *F17F5CFB51BD_CE5EDFC2232C_var*
//#UC END# *F17F5CFB51BD_CE5EDFC2232C_var*
begin
//#UC START# *F17F5CFB51BD_CE5EDFC2232C_impl*
 !!! Needs to be implemented !!!
//#UC END# *F17F5CFB51BD_CE5EDFC2232C_impl*
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmEntityForm;
 aStyleID: Integer): Boolean;
 {* ����� �������� StyleEditor.SetNewContent � ����� }
//#UC START# *60FA6A7C5E71_CE5EDFC2232C_var*
//#UC END# *60FA6A7C5E71_CE5EDFC2232C_var*
begin
//#UC START# *60FA6A7C5E71_CE5EDFC2232C_impl*
 !!! Needs to be implemented !!!
//#UC END# *60FA6A7C5E71_CE5EDFC2232C_impl*
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_SetNewContent.Call(const aTarget: IvcmContainer;
 aStyleID: Integer): Boolean;
 {* ����� �������� StyleEditor.SetNewContent � ���������� }
//#UC START# *B8F01849268C_CE5EDFC2232C_var*
//#UC END# *B8F01849268C_CE5EDFC2232C_var*
begin
//#UC START# *B8F01849268C_CE5EDFC2232C_impl*
 !!! Needs to be implemented !!!
//#UC END# *B8F01849268C_CE5EDFC2232C_impl*
end;//Op_StyleEditor_SetNewContent.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� StyleEditor.ReloadStyleTable � �������� }
//#UC START# *FDDB41C892A8_6D9B760D5CA1_var*
//#UC END# *FDDB41C892A8_6D9B760D5CA1_var*
begin
//#UC START# *FDDB41C892A8_6D9B760D5CA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *FDDB41C892A8_6D9B760D5CA1_impl*
end;//Op_StyleEditor_ReloadStyleTable.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� StyleEditor.ReloadStyleTable � ��������� }
//#UC START# *2E1B01B71CF9_6D9B760D5CA1_var*
//#UC END# *2E1B01B71CF9_6D9B760D5CA1_var*
begin
//#UC START# *2E1B01B71CF9_6D9B760D5CA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E1B01B71CF9_6D9B760D5CA1_impl*
end;//Op_StyleEditor_ReloadStyleTable.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� StyleEditor.ReloadStyleTable � ����� }
//#UC START# *8E36ED144DB0_6D9B760D5CA1_var*
//#UC END# *8E36ED144DB0_6D9B760D5CA1_var*
begin
//#UC START# *8E36ED144DB0_6D9B760D5CA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E36ED144DB0_6D9B760D5CA1_impl*
end;//Op_StyleEditor_ReloadStyleTable.Call

class function Op_StyleEditor_ReloadStyleTable.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� StyleEditor.ReloadStyleTable � ���������� }
//#UC START# *1E8B6CBE0CA9_6D9B760D5CA1_var*
//#UC END# *1E8B6CBE0CA9_6D9B760D5CA1_var*
begin
//#UC START# *1E8B6CBE0CA9_6D9B760D5CA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *1E8B6CBE0CA9_6D9B760D5CA1_impl*
end;//Op_StyleEditor_ReloadStyleTable.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
