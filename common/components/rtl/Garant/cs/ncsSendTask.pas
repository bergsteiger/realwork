unit ncsSendTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsSendTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::TaskSend::TncsSendTask
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
  k2SizedMemoryPool,
  ncsMessage,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsSendTask = class(TncsMessage)
 protected
 // property methods
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property Data: Tk2RawData
     read pm_GetData
     write pm_SetData;
 end;//TncsSendTask
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csSendTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsSendTask

function TncsSendTask.pm_GetData: Tk2RawData;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Tk2RawData(TaggedData.cAtom(k2_attrData));
end;//TncsSendTask.pm_GetData

procedure TncsSendTask.pm_SetData(aValue: Tk2RawData);
 {-}
begin
 TaggedData.AttrW[k2_attrData, nil] := (aValue);
end;//TncsSendTask.pm_SetData

class function TncsSendTask.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsSendTask;
end;//TncsSendTask.GetTaggedDataType

{$IfEnd} //not Nemesis

end.