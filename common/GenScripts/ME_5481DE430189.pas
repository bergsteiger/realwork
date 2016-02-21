unit eeSubDescriptorsExport;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeSubDescriptorsExport.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evSubPanel
 , eeInterfaces
;

type
 TeeSubDescriptors = class(TevSubDescriptors, IeeSubViewDescriptors)
  protected
   function Get_Subs: IeeSubViewDescriptor;
   function Get_Markers: IeeSubViewDescriptor;
   function Get_Bookmarks: IeeSubViewDescriptor;
 end;//TeeSubDescriptors
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3CacheableBase
 , evdTypes
;

type
 TeeSubDescriptor = class(Tl3CacheableBase, IeeSubViewDescriptor)
  private
   f_LayerID: Integer;
   f_Descriptors: TeeSubDescriptors;
  protected
   function Get_Visible: Boolean;
   procedure Set_Visible(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aDescriptors: TeeSubDescriptors;
    aLayerID: Integer); reintroduce;
   class function Make(aDescriptors: TeeSubDescriptors;
    aLayerID: Integer): IeeSubViewDescriptor; reintroduce;
 end;//TeeSubDescriptor

function TeeSubDescriptors.Get_Subs: IeeSubViewDescriptor;
//#UC START# *5481A0350122_5481DE6C03AAget_var*
//#UC END# *5481A0350122_5481DE6C03AAget_var*
begin
//#UC START# *5481A0350122_5481DE6C03AAget_impl*
 Result := TeeSubDescriptor.Make(Self, Ord(ev_sbtSub));
//#UC END# *5481A0350122_5481DE6C03AAget_impl*
end;//TeeSubDescriptors.Get_Subs

function TeeSubDescriptors.Get_Markers: IeeSubViewDescriptor;
//#UC START# *5481A03B01F9_5481DE6C03AAget_var*
//#UC END# *5481A03B01F9_5481DE6C03AAget_var*
begin
//#UC START# *5481A03B01F9_5481DE6C03AAget_impl*
 Result := TeeSubDescriptor.Make(Self, Ord(ev_sbtMarker));
//#UC END# *5481A03B01F9_5481DE6C03AAget_impl*
end;//TeeSubDescriptors.Get_Markers

function TeeSubDescriptors.Get_Bookmarks: IeeSubViewDescriptor;
//#UC START# *5481A043035B_5481DE6C03AAget_var*
//#UC END# *5481A043035B_5481DE6C03AAget_var*
begin
//#UC START# *5481A043035B_5481DE6C03AAget_impl*
 Result := TeeSubDescriptor.Make(Self, Ord(ev_sbtBookmark));
//#UC END# *5481A043035B_5481DE6C03AAget_impl*
end;//TeeSubDescriptors.Get_Bookmarks

constructor TeeSubDescriptor.Create(aDescriptors: TeeSubDescriptors;
 aLayerID: Integer);
//#UC START# *54940BE30056_5481DE6402F5_var*
//#UC END# *54940BE30056_5481DE6402F5_var*
begin
//#UC START# *54940BE30056_5481DE6402F5_impl*
 inherited Create;
 f_Descriptors := aDescriptors;
 f_LayerID := aLayerID;
//#UC END# *54940BE30056_5481DE6402F5_impl*
end;//TeeSubDescriptor.Create

class function TeeSubDescriptor.Make(aDescriptors: TeeSubDescriptors;
 aLayerID: Integer): IeeSubViewDescriptor;
var
 l_Inst : TeeSubDescriptor;
begin
 l_Inst := Create(aDescriptors, aLayerID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TeeSubDescriptor.Make

function TeeSubDescriptor.Get_Visible: Boolean;
//#UC START# *54819FF50172_5481DE6402F5get_var*
//#UC END# *54819FF50172_5481DE6402F5get_var*
begin
//#UC START# *54819FF50172_5481DE6402F5get_impl*
 Result := f_Descriptors.SubDescriptor[f_LayerID].Visible;
//#UC END# *54819FF50172_5481DE6402F5get_impl*
end;//TeeSubDescriptor.Get_Visible

procedure TeeSubDescriptor.Set_Visible(aValue: Boolean);
//#UC START# *54819FF50172_5481DE6402F5set_var*
//#UC END# *54819FF50172_5481DE6402F5set_var*
begin
//#UC START# *54819FF50172_5481DE6402F5set_impl*
 f_Descriptors.SubDescriptor[f_LayerID].Visible := aValue;
//#UC END# *54819FF50172_5481DE6402F5set_impl*
end;//TeeSubDescriptor.Set_Visible

procedure TeeSubDescriptor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5481DE6402F5_var*
//#UC END# *479731C50290_5481DE6402F5_var*
begin
//#UC START# *479731C50290_5481DE6402F5_impl*
 f_Descriptors := nil;
 f_LayerID := 0;
 inherited;
//#UC END# *479731C50290_5481DE6402F5_impl*
end;//TeeSubDescriptor.Cleanup
{$IfEnd} // Defined(Nemesis)

end.
