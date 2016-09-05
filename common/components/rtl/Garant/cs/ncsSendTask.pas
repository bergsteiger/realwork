unit ncsSendTask;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsSendTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsSendTask" MUID: (54855C2F0088)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2SizedMemoryPool
 , k2Base
;

type
 TncsSendTask = class(TncsMessage)
  protected
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Data: Tk2RawData
    read pm_GetData
    write pm_SetData;
 end;//TncsSendTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csSendTask_Const
 //#UC START# *54855C2F0088impl_uses*
 //#UC END# *54855C2F0088impl_uses*
;

function TncsSendTask.pm_GetData: Tk2RawData;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Tk2RawData(TaggedData.cAtom(k2_attrData));
end;//TncsSendTask.pm_GetData

procedure TncsSendTask.pm_SetData(aValue: Tk2RawData);
begin
 TaggedData.AttrW[k2_attrData, nil] := (aValue);
end;//TncsSendTask.pm_SetData

class function TncsSendTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsSendTask;
end;//TncsSendTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
