package dsparser;

import java.io.*;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.List;


import joptsimple.*;

import org.antlr.runtime.*;
import org.antlr.runtime.tree.CommonTreeNodeStream;

import dsparser.antlr.generated.*;
import dsparser.tc.TCProject;
import dsparser.worker.AllUnits;




public class Main {

	
	protected static void Die(String text)
	{
		System.err.println(text);
		System.exit(1);
	}
	
	protected static class Arguments
	{
		List<File> unit_files = null;
		List<File> mds_files = null;
		File out_analysis = null;
		File out_used = null;
		int use_threshold;
	}
	
	protected final static Arguments args = new Arguments();
	
	protected final static AllUnits units = new AllUnits();
	
	// ������ ��������� ��������� ������ � ��������� ��������� ������� ������.
	protected static void ParseArgs(String[] command_line_args) throws Exception
	{
		final class FileConv implements ValueConverter<File>
		{
			@Override
			public File convert(String arg0) {
				File file = new File(arg0);
				if (!file.canRead()) {
					Die("���� " + file.getAbsolutePath() + " �� ��������!");
				}
				return file;
			}

			@Override
			public String valuePattern() {		
				return "������������ ����";
			}

			@Override
			public Class<File> valueType() {
				return File.class;
			}			
		}
			
		OptionParser parser = new OptionParser();
		OptionSpec<File> opt_mds_file =	parser.accepts("mds-file").withOptionalArg().ofType(File.class).describedAs(".mds ���� ������� TestComplete").withValuesConvertedBy(new FileConv());
		OptionSpec<File> opt_unit_files = parser.accepts("unit-file").withOptionalArg().ofType(File.class).describedAs(".sd ����� ������� TestComplete").withValuesConvertedBy(new FileConv());
		OptionSpec<File> opt_out_analysis =	parser.accepts("out-analysis").withOptionalArg().ofType(File.class).describedAs("���� �������� ���������� �������");
		OptionSpec<File> opt_out_used = parser.accepts("out-used").withOptionalArg().ofType(File.class).describedAs("���� �������� ��������� � �������������� ��������");
		OptionSpec<Integer> opt_use_threshold = parser.accepts("use-threshold").withOptionalArg().ofType(Integer.class).describedAs("�������� ���������� � ������������ ������� ��� ������ ��� ��������").defaultsTo(0); 
		OptionSpec<Void> opt_need_help = parser.accepts("?", "������ ������� � ������������ ����������");
		
		OptionSet options = null;
		try {
			options = parser.parse(command_line_args);
		} catch(OptionException ex) {
			System.err.println(ex.getMessage());
			parser.printHelpOn(System.out);
			Die("�������� ������������ ��������� ��������� ������.");
		}
		
		if (options.has(opt_need_help))	{
			parser.printHelpOn(System.out);
			System.exit(1);
		}
		
		args.mds_files = options.valuesOf(opt_mds_file);
		args.unit_files = options.valuesOf(opt_unit_files);
							
		if ((args.unit_files.isEmpty()) && (args.mds_files.isEmpty())) {
			Die("����� ������� ���� ���-�� (mds_file ��� unit_file)");			
		}
			
		args.out_analysis = options.valueOf(opt_out_analysis);
		args.out_used = options.valueOf(opt_out_used);
		args.use_threshold = options.valueOf(opt_use_threshold);
	}
	
	protected final static void InitUnits() throws Exception
	{
		// �������� ������ �� ������� ������������. ����� ��������� ��������� ��������, ��� ��������.
		for (File file : args.mds_files) {
			TCProject tcProject = new TCProject(file);
			Collection<File> files = tcProject.GetUnitFiles();
			for (File f : files)
				if (f.getName().matches("(?i).*\\.sd$")) // ��������� ������ .sd �����
					units.AddFromFile(f);
		}
		
		// ���� ���������� ������
		for (File file : args.unit_files)
			units.AddFromFile(file);
	}
	
	// ������ ������ (�������������� ������ � ���������� ���).
	protected final static void ParseUnits() throws Exception
	{
		for (AllUnits.Unit u : units.Units())
		{			
			System.out.format("������ ������ %s �� ����� \"%s\"\r\n", u.name, u.file_name);
			long elapsed_time = -System.nanoTime();
			
			DelphiScriptLexer lexer = new DelphiScriptLexer( new ANTLRFileStream(u.file_name, "UTF8") );
			CommonTokenStream tokens = new CommonTokenStream(lexer);			
			
			DelphiScriptParser parser = new DelphiScriptParser(tokens);
			DelphiScriptParser.goal_return goal_ret;
			try {
				goal_ret = parser.goal();
				elapsed_time += System.nanoTime();
			} catch (RecognitionException ex) {
				ex.printStackTrace();
				return;
			}			
			u.ast = new CommonTreeNodeStream( goal_ret.getTree() );
			u.ast.setTokenStream(tokens);
						
			System.out.format("���������� ������ �� %d ��\r\n", elapsed_time/1000000);
		}
	}
	
	// ������ ���. �������� �������� ������.
	protected final static void AnalyzeAST() throws Exception
	{
		// ������� AST
		Class<?> parsers[] = new Class<?>[]{
				TDelphiScript1.class,	// ������������ ���������� ��������
				TDelphiScript2.class,	// ������������ ���������� ������� � ����������
				TDelphiScript3.class	// ������������ ����������� �������
			};
		
		int i = 0;
		// �� ������� ������ �������� ������������ ��� AST �������
		for (Class<?> parser : parsers)
		{
			Constructor<?> parser_ctr = parser.getConstructor(new Class[]{AllUnits.Unit.class});
			Method tGoal = parser.getMethod("tGoal");
			i++;
			// ������ ast ������ ������������ ������� ��������
			for (AllUnits.Unit u : units.Units())
			{
				System.out.format("%d-� ������ �� ������ %s\r\n", i, u.name);
				long elapsed_time = -System.nanoTime();
				
				u.ast.reset();					
				try {
					// ������� ��������� ������� ��������� � ����������� u � �������� �� ��� ����� tGoal()
					tGoal.invoke( parser_ctr.newInstance(new Object[]{u}) );
					elapsed_time += System.nanoTime();
				} catch (InvocationTargetException x) {
					x.getCause().printStackTrace();
					Die("���������� �� ����� �������� ���.");
				}

				System.out.format("��������� �� %d ��\r\n", elapsed_time/1000000);	
			}
		}
	}
	
	// ����� ����������.
	protected final static void EmitResult() throws Exception
	{
		// ������� ���������� ������� ������������ ������������ ���������������.
		PrintStream out_analysis;
		if (args.out_analysis != null)
			out_analysis = new PrintStream(args.out_analysis);
		else
			out_analysis = System.err;
		
		for (AllUnits.Unit u : units.Units())
		{
			List<String> msgs = u.context.GetAnalysisMessages();
			for (String msg : msgs) 
				out_analysis.println(msg);
		}
		//if (out_analysis != System.err)
		//	out_analysis.close();
		

		// ������� ���������� � ���������������� ���������������.
		PrintStream out_unused;
		if (args.out_used != null)
			out_unused = new PrintStream(args.out_used);
		else
			out_unused = System.err;
		
		for (AllUnits.Unit u : units.Units())
		{
			List<String> msgs = u.context.GetUsedSymbolsMessages(args.use_threshold);
			for (String msg : msgs) 
				out_unused.println(msg);
		}
		//if (out_unused != System.err)
		//	out_unused.close();
	}
	
	
	public static void main(String[] args) {
		
		try {
			ParseArgs(args);
			InitUnits();
			ParseUnits();
			AnalyzeAST();
			EmitResult();
		} catch(Exception ex) {
			ex.printStackTrace();
			Die("��������� ����������!");
		}
	}

}

