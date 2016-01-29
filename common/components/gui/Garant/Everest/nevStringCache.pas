unit nevStringCache;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/nevStringCache.pas"
// �����: 15.09.2011 17:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StringCache::TnevStringCache
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevBase,
  l3CProtoObject,
  l3CustomString
  ;

type
 _nevStringCache_Parent_ = Tl3CProtoObject;
 {$Include ..\Everest\nevStringCache.imp.pas}
 TnevStringCache = class(_nevStringCache_, InevStringCache)
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: InevStringCache; reintroduce;
     {* ��������� ������� TnevStringCache.Make }
 end;//TnevStringCache

implementation

uses
  evParaString,
  SysUtils
  ;

{$Include ..\Everest\nevStringCache.imp.pas}

// start class TnevStringCache

constructor TnevStringCache.Create;
//#UC START# *4E71FCAE00EE_4E71FC4D02BF_var*
//#UC END# *4E71FCAE00EE_4E71FC4D02BF_var*
begin
//#UC START# *4E71FCAE00EE_4E71FC4D02BF_impl*
 inherited Create;
//#UC END# *4E71FCAE00EE_4E71FC4D02BF_impl*
end;//TnevStringCache.Create

class function TnevStringCache.Make: InevStringCache;
var
 l_Inst : TnevStringCache;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

end.