unit RedactionInfoListHelper;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\RedactionInfoListHelper.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "RedactionInfoListHelper" MUID: (462895DD0240)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DocumentUnit
;

function FindRedaction(const redaction_info_list: IRedactionInfoList;
 to_find: TRedactionID): integer; overload; stdcall;
function FindRedaction(const redaction_info_list: IRedactionInfoList;
 const to_find: TRedactionInfo): integer; overload; stdcall;
function FindActualRedaction(const redaction_info_list: IRedactionInfoList): integer; stdcall;
procedure PrevRedactions(const redaction_info_list: IRedactionInfoList;
 id: TRedactionID;
 var prev_list: IRedactionInfoList); stdcall;
procedure CurAndNextRedactions(const redaction_info_list: IRedactionInfoList;
 id: TRedactionID;
 var next_list: IRedactionInfoList); stdcall;

implementation

uses
 l3ImplUses
;

function FindRedaction(const redaction_info_list: IRedactionInfoList;
 to_find: TRedactionID): integer;
//#UC START# *462896090184_462895DD0240_var*
//#UC END# *462896090184_462895DD0240_var*
begin
//#UC START# *462896090184_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *462896090184_462895DD0240_impl*
end;//FindRedaction

function FindRedaction(const redaction_info_list: IRedactionInfoList;
 const to_find: TRedactionInfo): integer;
//#UC START# *46289660023F_462895DD0240_var*
//#UC END# *46289660023F_462895DD0240_var*
begin
//#UC START# *46289660023F_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *46289660023F_462895DD0240_impl*
end;//FindRedaction

function FindActualRedaction(const redaction_info_list: IRedactionInfoList): integer;
//#UC START# *4628969F03E4_462895DD0240_var*
//#UC END# *4628969F03E4_462895DD0240_var*
begin
//#UC START# *4628969F03E4_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *4628969F03E4_462895DD0240_impl*
end;//FindActualRedaction

procedure PrevRedactions(const redaction_info_list: IRedactionInfoList;
 id: TRedactionID;
 var prev_list: IRedactionInfoList);
//#UC START# *4A8145520247_462895DD0240_var*
//#UC END# *4A8145520247_462895DD0240_var*
begin
//#UC START# *4A8145520247_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8145520247_462895DD0240_impl*
end;//PrevRedactions

procedure CurAndNextRedactions(const redaction_info_list: IRedactionInfoList;
 id: TRedactionID;
 var next_list: IRedactionInfoList);
//#UC START# *4B556E69014E_462895DD0240_var*
//#UC END# *4B556E69014E_462895DD0240_var*
begin
//#UC START# *4B556E69014E_462895DD0240_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B556E69014E_462895DD0240_impl*
end;//CurAndNextRedactions

end.
