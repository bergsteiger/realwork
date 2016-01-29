unit l3UnknownPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3UnknownPrim_ = class(_l3CheckStamp_)
  {* �����-������� ����������� ������� ������ � �����������. }
  procedure ClearFields;
  procedure BeforeClearFields;
  procedure AfterDestroyCalled;
  procedure AfterFree;
   {* �������, ���������� ����� ������� ���������� �������� ������ �� ������, �� ����������� � ����������� ������� }
  procedure InitAfterAlloc;
  function AllocInstanceMem: TObject;
  procedure FreeInstanceMem;
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; overload;
  procedure BeforeAddToCache;
   {* �������, ���������� ����� ����������� ������� � ��� ���������� �������������. }
  procedure InitFields;
  function IsCacheable: Boolean;
   {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
  procedure BeforeFree;
   {* �������, ���������� ��� ������ ���������� �������� ������ �� 1. ������ false ����� ��������� ����������� �������. }
  function CheckUnfreedResource(aPtrToResource: Pointer): Boolean;
   {* �������� �� ������ �� ���� ������� ��������� �� ������������� ��������.
              ���������� ��������� �� �� ���������� ��������� }
  function NeedCleanupFields: Boolean;
  function __AddRef: Integer; stdcall;
   {* ����������� ������� ������. }
  function __Release: Integer; stdcall;
   {* ��������� ������� ������. }
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; overload; stdcall;
   {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
 end;//_l3UnknownPrim_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
