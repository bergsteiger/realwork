unit RedactionInfoListHelper;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\RedactionInfoListHelper.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DocumentUnit
;

function find_redaction(const redaction_info_list: IRedactionInfoList;
 to_find: TRedactionID): integer; overload;
function find_redaction(const redaction_info_list: IRedactionInfoList;
 const to_find: TRedactionInfo): integer; overload;
function find_actual_redaction(const redaction_info_list: IRedactionInfoList): integer;
procedure prev_redactions(const redaction_info_list: IRedactionInfoList;
 id: TRedactionID;
 var prev_list: IRedactionInfoList);
procedure cur_and_next_redactions(const redaction_info_list: IRedactionInfoList;
 id: TRedactionID;
 var next_list: IRedactionInfoList);

implementation

uses
 l3ImplUses
;

function find_redaction(const redaction_info_list: IRedactionInfoList;
 to_find: TRedactionID): integer;
//#UC START# *462896090184_462895DD0240_var*
//#UC END# *462896090184_462895DD0240_var*
begin
//#UC START# *462896090184_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *462896090184_462895DD0240_impl*
end;//find_redaction

function find_redaction(const redaction_info_list: IRedactionInfoList;
 const to_find: TRedactionInfo): integer;
//#UC START# *46289660023F_462895DD0240_var*
//#UC END# *46289660023F_462895DD0240_var*
begin
//#UC START# *46289660023F_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *46289660023F_462895DD0240_impl*
end;//find_redaction

function find_actual_redaction(const redaction_info_list: IRedactionInfoList): integer;
//#UC START# *4628969F03E4_462895DD0240_var*
//#UC END# *4628969F03E4_462895DD0240_var*
begin
//#UC START# *4628969F03E4_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *4628969F03E4_462895DD0240_impl*
end;//find_actual_redaction

procedure prev_redactions(const redaction_info_list: IRedactionInfoList;
 id: TRedactionID;
 var prev_list: IRedactionInfoList);
//#UC START# *4A8145520247_462895DD0240_var*
//#UC END# *4A8145520247_462895DD0240_var*
begin
//#UC START# *4A8145520247_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8145520247_462895DD0240_impl*
end;//prev_redactions

procedure cur_and_next_redactions(const redaction_info_list: IRedactionInfoList;
 id: TRedactionID;
 var next_list: IRedactionInfoList);
//#UC START# *4B556E69014E_462895DD0240_var*
//#UC END# *4B556E69014E_462895DD0240_var*
begin
//#UC START# *4B556E69014E_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B556E69014E_462895DD0240_impl*
end;//cur_and_next_redactions

end.
