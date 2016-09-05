unit evdTask_Wrap;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdTask_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WevdTask" MUID: (53C3E67C0258)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2Tag_Wrap
 , l3Variant
 , k2Base
;

type
 WevdTask = class(Wk2Tag)
  protected
   function GetDescription: AnsiString; virtual;
   function GetAtomData(AE: Tl3Variant;
    aProp: Tk2CustomProperty;
    out Data: Tl3Variant): Boolean; override;
 end;//WevdTask

implementation

uses
 l3ImplUses
 , Task_Const
 , SysUtils
 , k2String
 , Math
 , k2Tags
 //#UC START# *53C3E67C0258impl_uses*
 //#UC END# *53C3E67C0258impl_uses*
;

function WevdTask.GetDescription: AnsiString;
//#UC START# *53C3E6AF0130_53C3E67C0258_var*
//#UC END# *53C3E6AF0130_53C3E67C0258_var*
begin
//#UC START# *53C3E6AF0130_53C3E67C0258_impl*
 Result := '';
//#UC END# *53C3E6AF0130_53C3E67C0258_impl*
end;//WevdTask.GetDescription

function WevdTask.GetAtomData(AE: Tl3Variant;
 aProp: Tk2CustomProperty;
 out Data: Tl3Variant): Boolean;
//#UC START# *4857A995029E_53C3E67C0258_var*
var
 l_D : String;
 l_S : Tk2String;
 l_Date : TDateTime;
 l_NeedPointer : Boolean;
//#UC END# *4857A995029E_53C3E67C0258_var*
begin
//#UC START# *4857A995029E_53C3E67C0258_impl*
 Result := inherited GetAtomData(AE, aProp, Data);
 if not Result then
 begin
  if (aProp.TagIndex = k2_attrDescription) then
  begin
   l_D := GetDescription;
  end//aProp.TagIndex = k2_ttrDescription
  else
  if (aProp.TagIndex = k2_attrTaskID) then
  begin
   l_S := Tk2String.Create;
   try
    l_Date := AE.DateTimeA[k2_attrDate];
    {$IfDef nsTest}
    l_NeedPointer := false;
    {$Else  nsTest}
    l_NeedPointer := true;
    {$EndIf nsTest}
    if IsZero(l_Date) then
    begin
     l_NeedPointer := true;
     l_Date := Now;
     if not Tk2Type(AE.TagType).Prop[k2_attrDate].ReadOnly then
      AE.DateTimeA[k2_attrDate] := l_Date;
    end;//IsZero(l_Date)
    if l_NeedPointer then
     l_S.AsString := SysUtils.Format('%d-%s (%p)', [AE.IntA[k2_attrUser], FormatDateTime('dd-mm-yyyy-hh-nn-ss-zzz', l_Date), Pointer(AE)])
    else
     l_S.AsString := SysUtils.Format('%d-%s', [AE.IntA[k2_attrUser], FormatDateTime('dd-mm-yyyy-hh-nn-ss-zzz', l_Date)]);
    AE.AttrW[aProp.TagIndex, nil] := l_S;
    Data := l_S;
    Result := true;
   finally
    FreeAndNil(l_S);
   end;//try..finally
  end//aProp.TagIndex = k2_attrDate
(*  else
  if (aProp.TagIndex = k2_attrDate) then
  begin
   AE.DateTimeW[k2_attrDate, nil] := Now;
  end*);//aProp.TagIndex = k2_attrDate
 end;//not Result
//#UC END# *4857A995029E_53C3E67C0258_impl*
end;//WevdTask.GetAtomData

end.
