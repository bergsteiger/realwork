/**
 * <copyright>
 * </copyright>
 *
 * $Id: Package.java,v 1.1 2009/02/25 06:20:00 pugin Exp $
 */
package euml;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Package</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link euml.Package#getClasses <em>Classes</em>}</li>
 *   <li>{@link euml.Package#getPackages <em>Packages</em>}</li>
 * </ul>
 * </p>
 *
 * @see euml.EumlPackage#getPackage()
 * @model
 * @generated
 */
public interface Package extends NamedElement {
	/**
	 * Returns the value of the '<em><b>Classes</b></em>' containment reference list.
	 * The list contents are of type {@link euml.Class}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Classes</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Classes</em>' containment reference list.
	 * @see euml.EumlPackage#getPackage_Classes()
	 * @model containment="true"
	 * @generated
	 */
	EList<euml.Class> getClasses();

	/**
	 * Returns the value of the '<em><b>Packages</b></em>' containment reference list.
	 * The list contents are of type {@link euml.Package}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Packages</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Packages</em>' containment reference list.
	 * @see euml.EumlPackage#getPackage_Packages()
	 * @model containment="true"
	 * @generated
	 */
	EList<Package> getPackages();

} // Package
