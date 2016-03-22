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
;

procedure adapter_to_server(const adap: TPId); overload;
procedure server_to_adapter(const serv;
 var adap: TPosition); overload; { can raise Unsupported }
procedure adapter_to_server(const adap: TPosition;
 var serv); overload; { can raise Unsupported }
procedure server_to_adapter(const serv;
 out adap: IPositionList); overload; { can raise Unsupported }
procedure adapter_to_server(const adap: IPositionList;
 var serv); overload; { can raise Unsupported }
procedure server_to_adapter(const serv;
 var adap: ILanguagesList); overload;
procedure category_to_query(const category: INodeBase;
 var query);
procedure convert(const adapter_from: TNodePosition;
 var srv_from);
procedure adapter_to_server(const adapter_index_path: INodeIndexPath); overload;
procedure server_to_adapter(const index_path;
 var adap_path: INodeIndexPath); overload;
procedure adapter_to_server(adapter_status: TConsultationStatus); overload;
function server_to_adapter(const server_status): TConsultationStatus; overload;
function consultation_status_to_folders_flag(const server_status): Cardinal;
procedure adapter_to_server(adapter_order: TFindOrder); overload;
procedure adapter_to_server(adapter_area: TSearchArea); overload;
procedure adapter_to_server(adapter_place: TContextPlace); overload;
procedure server_to_adapter(const serv;
 var adap: IDocPointList); overload;
 {* Преобразование серверного списка вида Документ, Саб в адаптерный }

implementation

uses
 l3ImplUses
 , SearchUnit
;

procedure adapter_to_server(const adap: TPId);
//#UC START# *460B95A600CB_460B956502AF_var*
//#UC END# *460B95A600CB_460B956502AF_var*
begin
//#UC START# *460B95A600CB_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B95A600CB_460B956502AF_impl*
end;//adapter_to_server

procedure server_to_adapter(const serv;
 var adap: TPosition); { can raise Unsupported }
//#UC START# *460BAC17029F_460B956502AF_var*
//#UC END# *460BAC17029F_460B956502AF_var*
begin
//#UC START# *460BAC17029F_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BAC17029F_460B956502AF_impl*
end;//server_to_adapter

procedure adapter_to_server(const adap: TPosition;
 var serv); { can raise Unsupported }
//#UC START# *460CCAA201E4_460B956502AF_var*
//#UC END# *460CCAA201E4_460B956502AF_var*
begin
//#UC START# *460CCAA201E4_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CCAA201E4_460B956502AF_impl*
end;//adapter_to_server

procedure server_to_adapter(const serv;
 out adap: IPositionList); { can raise Unsupported }
//#UC START# *460BADAA00EA_460B956502AF_var*
//#UC END# *460BADAA00EA_460B956502AF_var*
begin
//#UC START# *460BADAA00EA_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BADAA00EA_460B956502AF_impl*
end;//server_to_adapter

procedure adapter_to_server(const adap: IPositionList;
 var serv); { can raise Unsupported }
//#UC START# *460BAE0903B9_460B956502AF_var*
//#UC END# *460BAE0903B9_460B956502AF_var*
begin
//#UC START# *460BAE0903B9_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BAE0903B9_460B956502AF_impl*
end;//adapter_to_server

procedure server_to_adapter(const serv;
 var adap: ILanguagesList);
//#UC START# *460BB2AF01C5_460B956502AF_var*
//#UC END# *460BB2AF01C5_460B956502AF_var*
begin
//#UC START# *460BB2AF01C5_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BB2AF01C5_460B956502AF_impl*
end;//server_to_adapter

procedure category_to_query(const category: INodeBase;
 var query);
//#UC START# *460BB2E5036B_460B956502AF_var*
//#UC END# *460BB2E5036B_460B956502AF_var*
begin
//#UC START# *460BB2E5036B_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BB2E5036B_460B956502AF_impl*
end;//category_to_query

procedure convert(const adapter_from: TNodePosition;
 var srv_from);
//#UC START# *46151F7E0399_460B956502AF_var*
//#UC END# *46151F7E0399_460B956502AF_var*
begin
//#UC START# *46151F7E0399_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *46151F7E0399_460B956502AF_impl*
end;//convert

procedure adapter_to_server(const adapter_index_path: INodeIndexPath);
//#UC START# *47B6D48902FA_460B956502AF_var*
//#UC END# *47B6D48902FA_460B956502AF_var*
begin
//#UC START# *47B6D48902FA_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B6D48902FA_460B956502AF_impl*
end;//adapter_to_server

procedure server_to_adapter(const index_path;
 var adap_path: INodeIndexPath);
//#UC START# *47B6D5B502D3_460B956502AF_var*
//#UC END# *47B6D5B502D3_460B956502AF_var*
begin
//#UC START# *47B6D5B502D3_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B6D5B502D3_460B956502AF_impl*
end;//server_to_adapter

procedure adapter_to_server(adapter_status: TConsultationStatus);
//#UC START# *486B36420166_460B956502AF_var*
//#UC END# *486B36420166_460B956502AF_var*
begin
//#UC START# *486B36420166_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *486B36420166_460B956502AF_impl*
end;//adapter_to_server

function server_to_adapter(const server_status): TConsultationStatus;
//#UC START# *486B3685024C_460B956502AF_var*
//#UC END# *486B3685024C_460B956502AF_var*
begin
//#UC START# *486B3685024C_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *486B3685024C_460B956502AF_impl*
end;//server_to_adapter

function consultation_status_to_folders_flag(const server_status): Cardinal;
//#UC START# *486B4C8900FE_460B956502AF_var*
//#UC END# *486B4C8900FE_460B956502AF_var*
begin
//#UC START# *486B4C8900FE_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *486B4C8900FE_460B956502AF_impl*
end;//consultation_status_to_folders_flag

procedure adapter_to_server(adapter_order: TFindOrder);
//#UC START# *4D3EABF5008B_460B956502AF_var*
//#UC END# *4D3EABF5008B_460B956502AF_var*
begin
//#UC START# *4D3EABF5008B_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EABF5008B_460B956502AF_impl*
end;//adapter_to_server

procedure adapter_to_server(adapter_area: TSearchArea);
//#UC START# *4D3EACE502A5_460B956502AF_var*
//#UC END# *4D3EACE502A5_460B956502AF_var*
begin
//#UC START# *4D3EACE502A5_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EACE502A5_460B956502AF_impl*
end;//adapter_to_server

procedure adapter_to_server(adapter_place: TContextPlace);
//#UC START# *4D3EAD0C00A5_460B956502AF_var*
//#UC END# *4D3EAD0C00A5_460B956502AF_var*
begin
//#UC START# *4D3EAD0C00A5_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EAD0C00A5_460B956502AF_impl*
end;//adapter_to_server

procedure server_to_adapter(const serv;
 var adap: IDocPointList);
 {* Преобразование серверного списка вида Документ, Саб в адаптерный }
//#UC START# *4DCCD8970014_460B956502AF_var*
//#UC END# *4DCCD8970014_460B956502AF_var*
begin
//#UC START# *4DCCD8970014_460B956502AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DCCD8970014_460B956502AF_impl*
end;//server_to_adapter

end.
