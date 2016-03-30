unit ServerAdapterConverters;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ServerAdapterConverters.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ServerAdapterConverters" MUID: (460B956502AF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ConsultingUnit
 , BaseTypesUnit
 , DocumentUnit
 , DynamicTreeUnit
 //#UC START# *460B956502AFintf_uses*
 //#UC END# *460B956502AFintf_uses*
;

procedure AdapterToServer(const adap: TPId); overload; stdcall;
procedure ServerToAdapter(const serv;
 var adap: TPosition); overload; stdcall; { can raise Unsupported }
procedure AdapterToServer(const adap: TPosition;
 var serv); overload; stdcall; { can raise Unsupported }
procedure ServerToAdapter(const serv;
 out adap: IPositionList); overload; stdcall; { can raise Unsupported }
procedure AdapterToServer(const adap: IPositionList;
 var serv); overload; stdcall; { can raise Unsupported }
procedure ServerToAdapter(const serv;
 var adap: ILanguagesList); overload; stdcall;
procedure CategoryToQuery(const category: INodeBase;
 var query); stdcall;
procedure Convert(const adapter_from: TNodePosition;
 var srv_from); stdcall;
procedure AdapterToServer(const adapter_index_path: INodeIndexPath); overload; stdcall;
procedure ServerToAdapter(const index_path;
 var adap_path: INodeIndexPath); overload; stdcall;
procedure AdapterToServer(adapter_status: TConsultationStatus); overload; stdcall;
function ServerToAdapter(const server_status): TConsultationStatus; overload; stdcall;
function ConsultationStatusToFoldersFlag(const server_status): Cardinal; stdcall;
procedure AdapterToServer(adapter_order: TFindOrder); overload; stdcall;
procedure AdapterToServer(adapter_area: TSearchArea); overload; stdcall;
procedure AdapterToServer(adapter_place: TContextPlace); overload; stdcall;
procedure ServerToAdapter(const serv;
 var adap: IDocPointList); overload; stdcall;
 {* Преобразование серверного списка вида Документ, Саб в адаптерный }

implementation

uses
 l3ImplUses
 , SearchUnit
 //#UC START# *460B956502AFimpl_uses*
 //#UC END# *460B956502AFimpl_uses*
;

procedure AdapterToServer(const adap: TPId);
//#UC START# *460B95A600CB_460B956502AF_var*
//#UC END# *460B95A600CB_460B956502AF_var*
begin
//#UC START# *460B95A600CB_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B95A600CB_460B956502AF_impl*
end;//AdapterToServer

procedure ServerToAdapter(const serv;
 var adap: TPosition); { can raise Unsupported }
//#UC START# *460BAC17029F_460B956502AF_var*
//#UC END# *460BAC17029F_460B956502AF_var*
begin
//#UC START# *460BAC17029F_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BAC17029F_460B956502AF_impl*
end;//ServerToAdapter

procedure AdapterToServer(const adap: TPosition;
 var serv); { can raise Unsupported }
//#UC START# *460CCAA201E4_460B956502AF_var*
//#UC END# *460CCAA201E4_460B956502AF_var*
begin
//#UC START# *460CCAA201E4_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CCAA201E4_460B956502AF_impl*
end;//AdapterToServer

procedure ServerToAdapter(const serv;
 out adap: IPositionList); { can raise Unsupported }
//#UC START# *460BADAA00EA_460B956502AF_var*
//#UC END# *460BADAA00EA_460B956502AF_var*
begin
//#UC START# *460BADAA00EA_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BADAA00EA_460B956502AF_impl*
end;//ServerToAdapter

procedure AdapterToServer(const adap: IPositionList;
 var serv); { can raise Unsupported }
//#UC START# *460BAE0903B9_460B956502AF_var*
//#UC END# *460BAE0903B9_460B956502AF_var*
begin
//#UC START# *460BAE0903B9_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BAE0903B9_460B956502AF_impl*
end;//AdapterToServer

procedure ServerToAdapter(const serv;
 var adap: ILanguagesList);
//#UC START# *460BB2AF01C5_460B956502AF_var*
//#UC END# *460BB2AF01C5_460B956502AF_var*
begin
//#UC START# *460BB2AF01C5_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BB2AF01C5_460B956502AF_impl*
end;//ServerToAdapter

procedure CategoryToQuery(const category: INodeBase;
 var query);
//#UC START# *460BB2E5036B_460B956502AF_var*
//#UC END# *460BB2E5036B_460B956502AF_var*
begin
//#UC START# *460BB2E5036B_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BB2E5036B_460B956502AF_impl*
end;//CategoryToQuery

procedure Convert(const adapter_from: TNodePosition;
 var srv_from);
//#UC START# *46151F7E0399_460B956502AF_var*
//#UC END# *46151F7E0399_460B956502AF_var*
begin
//#UC START# *46151F7E0399_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *46151F7E0399_460B956502AF_impl*
end;//Convert

procedure AdapterToServer(const adapter_index_path: INodeIndexPath);
//#UC START# *47B6D48902FA_460B956502AF_var*
//#UC END# *47B6D48902FA_460B956502AF_var*
begin
//#UC START# *47B6D48902FA_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B6D48902FA_460B956502AF_impl*
end;//AdapterToServer

procedure ServerToAdapter(const index_path;
 var adap_path: INodeIndexPath);
//#UC START# *47B6D5B502D3_460B956502AF_var*
//#UC END# *47B6D5B502D3_460B956502AF_var*
begin
//#UC START# *47B6D5B502D3_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B6D5B502D3_460B956502AF_impl*
end;//ServerToAdapter

procedure AdapterToServer(adapter_status: TConsultationStatus);
//#UC START# *486B36420166_460B956502AF_var*
//#UC END# *486B36420166_460B956502AF_var*
begin
//#UC START# *486B36420166_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *486B36420166_460B956502AF_impl*
end;//AdapterToServer

function ServerToAdapter(const server_status): TConsultationStatus;
//#UC START# *486B3685024C_460B956502AF_var*
//#UC END# *486B3685024C_460B956502AF_var*
begin
//#UC START# *486B3685024C_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *486B3685024C_460B956502AF_impl*
end;//ServerToAdapter

function ConsultationStatusToFoldersFlag(const server_status): Cardinal;
//#UC START# *486B4C8900FE_460B956502AF_var*
//#UC END# *486B4C8900FE_460B956502AF_var*
begin
//#UC START# *486B4C8900FE_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *486B4C8900FE_460B956502AF_impl*
end;//ConsultationStatusToFoldersFlag

procedure AdapterToServer(adapter_order: TFindOrder);
//#UC START# *4D3EABF5008B_460B956502AF_var*
//#UC END# *4D3EABF5008B_460B956502AF_var*
begin
//#UC START# *4D3EABF5008B_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EABF5008B_460B956502AF_impl*
end;//AdapterToServer

procedure AdapterToServer(adapter_area: TSearchArea);
//#UC START# *4D3EACE502A5_460B956502AF_var*
//#UC END# *4D3EACE502A5_460B956502AF_var*
begin
//#UC START# *4D3EACE502A5_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EACE502A5_460B956502AF_impl*
end;//AdapterToServer

procedure AdapterToServer(adapter_place: TContextPlace);
//#UC START# *4D3EAD0C00A5_460B956502AF_var*
//#UC END# *4D3EAD0C00A5_460B956502AF_var*
begin
//#UC START# *4D3EAD0C00A5_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EAD0C00A5_460B956502AF_impl*
end;//AdapterToServer

procedure ServerToAdapter(const serv;
 var adap: IDocPointList);
 {* Преобразование серверного списка вида Документ, Саб в адаптерный }
//#UC START# *4DCCD8970014_460B956502AF_var*
//#UC END# *4DCCD8970014_460B956502AF_var*
begin
//#UC START# *4DCCD8970014_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DCCD8970014_460B956502AF_impl*
end;//ServerToAdapter

end.
