unit evBitmapEliminator4Tests;

// Модуль: "w:\common\components\gui\Garant\Everest\evBitmapEliminator4Tests.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevBitmapEliminator4Tests = class(Tk2TagFilter)
  protected
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevBitmapEliminator4Tests

implementation

uses
 l3ImplUses
 , k2Tags
 , BitmapPara_Const
 , Classes
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 , l3Stream
 , l3Types
 , ddPicturePathListner
 , SysUtils
;

procedure TevBitmapEliminator4Tests.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_53731FC4015A_var*
var
 l_Stream : TStream;

 function lp_CheckFormat: Integer;
 var
  l_Pos: Integer;
 begin
  Result := 0;
  l_Pos := l_Stream.Position;
 try
  l_Stream.Seek(0, soBeginning);
  Result := FindStreamFormat(l_Stream);
 finally
  l_Stream.Seek(l_Pos, soBeginning);
  // - восстанавливем указатель ОСНОВНОГО потока
 end;//try..finally
 end;

var
 l_Pos      : Integer;
 l_Format   : Integer;
 l_FileName : AnsiString;
 l_OutStream: Tl3NamedFileStream;
//#UC END# *4836D52400D9_53731FC4015A_var*
begin
//#UC START# *4836D52400D9_53731FC4015A_impl*
 if CurrentType.IsKindOf(k2_typBitmapPara) and (AtomIndex = k2_tiData) then
 begin
  l_Stream := Value.AsStream;
  l_Format := lp_CheckFormat;
  l_FileName := TddPicturePathListner.Instance.GetUniqPictureNameWithPath(l_Format, False);
  l_OutStream := Tl3NamedFileStream.Create(l_FileName, l3_fmWrite);
  try
   l_Pos := l_Stream.Position;
   try
    l_Stream.Seek(0, soBeginning);
    l3CopyStream(l_Stream, l_OutStream);
   finally
    l_Stream.Seek(l_Pos, soBeginning);
    // - восстанавливем указатель ОСНОВНОГО потока
   end;
  finally
   FreeAndNil(l_OutStream);
   TddPicturePathListner.Instance.AddPicturePath(l_FileName);
  end;
 end // if AtomIndex = k2_tiData then
 else
  inherited;
//#UC END# *4836D52400D9_53731FC4015A_impl*
end;//TevBitmapEliminator4Tests.AddAtomEx

end.
