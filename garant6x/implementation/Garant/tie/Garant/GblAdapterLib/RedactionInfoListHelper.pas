unit RedactionInfoListHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/RedactionInfoListHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::DocumentHelper::RedactionInfoListHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DocumentUnit
  ;

function FindRedaction(const redaction_info_list: IRedactionInfoList;
  to_find: TRedactionID): integer; overload; 
function FindRedaction(const redaction_info_list: IRedactionInfoList;
  const to_find: TRedactionInfo): integer; overload; 
function FindActualRedaction(const redaction_info_list: IRedactionInfoList): integer;
procedure PrevRedactions(const redaction_info_list: IRedactionInfoList;
  id: TRedactionID;
  var prev_list: IRedactionInfoList);
procedure CurAndNextRedactions(const redaction_info_list: IRedactionInfoList;
  id: TRedactionID;
  var next_list: IRedactionInfoList);

implementation

// unit methods

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