/**
 * <copyright>
 * </copyright>
 *
 * $Id: Class.java,v 1.1 2009/02/25 06:20:00 pugin Exp $
 */
package euml;

import org.eclipse.emf.common.util.EList;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Class</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link euml.Class#getDependencies <em>Dependencies</em>}</li>
 *   <li>{@link euml.Class#getAttributes <em>Attributes</em>}</li>
 *   <li>{@link euml.Class#getOperations <em>Operations</em>}</li>
 *   <li>{@link euml.Class#getRealizations <em>Realizations</em>}</li>
 *   <li>{@link euml.Class#getGeneralizations <em>Generalizations</em>}</li>
 * </ul>
 * </p>
 *
 * @see euml.EumlPackage#getClass_()
 * @model
 * @generated
 */
public interface Class extends NamedElement {
	/**
	 * Returns the value of the '<em><b>Dependencies</b></em>' containment reference list.
	 * The list contents are of type {@link euml.Dependecy}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Dependencies</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Dependencies</em>' containment reference list.
	 * @see euml.EumlPackage#getClass_Dependencies()
	 * @model containment="true"
	 * @generated
	 */
	EList<Dependecy> getDependencies();

	/**
	 * Returns the value of the '<em><b>Attributes</b></em>' containment reference list.
	 * The list contents are of type {@link euml.Attribute}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Attributes</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Attributes</em>' containment reference list.
	 * @see euml.EumlPackage#getClass_Attributes()
	 * @model containment="true"
	 * @generated
	 */
	EList<Attribute> getAttributes();

	/**
	 * Returns the value of the '<em><b>Operations</b></em>' containment reference list.
	 * The list contents are of type {@link euml.Operation}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Operations</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Operations</em>' containment reference list.
	 * @see euml.EumlPackage#getClass_Operations()
	 * @model containment="true"
	 * @generated
	 */
	EList<Operation> getOperations();

	/**
	 * Returns the value of the '<em><b>Realizations</b></em>' containment reference list.
	 * The list contents are of type {@link euml.Realization}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Realizations</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Realizations</em>' containment reference list.
	 * @see euml.EumlPackage#getClass_Realizations()
	 * @model containment="true"
	 * @generated
	 */
	EList<Realization> getRealizations();

	/**
	 * Returns the value of the '<em><b>Generalizations</b></em>' containment reference list.
	 * The list contents are of type {@link euml.Generalization}.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Generalizations</em>' containment reference list isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Generalizations</em>' containment reference list.
	 * @see euml.EumlPackage#getClass_Generalizations()
	 * @model containment="true"
	 * @generated
	 */
	EList<Generalization> getGeneralizations();

} // Class
