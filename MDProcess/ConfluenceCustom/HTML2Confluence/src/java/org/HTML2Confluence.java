package org.html2confluence;

///////////////////////////////////////////////////////////////////////////////
import com.atlassian.www._package.com_atlassian_confluence_rpc.*;
import com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.*;
import com.atlassian.www.software.confluence.$Proxy42.*;

import javax.xml.rpc.ServiceException;
///////////////////////////////////////////////////////////////////////////////

import com.atlassian.confluence.pages.*;
import com.atlassian.confluence.spaces.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.StringWriter;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.Long;

import java.util.*;
import java.util.Calendar;
import java.util.List;
import java.util.Vector;

public class HTML2Confluence {

	private static String LOGIN_USERNAME;
	private static String LOGIN_PASSWORD;
	private static String SRV_ADDRESS;

	private static String token;
	private static ConfluenceSoapService service;

	private static boolean remove_by_parent = false;
	private static boolean remove_by_search = false;
	private static boolean move_comments = false;
	private static boolean verbose = false;
	private static boolean add_attach = false;
	private static final int FAILURE = -99;           // exit code for program error exception
	
	private static long comment_id = 0;

	private static Vector title_vec = new Vector (20);
	private static Vector content_file_vec = new Vector (20);
	private static Vector content_string_vec = new Vector (1);
	private static String parent_title;
	private static String search_query;
	private static String space;
	private static Vector label_vec = new Vector (2);
	////////////////////////////////////////////////////////////////////////////////////////////

	public HTML2Confluence () {
	}

	public static void main (String [] args) throws ServiceException, java.rmi.RemoteException {
		try	{
			for (int i = 0; i < args.length; ++i) {
				if ((args [i].compareTo ("--action") == 0) && (++i < args.length)) {
					add_attach = args [i].compareTo ("addAttachment") == 0;
				} else if ((args [i].compareTo ("--title") == 0) && (++i < args.length)) {
					title_vec.add (new String (args [i]));
				} else if ((args [i].compareTo ("--content") == 0) && (++i < args.length)) {
					content_string_vec.add (new String (args [i]));
				} else if ((args [i].compareTo ("--label") == 0) && (++i < args.length)) {
					label_vec.add (new String (args [i]));
				} else if ((args [i].compareTo ("--space") == 0) && (++i < args.length)) {
					space = args [i];
				} else if ((args [i].compareTo ("--parent") == 0) && (++i < args.length)) {
					parent_title = args [i];
				} else if ((args [i].compareTo ("--file") == 0) && (++i < args.length)) {
					content_file_vec.add (new String (args [i]));
				} else if ((args [i].compareTo ("--user") == 0) && (++i < args.length)) {
					LOGIN_USERNAME = args [i];
				} else if ((args [i].compareTo ("--password") == 0) && (++i < args.length)) {
					LOGIN_PASSWORD = args [i];
				} else if ((args [i].compareTo ("--srv_address") == 0) && (++i < args.length)) {
					SRV_ADDRESS = args [i];
				} else if (args [i].compareTo ("--remove_by_parent") == 0) {
					remove_by_parent = true;
				} else if ((args [i].compareTo ("--remove_by_query") == 0) && (++i < args.length)) {
					remove_by_search = true;
					search_query = args [i];
				} else if (args [i].compareTo ("--move_all_comments") == 0) {
					move_comments = true;
				} else if ((args [i].compareTo ("--move_comment") == 0) && (++i < args.length)) {
					move_comments = true;
					Long l = new Long (args [i]);
					comment_id = l.longValue ();
				} else if ((args [i].compareTo ("--verbose") == 0) || (args [i].compareTo ("--v") == 0)) {
					verbose = true;
				} else {
					//System.out.println ("main: unknown " + i + "(" + args.length + ") param '" + args [i] + "'");
				}
			}
			soap_login ();
			if (remove_by_parent) {
				remove_children_by_parent ();
			} else if (remove_by_search) {
				remove_children_by_search ();
			} else if (move_comments) {
				move_comments_to ();
			} else {
				for (int i = 0; i < title_vec.size (); ++i) {
					create_page (i);
				}
			}
		} catch (Exception e) {
			System.err.println ("user:" + LOGIN_USERNAME + "; password=" + LOGIN_PASSWORD
				+ "; space=" + space + "; parent_title=" + parent_title + "; title=" + title_vec.toString () + "; content_file=" + content_file_vec.toString ()
				+ "; remove_by_parent=" + remove_by_parent + "; remove_by_search = " + remove_by_search + "; search_query = " + search_query
				+ "; verbose=" + verbose + "Exception: " + e.toString ());
			if (verbose) {
				e.printStackTrace (); 
			}
			System.exit (FAILURE);
		}
	}

	private static void soap_login () throws Exception {
		//String address = jsapResult.getString ("server") + jsapResult.getString ("soap");
		//String address = "http://zakharov.garant.ru:8080/confluence/rpc/soap/confluenceservice-v1";
		//String address = "http://zakharov.garant.ru:8080/rpc/soap/confluenceservice-v1";
		//String address = "http://dbtestwin1.garant.ru:8080/confluence/rpc/soap/confluenceservice-v1";
		String address = "http://" + SRV_ADDRESS + "/rpc/soap/confluenceservice-v1";
		try {
			ConfluenceServiceLocator confluenceServiceLocator = new ConfluenceServiceLocator ();
			confluenceServiceLocator.setConfluenceSoapServiceEndpointAddress (address);
			service = confluenceServiceLocator.getConfluenceSoapService ();
			
			token = service.login (LOGIN_USERNAME, LOGIN_PASSWORD);
		} catch (java.rmi.RemoteException e) {
			System.out.println (
				"soap_login::Unable to log in to server: " + address
				+ ". User id '" + LOGIN_USERNAME + "', or password '" + LOGIN_PASSWORD + "' are NOT correct."
			);
			System.err.println ("RemoteException: " + e.toString()); 
			if (verbose) { 
				e.printStackTrace ();
			}
			throw (e);
		} catch (ServiceException e) {
			System.out.println ("soap_login::ServiceException: Problem with remote service: " + address);
			System.err.println ("soap_login::More details: " + e.getMessage ()); 
			if (verbose) { 
				e.printStackTrace ();
			}
			throw (e);
		} catch (Exception e) {
			System.out.println ("soap_login::Exception: Problem with remote service: " + address);
			System.err.println ("soap_login::More details: " + e.getMessage ()); 
			if (verbose) { 
				e.printStackTrace ();
			}
			throw (e);
		}
	} // soap_login
	
	private static void move_comments_to () throws Exception {
		Map comment_ids = new HashMap ();
		
		//comment_id
		RemotePage page_from = service.getPage (token, space, parent_title);
		RemotePage page_to = service.getPage (token, space, (String)title_vec.get (0));
		
		long base_comment_id = 0;
		
		RemoteComment[] comments = service.getComments (token, page_from.getId ());
		for (int i = 0; i < comments.length; ++i) {
			try {
				Long new_parent_id = (Long)comment_ids.get (new Long (comments [i].getParentId ()));
				if (new_parent_id != null) {
					comments [i].setParentId (new_parent_id.longValue ());
				} else {
					if (base_comment_id == 0) {
						RemoteComment base_comment = new RemoteComment ();
						base_comment.setPageId (page_to.getId ());
						base_comment.setContent ("The base comment for all comments which were moved from " + page_from.getTitle ());
				        base_comment.setCreated (Calendar.getInstance ());
				        base_comment = service.addComment (token, base_comment);
				        base_comment_id = base_comment.getId ();
					}
					comments [i].setParentId (base_comment_id);
				}
				service.removeComment (token, comments [i].getId ());
				comments [i].setPageId (page_to.getId ());
				RemoteComment comment = service.addComment (token, comments [i]);
				comment_ids.put (new Long (comments [i].getId ()), new Long (comment.getId ()));
			} catch (Exception e) {
				System.out.println ("move_comments_to::Exception: i=" + i + "; commentId=" + comments [i].getId ());
				System.err.println ("move_comments_to::More details: " + e.getMessage ()); 
				if (verbose) { 
					e.printStackTrace ();
				}
			}
		}
	}
	
	private static void remove_children_by_search () throws Exception {
		long parent_id = 0;
		if ((parent_title != null) && (space != null)) {
			RemotePage parent_page = service.getPage (token, space, parent_title);
			if (parent_page == null) {
				System.err.println ("remove_children_by_search: parent page has not been found. parent_title=" + parent_title + ", space = " + space);
				return;
			}
			parent_id = parent_page.getId ();
		}
		RemoteSearchResult[] res = service.search (token, search_query, 100000);
		System.out.println ("remove_children_by_search: search_query = '" + search_query + "'; found " + res.length + " pages");
		int ii = 0;
		for (int i = 0; i < res.length; ++i) {
			RemoteSearchResult cur = res [i];
			try {
				if (parent_id != 0) {
					RemotePage page = service.getPage (token, cur.getId ());
					if ((page != null) && (page.getParentId () != parent_id)) {
						continue;
					}
				}
				System.out.println ("remove_children_by_search: i = " + i + ", title = " + cur.getTitle ());
				if (service.removePage (token, cur.getId ()).booleanValue () == false) {
					System.err.println ("remove_children_by_search: deletePage ('" + cur.getTitle () + "') - FAIL.");
				} else {
					++ii;
				}
			} catch (Exception e) {
				System.err.println ("remove_children_by_search::cur title = " + cur.getTitle () + ". More details: " + e.getMessage ()); 
			}
		}
		System.out.println ("remove_children_by_search: was removed " + ii + " pages - OK");
	}

	private static void remove_children_by_parent () throws Exception {
		long parent_id = 0;
		if ((parent_title != null) && (parent_title.length () > 0)) {
			RemotePage parent_page = service.getPage (token, space, parent_title);
			if (parent_page == null) {
				System.err.println ("remove_children_by_parent: parent page has not been found. parent_title=" + parent_title + ", space = " + space);
				return;
			}
			parent_id = parent_page.getId ();
		}
		RemotePageSummary pages [] = service.getPages (token, space);
		System.out.println ("remove_children_by_parent: parent_title = " + parent_title + "; found " + pages.length + " child pages");
		int ii = 0;
		for (int i = 0; i < pages.length; ++i) {
			RemotePageSummary rps = pages [i];
			if ((parent_id == 0) || (parent_id == rps.getParentId ())) {
				System.out.println ("remove_children_by_parent: i = " + ii + ", parent_id = " + rps.getId () + ", title = " + rps.getTitle ());
				if (service.removePage (token, rps.getId ()).booleanValue () == false) {
					System.err.println ("remove_children_by_parent: deletePage ('" + rps.getTitle () + "') - FAIL.");
				} else {
					++ii;
				}
			}
		}
		System.out.println ("remove_children_by_parent: was removed " + ii + " pages - OK");
	}
	
	private static RemotePage get_page (String page_title) {
		try {
			return service.getPage (token, space, page_title);
		} catch (Exception e) {
			RemotePage page = new RemotePage ();
			page.setTitle (page_title);
			page.setSpace (space);
			long id = page.getId ();
			page.setId (id);
			int version = page.getVersion ();
			page.setVersion (version);
			Calendar calendar = Calendar.getInstance ();
			page.setCreated (calendar);
			return page;
		}
	}

	private static void create_page (int i) throws Exception {
		//service.addLabelByNameToSpace (token, "Added_", space);
		try {
			RemotePage page = get_page ((String)title_vec.get (i));
			try { 
				RemotePage parent_page = service.getPage (token, space, parent_title); 
				page.setParentId (parent_page.getId ());
			} catch (java.rmi.RemoteException e) {
				System.err.println ("create_page::getParentPage FAIL!!!");
				System.err.println ("create_page::More details: " + e.getMessage ()); 
			}
			RemoteAttachment attach = null;
			if (add_attach) {
				page.setContent ((String)content_string_vec.get (i));
				attach = new RemoteAttachment ();
				Calendar calendar = Calendar.getInstance ();
				attach.setCreated (Calendar.getInstance ());
				attach.setContentType ("application/pdf");

				attach.setFileName ((String)content_file_vec.get (i));
			} else {
				if (content_string_vec.size () > i) {
					page.setContent ((String)content_string_vec.get (i));
				} else if (content_file_vec.size () > i) {
					String content = getFileAsString ((String)content_file_vec.get (i));
					page.setContent (content);
				} else {
					System.err.println ("create_page::setContent FAIL!!!");
				}
			}

			Calendar calendar = Calendar.getInstance ();
			page.setModified (calendar);

			service.storePage (token, page);

			if (attach != null) {
				page = service.getPage (token, space, (String)title_vec.get (i));
				service.addAttachment (token, page.getId (), attach, loadBinFile ((String)content_file_vec.get (i)));
			}
			if (label_vec.size () > 0) {
				page = service.getPage (token, space, (String)title_vec.get (i));
				for (int j = 0; j < label_vec.size (); ++j) {
					service.addLabelByName (token, (String)label_vec.get (j), page.getId ());
				}
			}			
		} catch (java.rmi.RemoteException e) {
			System.err.println ("create_page::RemoteException: " + e.getMessage ()); 
			if (verbose) { 
				e.printStackTrace (); 
			}
			throw (e);
		} // catch
	} // soap_page_create

	private static String getFileAsString (String fileName) throws Exception {
		byte[] data = loadBinFile (fileName);
		String file_content = new String (data, "Cp1251");
		return file_content;
	}

	private static byte[] loadBinFile (String fileName) throws Exception {
		File file = new File (fileName);
		if (file.exists ()) {                
			try {
				FileInputStream stream = new FileInputStream (file);
				byte[] data = new byte [(new Long (file.length ())).intValue ()];
				int bytesRead = stream.read (data);
				if (verbose) {
					System.out.println ("loadBinFile::File '" + file.getAbsolutePath () + "' had: " + bytesRead + " bytes read.  Length was: " + file.length ());
				}
				return data;
			} catch (IOException e) {
				if (verbose) { 
					System.out.println (e.getMessage ());
					e.printStackTrace (); 
				}            
				throw new Exception ("loadBinFile::Error reading file: " + file.getAbsolutePath ());
			}
		} else {
			throw new Exception ("loadBinFile::File not found: " + file.getAbsolutePath ());
		}   
	}
}
