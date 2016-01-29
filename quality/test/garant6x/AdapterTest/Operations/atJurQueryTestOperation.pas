unit atJurQueryTestOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atJurQueryTestOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatJurQueryTestOperation
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  Classes,
  atOperationBase,
  atStringFileReader,
  SearchUnit,
  atQuery
  ;

type
 _atIterateThroughFilesAddOn_Parent_ = TatOperationBase;
 {$Include ..\Operations\atIterateThroughFilesAddOn.imp.pas}
 _atExecutesQueryAddOn_Parent_ = _atIterateThroughFilesAddOn_;
 {$Include ..\Operations\atExecutesQueryAddOn.imp.pas}
 TatJurQueryTestOperation = class(_atExecutesQueryAddOn_)
 private
 // private fields
   f_ImportErrors : TStringList;
   f_Errors : TStringList;
   f_ResultsDir : AnsiString;
   f_IsInternalNumbers : Boolean;
 protected
 // realized methods
   function OnFile(const aFileName: AnsiString): Boolean; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
   procedure ExecuteSelf; override;
 end;//TatJurQueryTestOperation

implementation

uses
  atLogger,
  atListHelper,
  SysUtils,
  XMLDoc,
  XMLIntf,
  DynamicTreeUnit,
  atListEntryInfo,
  atNodeHelper,
  atFileInitializer,
  atFileIterator,
  atSyncedStringFileReader,
  atOperationEnv,
  atSearchHelper
  ;

{$Include ..\Operations\atIterateThroughFilesAddOn.imp.pas}

{$Include ..\Operations\atExecutesQueryAddOn.imp.pas}

// start class TatJurQueryTestOperation

function TatJurQueryTestOperation.OnFile(const aFileName: AnsiString): Boolean;
//#UC START# *502A649F0204_5051E5CB00F4_var*
  var
    l_BaseFileName, l_ErrFileName, l_DescFileName, l_ResFileName : String;
    l_XML : IXMLDocument;
    l_Query : TatQuery;
    l_List : TatList;
    l_File : Text;
    l_ListNode : INodeBase;
    l_LEI : TatListEntryInfo;
    l_DocId : Longword;
    l_DocName : String;
//#UC END# *502A649F0204_5051E5CB00F4_var*
begin
//#UC START# *502A649F0204_5051E5CB00F4_impl*
  Result := true;
  //
  l_BaseFileName := f_ResultsDir + ChangeFileExt(ExtractFileName(aFileName), '');;
  l_ErrFileName := l_BaseFileName + '.errs';
  l_DescFileName := l_BaseFileName + '.desc';
  l_ResFileName := l_BaseFileName + '.csv';
  DeleteFile(l_ErrFileName);
  DeleteFile(l_DescFileName);
  DeleteFile(l_ResFileName);
  //
  f_Errors.Clear;
  try
    // ������ �������� ����
    try
      l_XML := TXMLDocument.Create(aFileName);
      l_XML.Active := true;
    except
      on ex : Exception do
      begin
        Logger.Exception(ex, '������ �������� �����: ');
        f_Errors.Append( Format('������ �������� ����� "%s" : %s', [aFileName, ex.Message]) );
        Exit;
      end;
    end;

    f_ImportErrors.Clear;
    l_Query := TatQuery.CreateFromXML(l_XML, f_ImportErrors);
    try
      if f_ImportErrors.Count > 0 then
      begin
        f_Errors.Append('��� ������� ������� ��������� �������� �� ������� � ����:');
        f_Errors.AddStrings(f_ImportErrors);
        Exit;
      end;
      //
      if ExecuteQuery(l_Query) then
        l_List := TatList.Create(ExecutionContext.UserWorkContext.CurrList)
      else
        l_List := nil;
    finally
      FreeAndNil(l_Query);
    end;

    if l_List <> nil then
    try
      // ��������� �������� ������ � ����
      AssignFile(l_File, l_DescFileName);
      try
        Rewrite(l_File);
        WriteLn(l_File, l_List.Name);
        WriteLn(l_File);
        WriteLn(l_File, l_List.History);
      finally
        CloseFile(l_File);
      end;

      // ��������� ������ � ����
      AssignFile(l_File, l_ResFileName);
      try
        Rewrite(l_File);
        // ���������� �������� ������
        l_ListNode := l_List.FirstElement;
        repeat
          l_DocName := TatNodeHelper.GetCaption(l_ListNode);
          //
          l_LEI := TatListEntryInfo.Create(l_ListNode);
          try
            l_DocId := l_LEI.PID.rObjectId;
          finally
            FreeAndNil(l_LEI);
          end;
          //
          if f_IsInternalNumbers then
            Dec(l_DocId, 100000);
          l_DocName := AnsiQuotedStr(l_DocName, '"');
          //            
          WriteLn(l_File, Format('%d;%s', [l_DocId, l_DocName]) );
          //
          l_ListNode := TatNodeHelper.GetNext(l_ListNode);
        until l_ListNode = nil;
      finally
        CloseFile(l_File);
      end;
    finally
      FreeAndNil(l_List);
    end;
  finally
    if f_Errors.Count > 0 then
      f_Errors.SaveToFile(l_ErrFileName);
  end;
//#UC END# *502A649F0204_5051E5CB00F4_impl*
end;//TatJurQueryTestOperation.OnFile

procedure TatJurQueryTestOperation.InitParamList;
//#UC START# *48089F3701B4_5051E5CB00F4_var*
//#UC END# *48089F3701B4_5051E5CB00F4_var*
begin
//#UC START# *48089F3701B4_5051E5CB00F4_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('results_dir', '����� ��� �����������') );
    Add( ParamType.Create('is_internal_numbers', '�������� � ��������� ���������� ������ ����������', 'false') );    
  end;
//#UC END# *48089F3701B4_5051E5CB00F4_impl*
end;//TatJurQueryTestOperation.InitParamList

procedure TatJurQueryTestOperation.ExecuteSelf;
//#UC START# *48089F460352_5051E5CB00F4_var*
//#UC END# *48089F460352_5051E5CB00F4_var*
begin
//#UC START# *48089F460352_5051E5CB00F4_impl*
  f_ResultsDir := IncludeTrailingPathDelimiter(Parameters['results_dir'].AsStr);
  ForceDirectories(f_ResultsDir);
  f_IsInternalNumbers := Parameters['is_internal_numbers'].AsBool;
  //
  f_Errors := TStringList.Create;
  f_ImportErrors := TStringList.Create;
  try
    inherited;
  finally
    FreeAndNil(f_Errors);
    FreeAndNil(f_ImportErrors);
  end;
//#UC END# *48089F460352_5051E5CB00F4_impl*
end;//TatJurQueryTestOperation.ExecuteSelf

end.