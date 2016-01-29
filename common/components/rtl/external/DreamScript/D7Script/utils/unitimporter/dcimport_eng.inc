sDCErrorParamNumber = 'Bad parameters count';

sDCImportMainFormCaption    = 'Import file generator';
sDCSourceFilesPanelCaption  = 'Source file(s)';
sDCPostfixLabelCaption      = 'Postfix:';

sDCImportOptionsPanelCaption      = 'Import options';
sDCDestPathLabelCaption           = 'Destination path:';
sDCLibPathLabelCaption            = 'Library path:';
sDCConditionalDefinesLabelCaption = 'Conditional defines:';
sDCAliasesLabelCaption            = 'Aliases:';
sDCDelphiLibsBtnHint              = 'Fill with VCL source path';

sDCIncludeCommentsCheckCaption   = 'Include comments into importing files';
sDCCustomImportCheckCaption      = 'Import only specified topics';
sDCImportSilentlyCheckCaption    = 'Perform registration silently';
sDCAddUnregistrationCheckCaption = 'Add unregistration of topics';

sDCImportBtnCaption = 'Process';
sDCImportHelpButton = 'Command line help';

sDCAddFilesDlgTitle = 'Select files to import';

sDCImportHelpFormCaption = 'Import file generator help';
sDCImportHelpContextLine = 19;
sDCImportHelpContext : Array[ 0 .. sDCImportHelpContextLine - 1 ] Of String =
          ( 'Import file generator',
            'Copyright (c) 1998-2000 Dream Company',
            '',
            'Run impgen.exe -h to display command line parameters',
            '',
            'Syntax: ImpGen [options] sourcefile destpath',
            '',
            'Options:',
            '     -A		Define aliases',
            '     -D<syms>	Define conditionals',
            '     -S		Recurse subdirectories',
            '     -U<paths>	Unit directories',
            '     -L		Add VCL library paths to unit directories',
            '     -X		Don''t output comments',
            '     -P<postfix>	String that will be added to original unit name',
            '     -E<filename>	Exclude from import all items listed in <filename>',
            '',
            'Example:',
            'ImpGen -UC:\D3\SOURCE\VCL;C:\D3\SOURCE\RTL\SYS -P_IMP D:\MYPROG\*.pas D:\IMP' );

sDCFileImportCaption       = 'Import file generator ';
sDCBuildingInProgress      = 'Generating import files';
sDCBuildingFinished        = 'Generation completed';
sDCBuildingFinishedByError = 'Generation was terminated due to error.';
sDCBuildingFinishedByUser  = 'Generation was terminated by user.';

sDCCollectingTopicsInfo = 'Collecting topics information ...';

sDCFileProcessed  = '%d file(s) processed.';
sDCFilesGenerated = '%d file(s) generated.';

sDCImportingUnits    = 'Importing units ...';
sDCCheckinTopics     = 'Check in valid topics ...';
sDCCollectingTopics  = 'Collecting topics ...';
sDCCollectionFrom    = 'Collecting topics from "%s".';
sDCUserCancelProcess = 'User cancelled the process.';
sDCCreateFolders     = 'Creating "%s" folder.';
sDCFilesNumber       = '%d file(s)';

sDCExcludeConfirm           = 'Do you really want to exclude ''%s'' file from importing?';
sDCImportTerminationConfirm = 'Do you really want to clear the list of files?';
sDCFolderCreateConfirmation = '"%s" folder doesn''t exist. Do you want to create it?';

sDCErrorFolderCannotBeCreated = '"%s" folder cannot be created.';

sDCImportingPosfix       = '[Importing]';
sDCImportCompletePostfix = '[Import completed]';

sDCTopicsCheckFormCaption = 'Check in import topics';
sDCSelectAllItemCaption   = '&Select all';
sDCUnselectAllItemCaption = '&Unselect all';
sDCProcCheckHeader        = 'List of available procedures:';
sDCTypeCheckHeader        = 'List of available types:';
sDCClassCheckHeader       = 'List of available classes:';
sDCVarCheckHeader         = 'List of available variables:';
sDCConstsCheckHeader      = 'List of available constants:';
sDCPropertiesCheckHeader  = 'List of available properties:';
sDCMethodsCheckHeader     = 'List of available methods:';

sDCProjectItemsCaption   = 'Project';

sDCAddUnitsActionCaption = '&Add files...';
sDCAddUnitsActionHint    = 'Add files...';
sDCAddUnitsRecursActionCaption = 'Add all units from &folder recursively';
sDCAddUnitsRecursActionHint    = 'Add all units from folder recursively';
sDCDeleteActionCaption   = '&Delete selected file';
sDCDeleteActionHint      = 'Delete selected file';
sDCClearAllActionCaption = 'Delete all &files';
sDCClearAllActionHint    = 'Delete all files';

sDCNewImportProjectName = 'New Import Project';

sDCSaveDialogTitle = 'Save ''%s'' as ...';
sDCFilterImportProject = 'Import Project';
sDCImportOpenPrjDialogTitle = 'Open import project';
sDCPathDialogTitle = 'Select a directory with files to import:';

sDCCreateFileError = 'Cannot create specified file';
sDCSaveFileError = 'Error writing project file.';
sDCOpenFileError = 'Cannot open specified file';
sDCLoadFileError = 'Error reading project file.';

sDCSaveProjectFile = 'Saving project file';
sDCLoadProjectFile = 'Loading project file';

sDCSaveWarning = 'Currently opened project was changed. Do you want to save changes?';

sDCFormListOfBadClasses    = 'Creating list of excluded classes, methods and properties';
sDCFormListOfBadProcedures = 'Creating list of excluded procedures';
sDCFormListOfBadTypes      = 'Creating list of excluded types';
sDCFormListOfBadVariables  = 'Creating list of excluded variables';
sDCFormListOfBadConstants  = 'Creating list of excluded constants';

sDCBadTopicsAreCollected = 'Information about bad topics is collected.';

sDCImportTerminateQuery = 'Do you want to cancel import process?';

