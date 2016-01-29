unit NOT_FINISHED_DT_DbInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/NOT_FINISHED_DT_DbInfo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DT::DbInfo::DT_DbInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  dtFamilyInfoList
  ;

type
 TDbInfo = class(Tl3ProtoObject)
 private
 // private fields
   f_FamiliesData : TdtFamilyInfoList;
 end;//TDbInfo
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.