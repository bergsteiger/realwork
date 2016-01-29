{$IfNDef evTreeData_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestCommon"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/EverestCommon/evTreeData.imp.pas"
// �����: 17.10.2008 17:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::EverestCommon::DataObjects::evTreeData
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evTreeData_imp}
 RDataClass = class of _DataClass_;

 {$Include ..\EverestCommon\ddTreeDataObject.imp.pas}
 _evTreeData_ = {abstract mixin} class(_ddTreeDataObject_)
 private
 // private fields
   f_ExtData : IDataObject;
   f_Ext : Boolean;
    {* ���� ��� �������� Ext}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   function DoGetData(const aFormatEtcIn: TFormatEtc;
    var medium: Tl3StoragePlace): HResult; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* ���������� ������� ���������� }
 public
 // overridden public methods
   function AcceptableTymed: Integer; override;
 protected
 // protected methods
   function ExtData: IDataObject;
   function MakeExtData: IDataObject; virtual;
   function ExtDataClass: RDataClass; virtual;
 public
 // public methods
   constructor Create(const aData: _DataType_;
     const aBitmap: Il3Bitmap); reintroduce;
   class function Make(const aData: _DataType_;
     const aBitmap: Il3Bitmap): IDataObject; reintroduce;
     {* ��������� ������� evTreeData.Make }
 protected
 // protected properties
   property Ext: Boolean
     read f_Ext;
 end;//_evTreeData_

{$Else evTreeData_imp}

{$Include ..\EverestCommon\ddTreeDataObject.imp.pas}

// start class _evTreeData_

constructor _evTreeData_.Create(const aData: _DataType_;
  const aBitmap: Il3Bitmap);
//#UC START# *4CDD4D9D0014_48F895480266_var*
//#UC END# *4CDD4D9D0014_48F895480266_var*
begin
//#UC START# *4CDD4D9D0014_48F895480266_impl*
 f_Ext := Supports(aData, _DataType_);
 inherited Create(aData, aBitmap);
//#UC END# *4CDD4D9D0014_48F895480266_impl*
end;//_evTreeData_.Create

class function _evTreeData_.Make(const aData: _DataType_;
  const aBitmap: Il3Bitmap): IDataObject;
var
 l_Inst : _evTreeData_;
begin
 l_Inst := Create(aData, aBitmap);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function _evTreeData_.ExtData: IDataObject;
//#UC START# *48F896070020_48F895480266_var*
//#UC END# *48F896070020_48F895480266_var*
begin
//#UC START# *48F896070020_48F895480266_impl*
 if (f_ExtData = nil) then
  f_ExtData := MakeExtData;
 Result := f_ExtData;
//#UC END# *48F896070020_48F895480266_impl*
end;//_evTreeData_.ExtData

function _evTreeData_.MakeExtData: IDataObject;
//#UC START# *48F89615037B_48F895480266_var*
var
 l_Node : _DataType_;
//#UC END# *48F89615037B_48F895480266_var*
begin
//#UC START# *48F89615037B_48F895480266_impl*
 if Supports(Data, _DataType_, l_Node) then
  try
   Result := ExtDataClass.Make(l_Node);
  finally
   l_Node := nil;
  end//try..finally
 else
 begin
  Result := nil;
  Assert(false);
 end;//if Supports(Data, InevSimpleNode, l_Node) then
//#UC END# *48F89615037B_48F895480266_impl*
end;//_evTreeData_.MakeExtData

function _evTreeData_.ExtDataClass: RDataClass;
//#UC START# *48F8D47302FD_48F895480266_var*
//#UC END# *48F8D47302FD_48F895480266_var*
begin
//#UC START# *48F8D47302FD_48F895480266_impl*
 Result := _DataClass_;
//#UC END# *48F8D47302FD_48F895480266_impl*
end;//_evTreeData_.ExtDataClass

procedure _evTreeData_.Cleanup;
//#UC START# *479731C50290_48F895480266_var*
//#UC END# *479731C50290_48F895480266_var*
begin
//#UC START# *479731C50290_48F895480266_impl*
 inherited;
 f_ExtData := nil;
//#UC END# *479731C50290_48F895480266_impl*
end;//_evTreeData_.Cleanup

function _evTreeData_.DoGetData(const aFormatEtcIn: TFormatEtc;
  var medium: Tl3StoragePlace): HResult;
//#UC START# *48F3495D0398_48F895480266_var*
var
 l_E : IDataObject;
//#UC END# *48F3495D0398_48F895480266_var*
begin
//#UC START# *48F3495D0398_48F895480266_impl*
 if f_Ext then
 begin
  l_E := ExtData;
  if (l_E <> nil) then
  begin
   Result := l_E.GetData(aFormatEtcIn, medium);
   if l3IOk(Result) then
    Exit;
  end;//l_E <> nil
 end;//f_Ext
 Result := inherited DoGetData(aFormatEtcIn, medium);
//#UC END# *48F3495D0398_48F895480266_impl*
end;//_evTreeData_.DoGetData

function _evTreeData_.AcceptableTymed: Integer;
//#UC START# *48F351BE0015_48F895480266_var*
//#UC END# *48F351BE0015_48F895480266_var*
begin
//#UC START# *48F351BE0015_48F895480266_impl*
 Result := inherited AcceptableTymed;
 if f_Ext then
  Result := Result or TYMED_ISTREAM;
//#UC END# *48F351BE0015_48F895480266_impl*
end;//_evTreeData_.AcceptableTymed

function _evTreeData_.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_48F895480266_var*
//#UC END# *4A60B23E00C3_48F895480266_var*
begin
//#UC START# *4A60B23E00C3_48F895480266_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if f_Ext then
  if Result.Fail then
   if IID.EQ(Il3DataObjectInfo) then
    if Supports(ExtData, Il3DataObjectInfo, Obj) then
     Result.SetOk;
//#UC END# *4A60B23E00C3_48F895480266_impl*
end;//_evTreeData_.COMQueryInterface

{$EndIf evTreeData_imp}
