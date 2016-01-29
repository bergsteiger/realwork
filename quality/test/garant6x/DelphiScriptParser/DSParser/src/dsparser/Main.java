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
	
	// Парсит аргументы командной строки и заполняет структуру входных данных.
	protected static void ParseArgs(String[] command_line_args) throws Exception
	{
		final class FileConv implements ValueConverter<File>
		{
			@Override
			public File convert(String arg0) {
				File file = new File(arg0);
				if (!file.canRead()) {
					Die("Файл " + file.getAbsolutePath() + " не доступен!");
				}
				return file;
			}

			@Override
			public String valuePattern() {		
				return "существующий файл";
			}

			@Override
			public Class<File> valueType() {
				return File.class;
			}			
		}
			
		OptionParser parser = new OptionParser();
		OptionSpec<File> opt_mds_file =	parser.accepts("mds-file").withOptionalArg().ofType(File.class).describedAs(".mds файл проекта TestComplete").withValuesConvertedBy(new FileConv());
		OptionSpec<File> opt_unit_files = parser.accepts("unit-file").withOptionalArg().ofType(File.class).describedAs(".sd файлы модулей TestComplete").withValuesConvertedBy(new FileConv());
		OptionSpec<File> opt_out_analysis =	parser.accepts("out-analysis").withOptionalArg().ofType(File.class).describedAs("куда выводить результаты анализа");
		OptionSpec<File> opt_out_used = parser.accepts("out-used").withOptionalArg().ofType(File.class).describedAs("куда выводить сообщения о используемости символов");
		OptionSpec<Integer> opt_use_threshold = parser.accepts("use-threshold").withOptionalArg().ofType(Integer.class).describedAs("выводить информацию о используемых столько или меньше раз символах").defaultsTo(0); 
		OptionSpec<Void> opt_need_help = parser.accepts("?", "выдать справку о используемых параметрах");
		
		OptionSet options = null;
		try {
			options = parser.parse(command_line_args);
		} catch(OptionException ex) {
			System.err.println(ex.getMessage());
			parser.printHelpOn(System.out);
			Die("Переданы неправильные параметры командной строки.");
		}
		
		if (options.has(opt_need_help))	{
			parser.printHelpOn(System.out);
			System.exit(1);
		}
		
		args.mds_files = options.valuesOf(opt_mds_file);
		args.unit_files = options.valuesOf(opt_unit_files);
							
		if ((args.unit_files.isEmpty()) && (args.mds_files.isEmpty())) {
			Die("Нужно указать хоть что-то (mds_file или unit_file)");			
		}
			
		args.out_analysis = options.valueOf(opt_out_analysis);
		args.out_used = options.valueOf(opt_out_used);
		args.use_threshold = options.valueOf(opt_use_threshold);
	}
	
	protected final static void InitUnits() throws Exception
	{
		// Получаем модули из проекта тесткомплита. Можем открывать несколько проектов, для простоты.
		for (File file : args.mds_files) {
			TCProject tcProject = new TCProject(file);
			Collection<File> files = tcProject.GetUnitFiles();
			for (File f : files)
				if (f.getName().matches("(?i).*\\.sd$")) // Добавляем только .sd файлы
					units.AddFromFile(f);
		}
		
		// Явно переданные модули
		for (File file : args.unit_files)
			units.AddFromFile(file);
	}
	
	// Парсит модули (синтаксический разбор и построение АСД).
	protected final static void ParseUnits() throws Exception
	{
		for (AllUnits.Unit u : units.Units())
		{			
			System.out.format("Парсим модуль %s из файла \"%s\"\r\n", u.name, u.file_name);
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
						
			System.out.format("Пропарсили модуль за %d мс\r\n", elapsed_time/1000000);
		}
	}
	
	// Анализ АСД. Основная полезная работа.
	protected final static void AnalyzeAST() throws Exception
	{
		// парсеры AST
		Class<?> parsers[] = new Class<?>[]{
				TDelphiScript1.class,	// обрабатывает объявления констант
				TDelphiScript2.class,	// обрабатывает объявления методов и переменных
				TDelphiScript3.class	// обрабатывает определения методов
			};
		
		int i = 0;
		// по порядку каждым парсером обрабатываем все AST модулей
		for (Class<?> parser : parsers)
		{
			Constructor<?> parser_ctr = parser.getConstructor(new Class[]{AllUnits.Unit.class});
			Method tGoal = parser.getMethod("tGoal");
			i++;
			// каждое ast модуля обрабатываем текущим парсером
			for (AllUnits.Unit u : units.Units())
			{
				System.out.format("%d-й проход по модулю %s\r\n", i, u.name);
				long elapsed_time = -System.nanoTime();
				
				u.ast.reset();					
				try {
					// создаем экземпляр парсера передавая в конструктор u и вызываем на нем метод tGoal()
					tGoal.invoke( parser_ctr.newInstance(new Object[]{u}) );
					elapsed_time += System.nanoTime();
				} catch (InvocationTargetException x) {
					x.getCause().printStackTrace();
					Die("Исключение во время парсинга АСД.");
				}

				System.out.format("Выполнено за %d мс\r\n", elapsed_time/1000000);	
			}
		}
	}
	
	// Вывод результата.
	protected final static void EmitResult() throws Exception
	{
		// Выводим результаты анализа корректности использовния идентификаторов.
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
		

		// Выводим информацию о использовавшихся идентификаторах.
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
			Die("Случилось исключение!");
		}
	}

}

