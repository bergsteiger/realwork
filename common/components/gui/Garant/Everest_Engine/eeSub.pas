unit eeSub;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeSub.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeDocumentTool
 , eeInterfaces
 , eeInterfacesEx
 , evdTypes
 , l3Interfaces
;

type
 TeeSub = class(TeeDocumentTool, IeeSub)
  private
   f_ID: Integer;
   f_LayerID: Integer;
   f_Flag: Integer;
  protected
   function Delete: Boolean;
   function Exists: Boolean;
   function Select: Boolean;
   function IsSame(const aSub: IeeSub): Boolean;
   function Get_SubPlace: TevSubPlace;
   function Get_ID: Integer;
   function Get_LayerID: Integer;
   function Get_Flag: Integer;
   function Get_Flags: Integer;
   function Get_Name: Tl3WString;
   procedure Set_Name(const aValue: Tl3WString);
   function Get_Next: IeeSub;
   function Get_LeafPara: IeeLeafPara;
   function Get_Para: IeePara;
  public
   constructor Create(const aDocument: IeeDocumentEx;
    anID: Integer;
    aLayerID: Integer;
    aFlag: Integer); reintroduce;
   class function Make(const aDocument: IeeDocumentEx;
    anID: Integer;
    aLayerID: Integer;
    aFlag: Integer): IeeSub; reintroduce;
 end;//TeeSub
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , l3String
 , eePara
 , nevTools
;

constructor TeeSub.Create(const aDocument: IeeDocumentEx;
 anID: Integer;
 aLayerID: Integer;
 aFlag: Integer);
//#UC START# *5487199800AD_54817DA2016E_var*
//#UC END# *5487199800AD_54817DA2016E_var*
begin
//#UC START# *5487199800AD_54817DA2016E_impl*
 inherited Create(aDocument);
 f_ID := anID;
 f_LayerID := aLayerID;
 f_Flag := aFlag;
//#UC END# *5487199800AD_54817DA2016E_impl*
end;//TeeSub.Create

class function TeeSub.Make(const aDocument: IeeDocumentEx;
 anID: Integer;
 aLayerID: Integer;
 aFlag: Integer): IeeSub;
var
 l_Inst : TeeSub;
begin
 l_Inst := Create(aDocument, anID, aLayerID, aFlag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TeeSub.Make

function TeeSub.Delete: Boolean;
//#UC START# *548188CE0291_54817DA2016E_var*
var
 l_Sub: IevSub;
//#UC END# *548188CE0291_54817DA2016E_var*
begin
//#UC START# *548188CE0291_54817DA2016E_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID];
 if (l_Sub = nil) then
  Result := False
 else
  Result := l_Sub.Delete(nil);
//#UC END# *548188CE0291_54817DA2016E_impl*
end;//TeeSub.Delete

function TeeSub.Exists: Boolean;
//#UC START# *548188E50006_54817DA2016E_var*
var
 l_Sub: IevSub;
//#UC END# *548188E50006_54817DA2016E_var*
begin
//#UC START# *548188E50006_54817DA2016E_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID];
 Result := (l_Sub <> nil) and l_Sub.Exists;
//#UC END# *548188E50006_54817DA2016E_impl*
end;//TeeSub.Exists

function TeeSub.Select: Boolean;
//#UC START# *548188FC0305_54817DA2016E_var*
//#UC END# *548188FC0305_54817DA2016E_var*
begin
//#UC START# *548188FC0305_54817DA2016E_impl*
 Result := Exists;
 if Result then
  with Document do
   SubEx[f_ID, f_LayerID].Select(Selection);
//#UC END# *548188FC0305_54817DA2016E_impl*
end;//TeeSub.Select

function TeeSub.IsSame(const aSub: IeeSub): Boolean;
//#UC START# *5481891302A1_54817DA2016E_var*
//#UC END# *5481891302A1_54817DA2016E_var*
begin
//#UC START# *5481891302A1_54817DA2016E_impl*
 Result := l3IEQ(Self, aSub) or
           ((aSub <> nil) and
            (Get_ID = aSub.ID) and
            (Get_LayerID = aSub.LayerID) and
            (Get_Flag = aSub.Flag));
//#UC END# *5481891302A1_54817DA2016E_impl*
end;//TeeSub.IsSame

function TeeSub.Get_SubPlace: TevSubPlace;
//#UC START# *548189A0022F_54817DA2016Eget_var*
var
 l_Sub: IevSub;
//#UC END# *548189A0022F_54817DA2016Eget_var*
begin
//#UC START# *548189A0022F_54817DA2016Eget_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID];
 if (l_Sub = nil) then
  Result := ev_spNoWhere
 else
  Result := l_Sub.SubPlace;
//#UC END# *548189A0022F_54817DA2016Eget_impl*
end;//TeeSub.Get_SubPlace

function TeeSub.Get_ID: Integer;
//#UC START# *548189BC01DF_54817DA2016Eget_var*
//#UC END# *548189BC01DF_54817DA2016Eget_var*
begin
//#UC START# *548189BC01DF_54817DA2016Eget_impl*
 Result := f_ID;
//#UC END# *548189BC01DF_54817DA2016Eget_impl*
end;//TeeSub.Get_ID

function TeeSub.Get_LayerID: Integer;
//#UC START# *548189D0014C_54817DA2016Eget_var*
//#UC END# *548189D0014C_54817DA2016Eget_var*
begin
//#UC START# *548189D0014C_54817DA2016Eget_impl*
 Result := f_LayerID;
//#UC END# *548189D0014C_54817DA2016Eget_impl*
end;//TeeSub.Get_LayerID

function TeeSub.Get_Flag: Integer;
//#UC START# *548189EE0355_54817DA2016Eget_var*
//#UC END# *548189EE0355_54817DA2016Eget_var*
begin
//#UC START# *548189EE0355_54817DA2016Eget_impl*
 Result := f_Flag;
//#UC END# *548189EE0355_54817DA2016Eget_impl*
end;//TeeSub.Get_Flag

function TeeSub.Get_Flags: Integer;
//#UC START# *548189F9001A_54817DA2016Eget_var*
var
 l_Sub: IevSub;
//#UC END# *548189F9001A_54817DA2016Eget_var*
begin
//#UC START# *548189F9001A_54817DA2016Eget_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID];
 if (l_Sub = nil) then
  Result := 0
 else
  Result := l_Sub.Flags;
//#UC END# *548189F9001A_54817DA2016Eget_impl*
end;//TeeSub.Get_Flags

function TeeSub.Get_Name: Tl3WString;
//#UC START# *54818A59008A_54817DA2016Eget_var*
var
 l_Sub: IevSub;
//#UC END# *54818A59008A_54817DA2016Eget_var*
begin
//#UC START# *54818A59008A_54817DA2016Eget_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID];
 if (l_Sub = nil) then
  l3AssignNil(Result)
 else
  Result := l_Sub.Name;
//#UC END# *54818A59008A_54817DA2016Eget_impl*
end;//TeeSub.Get_Name

procedure TeeSub.Set_Name(const aValue: Tl3WString);
//#UC START# *54818A59008A_54817DA2016Eset_var*
var
 l_Sub: IevSub;
//#UC END# *54818A59008A_54817DA2016Eset_var*
begin
//#UC START# *54818A59008A_54817DA2016Eset_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID];
 if (l_Sub <> nil) then
  l_Sub.Name := aValue;
//#UC END# *54818A59008A_54817DA2016Eset_impl*
end;//TeeSub.Set_Name

function TeeSub.Get_Next: IeeSub;
//#UC START# *54818A7B0210_54817DA2016Eget_var*
var
 l_Sub: IevSub;
//#UC END# *54818A7B0210_54817DA2016Eget_var*
begin
//#UC START# *54818A7B0210_54817DA2016Eget_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID].Next;
 if (l_Sub = nil) then
  Result := nil
 else
  Result := Make(Document, l_Sub.ID, l_Sub.LayerID, 0);
//#UC END# *54818A7B0210_54817DA2016Eget_impl*
end;//TeeSub.Get_Next

function TeeSub.Get_LeafPara: IeeLeafPara;
//#UC START# *54818A9700C3_54817DA2016Eget_var*
var
 l_Sub: IevSub;
//#UC END# *54818A9700C3_54817DA2016Eget_var*
begin
//#UC START# *54818A9700C3_54817DA2016Eget_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID];
 if (l_Sub <> nil) and l_Sub.Exists then
  Result := TeePara.Make(l_Sub.LeafPara, Document) as IeeLeafPara
 else
  Result := nil;
//#UC END# *54818A9700C3_54817DA2016Eget_impl*
end;//TeeSub.Get_LeafPara

function TeeSub.Get_Para: IeePara;
//#UC START# *54818AA901FF_54817DA2016Eget_var*
var
 l_Sub: IevSub;
//#UC END# *54818AA901FF_54817DA2016Eget_var*
begin
//#UC START# *54818AA901FF_54817DA2016Eget_impl*
 l_Sub := Document.SubEx[f_ID, f_LayerID];
 if (l_Sub <> nil) and l_Sub.Exists then
  Result := TeePara.Make(l_Sub.Para, Document)
 else
  Result := nil;
//#UC END# *54818AA901FF_54817DA2016Eget_impl*
end;//TeeSub.Get_Para
{$IfEnd} // Defined(Nemesis)

end.
