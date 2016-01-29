unit ddTaskRecord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddTaskRecord.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ArchiClientServer::TddTaskRecord
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  ddServerTask,
  csTaskTypes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddTaskRecord = class(Tl3ProtoObject)
 public
 // public fields
   TaskType : TcsTaskType;
   TaskClass : TddTaskClass;
   Description : AnsiString;
 end;//TddTaskRecord
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}


{$IfEnd} //not Nemesis
end.