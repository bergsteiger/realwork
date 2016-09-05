unit ncsGetFilePartReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetFilePartReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetFilePartReply" MUID: (547583540319)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsGetFilePartReply = class(TncsReply)
  protected
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
 end;//TncsGetFilePartReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetFilePartReply_Const
 //#UC START# *547583540319impl_uses*
 //#UC END# *547583540319impl_uses*
;

function TncsGetFilePartReply.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TncsGetFilePartReply.pm_GetIsSuccess

procedure TncsGetFilePartReply.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TncsGetFilePartReply.pm_SetIsSuccess

class function TncsGetFilePartReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsGetFilePartReply;
end;//TncsGetFilePartReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
